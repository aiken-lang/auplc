use uplc/builtins.{DefaultFunction}
use uplc/constant.{Constant}

pub type Term {
  Var(Int)

  Delay(Term)

  Lambda { param: Int, body: Term }

  Apply { function: Term, argument: Term }

  TConstant(Constant)

  Force(Term)

  Error

  Builtin(DefaultFunction)
}
