pub opaque type DefaultFunction {
  AddInteger
  SubInteger
}

pub const default_force_counts = {
    expect 0 = 0

    // AddInteger
    // SubtractInteger
    // MultiplyInteger
    // DivideInteger
    // QuotientInteger
    // RemainderInteger
    // ModInteger
    // EqualsInteger
    // LessThanInteger
    // LessThanEqualsInteger
    // AppendByteString
    // ConsByteString
    // SliceByteString
    // LengthOfByteString
    // IndexByteString
    // EqualsByteString
    // LessThanByteString
    // LessThanEqualsByteString
    // Sha2_256
    // Sha3_256
    // Blake2b_256
    // Blake2b_224
    // Keccak_256
    // VerifyEd25519Signature
    // VerifyEcdsaSecp256k1Signature
    // VerifySchnorrSecp256k1Signature
    // AppendString
    // EqualsString
    // EncodeUtf8
    // DecodeUtf8
    // IfThenElse
    // ChooseUnit
    // Trace
    // FstPair
    // SndPair
    // ChooseList
    // MkCons
    // HeadList
    // TailList
    // NullList
    // ChooseData
    // ConstrData
    // MapData
    // ListData
    // IData
    // BData
    // UnConstrData
    // UnMapData
    // UnListData
    // UnIData
    // UnBData
    // EqualsData
    // SerialiseData
    // MkPairData
    // MkNilData
    // MkNilPairData
    // Bls12_381_G1_Add
    // Bls12_381_G1_Neg
    // Bls12_381_G1_ScalarMul
    // Bls12_381_G1_Equal
    // Bls12_381_G1_Compress
    // Bls12_381_G1_Uncompress
    // Bls12_381_G1_HashToGroup
    // Bls12_381_G2_Add
    // Bls12_381_G2_Neg
    // Bls12_381_G2_ScalarMul
    // Bls12_381_G2_Equal
    // Bls12_381_G2_Compress
    // Bls12_381_G2_Uncompress
    // Bls12_381_G2_HashToGroup
    // Bls12_381_MillerLoop
    // Bls12_381_MulMlResult
    // Bls12_381_FinalVerify
    // IntegerToByteString
    // ByteStringToInteger
    // AndByteString
    // OrByteString
    // XorByteString
    // ComplementByteString
    // ReadBit
    // WriteBits
    // ReplicateByte
    // ShiftByteString
    // RotateByteString
    // CountSetBits
    // FindFirstSetBit
    // Ripemd_160
    #[0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      1,
      1,
      1,
      2,
      2,
      2,
      1,
      1,
      1,
      1,
      1,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ]
  }

pub const default_arg_counts = {
    expect 0 = 0

    // AddInteger
    // SubtractInteger
    // MultiplyInteger
    // DivideInteger
    // QuotientInteger
    // RemainderInteger
    // ModInteger
    // EqualsInteger
    // LessThanInteger
    // LessThanEqualsInteger
    // AppendByteString
    // ConsByteString
    // SliceByteString
    // LengthOfByteString
    // IndexByteString
    // EqualsByteString
    // LessThanByteString
    // LessThanEqualsByteString
    // Sha2_256
    // Sha3_256
    // Blake2b_256
    // Blake2b_224
    // Keccak_256
    // VerifyEd25519Signature
    // VerifyEcdsaSecp256k1Signature
    // VerifySchnorrSecp256k1Signature
    // AppendString
    // EqualsString
    // EncodeUtf8
    // DecodeUtf8
    // IfThenElse
    // ChooseUnit
    // Trace
    // FstPair
    // SndPair
    // ChooseList
    // MkCons
    // HeadList
    // TailList
    // NullList
    // ChooseData
    // ConstrData
    // MapData
    // ListData
    // IData
    // BData
    // UnConstrData
    // UnMapData
    // UnListData
    // UnIData
    // UnBData
    // EqualsData
    // SerialiseData
    // MkPairData
    // MkNilData
    // MkNilPairData
    // Bls12_381_G1_Add
    // Bls12_381_G1_Neg
    // Bls12_381_G1_ScalarMul
    // Bls12_381_G1_Equal
    // Bls12_381_G1_Compress
    // Bls12_381_G1_Uncompress
    // Bls12_381_G1_HashToGroup
    // Bls12_381_G2_Add
    // Bls12_381_G2_Neg
    // Bls12_381_G2_ScalarMul
    // Bls12_381_G2_Equal
    // Bls12_381_G2_Compress
    // Bls12_381_G2_Uncompress
    // Bls12_381_G2_HashToGroup
    // Bls12_381_MillerLoop
    // Bls12_381_MulMlResult
    // Bls12_381_FinalVerify
    // IntegerToByteString
    // ByteStringToInteger
    // AndByteString
    // OrByteString
    // XorByteString
    // ComplementByteString
    // ReadBit
    // WriteBits
    // ReplicateByte
    // ShiftByteString
    // RotateByteString
    // CountSetBits
    // FindFirstSetBit
    // Ripemd_160
    #[2,
      2,
      2,
      2,
      2,
      2,
      2,
      2,
      2,
      2,
      2,
      2,
      3,
      1,
      2,
      2,
      2,
      2,
      1,
      1,
      1,
      1,
      1,
      3,
      3,
      3,
      2,
      2,
      1,
      1,
      3,
      2,
      2,
      1,
      1,
      3,
      2,
      1,
      1,
      1,
      6,
      2,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      2,
      1,
      2,
      1,
      1,
      2,
      1,
      2,
      2,
      1,
      1,
      2,
      2,
      1,
      2,
      2,
      1,
      1,
      2,
      2,
      2,
      2,
      3,
      2,
      3,
      3,
      3,
      1,
      2,
      3,
      2,
      2,
      2,
      1,
      1,
      1,
    ]
  }

pub type NotBuiltin<a> =
  fn() -> a

pub type OneArgBuiltin<a, b> =
  fn(fn(a) -> b) -> fn(a) -> b

pub type TwoArgBuiltin<a, b, c> =
  fn(fn(a, b) -> c) -> fn(a) -> fn(b) -> c

pub type BuiltinRunTime<func> =
  func
