use uplc/builtins.{DefaultFunction}
use uplc/constant.{Constant, Integer}
use uplc/term.{Apply,
  Builtin, Delay, Error, Force, Lambda, TConstant, Term, Var}

pub type Env =
  List<Value>

pub type Context {
  FrameApplyFun(Value, Context)
  FrameApplyArg(Env, Term, Context)
  FrameForce(Context)
  NoFrame
}

pub type Value {
  VCon(Constant)
  VDelay(Term, Env)
  VLambda { param: Int, body: Term, env: Env }
  VBuiltin { fun: DefaultFunction, term: Term }
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
    Delay(body) -> return(ctx, VDelay(body, env))
    Lambda { param, body } -> return(ctx, VLambda { param, body, env })
    Apply { function, argument } -> {
      let frame = FrameApplyArg(env, argument, ctx)
      compute(frame, env, function)
    }
    TConstant(x) -> return(ctx, VCon(x))
    Force(body) -> {
      let frame = FrameForce(ctx)
      compute(frame, env, body)
    }
    Error -> error("evaluation failure")
    Builtin(_) -> error("builtins not supported")
  }
}

fn return(ctx: Context, value: Value) -> Term {
  when ctx is {
    FrameApplyFun(function, ctx) -> apply_eval(ctx, function, value)
    FrameApplyArg(arg_var_env, arg, ctx) -> {
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

fn apply_eval(ctx: Context, function: Value, argument: Value) -> Term {
  todo
}

fn force_eval(ctx: Context, value: Value) -> Term {
  when value is {
    VDelay(body, env) -> compute(ctx, env, body)
    _ -> error("nonpolymorphic instantiation")
  }
}

fn discharge_value(value: Value) -> Term {
  todo
}

fn lookup_var(index: Int, env: Env) -> Value {
  if index < 0 {
    error("get_or_err: index is negative")
  } else {
    do_get_or_err(env, index, 0)
  }
}

fn do_get_or_err(env: Env, index: Int, current: Int) -> Value {
  if current > index {
    error("open term evaluation")
  } else {
    when env is {
      [] -> error("open term evaluation")
      [x, ..xs] ->
        if index == current {
          x
        } else {
          do_get_or_err(xs, index, current + 1)
        }
    }
  }
}
// TODO: mutual recursion does not work atm
// test run_1() {
//   let term =
//     Apply {
//       function: Lambda { param: 0, body: Var(0) },
//       argument: TConstant(Integer(1)),
//     }

//   run(term) == TConstant(Integer(1))
// }
