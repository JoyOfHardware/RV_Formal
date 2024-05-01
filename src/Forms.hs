{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Forms(Form) where

import Clash.Prelude

data Form
  =  A1 {  a1FRT     :: Unsigned 5,  a1FRB     :: Unsigned 5,  a1Rc      :: Unsigned 1}
  |  A2 {  a2FRT     :: Unsigned 5,  a2FRA     :: Unsigned 5,  a2FRC     :: Unsigned 5,  a2Rc      :: Unsigned 1}
  |  A3 {  a3FRT     :: Unsigned 5,  a3FRA     :: Unsigned 5,  a3FRB     :: Unsigned 5,  a3Rc      :: Unsigned 1}
  |  A4 {  a4FRT     :: Unsigned 5,  a4FRA     :: Unsigned 5,  a4FRB     :: Unsigned 5,  a4FRC     :: Unsigned 5,  a4Rc      :: Unsigned 1}
  |  A5 {  a5RT      :: Unsigned 5,  a5RA      :: Unsigned 5,  a5RB      :: Unsigned 5,  a5BC      :: Unsigned 5}
  |  B1 {  b1BO      :: Unsigned 5,  b1BI      :: Unsigned 5,  b1BD      :: Unsigned 14,  b1AA      :: Unsigned 1,  b1LK      :: Unsigned 1}
  |  D1 {  d1BF      :: Unsigned 3,  d1L       :: Unsigned 1,  d1RA      :: Unsigned 5,  d1SI      :: Unsigned 16}
  |  D2 {  d2BF      :: Unsigned 3,  d2L       :: Unsigned 1,  d2RA      :: Unsigned 5,  d2UI      :: Unsigned 16}
  |  D3 {  d3FRS     :: Unsigned 5,  d3RA      :: Unsigned 5,  d3D       :: Unsigned 16}
  |  D4 {  d4FRT     :: Unsigned 5,  d4RA      :: Unsigned 5,  d4D       :: Unsigned 16}
  |  D5 {  d5RS      :: Unsigned 5,  d5RA      :: Unsigned 5,  d5D       :: Unsigned 16}
  |  D6 {  d6RS      :: Unsigned 5,  d6RA      :: Unsigned 5,  d6UI      :: Unsigned 16}
  |  D7 {  d7RT      :: Unsigned 5,  d7RA      :: Unsigned 5,  d7D       :: Unsigned 16}
  |  D8 {  d8RT      :: Unsigned 5,  d8RA      :: Unsigned 5,  d8SI      :: Unsigned 16}
  |  D9 {  d9TO      :: Unsigned 5,  d9RA      :: Unsigned 5,  d9SI      :: Unsigned 16}
  |  DQ1 {  dq1RTp    :: Unsigned 5,  dq1RA     :: Unsigned 5,  dq1DQ     :: Unsigned 12,  dq1PT     :: Unsigned 4}
  |  DQ2 {  dq2S      :: Unsigned 5,  dq2RA     :: Unsigned 5,  dq2DQ     :: Unsigned 12,  dq2SX     :: Unsigned 1}
  |  DQ3 {  dq3TO     :: Unsigned 5,  dq3RA     :: Unsigned 5,  dq3DQ     :: Unsigned 12,  dq3TX     :: Unsigned 1}
  |  DS1 {  ds1FRSp   :: Unsigned 5,  ds1RA     :: Unsigned 5,  ds1DS     :: Unsigned 14}
  |  DS2 {  ds2FRTp   :: Unsigned 5,  ds2RA     :: Unsigned 5,  ds2DS     :: Unsigned 14}
  |  DS3 {  ds3RS     :: Unsigned 5,  ds3RA     :: Unsigned 5,  ds3DS     :: Unsigned 14}
  |  DS4 {  ds4RSp    :: Unsigned 5,  ds4RA     :: Unsigned 5,  ds4DS     :: Unsigned 14}
  |  DS5 {  ds5RT     :: Unsigned 5,  ds5RA     :: Unsigned 5,  ds5DS     :: Unsigned 14}
  |  DS6 {  ds6VRS    :: Unsigned 5,  ds6RA     :: Unsigned 5,  ds6DS     :: Unsigned 14}
  |  DS7 {  ds7VRT    :: Unsigned 5,  ds7RA     :: Unsigned 5,  ds7DS     :: Unsigned 14}
  |  DX1 {  dx1RT     :: Unsigned 5,  dx1d1     :: Unsigned 5,  dx1d0     :: Unsigned 10,  dx1d2     :: Unsigned 1}
  |  I1 {  i1LI      :: Unsigned 24,  i1AA      :: Unsigned 1,  i1LK      :: Unsigned 1}
  |  M1 {  m1RS      :: Unsigned 5,  m1RA      :: Unsigned 5,  m1RB      :: Unsigned 5,  m1MB      :: Unsigned 5,  m1ME      :: Unsigned 5,  m1Rc      :: Unsigned 1}
  |  M2 {  m2RS      :: Unsigned 5,  m2RA      :: Unsigned 5,  m2SH      :: Unsigned 5,  m2MB      :: Unsigned 5,  m2ME      :: Unsigned 5,  m2Rc      :: Unsigned 1}
  |  MD1 {  md1RS     :: Unsigned 5,  md1RA     :: Unsigned 5,  md1mb     :: Unsigned 6,  md1Rc     :: Unsigned 1}
  |  MD2 {  md2RS     :: Unsigned 5,  md2RA     :: Unsigned 5,  md2me     :: Unsigned 6,  md2Rc     :: Unsigned 1}
  |  MDS1 {  mds1RS    :: Unsigned 5,  mds1RA    :: Unsigned 5,  mds1RB    :: Unsigned 5,  mds1mb    :: Unsigned 6,  mds1Rc    :: Unsigned 1}
  |  MDS2 {  mds2RS    :: Unsigned 5,  mds2RA    :: Unsigned 5,  mds2RB    :: Unsigned 5,  mds2me    :: Unsigned 6,  mds2Rc    :: Unsigned 1}
  |  SC1 {  sc1LEV    :: Unsigned 7}
  |  VA1 {  va1RT     :: Unsigned 5,  va1RA     :: Unsigned 5,  va1RB     :: Unsigned 5,  va1RC     :: Unsigned 5}
  |  VA2 {  va2VRT    :: Unsigned 5,  va2VRA    :: Unsigned 5,  va2VRB    :: Unsigned 5,  va2SHB    :: Unsigned 4}
  |  VA3 {  va3VRT    :: Unsigned 5,  va3VRA    :: Unsigned 5,  va3VRB    :: Unsigned 5,  va3VRC    :: Unsigned 5}
  |  VC1 {  vc1VRT    :: Unsigned 5,  vc1VRA    :: Unsigned 5,  vc1VRB    :: Unsigned 5,  vc1Rc     :: Unsigned 1}
  |  VX1 {  vx1VRB    :: Unsigned 5}
  |  VX2 {  vx2RT     :: Unsigned 5,  vx2EO     :: Unsigned 5,  vx2VRB    :: Unsigned 5}
  |  VX3 {  vx3VRT    :: Unsigned 5}
  |  VX4 {  vx4VRT    :: Unsigned 5,  vx4VRB    :: Unsigned 5}
  |  VX5 {  vx5VRT    :: Unsigned 5,  vx5UIM    :: Unsigned 2,  vx5VRB    :: Unsigned 5}
  |  VX6 {  vx6VRT    :: Unsigned 5,  vx6UIM    :: Unsigned 3,  vx6VRB    :: Unsigned 5}
  |  VX7 {  vx7VRT    :: Unsigned 5,  vx7UIM    :: Unsigned 4,  vx7VRB    :: Unsigned 5}
  |  VX8 {  vx8VRT    :: Unsigned 5,  vx8EO     :: Unsigned 5,  vx8VRB    :: Unsigned 5}
  |  VX9 {  vx9VRT    :: Unsigned 5,  vx9EO     :: Unsigned 5,  vx9VRB    :: Unsigned 5,  vx9PS     :: Unsigned 1}
  |  VX10 {  vx10VRT   :: Unsigned 5,  vx10EO    :: Unsigned 5,  vx10VRB   :: Unsigned 5}
  |  VX11 {  vx11VRT   :: Unsigned 5,  vx11RA    :: Unsigned 5,  vx11VRB   :: Unsigned 5}
  |  VX12 {  vx12VRT   :: Unsigned 5,  vx12SIM   :: Unsigned 5}
  |  VX13 {  vx13VRT   :: Unsigned 5,  vx13UIM   :: Unsigned 5,  vx13VRB   :: Unsigned 5}
  |  VX14 {  vx14VRT   :: Unsigned 5,  vx14VRA   :: Unsigned 5}
  |  VX15 {  vx15VRT   :: Unsigned 5,  vx15VRA   :: Unsigned 5,  vx15VRB   :: Unsigned 5}
  |  VX16 {  vx16VRT   :: Unsigned 5,  vx16VRA   :: Unsigned 5,  vx16VRB   :: Unsigned 5,  vx16PS    :: Unsigned 1}
  |  VX17 {  vx17VRT   :: Unsigned 5,  vx17VRA   :: Unsigned 5,  vx17VRB   :: Unsigned 5}
  |  X1 {}
  |  X2 {}
  |  X3 {  x3RB      :: Unsigned 5}
  |  X4 {  x4RA      :: Unsigned 5}
  |  X5 {  x5RA      :: Unsigned 5}
  |  X6 {  x6RA      :: Unsigned 5,  x6RB      :: Unsigned 5}
  |  X7 {  x7L       :: Unsigned 1}
  |  X8 {  x8L       :: Unsigned 1,  x8RB      :: Unsigned 5}
  |  X9 {  x9RA      :: Unsigned 5,  x9RB      :: Unsigned 5}
  |  X10 {  x10L      :: Unsigned 1,  x10RA     :: Unsigned 5,  x10RB     :: Unsigned 5}
  |  X11 {  x11L      :: Unsigned 2}
  |  X12 {  x12L      :: Unsigned 2,  x12RA     :: Unsigned 5,  x12RB     :: Unsigned 5,  x12Rc     :: Unsigned 1}
  |  X13 {  x13WC     :: Unsigned 2}
  |  X14 {  x14IH     :: Unsigned 3}
  |  X15 {  x15CT     :: Unsigned 4,  x15RA     :: Unsigned 5,  x15RB     :: Unsigned 5}
  |  X16 {  x16A      :: Unsigned 1}
  |  X17 {  x17A      :: Unsigned 1,  x17R      :: Unsigned 1}
  |  X18 {  x18BF     :: Unsigned 3}
  |  X19 {  x19BF     :: Unsigned 3,  x19FRB    :: Unsigned 5}
  |  X20 {  x20BF     :: Unsigned 3,  x20W      :: Unsigned 1,  x20U      :: Unsigned 4,  x20Rc     :: Unsigned 1}
  |  X21 {  x21BF     :: Unsigned 3,  x21BFA    :: Unsigned 3}
  |  X22 {  x22BF     :: Unsigned 3,  x22FRA    :: Unsigned 5,  x22FRB    :: Unsigned 5}
  |  X23 {  x23BF     :: Unsigned 3,  x23FRAp   :: Unsigned 5,  x23FRBp   :: Unsigned 5}
  |  X24 {  x24BF     :: Unsigned 3,  x24FRAp   :: Unsigned 5,  x24FRBp   :: Unsigned 5}
  |  X25 {  x25BF     :: Unsigned 3,  x25RA     :: Unsigned 5,  x25RB     :: Unsigned 5}
  |  X26 {  x26BF     :: Unsigned 3,  x26UIM    :: Unsigned 5,  x26FRBp   :: Unsigned 5}
  |  X27 {  x27BF     :: Unsigned 3,  x27UIM    :: Unsigned 5,  x27FRBp   :: Unsigned 5}
  |  X28 {  x28BF     :: Unsigned 3,  x28VRA    :: Unsigned 5,  x28VRB    :: Unsigned 5}
  |  X29 {  x29BF     :: Unsigned 3,  x29RA     :: Unsigned 5,  x29RB     :: Unsigned 5}
  |  X30 {  x30BF     :: Unsigned 3,  x30L      :: Unsigned 1,  x30RA     :: Unsigned 5,  x30RB     :: Unsigned 5}
  |  X31 {  x31BF     :: Unsigned 3,  x31DCMX   :: Unsigned 7,  x31VRB    :: Unsigned 5}
  |  X32 {  x32BT     :: Unsigned 5,  x32Rc     :: Unsigned 1}
  |  X33 {  x33FRS    :: Unsigned 5,  x33RA     :: Unsigned 5,  x33RB     :: Unsigned 5}
  |  X34 {  x34FRSp   :: Unsigned 5,  x34RA     :: Unsigned 5,  x34RB     :: Unsigned 5}
  |  X35 {  x35FRT    :: Unsigned 5,  x35Rc     :: Unsigned 1}
  |  X36 {  x36FRT    :: Unsigned 5,  x36FRB    :: Unsigned 5,  x36Rc     :: Unsigned 1}
  |  X37 {  x37FRT    :: Unsigned 5,  x37FRBp   :: Unsigned 5,  x37Rc     :: Unsigned 1}
  |  X38 {  x38FRT    :: Unsigned 5,  x38EO     :: Unsigned 5,  x38Rc     :: Unsigned 1}
  |  X39 {  x39FRT    :: Unsigned 5,  x39EO     :: Unsigned 5}
  |  X40 {  x40FRT    :: Unsigned 5,  x40EO     :: Unsigned 5,  x40RM     :: Unsigned 2}
  |  X41 {  x41FRT    :: Unsigned 5,  x41EO     :: Unsigned 5,  x41DRM    :: Unsigned 3}
  |  X42 {  x42FRT    :: Unsigned 5,  x42EO     :: Unsigned 5,  x42FRB    :: Unsigned 5}
  |  X43 {  x43FRT    :: Unsigned 5,  x43FRA    :: Unsigned 5,  x43FRB    :: Unsigned 5}
  |  X44 {  x44FRT    :: Unsigned 5,  x44FRA    :: Unsigned 5,  x44FRB    :: Unsigned 5,  x44Rc     :: Unsigned 1}
  |  X45 {  x45FRT    :: Unsigned 5,  x45RA     :: Unsigned 5,  x45RB     :: Unsigned 5}
  |  X46 {  x46FRT    :: Unsigned 5,  x46S      :: Unsigned 1,  x46FRB    :: Unsigned 5,  x46Rc     :: Unsigned 1}
  |  X47 {  x47FRT    :: Unsigned 5,  x47SP     :: Unsigned 2,  x47FRB    :: Unsigned 5,  x47Rc     :: Unsigned 1}
  |  X48 {  x48FRTp   :: Unsigned 5,  x48FRB    :: Unsigned 5,  x48Rc     :: Unsigned 1}
  |  X49 {  x49FRTp   :: Unsigned 5,  x49FRBp   :: Unsigned 5,  x49Rc     :: Unsigned 1}
  |  X50 {  x50FRTp   :: Unsigned 5,  x50FRA    :: Unsigned 5,  x50FRBp   :: Unsigned 5,  x50Rc     :: Unsigned 1}
  |  X51 {  x51FRTp   :: Unsigned 5,  x51FRAp   :: Unsigned 5,  x51FRBp   :: Unsigned 5,  x51Rc     :: Unsigned 1}
  |  X52 {  x52FRTp   :: Unsigned 5,  x52RA     :: Unsigned 5,  x52RB     :: Unsigned 5}
  |  X53 {  x53FRTp   :: Unsigned 5,  x53S      :: Unsigned 1,  x53FRBp   :: Unsigned 5,  x53Rc     :: Unsigned 1}
  |  X54 {  x54FRTp   :: Unsigned 5,  x54SP     :: Unsigned 2,  x54FRBp   :: Unsigned 5,  x54Rc     :: Unsigned 1}
  |  X55 {  x55RS     :: Unsigned 5,  x55RB     :: Unsigned 5}
  |  X56 {  x56RS     :: Unsigned 5,  x56L      :: Unsigned 1}
  |  X57 {  x57RS     :: Unsigned 5,  x57RIC    :: Unsigned 2,  x57PR     :: Unsigned 1,  x57R      :: Unsigned 1,  x57RB     :: Unsigned 5}
  |  X58 {  x58RS     :: Unsigned 5,  x58SR     :: Unsigned 4}
  |  X59 {  x59RS     :: Unsigned 5,  x59BFA    :: Unsigned 3}
  |  X60 {  x60RS     :: Unsigned 5,  x60RA     :: Unsigned 5}
  |  X61 {  x61RS     :: Unsigned 5,  x61RA     :: Unsigned 5}
  |  X62 {  x62RS     :: Unsigned 5,  x62RA     :: Unsigned 5,  x62Rc     :: Unsigned 1}
  |  X63 {  x63RS     :: Unsigned 5,  x63RA     :: Unsigned 5,  x63FC     :: Unsigned 5}
  |  X64 {  x64RS     :: Unsigned 5,  x64RA     :: Unsigned 5,  x64NB     :: Unsigned 5}
  |  X65 {  x65RS     :: Unsigned 5,  x65RA     :: Unsigned 5,  x65SH     :: Unsigned 5,  x65Rc     :: Unsigned 1}
  |  X66 {  x66RS     :: Unsigned 5,  x66RA     :: Unsigned 5,  x66RB     :: Unsigned 5}
  |  X67 {  x67RS     :: Unsigned 5,  x67RA     :: Unsigned 5,  x67RB     :: Unsigned 5}
  |  X68 {  x68RS     :: Unsigned 5,  x68RA     :: Unsigned 5,  x68RB     :: Unsigned 5,  x68Rc     :: Unsigned 1}
  |  X69 {  x69RSp    :: Unsigned 5,  x69RA     :: Unsigned 5,  x69RB     :: Unsigned 5}
  |  X70 {  x70RT     :: Unsigned 5}
  |  X71 {  x71RT     :: Unsigned 5,  x71RB     :: Unsigned 5}
  |  X72 {  x72RT     :: Unsigned 5,  x72RB     :: Unsigned 5}
  |  X73 {  x73RT     :: Unsigned 5,  x73L      :: Unsigned 2}
  |  X74 {  x74RT     :: Unsigned 5,  x74SR     :: Unsigned 4}
  |  X75 {  x75RT     :: Unsigned 5,  x75RA     :: Unsigned 5,  x75FC     :: Unsigned 5}
  |  X76 {  x76RT     :: Unsigned 5,  x76RA     :: Unsigned 5,  x76NB     :: Unsigned 5}
  |  X77 {  x77RT     :: Unsigned 5,  x77RA     :: Unsigned 5,  x77RB     :: Unsigned 5}
  |  X78 {  x78RT     :: Unsigned 5,  x78RA     :: Unsigned 5,  x78RB     :: Unsigned 5,  x78EH     :: Unsigned 1}
  |  X79 {  x79RTp    :: Unsigned 5,  x79RA     :: Unsigned 5,  x79RB     :: Unsigned 5,  x79EH     :: Unsigned 1}
  |  X80 {  x80S      :: Unsigned 5,  x80RA     :: Unsigned 5,  x80SX     :: Unsigned 1}
  |  X81 {  x81S      :: Unsigned 5,  x81RA     :: Unsigned 5,  x81RB     :: Unsigned 5,  x81SX     :: Unsigned 1}
  |  X82 {  x82T      :: Unsigned 5,  x82EO     :: Unsigned 2,  x82IMM8   :: Unsigned 8,  x82TX     :: Unsigned 1}
  |  X83 {  x83T      :: Unsigned 5,  x83RA     :: Unsigned 5,  x83TX     :: Unsigned 1}
  |  X84 {  x84T      :: Unsigned 5,  x84RA     :: Unsigned 5,  x84RB     :: Unsigned 5,  x84TX     :: Unsigned 1}
  |  X85 {  x85TH     :: Unsigned 5,  x85RA     :: Unsigned 5,  x85RB     :: Unsigned 5}
  |  X86 {  x86TO     :: Unsigned 5,  x86RA     :: Unsigned 5,  x86SI     :: Unsigned 5}
  |  X87 {  x87TO     :: Unsigned 5,  x87RA     :: Unsigned 5,  x87RB     :: Unsigned 5}
  |  X88 {  x88TO     :: Unsigned 5,  x88RA     :: Unsigned 5,  x88RB     :: Unsigned 5}
  |  X89 {  x89VRS    :: Unsigned 5,  x89RA     :: Unsigned 5,  x89RB     :: Unsigned 5}
  |  X90 {  x90VRT    :: Unsigned 5,  x90EO     :: Unsigned 5,  x90VRB    :: Unsigned 5}
  |  X91 {  x91VRT    :: Unsigned 5,  x91EO     :: Unsigned 5,  x91VRB    :: Unsigned 5,  x91RO     :: Unsigned 1}
  |  X92 {  x92VRT    :: Unsigned 5,  x92RA     :: Unsigned 5,  x92RB     :: Unsigned 5}
  |  X93 {  x93VRT    :: Unsigned 5,  x93VRA    :: Unsigned 5,  x93VRB    :: Unsigned 5}
  |  X94 {  x94VRT    :: Unsigned 5,  x94VRA    :: Unsigned 5,  x94VRB    :: Unsigned 5,  x94RO     :: Unsigned 1}
  |  XFL1 {  xfl1L     :: Unsigned 1,  xfl1FLM   :: Unsigned 8,  xfl1W     :: Unsigned 1,  xfl1FRB   :: Unsigned 5,  xfl1Rc    :: Unsigned 1}
  |  XFX1 {}
  |  XFX2 {  xfx2RS    :: Unsigned 5,  xfx2FXM   :: Unsigned 8}
  |  XFX3 {  xfx3RS    :: Unsigned 5,  xfx3FXM   :: Unsigned 8}
  |  XFX4 {  xfx4RS    :: Unsigned 5,  xfx4spr   :: Unsigned 10}
  |  XFX5 {  xfx5RT    :: Unsigned 5}
  |  XFX6 {  xfx6RT    :: Unsigned 5,  xfx6FXM   :: Unsigned 8}
  |  XFX7 {  xfx7RT    :: Unsigned 5,  xfx7BHRBE :: Unsigned 10}
  |  XFX8 {  xfx8RT    :: Unsigned 5,  xfx8spr   :: Unsigned 10}
  |  XFX9 {  xfx9RT    :: Unsigned 5,  xfx9tbr   :: Unsigned 10}
  |  XL1 {}
  |  XL2 {  xl2S      :: Unsigned 1}
  |  XL3 {  xl3BF     :: Unsigned 3,  xl3BFA    :: Unsigned 3}
  |  XL4 {  xl4BO     :: Unsigned 5,  xl4BI     :: Unsigned 5,  xl4BH     :: Unsigned 2,  xl4LK     :: Unsigned 1}
  |  XL5 {  xl5BT     :: Unsigned 5,  xl5BA     :: Unsigned 5,  xl5BB     :: Unsigned 5}
  |  XO1 {  xo1RT     :: Unsigned 5,  xo1RA     :: Unsigned 5,  xo1OE     :: Unsigned 1,  xo1Rc     :: Unsigned 1}
  |  XO2 {  xo2RT     :: Unsigned 5,  xo2RA     :: Unsigned 5,  xo2RB     :: Unsigned 5}
  |  XO3 {  xo3RT     :: Unsigned 5,  xo3RA     :: Unsigned 5,  xo3RB     :: Unsigned 5,  xo3Rc     :: Unsigned 1}
  |  XO4 {  xo4RT     :: Unsigned 5,  xo4RA     :: Unsigned 5,  xo4RB     :: Unsigned 5,  xo4OE     :: Unsigned 1,  xo4Rc     :: Unsigned 1}
  |  XS1 {  xs1RS     :: Unsigned 5,  xs1RA     :: Unsigned 5,  xs1Rc     :: Unsigned 1}
  |  XX2_1 {  xx2_1BF   :: Unsigned 3,  xx2_1B    :: Unsigned 5,  xx2_1BX   :: Unsigned 1}
  |  XX2_2 {  xx2_2BF   :: Unsigned 3,  xx2_2DCMX :: Unsigned 7,  xx2_2B    :: Unsigned 5,  xx2_2BX   :: Unsigned 1}
  |  XX2_3 {  xx2_3RT   :: Unsigned 5,  xx2_3EO   :: Unsigned 5,  xx2_3B    :: Unsigned 5,  xx2_3BX   :: Unsigned 1}
  |  XX2_4 {  xx2_4T    :: Unsigned 5,  xx2_4B    :: Unsigned 5,  xx2_4BX   :: Unsigned 1,  xx2_4TX   :: Unsigned 1}
  |  XX2_5 {  xx2_5T    :: Unsigned 5,  xx2_5UIM  :: Unsigned 2,  xx2_5B    :: Unsigned 5,  xx2_5BX   :: Unsigned 1,  xx2_5TX   :: Unsigned 1}
  |  XX2_6 {  xx2_6T    :: Unsigned 5,  xx2_6UIM  :: Unsigned 4,  xx2_6B    :: Unsigned 5,  xx2_6BX   :: Unsigned 1,  xx2_6TX   :: Unsigned 1}
  |  XX2_7 {  xx2_7T    :: Unsigned 5,  xx2_7dx   :: Unsigned 5,  xx2_7B    :: Unsigned 5,  xx2_7dc   :: Unsigned 1,  xx2_7dm   :: Unsigned 1,  xx2_7BX   :: Unsigned 1,  xx2_7TX   :: Unsigned 1}
  |  XX2_8 {  xx2_8T    :: Unsigned 5,  xx2_8EO   :: Unsigned 5,  xx2_8B    :: Unsigned 5,  xx2_8BX   :: Unsigned 1,  xx2_8TX   :: Unsigned 1}
  |  XX3_1 {  xx3_1BF   :: Unsigned 3,  xx3_1A    :: Unsigned 5,  xx3_1B    :: Unsigned 5,  xx3_1AX   :: Unsigned 1,  xx3_1BX   :: Unsigned 1}
  |  XX3_2 {  xx3_2T    :: Unsigned 5,  xx3_2A    :: Unsigned 5,  xx3_2B    :: Unsigned 5,  xx3_2DM   :: Unsigned 2,  xx3_2AX   :: Unsigned 1,  xx3_2BX   :: Unsigned 1,  xx3_2TX   :: Unsigned 1}
  |  XX3_3 {  xx3_3T    :: Unsigned 5,  xx3_3A    :: Unsigned 5,  xx3_3B    :: Unsigned 5,  xx3_3SHW  :: Unsigned 2,  xx3_3AX   :: Unsigned 1,  xx3_3BX   :: Unsigned 1,  xx3_3TX   :: Unsigned 1}
  |  XX3_4 {  xx3_4T    :: Unsigned 5,  xx3_4A    :: Unsigned 5,  xx3_4B    :: Unsigned 5,  xx3_4Rc   :: Unsigned 1,  xx3_4AX   :: Unsigned 1,  xx3_4BX   :: Unsigned 1,  xx3_4TX   :: Unsigned 1}
  |  XX3_5 {  xx3_5T    :: Unsigned 5,  xx3_5A    :: Unsigned 5,  xx3_5B    :: Unsigned 5,  xx3_5AX   :: Unsigned 1,  xx3_5BX   :: Unsigned 1,  xx3_5TX   :: Unsigned 1}
  |  XX4_1 {  xx4_1T    :: Unsigned 5,  xx4_1A    :: Unsigned 5,  xx4_1B    :: Unsigned 5,  xx4_1C    :: Unsigned 5,  xx4_1CX   :: Unsigned 1,  xx4_1AX   :: Unsigned 1,  xx4_1BX   :: Unsigned 1,  xx4_1TX   :: Unsigned 1}
  |  Z22_1 {  z22_1BF   :: Unsigned 3,  z22_1FRA  :: Unsigned 5,  z22_1DCM  :: Unsigned 6}
  |  Z22_2 {  z22_2BF   :: Unsigned 3,  z22_2FRA  :: Unsigned 5,  z22_2DGM  :: Unsigned 6}
  |  Z22_3 {  z22_3BF   :: Unsigned 3,  z22_3FRAp :: Unsigned 5,  z22_3DCM  :: Unsigned 6}
  |  Z22_4 {  z22_4BF   :: Unsigned 3,  z22_4FRAp :: Unsigned 5,  z22_4DGM  :: Unsigned 6}
  |  Z22_5 {  z22_5FRT  :: Unsigned 5,  z22_5FRA  :: Unsigned 5,  z22_5SH   :: Unsigned 6,  z22_5Rc   :: Unsigned 1}
  |  Z22_6 {  z22_6FRTp :: Unsigned 5,  z22_6FRAp :: Unsigned 5,  z22_6SH   :: Unsigned 6,  z22_6Rc   :: Unsigned 1}
  |  Z23_1 {  z23_1FRT  :: Unsigned 5,  z23_1R    :: Unsigned 1,  z23_1FRB  :: Unsigned 5,  z23_1RMC  :: Unsigned 1,  z23_1Rc   :: Unsigned 1}
  |  Z23_2 {  z23_2FRT  :: Unsigned 5,  z23_2FRA  :: Unsigned 5,  z23_2FRB  :: Unsigned 5,  z23_2RMC  :: Unsigned 1,  z23_2Rc   :: Unsigned 1}
  |  Z23_3 {  z23_3FRT  :: Unsigned 5,  z23_3TE   :: Unsigned 5,  z23_3FRB  :: Unsigned 5,  z23_3RMC  :: Unsigned 1,  z23_3Rc   :: Unsigned 1}
  |  Z23_4 {  z23_4FRTp :: Unsigned 5,  z23_4R    :: Unsigned 1,  z23_4FRBp :: Unsigned 5,  z23_4RMC  :: Unsigned 1,  z23_4Rc   :: Unsigned 1}
  |  Z23_5 {  z23_5FRTp :: Unsigned 5,  z23_5FRAp :: Unsigned 5,  z23_5FRBp :: Unsigned 5,  z23_5RMC  :: Unsigned 1,  z23_5Rc   :: Unsigned 1}
  |  Z23_6 {  z23_6FRTp :: Unsigned 5,  z23_6FRAp :: Unsigned 5,  z23_6FRBp :: Unsigned 5,  z23_6RMC  :: Unsigned 1,  z23_6Rc   :: Unsigned 1}
  |  Z23_7 {  z23_7FRTp :: Unsigned 5,  z23_7TE   :: Unsigned 5,  z23_7FRBp :: Unsigned 5,  z23_7RMC  :: Unsigned 1,  z23_7Rc   :: Unsigned 1}
  |  Z23_8 {  z23_8VRT  :: Unsigned 5,  z23_8R    :: Unsigned 1,  z23_8VRB  :: Unsigned 5,  z23_8RMC  :: Unsigned 1}
  |  Z23_9 {  z23_9VRT  :: Unsigned 5,  z23_9R    :: Unsigned 1,  z23_9VRB  :: Unsigned 5,  z23_9RMC  :: Unsigned 1,  z23_9EX   :: Unsigned 1}
  deriving (Generic, Show, Eq, NFDataX)