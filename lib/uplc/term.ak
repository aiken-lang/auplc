use uplc/constant.{Constant}

pub type DebruijnIndex =
  Int

pub type Term {
  Var(DebruijnIndex)

  Delay(Term)

  Lambda { param: Int, body: Term }

  Apply { function: Term, argument: Term }

  TConstant(Constant)

  Force(Term)

  Error

  Builtin(Int)
}
