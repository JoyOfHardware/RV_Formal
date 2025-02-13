{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Decode.Opcodes(Opcode(..)) where
import Clash.Prelude
import Data.Functor.Contravariant (Op)

type FUNCT7 = Unsigned 7
type RS2    = Unsigned 5
type RS1    = Unsigned 5
type FUNCT3 = Unsigned 3
type RD     = Unsigned 5
type OPCODE = Unsigned 7

type IMM12  = Unsigned 12
type IMM13  = Unsigned 13
type IMM20  = Unsigned 20
type IMM21  = Unsigned 21

data RTypeFields = RTypeFields OPCODE RD FUNCT3 RS1 RS2 FUNCT7
data ITypeFields = ITypeFields OPCODE RD FUNCT3 RS1 IMM12
data STypeFields = STypeFields OPCODE FUNCT3 RS1 RS2 IMM12
data BTypeFields = BTypeFields OPCODE FUNCT3 RS1 RS2 IMM13
data UTypeFields = UTypeFields OPCODE RD IMM20
data JTypeFields = JTypeFields OPCODE RD IMM21

data Opcode
  = ADD  RTypeFields
  | SUB  RTypeFields
  | XOR  RTypeFields
  | OR   RTypeFields
  | AND  RTypeFields
  | SLL  RTypeFields
  | SRL  RTypeFields
  | SRA  RTypeFields
  | SLT  RTypeFields
  | SLTU RTypeFields
  | ADDRI  ITypeFields
  | XORI   ITypeFields
  | ORI    ITypeFields
  | ANDI   ITypeFields
  | SLLI   ITypeFields
  | SRLI   ITypeFields
  | SRAI   ITypeFields
  | SLTI   ITypeFields
  | SLTIU  ITypeFields
  | LB     ITypeFields
  | LH     ITypeFields
  | LW     ITypeFields
  | LBU    ITypeFields
  | LHU    ITypeFields

