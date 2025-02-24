use aiken/builtin
use uplc/builtins.{default_arg_counts, default_force_counts}
use uplc/constant.{Constant, Integer}
use uplc/term.{Apply,
  Builtin, Delay, Error, Force, Lambda, TConstant, Term, Var}

pub type Env =
  List<Value>

pub type Context {
  FrameApplyFun(Value, Context)
  FrameAwaitFunTerm(Env, Term, Context)
  FrameForce(Context)
  NoFrame
}

pub type Value {
  VCon(Constant)
  VDelay(Term, Env)
  VLambda { param: Int, body: Term, env: Env }
  // term holds current builtin state
  VBuiltin {
    fun: Int,
    term: Term,
    force_count: Int,
    args_count: Int,
    args: List<Value>,
  }
}

pub fn run(term: Term) -> Term {
  compute(NoFrame, [], term)
}

fn compute(ctx: Context, env: Env, term: Term) -> Term {
  when term is {
    Var(name) -> {
      let value = lookup_var(name, env)
      return(ctx, value)
    }
    TConstant(x) -> return(ctx, VCon(x))
    Lambda { param, body } -> return(ctx, VLambda { param, body, env })
    Delay(body) -> return(ctx, VDelay(body, env))
    Force(body) -> compute(FrameForce(ctx), env, body)
    Apply { function, argument } ->
      compute(FrameAwaitFunTerm(env, argument, ctx), env, function)
    Error -> fail @"evaluation failure"
    Builtin(fun) -> {
      let force_count = builtin.index_bytearray(default_force_counts, fun)

      let args_count = builtin.index_bytearray(default_arg_counts, fun)

      return(ctx, VBuiltin { fun, term, force_count, args_count, args: [] })
    }
  }
}

fn return(ctx: Context, value: Value) -> Term {
  when ctx is {
    FrameApplyFun(function, ctx) -> apply_eval(ctx, function, value)
    FrameAwaitFunTerm(arg_var_env, arg, ctx) -> {
      let frame = FrameApplyFun(value, ctx)
      compute(frame, arg_var_env, arg)
    }
    FrameForce(ctx) -> force_eval(ctx, value)
    NoFrame -> {
      let term = discharge_value(value)
      term
    }
  }
}

fn force_eval(ctx: Context, value: Value) -> Term {
  when value is {
    VDelay(body, env) -> compute(ctx, env, body)
    VBuiltin { fun, term, force_count, args_count, args } ->
      if force_count > 0 {
        //TODO: Should call evalBuiltinApp here for exact semantics
        // but in reality we dont have a builtin that only takes in force
        return(
          ctx,
          VBuiltin {
            fun,
            term: Force(term),
            force_count: force_count - 1,
            args_count,
            args,
          },
        )
      } else {
        fail @"builtin term argument expected"
      }
    _ -> fail @"nonpolymorphic instantiation"
  }
}

fn apply_eval(ctx: Context, function: Value, argument: Value) -> Term {
  todo
}

fn eval_builtin(
  fun: Int,
  term: Term,
  args_count: Int,
  args: List<Value>,
) -> Value {
  todo
}

fn call_builtin(fun: Int, args: List<Value>) -> Value {
  if fun < 43 {
    when fun is {
      // AddInteger
      0 ->
        when args is {
          [VCon(Integer(a)), VCon(Integer(b))] -> VCon(Integer(a + b))
          _ -> fail @"Fail Case Here"
        }
      // SubtractInteger
      1 ->
        when args is {
          [VCon(Integer(a)), VCon(Integer(b))] -> VCon(Integer(a - b))
          _ -> fail @"Fail Case Here"
        }
      // Case for negative builtins
      _ -> fail @"Invalid builtin"
    }
  } else {
    todo
  }
}

fn discharge_value(value: Value) -> Term {
  todo
}

fn lookup_var(index: Int, env: Env) -> Value {
  if index < 0 {
    fail @"get_or_err: index is negative"
  } else {
    do_get_or_err(env, index, 0)
  }
}

fn do_get_or_err(env: Env, index: Int, current: Int) -> Value {
  if current > index {
    fail @"open term evaluation"
  } else {
    when env is {
      [] -> fail @"open term evaluation"
      [x, ..xs] ->
        if index == current {
          x
        } else {
          do_get_or_err(xs, index, current + 1)
        }
    }
  }
}

test run_1() {
  let term =
    Apply {
      function: Lambda { param: 0, body: Var(1) },
      argument: TConstant(Integer(1)),
    }

  run(TConstant(Integer(1))) == TConstant(Integer(1))
}
