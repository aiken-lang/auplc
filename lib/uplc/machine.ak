use uplc/builtins.{DefaultFunction}
use uplc/constant.{Constant}
use uplc/term.{Delay, Term, Var}

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
    _ -> todo("finish terms")
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
    _ -> todo("finish ctxs")
  }
}

fn apply_eval(ctx: Context, function: Value, argument: Value) -> Term {
  todo
}

fn force_eval(ctx: Context, value: Value) -> Term {
  todo
}

fn discharge_value(value: Value) -> Term {
  todo
}

fn lookup_var(name: Int, env: Env) -> Value {
  todo
}
