{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Forms
  ( Form(..)  , FormA1(FormA1, a1FRT, a1FRB, a1Rc)
  , FormA2(FormA2, a2FRT, a2FRA, a2FRC, a2Rc)
  , FormA3(FormA3, a3FRT, a3FRA, a3FRB, a3Rc)
  , FormA4(FormA4, a4FRT, a4FRA, a4FRB, a4FRC, a4Rc)
  , FormA5(FormA5, a5RT, a5RA, a5RB, a5BC)
  , FormB1(FormB1, b1BO, b1BI, b1BD, b1AA, b1LK)
  , FormD1(FormD1, d1BF, d1L, d1RA, d1SI)
  , FormD2(FormD2, d2BF, d2L, d2RA, d2UI)
  , FormD3(FormD3, d3FRS, d3RA, d3D)
  , FormD4(FormD4, d4FRT, d4RA, d4D)
  , FormD5(FormD5, d5RS, d5RA, d5D)
  , FormD6(FormD6, d6RS, d6RA, d6UI)
  , FormD7(FormD7, d7RT, d7RA, d7D)
  , FormD8(FormD8, d8RT, d8RA, d8SI)
  , FormD9(FormD9, d9TO, d9RA, d9SI)
  , FormDQ1(FormDQ1, dq1RTp, dq1RA, dq1DQ, dq1PT)
  , FormDQ2(FormDQ2, dq2S, dq2RA, dq2DQ, dq2SX)
  , FormDQ3(FormDQ3, dq3TO, dq3RA, dq3DQ, dq3TX)
  , FormDS1(FormDS1, ds1FRSp, ds1RA, ds1DS)
  , FormDS2(FormDS2, ds2FRTp, ds2RA, ds2DS)
  , FormDS3(FormDS3, ds3RS, ds3RA, ds3DS)
  , FormDS4(FormDS4, ds4RSp, ds4RA, ds4DS)
  , FormDS5(FormDS5, ds5RT, ds5RA, ds5DS)
  , FormDS6(FormDS6, ds6VRS, ds6RA, ds6DS)
  , FormDS7(FormDS7, ds7VRT, ds7RA, ds7DS)
  , FormDX1(FormDX1, dx1RT, dx1d1, dx1d0, dx1d2)
  , FormI1(FormI1, i1LI, i1AA, i1LK)
  , FormM1(FormM1, m1RS, m1RA, m1RB, m1MB, m1ME, m1Rc)
  , FormM2(FormM2, m2RS, m2RA, m2SH, m2MB, m2ME, m2Rc)
  , FormMD1(FormMD1, md1RS, md1RA, md1mb, md1Rc)
  , FormMD2(FormMD2, md2RS, md2RA, md2me, md2Rc)
  , FormMDS1(FormMDS1, mds1RS, mds1RA, mds1RB, mds1mb, mds1Rc)
  , FormMDS2(FormMDS2, mds2RS, mds2RA, mds2RB, mds2me, mds2Rc)
  , FormSC1(FormSC1, sc1LEV)
  , FormVA1(FormVA1, va1RT, va1RA, va1RB, va1RC)
  , FormVA2(FormVA2, va2VRT, va2VRA, va2VRB, va2SHB)
  , FormVA3(FormVA3, va3VRT, va3VRA, va3VRB, va3VRC)
  , FormVC1(FormVC1, vc1VRT, vc1VRA, vc1VRB, vc1Rc)
  , FormVX1(FormVX1, vx1VRB)
  , FormVX2(FormVX2, vx2RT, vx2EO, vx2VRB)
  , FormVX3(FormVX3, vx3VRT)
  , FormVX4(FormVX4, vx4VRT, vx4VRB)
  , FormVX5(FormVX5, vx5VRT, vx5UIM, vx5VRB)
  , FormVX6(FormVX6, vx6VRT, vx6UIM, vx6VRB)
  , FormVX7(FormVX7, vx7VRT, vx7UIM, vx7VRB)
  , FormVX8(FormVX8, vx8VRT, vx8EO, vx8VRB)
  , FormVX9(FormVX9, vx9VRT, vx9EO, vx9VRB, vx9PS)
  , FormVX10(FormVX10, vx10VRT, vx10EO, vx10VRB)
  , FormVX11(FormVX11, vx11VRT, vx11RA, vx11VRB)
  , FormVX12(FormVX12, vx12VRT, vx12SIM)
  , FormVX13(FormVX13, vx13VRT, vx13UIM, vx13VRB)
  , FormVX14(FormVX14, vx14VRT, vx14VRA)
  , FormVX15(FormVX15, vx15VRT, vx15VRA, vx15VRB)
  , FormVX16(FormVX16, vx16VRT, vx16VRA, vx16VRB, vx16PS)
  , FormVX17(FormVX17, vx17VRT, vx17VRA, vx17VRB)
  , FormX1(FormX1)
  , FormX2(FormX2)
  , FormX3(FormX3, x3RB)
  , FormX4(FormX4, x4RA)
  , FormX5(FormX5, x5RA)
  , FormX6(FormX6, x6RA, x6RB)
  , FormX7(FormX7, x7L)
  , FormX8(FormX8, x8L, x8RB)
  , FormX9(FormX9, x9RA, x9RB)
  , FormX10(FormX10, x10L, x10RA, x10RB)
  , FormX11(FormX11, x11L)
  , FormX12(FormX12, x12L, x12RA, x12RB, x12Rc)
  , FormX13(FormX13, x13WC)
  , FormX14(FormX14, x14IH)
  , FormX15(FormX15, x15CT, x15RA, x15RB)
  , FormX16(FormX16, x16A)
  , FormX17(FormX17, x17A, x17R)
  , FormX18(FormX18, x18BF)
  , FormX19(FormX19, x19BF, x19FRB)
  , FormX20(FormX20, x20BF, x20W, x20U, x20Rc)
  , FormX21(FormX21, x21BF, x21BFA)
  , FormX22(FormX22, x22BF, x22FRA, x22FRB)
  , FormX23(FormX23, x23BF, x23FRAp, x23FRBp)
  , FormX24(FormX24, x24BF, x24FRAp, x24FRBp)
  , FormX25(FormX25, x25BF, x25RA, x25RB)
  , FormX26(FormX26, x26BF, x26UIM, x26FRBp)
  , FormX27(FormX27, x27BF, x27UIM, x27FRBp)
  , FormX28(FormX28, x28BF, x28VRA, x28VRB)
  , FormX29(FormX29, x29BF, x29RA, x29RB)
  , FormX30(FormX30, x30BF, x30L, x30RA, x30RB)
  , FormX31(FormX31, x31BF, x31DCMX, x31VRB)
  , FormX32(FormX32, x32BT, x32Rc)
  , FormX33(FormX33, x33FRS, x33RA, x33RB)
  , FormX34(FormX34, x34FRSp, x34RA, x34RB)
  , FormX35(FormX35, x35FRT, x35Rc)
  , FormX36(FormX36, x36FRT, x36FRB, x36Rc)
  , FormX37(FormX37, x37FRT, x37FRBp, x37Rc)
  , FormX38(FormX38, x38FRT, x38EO, x38Rc)
  , FormX39(FormX39, x39FRT, x39EO)
  , FormX40(FormX40, x40FRT, x40EO, x40RM)
  , FormX41(FormX41, x41FRT, x41EO, x41DRM)
  , FormX42(FormX42, x42FRT, x42EO, x42FRB)
  , FormX43(FormX43, x43FRT, x43FRA, x43FRB)
  , FormX44(FormX44, x44FRT, x44FRA, x44FRB, x44Rc)
  , FormX45(FormX45, x45FRT, x45RA, x45RB)
  , FormX46(FormX46, x46FRT, x46S, x46FRB, x46Rc)
  , FormX47(FormX47, x47FRT, x47SP, x47FRB, x47Rc)
  , FormX48(FormX48, x48FRTp, x48FRB, x48Rc)
  , FormX49(FormX49, x49FRTp, x49FRBp, x49Rc)
  , FormX50(FormX50, x50FRTp, x50FRA, x50FRBp, x50Rc)
  , FormX51(FormX51, x51FRTp, x51FRAp, x51FRBp, x51Rc)
  , FormX52(FormX52, x52FRTp, x52RA, x52RB)
  , FormX53(FormX53, x53FRTp, x53S, x53FRBp, x53Rc)
  , FormX54(FormX54, x54FRTp, x54SP, x54FRBp, x54Rc)
  , FormX55(FormX55, x55RS, x55RB)
  , FormX56(FormX56, x56RS, x56L)
  , FormX57(FormX57, x57RS, x57RIC, x57PR, x57R, x57RB)
  , FormX58(FormX58, x58RS, x58SR)
  , FormX59(FormX59, x59RS, x59BFA)
  , FormX60(FormX60, x60RS, x60RA)
  , FormX61(FormX61, x61RS, x61RA)
  , FormX62(FormX62, x62RS, x62RA, x62Rc)
  , FormX63(FormX63, x63RS, x63RA, x63FC)
  , FormX64(FormX64, x64RS, x64RA, x64NB)
  , FormX65(FormX65, x65RS, x65RA, x65SH, x65Rc)
  , FormX66(FormX66, x66RS, x66RA, x66RB)
  , FormX67(FormX67, x67RS, x67RA, x67RB)
  , FormX68(FormX68, x68RS, x68RA, x68RB, x68Rc)
  , FormX69(FormX69, x69RSp, x69RA, x69RB)
  , FormX70(FormX70, x70RT)
  , FormX71(FormX71, x71RT, x71RB)
  , FormX72(FormX72, x72RT, x72RB)
  , FormX73(FormX73, x73RT, x73L)
  , FormX74(FormX74, x74RT, x74SR)
  , FormX75(FormX75, x75RT, x75RA, x75FC)
  , FormX76(FormX76, x76RT, x76RA, x76NB)
  , FormX77(FormX77, x77RT, x77RA, x77RB)
  , FormX78(FormX78, x78RT, x78RA, x78RB, x78EH)
  , FormX79(FormX79, x79RTp, x79RA, x79RB, x79EH)
  , FormX80(FormX80, x80S, x80RA, x80SX)
  , FormX81(FormX81, x81S, x81RA, x81RB, x81SX)
  , FormX82(FormX82, x82T, x82EO, x82IMM8, x82TX)
  , FormX83(FormX83, x83T, x83RA, x83TX)
  , FormX84(FormX84, x84T, x84RA, x84RB, x84TX)
  , FormX85(FormX85, x85TH, x85RA, x85RB)
  , FormX86(FormX86, x86TO, x86RA, x86SI)
  , FormX87(FormX87, x87TO, x87RA, x87RB)
  , FormX88(FormX88, x88TO, x88RA, x88RB)
  , FormX89(FormX89, x89VRS, x89RA, x89RB)
  , FormX90(FormX90, x90VRT, x90EO, x90VRB)
  , FormX91(FormX91, x91VRT, x91EO, x91VRB, x91RO)
  , FormX92(FormX92, x92VRT, x92RA, x92RB)
  , FormX93(FormX93, x93VRT, x93VRA, x93VRB)
  , FormX94(FormX94, x94VRT, x94VRA, x94VRB, x94RO)
  , FormXFL1(FormXFL1, xfl1L, xfl1FLM, xfl1W, xfl1FRB, xfl1Rc)
  , FormXFX1(FormXFX1)
  , FormXFX2(FormXFX2, xfx2RS, xfx2FXM)
  , FormXFX3(FormXFX3, xfx3RS, xfx3FXM)
  , FormXFX4(FormXFX4, xfx4RS, xfx4spr)
  , FormXFX5(FormXFX5, xfx5RT)
  , FormXFX6(FormXFX6, xfx6RT, xfx6FXM)
  , FormXFX7(FormXFX7, xfx7RT, xfx7BHRBE)
  , FormXFX8(FormXFX8, xfx8RT, xfx8spr)
  , FormXFX9(FormXFX9, xfx9RT, xfx9tbr)
  , FormXL1(FormXL1)
  , FormXL2(FormXL2, xl2S)
  , FormXL3(FormXL3, xl3BF, xl3BFA)
  , FormXL4(FormXL4, xl4BO, xl4BI, xl4BH, xl4LK)
  , FormXL5(FormXL5, xl5BT, xl5BA, xl5BB)
  , FormXO1(FormXO1, xo1RT, xo1RA, xo1OE, xo1Rc)
  , FormXO2(FormXO2, xo2RT, xo2RA, xo2RB)
  , FormXO3(FormXO3, xo3RT, xo3RA, xo3RB, xo3Rc)
  , FormXO4(FormXO4, xo4RT, xo4RA, xo4RB, xo4OE, xo4Rc)
  , FormXS1(FormXS1, xs1RS, xs1RA, xs1Rc)
  , FormXX2_1(FormXX2_1, xx2_1BF, xx2_1B, xx2_1BX)
  , FormXX2_2(FormXX2_2, xx2_2BF, xx2_2DCMX, xx2_2B, xx2_2BX)
  , FormXX2_3(FormXX2_3, xx2_3RT, xx2_3EO, xx2_3B, xx2_3BX)
  , FormXX2_4(FormXX2_4, xx2_4T, xx2_4B, xx2_4BX, xx2_4TX)
  , FormXX2_5(FormXX2_5, xx2_5T, xx2_5UIM, xx2_5B, xx2_5BX, xx2_5TX)
  , FormXX2_6(FormXX2_6, xx2_6T, xx2_6UIM, xx2_6B, xx2_6BX, xx2_6TX)
  , FormXX2_7(FormXX2_7, xx2_7T, xx2_7dx, xx2_7B, xx2_7dc, xx2_7dm, xx2_7BX, xx2_7TX)
  , FormXX2_8(FormXX2_8, xx2_8T, xx2_8EO, xx2_8B, xx2_8BX, xx2_8TX)
  , FormXX3_1(FormXX3_1, xx3_1BF, xx3_1A, xx3_1B, xx3_1AX, xx3_1BX)
  , FormXX3_2(FormXX3_2, xx3_2T, xx3_2A, xx3_2B, xx3_2DM, xx3_2AX, xx3_2BX, xx3_2TX)
  , FormXX3_3(FormXX3_3, xx3_3T, xx3_3A, xx3_3B, xx3_3SHW, xx3_3AX, xx3_3BX, xx3_3TX)
  , FormXX3_4(FormXX3_4, xx3_4T, xx3_4A, xx3_4B, xx3_4Rc, xx3_4AX, xx3_4BX, xx3_4TX)
  , FormXX3_5(FormXX3_5, xx3_5T, xx3_5A, xx3_5B, xx3_5AX, xx3_5BX, xx3_5TX)
  , FormXX4_1(FormXX4_1, xx4_1T, xx4_1A, xx4_1B, xx4_1C, xx4_1CX, xx4_1AX, xx4_1BX, xx4_1TX)
  , FormZ22_1(FormZ22_1, z22_1BF, z22_1FRA, z22_1DCM)
  , FormZ22_2(FormZ22_2, z22_2BF, z22_2FRA, z22_2DGM)
  , FormZ22_3(FormZ22_3, z22_3BF, z22_3FRAp, z22_3DCM)
  , FormZ22_4(FormZ22_4, z22_4BF, z22_4FRAp, z22_4DGM)
  , FormZ22_5(FormZ22_5, z22_5FRT, z22_5FRA, z22_5SH, z22_5Rc)
  , FormZ22_6(FormZ22_6, z22_6FRTp, z22_6FRAp, z22_6SH, z22_6Rc)
  , FormZ23_1(FormZ23_1, z23_1FRT, z23_1R, z23_1FRB, z23_1RMC, z23_1Rc)
  , FormZ23_2(FormZ23_2, z23_2FRT, z23_2FRA, z23_2FRB, z23_2RMC, z23_2Rc)
  , FormZ23_3(FormZ23_3, z23_3FRT, z23_3TE, z23_3FRB, z23_3RMC, z23_3Rc)
  , FormZ23_4(FormZ23_4, z23_4FRTp, z23_4R, z23_4FRBp, z23_4RMC, z23_4Rc)
  , FormZ23_5(FormZ23_5, z23_5FRTp, z23_5FRAp, z23_5FRBp, z23_5RMC, z23_5Rc)
  , FormZ23_6(FormZ23_6, z23_6FRTp, z23_6FRAp, z23_6FRBp, z23_6RMC, z23_6Rc)
  , FormZ23_7(FormZ23_7, z23_7FRTp, z23_7TE, z23_7FRBp, z23_7RMC, z23_7Rc)
  , FormZ23_8(FormZ23_8, z23_8VRT, z23_8R, z23_8VRB, z23_8RMC)
  , FormZ23_9(FormZ23_9, z23_9VRT, z23_9R, z23_9VRB, z23_9RMC, z23_9EX)
  ) where

import Clash.Prelude

data Form
  = A1 FormA1
  | A2 FormA2
  | A3 FormA3
  | A4 FormA4
  | A5 FormA5
  | B1 FormB1
  | D1 FormD1
  | D2 FormD2
  | D3 FormD3
  | D4 FormD4
  | D5 FormD5
  | D6 FormD6
  | D7 FormD7
  | D8 FormD8
  | D9 FormD9
  | DQ1 FormDQ1
  | DQ2 FormDQ2
  | DQ3 FormDQ3
  | DS1 FormDS1
  | DS2 FormDS2
  | DS3 FormDS3
  | DS4 FormDS4
  | DS5 FormDS5
  | DS6 FormDS6
  | DS7 FormDS7
  | DX1 FormDX1
  | I1 FormI1
  | M1 FormM1
  | M2 FormM2
  | MD1 FormMD1
  | MD2 FormMD2
  | MDS1 FormMDS1
  | MDS2 FormMDS2
  | SC1 FormSC1
  | VA1 FormVA1
  | VA2 FormVA2
  | VA3 FormVA3
  | VC1 FormVC1
  | VX1 FormVX1
  | VX2 FormVX2
  | VX3 FormVX3
  | VX4 FormVX4
  | VX5 FormVX5
  | VX6 FormVX6
  | VX7 FormVX7
  | VX8 FormVX8
  | VX9 FormVX9
  | VX10 FormVX10
  | VX11 FormVX11
  | VX12 FormVX12
  | VX13 FormVX13
  | VX14 FormVX14
  | VX15 FormVX15
  | VX16 FormVX16
  | VX17 FormVX17
  | X1 FormX1
  | X2 FormX2
  | X3 FormX3
  | X4 FormX4
  | X5 FormX5
  | X6 FormX6
  | X7 FormX7
  | X8 FormX8
  | X9 FormX9
  | X10 FormX10
  | X11 FormX11
  | X12 FormX12
  | X13 FormX13
  | X14 FormX14
  | X15 FormX15
  | X16 FormX16
  | X17 FormX17
  | X18 FormX18
  | X19 FormX19
  | X20 FormX20
  | X21 FormX21
  | X22 FormX22
  | X23 FormX23
  | X24 FormX24
  | X25 FormX25
  | X26 FormX26
  | X27 FormX27
  | X28 FormX28
  | X29 FormX29
  | X30 FormX30
  | X31 FormX31
  | X32 FormX32
  | X33 FormX33
  | X34 FormX34
  | X35 FormX35
  | X36 FormX36
  | X37 FormX37
  | X38 FormX38
  | X39 FormX39
  | X40 FormX40
  | X41 FormX41
  | X42 FormX42
  | X43 FormX43
  | X44 FormX44
  | X45 FormX45
  | X46 FormX46
  | X47 FormX47
  | X48 FormX48
  | X49 FormX49
  | X50 FormX50
  | X51 FormX51
  | X52 FormX52
  | X53 FormX53
  | X54 FormX54
  | X55 FormX55
  | X56 FormX56
  | X57 FormX57
  | X58 FormX58
  | X59 FormX59
  | X60 FormX60
  | X61 FormX61
  | X62 FormX62
  | X63 FormX63
  | X64 FormX64
  | X65 FormX65
  | X66 FormX66
  | X67 FormX67
  | X68 FormX68
  | X69 FormX69
  | X70 FormX70
  | X71 FormX71
  | X72 FormX72
  | X73 FormX73
  | X74 FormX74
  | X75 FormX75
  | X76 FormX76
  | X77 FormX77
  | X78 FormX78
  | X79 FormX79
  | X80 FormX80
  | X81 FormX81
  | X82 FormX82
  | X83 FormX83
  | X84 FormX84
  | X85 FormX85
  | X86 FormX86
  | X87 FormX87
  | X88 FormX88
  | X89 FormX89
  | X90 FormX90
  | X91 FormX91
  | X92 FormX92
  | X93 FormX93
  | X94 FormX94
  | XFL1 FormXFL1
  | XFX1 FormXFX1
  | XFX2 FormXFX2
  | XFX3 FormXFX3
  | XFX4 FormXFX4
  | XFX5 FormXFX5
  | XFX6 FormXFX6
  | XFX7 FormXFX7
  | XFX8 FormXFX8
  | XFX9 FormXFX9
  | XL1 FormXL1
  | XL2 FormXL2
  | XL3 FormXL3
  | XL4 FormXL4
  | XL5 FormXL5
  | XO1 FormXO1
  | XO2 FormXO2
  | XO3 FormXO3
  | XO4 FormXO4
  | XS1 FormXS1
  | XX2_1 FormXX2_1
  | XX2_2 FormXX2_2
  | XX2_3 FormXX2_3
  | XX2_4 FormXX2_4
  | XX2_5 FormXX2_5
  | XX2_6 FormXX2_6
  | XX2_7 FormXX2_7
  | XX2_8 FormXX2_8
  | XX3_1 FormXX3_1
  | XX3_2 FormXX3_2
  | XX3_3 FormXX3_3
  | XX3_4 FormXX3_4
  | XX3_5 FormXX3_5
  | XX4_1 FormXX4_1
  | Z22_1 FormZ22_1
  | Z22_2 FormZ22_2
  | Z22_3 FormZ22_3
  | Z22_4 FormZ22_4
  | Z22_5 FormZ22_5
  | Z22_6 FormZ22_6
  | Z23_1 FormZ23_1
  | Z23_2 FormZ23_2
  | Z23_3 FormZ23_3
  | Z23_4 FormZ23_4
  | Z23_5 FormZ23_5
  | Z23_6 FormZ23_6
  | Z23_7 FormZ23_7
  | Z23_8 FormZ23_8
  | Z23_9 FormZ23_9
  deriving (Generic, Show, Eq, NFDataX)

data FormA1 = FormA1 {  a1FRT     :: Unsigned 5,
  a1FRB     :: Unsigned 5,
  a1Rc      :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormA2 = FormA2 {  a2FRT     :: Unsigned 5,
  a2FRA     :: Unsigned 5,
  a2FRC     :: Unsigned 5,
  a2Rc      :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormA3 = FormA3 {  a3FRT     :: Unsigned 5,
  a3FRA     :: Unsigned 5,
  a3FRB     :: Unsigned 5,
  a3Rc      :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormA4 = FormA4 {  a4FRT     :: Unsigned 5,
  a4FRA     :: Unsigned 5,
  a4FRB     :: Unsigned 5,
  a4FRC     :: Unsigned 5,
  a4Rc      :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormA5 = FormA5 {  a5RT      :: Unsigned 5,
  a5RA      :: Unsigned 5,
  a5RB      :: Unsigned 5,
  a5BC      :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormB1 = FormB1 {  b1BO      :: Unsigned 5,
  b1BI      :: Unsigned 5,
  b1BD      :: Unsigned 14,
  b1AA      :: Unsigned 1,
  b1LK      :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormD1 = FormD1 {  d1BF      :: Unsigned 3,
  d1L       :: Unsigned 1,
  d1RA      :: Unsigned 5,
  d1SI      :: Unsigned 16 }
  deriving (Generic, Show, Eq, NFDataX)

data FormD2 = FormD2 {  d2BF      :: Unsigned 3,
  d2L       :: Unsigned 1,
  d2RA      :: Unsigned 5,
  d2UI      :: Unsigned 16 }
  deriving (Generic, Show, Eq, NFDataX)

data FormD3 = FormD3 {  d3FRS     :: Unsigned 5,
  d3RA      :: Unsigned 5,
  d3D       :: Unsigned 16 }
  deriving (Generic, Show, Eq, NFDataX)

data FormD4 = FormD4 {  d4FRT     :: Unsigned 5,
  d4RA      :: Unsigned 5,
  d4D       :: Unsigned 16 }
  deriving (Generic, Show, Eq, NFDataX)

data FormD5 = FormD5 {  d5RS      :: Unsigned 5,
  d5RA      :: Unsigned 5,
  d5D       :: Unsigned 16 }
  deriving (Generic, Show, Eq, NFDataX)

data FormD6 = FormD6 {  d6RS      :: Unsigned 5,
  d6RA      :: Unsigned 5,
  d6UI      :: Unsigned 16 }
  deriving (Generic, Show, Eq, NFDataX)

data FormD7 = FormD7 {  d7RT      :: Unsigned 5,
  d7RA      :: Unsigned 5,
  d7D       :: Unsigned 16 }
  deriving (Generic, Show, Eq, NFDataX)

data FormD8 = FormD8 {  d8RT      :: Unsigned 5,
  d8RA      :: Unsigned 5,
  d8SI      :: Unsigned 16 }
  deriving (Generic, Show, Eq, NFDataX)

data FormD9 = FormD9 {  d9TO      :: Unsigned 5,
  d9RA      :: Unsigned 5,
  d9SI      :: Unsigned 16 }
  deriving (Generic, Show, Eq, NFDataX)

data FormDQ1 = FormDQ1 {  dq1RTp    :: Unsigned 5,
  dq1RA     :: Unsigned 5,
  dq1DQ     :: Unsigned 12,
  dq1PT     :: Unsigned 4 }
  deriving (Generic, Show, Eq, NFDataX)

data FormDQ2 = FormDQ2 {  dq2S      :: Unsigned 5,
  dq2RA     :: Unsigned 5,
  dq2DQ     :: Unsigned 12,
  dq2SX     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormDQ3 = FormDQ3 {  dq3TO     :: Unsigned 5,
  dq3RA     :: Unsigned 5,
  dq3DQ     :: Unsigned 12,
  dq3TX     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormDS1 = FormDS1 {  ds1FRSp   :: Unsigned 5,
  ds1RA     :: Unsigned 5,
  ds1DS     :: Unsigned 14 }
  deriving (Generic, Show, Eq, NFDataX)

data FormDS2 = FormDS2 {  ds2FRTp   :: Unsigned 5,
  ds2RA     :: Unsigned 5,
  ds2DS     :: Unsigned 14 }
  deriving (Generic, Show, Eq, NFDataX)

data FormDS3 = FormDS3 {  ds3RS     :: Unsigned 5,
  ds3RA     :: Unsigned 5,
  ds3DS     :: Unsigned 14 }
  deriving (Generic, Show, Eq, NFDataX)

data FormDS4 = FormDS4 {  ds4RSp    :: Unsigned 5,
  ds4RA     :: Unsigned 5,
  ds4DS     :: Unsigned 14 }
  deriving (Generic, Show, Eq, NFDataX)

data FormDS5 = FormDS5 {  ds5RT     :: Unsigned 5,
  ds5RA     :: Unsigned 5,
  ds5DS     :: Unsigned 14 }
  deriving (Generic, Show, Eq, NFDataX)

data FormDS6 = FormDS6 {  ds6VRS    :: Unsigned 5,
  ds6RA     :: Unsigned 5,
  ds6DS     :: Unsigned 14 }
  deriving (Generic, Show, Eq, NFDataX)

data FormDS7 = FormDS7 {  ds7VRT    :: Unsigned 5,
  ds7RA     :: Unsigned 5,
  ds7DS     :: Unsigned 14 }
  deriving (Generic, Show, Eq, NFDataX)

data FormDX1 = FormDX1 {  dx1RT     :: Unsigned 5,
  dx1d1     :: Unsigned 5,
  dx1d0     :: Unsigned 10,
  dx1d2     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormI1 = FormI1 {  i1LI      :: Unsigned 24,
  i1AA      :: Unsigned 1,
  i1LK      :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormM1 = FormM1 {  m1RS      :: Unsigned 5,
  m1RA      :: Unsigned 5,
  m1RB      :: Unsigned 5,
  m1MB      :: Unsigned 5,
  m1ME      :: Unsigned 5,
  m1Rc      :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormM2 = FormM2 {  m2RS      :: Unsigned 5,
  m2RA      :: Unsigned 5,
  m2SH      :: Unsigned 5,
  m2MB      :: Unsigned 5,
  m2ME      :: Unsigned 5,
  m2Rc      :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormMD1 = FormMD1 {  md1RS     :: Unsigned 5,
  md1RA     :: Unsigned 5,
  md1mb     :: Unsigned 6,
  md1Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormMD2 = FormMD2 {  md2RS     :: Unsigned 5,
  md2RA     :: Unsigned 5,
  md2me     :: Unsigned 6,
  md2Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormMDS1 = FormMDS1 {  mds1RS    :: Unsigned 5,
  mds1RA    :: Unsigned 5,
  mds1RB    :: Unsigned 5,
  mds1mb    :: Unsigned 6,
  mds1Rc    :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormMDS2 = FormMDS2 {  mds2RS    :: Unsigned 5,
  mds2RA    :: Unsigned 5,
  mds2RB    :: Unsigned 5,
  mds2me    :: Unsigned 6,
  mds2Rc    :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormSC1 = FormSC1 {  sc1LEV    :: Unsigned 7 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVA1 = FormVA1 {  va1RT     :: Unsigned 5,
  va1RA     :: Unsigned 5,
  va1RB     :: Unsigned 5,
  va1RC     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVA2 = FormVA2 {  va2VRT    :: Unsigned 5,
  va2VRA    :: Unsigned 5,
  va2VRB    :: Unsigned 5,
  va2SHB    :: Unsigned 4 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVA3 = FormVA3 {  va3VRT    :: Unsigned 5,
  va3VRA    :: Unsigned 5,
  va3VRB    :: Unsigned 5,
  va3VRC    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVC1 = FormVC1 {  vc1VRT    :: Unsigned 5,
  vc1VRA    :: Unsigned 5,
  vc1VRB    :: Unsigned 5,
  vc1Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX1 = FormVX1 {  vx1VRB    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX2 = FormVX2 {  vx2RT     :: Unsigned 5,
  vx2EO     :: Unsigned 5,
  vx2VRB    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX3 = FormVX3 {  vx3VRT    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX4 = FormVX4 {  vx4VRT    :: Unsigned 5,
  vx4VRB    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX5 = FormVX5 {  vx5VRT    :: Unsigned 5,
  vx5UIM    :: Unsigned 2,
  vx5VRB    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX6 = FormVX6 {  vx6VRT    :: Unsigned 5,
  vx6UIM    :: Unsigned 3,
  vx6VRB    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX7 = FormVX7 {  vx7VRT    :: Unsigned 5,
  vx7UIM    :: Unsigned 4,
  vx7VRB    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX8 = FormVX8 {  vx8VRT    :: Unsigned 5,
  vx8EO     :: Unsigned 5,
  vx8VRB    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX9 = FormVX9 {  vx9VRT    :: Unsigned 5,
  vx9EO     :: Unsigned 5,
  vx9VRB    :: Unsigned 5,
  vx9PS     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX10 = FormVX10 {  vx10VRT   :: Unsigned 5,
  vx10EO    :: Unsigned 5,
  vx10VRB   :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX11 = FormVX11 {  vx11VRT   :: Unsigned 5,
  vx11RA    :: Unsigned 5,
  vx11VRB   :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX12 = FormVX12 {  vx12VRT   :: Unsigned 5,
  vx12SIM   :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX13 = FormVX13 {  vx13VRT   :: Unsigned 5,
  vx13UIM   :: Unsigned 5,
  vx13VRB   :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX14 = FormVX14 {  vx14VRT   :: Unsigned 5,
  vx14VRA   :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX15 = FormVX15 {  vx15VRT   :: Unsigned 5,
  vx15VRA   :: Unsigned 5,
  vx15VRB   :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX16 = FormVX16 {  vx16VRT   :: Unsigned 5,
  vx16VRA   :: Unsigned 5,
  vx16VRB   :: Unsigned 5,
  vx16PS    :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormVX17 = FormVX17 {  vx17VRT   :: Unsigned 5,
  vx17VRA   :: Unsigned 5,
  vx17VRB   :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX1 = FormX1 { }
  deriving (Generic, Show, Eq, NFDataX)

data FormX2 = FormX2 { }
  deriving (Generic, Show, Eq, NFDataX)

data FormX3 = FormX3 {  x3RB      :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX4 = FormX4 {  x4RA      :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX5 = FormX5 {  x5RA      :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX6 = FormX6 {  x6RA      :: Unsigned 5,
  x6RB      :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX7 = FormX7 {  x7L       :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX8 = FormX8 {  x8L       :: Unsigned 1,
  x8RB      :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX9 = FormX9 {  x9RA      :: Unsigned 5,
  x9RB      :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX10 = FormX10 {  x10L      :: Unsigned 1,
  x10RA     :: Unsigned 5,
  x10RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX11 = FormX11 {  x11L      :: Unsigned 2 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX12 = FormX12 {  x12L      :: Unsigned 2,
  x12RA     :: Unsigned 5,
  x12RB     :: Unsigned 5,
  x12Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX13 = FormX13 {  x13WC     :: Unsigned 2 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX14 = FormX14 {  x14IH     :: Unsigned 3 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX15 = FormX15 {  x15CT     :: Unsigned 4,
  x15RA     :: Unsigned 5,
  x15RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX16 = FormX16 {  x16A      :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX17 = FormX17 {  x17A      :: Unsigned 1,
  x17R      :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX18 = FormX18 {  x18BF     :: Unsigned 3 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX19 = FormX19 {  x19BF     :: Unsigned 3,
  x19FRB    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX20 = FormX20 {  x20BF     :: Unsigned 3,
  x20W      :: Unsigned 1,
  x20U      :: Unsigned 4,
  x20Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX21 = FormX21 {  x21BF     :: Unsigned 3,
  x21BFA    :: Unsigned 3 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX22 = FormX22 {  x22BF     :: Unsigned 3,
  x22FRA    :: Unsigned 5,
  x22FRB    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX23 = FormX23 {  x23BF     :: Unsigned 3,
  x23FRAp   :: Unsigned 5,
  x23FRBp   :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX24 = FormX24 {  x24BF     :: Unsigned 3,
  x24FRAp   :: Unsigned 5,
  x24FRBp   :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX25 = FormX25 {  x25BF     :: Unsigned 3,
  x25RA     :: Unsigned 5,
  x25RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX26 = FormX26 {  x26BF     :: Unsigned 3,
  x26UIM    :: Unsigned 5,
  x26FRBp   :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX27 = FormX27 {  x27BF     :: Unsigned 3,
  x27UIM    :: Unsigned 5,
  x27FRBp   :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX28 = FormX28 {  x28BF     :: Unsigned 3,
  x28VRA    :: Unsigned 5,
  x28VRB    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX29 = FormX29 {  x29BF     :: Unsigned 3,
  x29RA     :: Unsigned 5,
  x29RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX30 = FormX30 {  x30BF     :: Unsigned 3,
  x30L      :: Unsigned 1,
  x30RA     :: Unsigned 5,
  x30RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX31 = FormX31 {  x31BF     :: Unsigned 3,
  x31DCMX   :: Unsigned 7,
  x31VRB    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX32 = FormX32 {  x32BT     :: Unsigned 5,
  x32Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX33 = FormX33 {  x33FRS    :: Unsigned 5,
  x33RA     :: Unsigned 5,
  x33RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX34 = FormX34 {  x34FRSp   :: Unsigned 5,
  x34RA     :: Unsigned 5,
  x34RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX35 = FormX35 {  x35FRT    :: Unsigned 5,
  x35Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX36 = FormX36 {  x36FRT    :: Unsigned 5,
  x36FRB    :: Unsigned 5,
  x36Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX37 = FormX37 {  x37FRT    :: Unsigned 5,
  x37FRBp   :: Unsigned 5,
  x37Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX38 = FormX38 {  x38FRT    :: Unsigned 5,
  x38EO     :: Unsigned 5,
  x38Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX39 = FormX39 {  x39FRT    :: Unsigned 5,
  x39EO     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX40 = FormX40 {  x40FRT    :: Unsigned 5,
  x40EO     :: Unsigned 5,
  x40RM     :: Unsigned 2 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX41 = FormX41 {  x41FRT    :: Unsigned 5,
  x41EO     :: Unsigned 5,
  x41DRM    :: Unsigned 3 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX42 = FormX42 {  x42FRT    :: Unsigned 5,
  x42EO     :: Unsigned 5,
  x42FRB    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX43 = FormX43 {  x43FRT    :: Unsigned 5,
  x43FRA    :: Unsigned 5,
  x43FRB    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX44 = FormX44 {  x44FRT    :: Unsigned 5,
  x44FRA    :: Unsigned 5,
  x44FRB    :: Unsigned 5,
  x44Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX45 = FormX45 {  x45FRT    :: Unsigned 5,
  x45RA     :: Unsigned 5,
  x45RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX46 = FormX46 {  x46FRT    :: Unsigned 5,
  x46S      :: Unsigned 1,
  x46FRB    :: Unsigned 5,
  x46Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX47 = FormX47 {  x47FRT    :: Unsigned 5,
  x47SP     :: Unsigned 2,
  x47FRB    :: Unsigned 5,
  x47Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX48 = FormX48 {  x48FRTp   :: Unsigned 5,
  x48FRB    :: Unsigned 5,
  x48Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX49 = FormX49 {  x49FRTp   :: Unsigned 5,
  x49FRBp   :: Unsigned 5,
  x49Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX50 = FormX50 {  x50FRTp   :: Unsigned 5,
  x50FRA    :: Unsigned 5,
  x50FRBp   :: Unsigned 5,
  x50Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX51 = FormX51 {  x51FRTp   :: Unsigned 5,
  x51FRAp   :: Unsigned 5,
  x51FRBp   :: Unsigned 5,
  x51Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX52 = FormX52 {  x52FRTp   :: Unsigned 5,
  x52RA     :: Unsigned 5,
  x52RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX53 = FormX53 {  x53FRTp   :: Unsigned 5,
  x53S      :: Unsigned 1,
  x53FRBp   :: Unsigned 5,
  x53Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX54 = FormX54 {  x54FRTp   :: Unsigned 5,
  x54SP     :: Unsigned 2,
  x54FRBp   :: Unsigned 5,
  x54Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX55 = FormX55 {  x55RS     :: Unsigned 5,
  x55RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX56 = FormX56 {  x56RS     :: Unsigned 5,
  x56L      :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX57 = FormX57 {  x57RS     :: Unsigned 5,
  x57RIC    :: Unsigned 2,
  x57PR     :: Unsigned 1,
  x57R      :: Unsigned 1,
  x57RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX58 = FormX58 {  x58RS     :: Unsigned 5,
  x58SR     :: Unsigned 4 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX59 = FormX59 {  x59RS     :: Unsigned 5,
  x59BFA    :: Unsigned 3 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX60 = FormX60 {  x60RS     :: Unsigned 5,
  x60RA     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX61 = FormX61 {  x61RS     :: Unsigned 5,
  x61RA     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX62 = FormX62 {  x62RS     :: Unsigned 5,
  x62RA     :: Unsigned 5,
  x62Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX63 = FormX63 {  x63RS     :: Unsigned 5,
  x63RA     :: Unsigned 5,
  x63FC     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX64 = FormX64 {  x64RS     :: Unsigned 5,
  x64RA     :: Unsigned 5,
  x64NB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX65 = FormX65 {  x65RS     :: Unsigned 5,
  x65RA     :: Unsigned 5,
  x65SH     :: Unsigned 5,
  x65Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX66 = FormX66 {  x66RS     :: Unsigned 5,
  x66RA     :: Unsigned 5,
  x66RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX67 = FormX67 {  x67RS     :: Unsigned 5,
  x67RA     :: Unsigned 5,
  x67RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX68 = FormX68 {  x68RS     :: Unsigned 5,
  x68RA     :: Unsigned 5,
  x68RB     :: Unsigned 5,
  x68Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX69 = FormX69 {  x69RSp    :: Unsigned 5,
  x69RA     :: Unsigned 5,
  x69RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX70 = FormX70 {  x70RT     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX71 = FormX71 {  x71RT     :: Unsigned 5,
  x71RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX72 = FormX72 {  x72RT     :: Unsigned 5,
  x72RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX73 = FormX73 {  x73RT     :: Unsigned 5,
  x73L      :: Unsigned 2 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX74 = FormX74 {  x74RT     :: Unsigned 5,
  x74SR     :: Unsigned 4 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX75 = FormX75 {  x75RT     :: Unsigned 5,
  x75RA     :: Unsigned 5,
  x75FC     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX76 = FormX76 {  x76RT     :: Unsigned 5,
  x76RA     :: Unsigned 5,
  x76NB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX77 = FormX77 {  x77RT     :: Unsigned 5,
  x77RA     :: Unsigned 5,
  x77RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX78 = FormX78 {  x78RT     :: Unsigned 5,
  x78RA     :: Unsigned 5,
  x78RB     :: Unsigned 5,
  x78EH     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX79 = FormX79 {  x79RTp    :: Unsigned 5,
  x79RA     :: Unsigned 5,
  x79RB     :: Unsigned 5,
  x79EH     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX80 = FormX80 {  x80S      :: Unsigned 5,
  x80RA     :: Unsigned 5,
  x80SX     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX81 = FormX81 {  x81S      :: Unsigned 5,
  x81RA     :: Unsigned 5,
  x81RB     :: Unsigned 5,
  x81SX     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX82 = FormX82 {  x82T      :: Unsigned 5,
  x82EO     :: Unsigned 2,
  x82IMM8   :: Unsigned 8,
  x82TX     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX83 = FormX83 {  x83T      :: Unsigned 5,
  x83RA     :: Unsigned 5,
  x83TX     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX84 = FormX84 {  x84T      :: Unsigned 5,
  x84RA     :: Unsigned 5,
  x84RB     :: Unsigned 5,
  x84TX     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX85 = FormX85 {  x85TH     :: Unsigned 5,
  x85RA     :: Unsigned 5,
  x85RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX86 = FormX86 {  x86TO     :: Unsigned 5,
  x86RA     :: Unsigned 5,
  x86SI     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX87 = FormX87 {  x87TO     :: Unsigned 5,
  x87RA     :: Unsigned 5,
  x87RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX88 = FormX88 {  x88TO     :: Unsigned 5,
  x88RA     :: Unsigned 5,
  x88RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX89 = FormX89 {  x89VRS    :: Unsigned 5,
  x89RA     :: Unsigned 5,
  x89RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX90 = FormX90 {  x90VRT    :: Unsigned 5,
  x90EO     :: Unsigned 5,
  x90VRB    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX91 = FormX91 {  x91VRT    :: Unsigned 5,
  x91EO     :: Unsigned 5,
  x91VRB    :: Unsigned 5,
  x91RO     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX92 = FormX92 {  x92VRT    :: Unsigned 5,
  x92RA     :: Unsigned 5,
  x92RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX93 = FormX93 {  x93VRT    :: Unsigned 5,
  x93VRA    :: Unsigned 5,
  x93VRB    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormX94 = FormX94 {  x94VRT    :: Unsigned 5,
  x94VRA    :: Unsigned 5,
  x94VRB    :: Unsigned 5,
  x94RO     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXFL1 = FormXFL1 {  xfl1L     :: Unsigned 1,
  xfl1FLM   :: Unsigned 8,
  xfl1W     :: Unsigned 1,
  xfl1FRB   :: Unsigned 5,
  xfl1Rc    :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXFX1 = FormXFX1 { }
  deriving (Generic, Show, Eq, NFDataX)

data FormXFX2 = FormXFX2 {  xfx2RS    :: Unsigned 5,
  xfx2FXM   :: Unsigned 8 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXFX3 = FormXFX3 {  xfx3RS    :: Unsigned 5,
  xfx3FXM   :: Unsigned 8 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXFX4 = FormXFX4 {  xfx4RS    :: Unsigned 5,
  xfx4spr   :: Unsigned 10 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXFX5 = FormXFX5 {  xfx5RT    :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXFX6 = FormXFX6 {  xfx6RT    :: Unsigned 5,
  xfx6FXM   :: Unsigned 8 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXFX7 = FormXFX7 {  xfx7RT    :: Unsigned 5,
  xfx7BHRBE :: Unsigned 10 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXFX8 = FormXFX8 {  xfx8RT    :: Unsigned 5,
  xfx8spr   :: Unsigned 10 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXFX9 = FormXFX9 {  xfx9RT    :: Unsigned 5,
  xfx9tbr   :: Unsigned 10 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXL1 = FormXL1 { }
  deriving (Generic, Show, Eq, NFDataX)

data FormXL2 = FormXL2 {  xl2S      :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXL3 = FormXL3 {  xl3BF     :: Unsigned 3,
  xl3BFA    :: Unsigned 3 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXL4 = FormXL4 {  xl4BO     :: Unsigned 5,
  xl4BI     :: Unsigned 5,
  xl4BH     :: Unsigned 2,
  xl4LK     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXL5 = FormXL5 {  xl5BT     :: Unsigned 5,
  xl5BA     :: Unsigned 5,
  xl5BB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXO1 = FormXO1 {  xo1RT     :: Unsigned 5,
  xo1RA     :: Unsigned 5,
  xo1OE     :: Unsigned 1,
  xo1Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXO2 = FormXO2 {  xo2RT     :: Unsigned 5,
  xo2RA     :: Unsigned 5,
  xo2RB     :: Unsigned 5 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXO3 = FormXO3 {  xo3RT     :: Unsigned 5,
  xo3RA     :: Unsigned 5,
  xo3RB     :: Unsigned 5,
  xo3Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXO4 = FormXO4 {  xo4RT     :: Unsigned 5,
  xo4RA     :: Unsigned 5,
  xo4RB     :: Unsigned 5,
  xo4OE     :: Unsigned 1,
  xo4Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXS1 = FormXS1 {  xs1RS     :: Unsigned 5,
  xs1RA     :: Unsigned 5,
  xs1Rc     :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXX2_1 = FormXX2_1 {  xx2_1BF   :: Unsigned 3,
  xx2_1B    :: Unsigned 5,
  xx2_1BX   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXX2_2 = FormXX2_2 {  xx2_2BF   :: Unsigned 3,
  xx2_2DCMX :: Unsigned 7,
  xx2_2B    :: Unsigned 5,
  xx2_2BX   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXX2_3 = FormXX2_3 {  xx2_3RT   :: Unsigned 5,
  xx2_3EO   :: Unsigned 5,
  xx2_3B    :: Unsigned 5,
  xx2_3BX   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXX2_4 = FormXX2_4 {  xx2_4T    :: Unsigned 5,
  xx2_4B    :: Unsigned 5,
  xx2_4BX   :: Unsigned 1,
  xx2_4TX   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXX2_5 = FormXX2_5 {  xx2_5T    :: Unsigned 5,
  xx2_5UIM  :: Unsigned 2,
  xx2_5B    :: Unsigned 5,
  xx2_5BX   :: Unsigned 1,
  xx2_5TX   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXX2_6 = FormXX2_6 {  xx2_6T    :: Unsigned 5,
  xx2_6UIM  :: Unsigned 4,
  xx2_6B    :: Unsigned 5,
  xx2_6BX   :: Unsigned 1,
  xx2_6TX   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXX2_7 = FormXX2_7 {  xx2_7T    :: Unsigned 5,
  xx2_7dx   :: Unsigned 5,
  xx2_7B    :: Unsigned 5,
  xx2_7dc   :: Unsigned 1,
  xx2_7dm   :: Unsigned 1,
  xx2_7BX   :: Unsigned 1,
  xx2_7TX   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXX2_8 = FormXX2_8 {  xx2_8T    :: Unsigned 5,
  xx2_8EO   :: Unsigned 5,
  xx2_8B    :: Unsigned 5,
  xx2_8BX   :: Unsigned 1,
  xx2_8TX   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXX3_1 = FormXX3_1 {  xx3_1BF   :: Unsigned 3,
  xx3_1A    :: Unsigned 5,
  xx3_1B    :: Unsigned 5,
  xx3_1AX   :: Unsigned 1,
  xx3_1BX   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXX3_2 = FormXX3_2 {  xx3_2T    :: Unsigned 5,
  xx3_2A    :: Unsigned 5,
  xx3_2B    :: Unsigned 5,
  xx3_2DM   :: Unsigned 2,
  xx3_2AX   :: Unsigned 1,
  xx3_2BX   :: Unsigned 1,
  xx3_2TX   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXX3_3 = FormXX3_3 {  xx3_3T    :: Unsigned 5,
  xx3_3A    :: Unsigned 5,
  xx3_3B    :: Unsigned 5,
  xx3_3SHW  :: Unsigned 2,
  xx3_3AX   :: Unsigned 1,
  xx3_3BX   :: Unsigned 1,
  xx3_3TX   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXX3_4 = FormXX3_4 {  xx3_4T    :: Unsigned 5,
  xx3_4A    :: Unsigned 5,
  xx3_4B    :: Unsigned 5,
  xx3_4Rc   :: Unsigned 1,
  xx3_4AX   :: Unsigned 1,
  xx3_4BX   :: Unsigned 1,
  xx3_4TX   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXX3_5 = FormXX3_5 {  xx3_5T    :: Unsigned 5,
  xx3_5A    :: Unsigned 5,
  xx3_5B    :: Unsigned 5,
  xx3_5AX   :: Unsigned 1,
  xx3_5BX   :: Unsigned 1,
  xx3_5TX   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormXX4_1 = FormXX4_1 {  xx4_1T    :: Unsigned 5,
  xx4_1A    :: Unsigned 5,
  xx4_1B    :: Unsigned 5,
  xx4_1C    :: Unsigned 5,
  xx4_1CX   :: Unsigned 1,
  xx4_1AX   :: Unsigned 1,
  xx4_1BX   :: Unsigned 1,
  xx4_1TX   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormZ22_1 = FormZ22_1 {  z22_1BF   :: Unsigned 3,
  z22_1FRA  :: Unsigned 5,
  z22_1DCM  :: Unsigned 6 }
  deriving (Generic, Show, Eq, NFDataX)

data FormZ22_2 = FormZ22_2 {  z22_2BF   :: Unsigned 3,
  z22_2FRA  :: Unsigned 5,
  z22_2DGM  :: Unsigned 6 }
  deriving (Generic, Show, Eq, NFDataX)

data FormZ22_3 = FormZ22_3 {  z22_3BF   :: Unsigned 3,
  z22_3FRAp :: Unsigned 5,
  z22_3DCM  :: Unsigned 6 }
  deriving (Generic, Show, Eq, NFDataX)

data FormZ22_4 = FormZ22_4 {  z22_4BF   :: Unsigned 3,
  z22_4FRAp :: Unsigned 5,
  z22_4DGM  :: Unsigned 6 }
  deriving (Generic, Show, Eq, NFDataX)

data FormZ22_5 = FormZ22_5 {  z22_5FRT  :: Unsigned 5,
  z22_5FRA  :: Unsigned 5,
  z22_5SH   :: Unsigned 6,
  z22_5Rc   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormZ22_6 = FormZ22_6 {  z22_6FRTp :: Unsigned 5,
  z22_6FRAp :: Unsigned 5,
  z22_6SH   :: Unsigned 6,
  z22_6Rc   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormZ23_1 = FormZ23_1 {  z23_1FRT  :: Unsigned 5,
  z23_1R    :: Unsigned 1,
  z23_1FRB  :: Unsigned 5,
  z23_1RMC  :: Unsigned 1,
  z23_1Rc   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormZ23_2 = FormZ23_2 {  z23_2FRT  :: Unsigned 5,
  z23_2FRA  :: Unsigned 5,
  z23_2FRB  :: Unsigned 5,
  z23_2RMC  :: Unsigned 1,
  z23_2Rc   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormZ23_3 = FormZ23_3 {  z23_3FRT  :: Unsigned 5,
  z23_3TE   :: Unsigned 5,
  z23_3FRB  :: Unsigned 5,
  z23_3RMC  :: Unsigned 1,
  z23_3Rc   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormZ23_4 = FormZ23_4 {  z23_4FRTp :: Unsigned 5,
  z23_4R    :: Unsigned 1,
  z23_4FRBp :: Unsigned 5,
  z23_4RMC  :: Unsigned 1,
  z23_4Rc   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormZ23_5 = FormZ23_5 {  z23_5FRTp :: Unsigned 5,
  z23_5FRAp :: Unsigned 5,
  z23_5FRBp :: Unsigned 5,
  z23_5RMC  :: Unsigned 1,
  z23_5Rc   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormZ23_6 = FormZ23_6 {  z23_6FRTp :: Unsigned 5,
  z23_6FRAp :: Unsigned 5,
  z23_6FRBp :: Unsigned 5,
  z23_6RMC  :: Unsigned 1,
  z23_6Rc   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormZ23_7 = FormZ23_7 {  z23_7FRTp :: Unsigned 5,
  z23_7TE   :: Unsigned 5,
  z23_7FRBp :: Unsigned 5,
  z23_7RMC  :: Unsigned 1,
  z23_7Rc   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormZ23_8 = FormZ23_8 {  z23_8VRT  :: Unsigned 5,
  z23_8R    :: Unsigned 1,
  z23_8VRB  :: Unsigned 5,
  z23_8RMC  :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)

data FormZ23_9 = FormZ23_9 {  z23_9VRT  :: Unsigned 5,
  z23_9R    :: Unsigned 1,
  z23_9VRB  :: Unsigned 5,
  z23_9RMC  :: Unsigned 1,
  z23_9EX   :: Unsigned 1 }
  deriving (Generic, Show, Eq, NFDataX)