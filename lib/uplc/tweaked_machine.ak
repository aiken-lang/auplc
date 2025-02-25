use aiken/builtin
use uplc/builtins.{default_arg_counts, default_force_counts}
use uplc/constant.{Constant}
use uplc/tweaked_term.{
  Apply, Blake2b_256, Builtin, Delay, Error, Force, Hash, Lambda, TConstant,
  Term, TermHash, hashing_algo,
}

pub type EnvHash =
  Hash<Blake2b_256, Env>

pub type Env {
  value: ValueHash,
  next: EnvHash,
}

pub type ContextHash =
  Hash<Blake2b_256, Context>

pub type Context {
  FrameAwaitArg(Value, ContextHash)
  FrameAwaitFunTerm(Env, TermHash, ContextHash)
  FrameAwaitFunValue(Value, ContextHash)
  FrameForce(ContextHash)
  FrameConstr(Env, Int, List<TermHash>, List<Value>, ContextHash)
  FrameCases(Env, List<TermHash>, ContextHash)
  NoFrame
}

pub type ValueHash =
  Hash<Blake2b_256, Value>

pub type Value {
  VCon(Constant)
  VDelay(TermHash, Env)
  VLambda { body: TermHash, env: Env }
  // don't need to hold builtin state
  // this is literally serializable
  VBuiltin {
    fun: Int,
    force_count: Int,
    args_count: Int,
    args: List<ValueHash>,
  }
  VConstr { tag: Int, fields: List<ValueHash> }
}

pub type MachineState {
  Compute(Context, Env, TermHash)
  // ComputeAwaitTerm(Context, Env, TermHash)
  Return(Context, ValueHash)
  // ReturnAwaitValue(Context, ValueHash)
  Done(TermHash)
  IteratingEnv(Context, Env, Int)
  ErrorState(ByteArray)
}

pub type MachineWrapper {
  ms: MachineState,
  value: Option<Value>,
  term: Option<Term>,
  envs: List<Value>,
}

// pub fn run(machine_state: MachineState) {
//   when machine_state is {
//     Compute(ctx, env, term) -> compute(ctx, env, term)
//     _ -> todo
//   }
// }

pub fn iterate_env(ctx: Context, env: Env, index: Int, next_env: Option<Env>) {
  if index == 1 {
    Return(ctx, env.value)
  } else {
    expect Some(next_env) = next_env
    expect env.next == ( next_env |> builtin.serialise_data |> hashing_algo )

    IteratingEnv(ctx, next_env, index - 1)
  }
}

pub fn compute(
  ctx: Context,
  env: Env,
  term_hash: TermHash,
  term: Term,
) -> MachineState {
  expect term_hash == ( term |> builtin.serialise_data |> hashing_algo )

  when term is {
    Delay(inner_hash) ->
      Return(
        ctx,
        VDelay(inner_hash, env) |> builtin.serialise_data |> hashing_algo,
      )
    Force(inner_hash) -> {
      let ctx = ctx |> builtin.serialise_data |> hashing_algo |> FrameForce

      Compute(ctx, env, inner_hash)
    }
    Lambda { body: body_hash } ->
      Return(
        ctx,
        VLambda(body_hash, env) |> builtin.serialise_data |> hashing_algo,
      )
    Apply { function, argument } -> {
      let ctx =
        ctx
          |> builtin.serialise_data
          |> hashing_algo
          |> fn(a) { FrameAwaitFunTerm(env, argument, a) }

      Compute(ctx, env, function)
    }
    TConstant(constant) ->
      Return(ctx, VCon(constant) |> builtin.serialise_data |> hashing_algo)

    Error -> ErrorState("Evaluation Failure")

    Builtin(fun) -> {
      let force_count = builtin.index_bytearray(default_force_counts, fun)

      let args_count = builtin.index_bytearray(default_arg_counts, fun)

      Return(
        ctx,
        VBuiltin { fun, force_count, args_count, args: [] }
          |> builtin.serialise_data
          |> hashing_algo,
      )
    }

    _ -> fail
  }
}
