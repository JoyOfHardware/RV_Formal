{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Fields(UnpopulatedField(..), PopulatedField(..)) where
import Clash.Prelude

data UnpopulatedField
  = Unpopulated_Frt_1  
  | Unpopulated_Frb_1  
  | Unpopulated_Xo_1   
  | Unpopulated_Rc_1   
  | Unpopulated_Fra_1  
  | Unpopulated_Frc_1  
  | Unpopulated_Rt_1   
  | Unpopulated_Ra_1   
  | Unpopulated_Rb_1   
  | Unpopulated_Bc_1   
  | Unpopulated_Bo_1   
  | Unpopulated_Bi_1   
  | Unpopulated_Bd_1   
  | Unpopulated_Aa_1   
  | Unpopulated_Lk_1   
  | Unpopulated_Bf_1   
  | Unpopulated_L_1    
  | Unpopulated_Si_1   
  | Unpopulated_Ui_1   
  | Unpopulated_Frs_1  
  | Unpopulated_D_1    
  | Unpopulated_Rs_1   
  | Unpopulated_To_1   
  | Unpopulated_Rtp_1  
  | Unpopulated_Dq_1   
  | Unpopulated_Pt_1   
  | Unpopulated_S_1    
  | Unpopulated_Sx_1   
  | Unpopulated_Xo_2   
  | Unpopulated_Tx_1   
  | Unpopulated_Frsp_1 
  | Unpopulated_Ds_1   
  | Unpopulated_Xo_3   
  | Unpopulated_Frtp_1 
  | Unpopulated_Rsp_1  
  | Unpopulated_Vrs_1  
  | Unpopulated_Vrt_1  
  | Unpopulated_D1_1   
  | Unpopulated_D0_1   
  | Unpopulated_D2_1   
  | Unpopulated_Li_1   
  | Unpopulated_Mb_1   
  | Unpopulated_Me_1   
  | Unpopulated_Sh_1   
  | Unpopulated_Mb_2   
  | Unpopulated_Xo_4   
  | Unpopulated_Me_2   
  | Unpopulated_Xo_5   
  | Unpopulated_Lev_1  
  | Unpopulated_Rc_2   
  | Unpopulated_Xo_6   
  | Unpopulated_Vra_1  
  | Unpopulated_Vrb_1  
  | Unpopulated_Shb_1  
  | Unpopulated_Vrc_1  
  | Unpopulated_Rc_3   
  | Unpopulated_Xo_7   
  | Unpopulated_Xo_8   
  | Unpopulated_Eo_1   
  | Unpopulated_Uim_1  
  | Unpopulated_Uim_2  
  | Unpopulated_Uim_3  
  | Unpopulated_Xo_9   
  | Unpopulated_Ps_1   
  | Unpopulated_Sim_1  
  | Unpopulated_Uim_4  
  | Unpopulated_St_1   
  | Unpopulated_Six_1  
  | Unpopulated_Xo_10  
  | Unpopulated_L_2    
  | Unpopulated_Wc_1   
  | Unpopulated_Ih_1   
  | Unpopulated_Ct_1   
  | Unpopulated_A_1    
  | Unpopulated_R_1    
  | Unpopulated_W_1    
  | Unpopulated_U_1    
  | Unpopulated_Bfa_1  
  | Unpopulated_Frap_1 
  | Unpopulated_Frbp_1 
  | Unpopulated_Dcmx_1 
  | Unpopulated_Bt_1   
  | Unpopulated_Rm_1   
  | Unpopulated_Drm_1  
  | Unpopulated_S_2    
  | Unpopulated_Sp_1   
  | Unpopulated_L_3    
  | Unpopulated_Ric_1  
  | Unpopulated_Pr_1   
  | Unpopulated_R_2    
  | Unpopulated_Sr_1   
  | Unpopulated_Fc_1   
  | Unpopulated_Nb_1   
  | Unpopulated_L_4    
  | Unpopulated_Eh_1   
  | Unpopulated_Sx_2   
  | Unpopulated_T_1    
  | Unpopulated_Eo_2   
  | Unpopulated_Imm8_1 
  | Unpopulated_Tx_2   
  | Unpopulated_Th_1   
  | Unpopulated_Si_2   
  | Unpopulated_Ro_1   
  | Unpopulated_L_5    
  | Unpopulated_Flm_1  
  | Unpopulated_Fxm_1  
  | Unpopulated_Spr_1  
  | Unpopulated_Bhrbe_1
  | Unpopulated_Tbr_1  
  | Unpopulated_S_3    
  | Unpopulated_Bh_1   
  | Unpopulated_Ba_1   
  | Unpopulated_Bb_1   
  | Unpopulated_Oe_1   
  | Unpopulated_Xo_11  
  | Unpopulated_Xo_12  
  | Unpopulated_B_1    
  | Unpopulated_Bx_1   
  | Unpopulated_Dx_1   
  | Unpopulated_Dc_1   
  | Unpopulated_Dm_1   
  | Unpopulated_A_2    
  | Unpopulated_Xo_13  
  | Unpopulated_Ax_1   
  | Unpopulated_Dm_2   
  | Unpopulated_Xo_14  
  | Unpopulated_Shw_1  
  | Unpopulated_Xo_15  
  | Unpopulated_C_1    
  | Unpopulated_Xo_16  
  | Unpopulated_Cx_1   
  | Unpopulated_Dcm_1  
  | Unpopulated_Dgm_1  
  | Unpopulated_Sh_2   
  | Unpopulated_Rmc_1  
  | Unpopulated_Te_1   
  | Unpopulated_Ex_1   
  | Unpopulated_Cy_1   
  | Unpopulated_Xo_17  
  deriving (Generic, Show, Eq, NFDataX)

data PopulatedField
  = Populated_Frt_1   (Unsigned 5)
  | Populated_Frb_1   (Unsigned 5)
  | Populated_Xo_1    (Unsigned 5)
  | Populated_Rc_1    (Unsigned 1)
  | Populated_Fra_1   (Unsigned 5)
  | Populated_Frc_1   (Unsigned 5)
  | Populated_Rt_1    (Unsigned 5)
  | Populated_Ra_1    (Unsigned 5)
  | Populated_Rb_1    (Unsigned 5)
  | Populated_Bc_1    (Unsigned 5)
  | Populated_Bo_1    (Unsigned 5)
  | Populated_Bi_1    (Unsigned 5)
  | Populated_Bd_1    (Unsigned 14)
  | Populated_Aa_1    (Unsigned 1)
  | Populated_Lk_1    (Unsigned 1)
  | Populated_Bf_1    (Unsigned 3)
  | Populated_L_1     (Unsigned 1)
  | Populated_Si_1    (Unsigned 16)
  | Populated_Ui_1    (Unsigned 16)
  | Populated_Frs_1   (Unsigned 5)
  | Populated_D_1     (Unsigned 16)
  | Populated_Rs_1    (Unsigned 5)
  | Populated_To_1    (Unsigned 5)
  | Populated_Rtp_1   (Unsigned 5)
  | Populated_Dq_1    (Unsigned 12)
  | Populated_Pt_1    (Unsigned 4)
  | Populated_S_1     (Unsigned 5)
  | Populated_Sx_1    (Unsigned 1)
  | Populated_Xo_2    (Unsigned 3)
  | Populated_Tx_1    (Unsigned 1)
  | Populated_Frsp_1  (Unsigned 5)
  | Populated_Ds_1    (Unsigned 14)
  | Populated_Xo_3    (Unsigned 2)
  | Populated_Frtp_1  (Unsigned 5)
  | Populated_Rsp_1   (Unsigned 5)
  | Populated_Vrs_1   (Unsigned 5)
  | Populated_Vrt_1   (Unsigned 5)
  | Populated_D1_1    (Unsigned 5)
  | Populated_D0_1    (Unsigned 10)
  | Populated_D2_1    (Unsigned 1)
  | Populated_Li_1    (Unsigned 24)
  | Populated_Mb_1    (Unsigned 5)
  | Populated_Me_1    (Unsigned 5)
  | Populated_Sh_1    (Unsigned 5)
  | Populated_Mb_2    (Unsigned 6)
  | Populated_Xo_4    (Unsigned 3)
  | Populated_Me_2    (Unsigned 6)
  | Populated_Xo_5    (Unsigned 4)
  | Populated_Lev_1   (Unsigned 7)
  | Populated_Rc_2    (Unsigned 5)
  | Populated_Xo_6    (Unsigned 6)
  | Populated_Vra_1   (Unsigned 5)
  | Populated_Vrb_1   (Unsigned 5)
  | Populated_Shb_1   (Unsigned 4)
  | Populated_Vrc_1   (Unsigned 5)
  | Populated_Rc_3    (Unsigned 1)
  | Populated_Xo_7    (Unsigned 10)
  | Populated_Xo_8    (Unsigned 11)
  | Populated_Eo_1    (Unsigned 5)
  | Populated_Uim_1   (Unsigned 2)
  | Populated_Uim_2   (Unsigned 3)
  | Populated_Uim_3   (Unsigned 4)
  | Populated_Xo_9    (Unsigned 9)
  | Populated_Ps_1    (Unsigned 1)
  | Populated_Sim_1   (Unsigned 5)
  | Populated_Uim_4   (Unsigned 5)
  | Populated_St_1    (Unsigned 1)
  | Populated_Six_1   (Unsigned 4)
  | Populated_Xo_10   (Unsigned 10)
  | Populated_L_2     (Unsigned 2)
  | Populated_Wc_1    (Unsigned 2)
  | Populated_Ih_1    (Unsigned 3)
  | Populated_Ct_1    (Unsigned 4)
  | Populated_A_1     (Unsigned 1)
  | Populated_R_1     (Unsigned 1)
  | Populated_W_1     (Unsigned 1)
  | Populated_U_1     (Unsigned 4)
  | Populated_Bfa_1   (Unsigned 3)
  | Populated_Frap_1  (Unsigned 5)
  | Populated_Frbp_1  (Unsigned 5)
  | Populated_Dcmx_1  (Unsigned 7)
  | Populated_Bt_1    (Unsigned 5)
  | Populated_Rm_1    (Unsigned 2)
  | Populated_Drm_1   (Unsigned 3)
  | Populated_S_2     (Unsigned 1)
  | Populated_Sp_1    (Unsigned 2)
  | Populated_L_3     (Unsigned 1)
  | Populated_Ric_1   (Unsigned 2)
  | Populated_Pr_1    (Unsigned 1)
  | Populated_R_2     (Unsigned 1)
  | Populated_Sr_1    (Unsigned 4)
  | Populated_Fc_1    (Unsigned 5)
  | Populated_Nb_1    (Unsigned 5)
  | Populated_L_4     (Unsigned 2)
  | Populated_Eh_1    (Unsigned 1)
  | Populated_Sx_2    (Unsigned 1)
  | Populated_T_1     (Unsigned 5)
  | Populated_Eo_2    (Unsigned 2)
  | Populated_Imm8_1  (Unsigned 8)
  | Populated_Tx_2    (Unsigned 1)
  | Populated_Th_1    (Unsigned 5)
  | Populated_Si_2    (Unsigned 5)
  | Populated_Ro_1    (Unsigned 1)
  | Populated_L_5     (Unsigned 1)
  | Populated_Flm_1   (Unsigned 8)
  | Populated_Fxm_1   (Unsigned 8)
  | Populated_Spr_1   (Unsigned 10)
  | Populated_Bhrbe_1 (Unsigned 10)
  | Populated_Tbr_1   (Unsigned 10)
  | Populated_S_3     (Unsigned 1)
  | Populated_Bh_1    (Unsigned 2)
  | Populated_Ba_1    (Unsigned 5)
  | Populated_Bb_1    (Unsigned 5)
  | Populated_Oe_1    (Unsigned 1)
  | Populated_Xo_11   (Unsigned 9)
  | Populated_Xo_12   (Unsigned 9)
  | Populated_B_1     (Unsigned 5)
  | Populated_Bx_1    (Unsigned 1)
  | Populated_Dx_1    (Unsigned 5)
  | Populated_Dc_1    (Unsigned 1)
  | Populated_Dm_1    (Unsigned 1)
  | Populated_A_2     (Unsigned 5)
  | Populated_Xo_13   (Unsigned 8)
  | Populated_Ax_1    (Unsigned 1)
  | Populated_Dm_2    (Unsigned 2)
  | Populated_Xo_14   (Unsigned 5)
  | Populated_Shw_1   (Unsigned 2)
  | Populated_Xo_15   (Unsigned 7)
  | Populated_C_1     (Unsigned 5)
  | Populated_Xo_16   (Unsigned 2)
  | Populated_Cx_1    (Unsigned 1)
  | Populated_Dcm_1   (Unsigned 6)
  | Populated_Dgm_1   (Unsigned 6)
  | Populated_Sh_2    (Unsigned 6)
  | Populated_Rmc_1   (Unsigned 1)
  | Populated_Te_1    (Unsigned 5)
  | Populated_Ex_1    (Unsigned 1)
  | Populated_Cy_1    (Unsigned 2)
  | Populated_Xo_17   (Unsigned 8)
  deriving (Generic, Show, Eq, NFDataX)
