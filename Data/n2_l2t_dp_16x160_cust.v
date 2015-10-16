// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: n2_l2t_dp_16x160_cust.v
// Copyright (C) 1995-2007 Sun Microsystems, Inc. All Rights Reserved
// 4150 Network Circle, Santa Clara, California 95054, U.S.A.
//
// * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER. 
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; version 2 of the License.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
// 
// For the avoidance of doubt, and except that if any non-GPL license 
// choice is available it will apply instead, Sun elects to use only 
// the General Public License version 2 (GPLv2) at this time for any 
// software where a choice of GPL license versions is made 
// available with the language indicating that GPLv2 or any later version 
// may be used, or where a choice of which version of the GPL is applied is 
// otherwise unspecified. 
//
// Please contact Sun Microsystems, Inc., 4150 Network Circle, Santa Clara, 
// CA 95054 USA or visit www.sun.com if you need additional information or 
// have any questions. 
// 
// ========== Copyright Header End ============================================
module n2_l2t_dp_16x160_cust (
  din, 
  rd_adr, 
  wr_adr, 
  read_en, 
  wr_en, 
  word_wen, 
  byte_wen, 
  l2clk, 
  tcu_pce_ov, 
  pce, 
  tcu_aclk, 
  tcu_bclk, 
  tcu_scan_en, 
  scan_in, 
  tcu_se_scancollar_in, 
  tcu_array_wr_inhibit, 
  mbist_wdata, 
  mbist_run, 
  dout, 
  scan_out);
wire siclk;
wire soclk;
wire stop;
wire pce_ov;
wire l1clk;
wire l1clk_mem;
wire ff_wdata_79_scanin;
wire ff_wdata_79_scanout;
wire [159:0] wrdata_d1;
wire ff_wdata_78_scanin;
wire ff_wdata_78_scanout;
wire ff_wdata_77_scanin;
wire ff_wdata_77_scanout;
wire ff_wdata_76_scanin;
wire ff_wdata_76_scanout;
wire ff_wdata_75_scanin;
wire ff_wdata_75_scanout;
wire ff_wdata_74_scanin;
wire ff_wdata_74_scanout;
wire ff_wdata_73_scanin;
wire ff_wdata_73_scanout;
wire ff_wdata_72_scanin;
wire ff_wdata_72_scanout;
wire ff_wdata_71_scanin;
wire ff_wdata_71_scanout;
wire ff_wdata_70_scanin;
wire ff_wdata_70_scanout;
wire ff_wdata_69_scanin;
wire ff_wdata_69_scanout;
wire ff_wdata_68_scanin;
wire ff_wdata_68_scanout;
wire ff_wdata_67_scanin;
wire ff_wdata_67_scanout;
wire ff_wdata_66_scanin;
wire ff_wdata_66_scanout;
wire ff_wdata_65_scanin;
wire ff_wdata_65_scanout;
wire ff_wdata_64_scanin;
wire ff_wdata_64_scanout;
wire ff_wdata_63_scanin;
wire ff_wdata_63_scanout;
wire ff_wdata_62_scanin;
wire ff_wdata_62_scanout;
wire ff_wdata_61_scanin;
wire ff_wdata_61_scanout;
wire ff_wdata_60_scanin;
wire ff_wdata_60_scanout;
wire ff_wdata_59_scanin;
wire ff_wdata_59_scanout;
wire ff_wdata_58_scanin;
wire ff_wdata_58_scanout;
wire ff_wdata_57_scanin;
wire ff_wdata_57_scanout;
wire ff_wdata_56_scanin;
wire ff_wdata_56_scanout;
wire ff_wdata_55_scanin;
wire ff_wdata_55_scanout;
wire ff_wdata_54_scanin;
wire ff_wdata_54_scanout;
wire ff_wdata_53_scanin;
wire ff_wdata_53_scanout;
wire ff_wdata_52_scanin;
wire ff_wdata_52_scanout;
wire ff_wdata_51_scanin;
wire ff_wdata_51_scanout;
wire ff_wdata_50_scanin;
wire ff_wdata_50_scanout;
wire ff_wdata_49_scanin;
wire ff_wdata_49_scanout;
wire ff_wdata_48_scanin;
wire ff_wdata_48_scanout;
wire ff_wdata_47_scanin;
wire ff_wdata_47_scanout;
wire ff_wdata_46_scanin;
wire ff_wdata_46_scanout;
wire ff_wdata_45_scanin;
wire ff_wdata_45_scanout;
wire ff_wdata_44_scanin;
wire ff_wdata_44_scanout;
wire ff_wdata_43_scanin;
wire ff_wdata_43_scanout;
wire ff_wdata_42_scanin;
wire ff_wdata_42_scanout;
wire ff_wdata_41_scanin;
wire ff_wdata_41_scanout;
wire ff_wdata_40_scanin;
wire ff_wdata_40_scanout;
wire ff_wdata_39_scanin;
wire ff_wdata_39_scanout;
wire ff_wdata_38_scanin;
wire ff_wdata_38_scanout;
wire ff_wdata_37_scanin;
wire ff_wdata_37_scanout;
wire ff_wdata_36_scanin;
wire ff_wdata_36_scanout;
wire ff_wdata_35_scanin;
wire ff_wdata_35_scanout;
wire ff_wdata_34_scanin;
wire ff_wdata_34_scanout;
wire ff_wdata_33_scanin;
wire ff_wdata_33_scanout;
wire ff_wdata_32_scanin;
wire ff_wdata_32_scanout;
wire ff_wdata_31_scanin;
wire ff_wdata_31_scanout;
wire ff_wdata_30_scanin;
wire ff_wdata_30_scanout;
wire ff_wdata_29_scanin;
wire ff_wdata_29_scanout;
wire ff_wdata_28_scanin;
wire ff_wdata_28_scanout;
wire ff_wdata_27_scanin;
wire ff_wdata_27_scanout;
wire ff_wdata_26_scanin;
wire ff_wdata_26_scanout;
wire ff_wdata_25_scanin;
wire ff_wdata_25_scanout;
wire ff_wdata_24_scanin;
wire ff_wdata_24_scanout;
wire ff_wdata_23_scanin;
wire ff_wdata_23_scanout;
wire ff_wdata_22_scanin;
wire ff_wdata_22_scanout;
wire ff_wdata_21_scanin;
wire ff_wdata_21_scanout;
wire ff_wdata_20_scanin;
wire ff_wdata_20_scanout;
wire ff_wdata_19_scanin;
wire ff_wdata_19_scanout;
wire ff_wdata_18_scanin;
wire ff_wdata_18_scanout;
wire ff_wdata_17_scanin;
wire ff_wdata_17_scanout;
wire ff_wdata_16_scanin;
wire ff_wdata_16_scanout;
wire ff_wdata_15_scanin;
wire ff_wdata_15_scanout;
wire ff_wdata_14_scanin;
wire ff_wdata_14_scanout;
wire ff_wdata_13_scanin;
wire ff_wdata_13_scanout;
wire ff_wdata_12_scanin;
wire ff_wdata_12_scanout;
wire ff_wdata_11_scanin;
wire ff_wdata_11_scanout;
wire ff_wdata_10_scanin;
wire ff_wdata_10_scanout;
wire ff_wdata_9_scanin;
wire ff_wdata_9_scanout;
wire ff_wdata_8_scanin;
wire ff_wdata_8_scanout;
wire ff_wdata_7_scanin;
wire ff_wdata_7_scanout;
wire ff_wdata_6_scanin;
wire ff_wdata_6_scanout;
wire ff_wdata_5_scanin;
wire ff_wdata_5_scanout;
wire ff_wdata_4_scanin;
wire ff_wdata_4_scanout;
wire ff_wdata_3_scanin;
wire ff_wdata_3_scanout;
wire ff_wdata_2_scanin;
wire ff_wdata_2_scanout;
wire ff_wdata_1_scanin;
wire ff_wdata_1_scanout;
wire ff_wdata_0_scanin;
wire ff_wdata_0_scanout;
wire ff_word_wen_scanin;
wire ff_word_wen_scanout;
wire [3:0] word_wen_d1;
wire ff_byte_wen_scanin;
wire ff_byte_wen_scanout;
wire [19:0] byte_wen_d1;
wire ff_mbist_wdata_scanin;
wire ff_mbist_wdata_scanout;
wire [7:0] mbist_wdata_d1;
wire ff_mbist_run_scanin;
wire ff_mbist_run_scanout;
wire mbist_run_d1;
wire ff_wr_adr_scanin;
wire ff_wr_adr_scanout;
wire [3:0] wrptr_d1;
wire ff_wr_en_scanin;
wire ff_wr_en_scanout;
wire wr_en_d1;
wire collusion_n;
wire collusion;
wire read_en_qualed;
wire ff_read_enable_scanin;
wire ff_read_enable_scanout;
wire ff_read_enable0_unused;
wire ff_read_enable1_unused;
wire ff_read_enable2_unused;
wire ren_d1;
wire ff_read_addr_scanin;
wire ff_read_addr_scanout;
wire [3:0] ff_read_addr0_unused;
wire [3:0] ff_read_addr1_unused;
wire [3:0] rd_ptr_d1;
wire [3:0] ff_read_addr2_unused;
wire mbist_run_d1_n;
wire [159:0] data_input;
 

input [159:0]  	din; 		// data input
input [3:0]    	rd_adr;   	// read addr 
input [3:0]	wr_adr;  	// write addr
input          	read_en; 	// read enable 
input	  	wr_en;		// used in conjunction with
     				// word_wen and byte_wen 
input [3:0]    	word_wen; 	// word enables ( if you don't use these
     		    		// tie them to Vdd )
input [19:0]	byte_wen;	// byte enables ( if you don't use these
                         	// tie them to Vdd )
input           l2clk;
input 		tcu_pce_ov;
input 		pce;
input 		tcu_aclk;
input 		tcu_bclk;
input 		tcu_scan_en;
input          	scan_in;
input	  	tcu_se_scancollar_in; // hold scan in data.
input          	tcu_array_wr_inhibit; // wr_inhibit

input  [7:0]	mbist_wdata;
input  		mbist_run;

output [159:0] dout;
output         scan_out;


// synopsys translate_off

wire   [159:0] dout_array;

// scan chain connections ////
assign siclk = tcu_aclk;
assign soclk = tcu_bclk;
assign stop = 1'b0;
assign pce_ov = tcu_pce_ov;
//// Input Flops /////

n2_l2t_dp_16x160_cust_l1clkhdr_ctl_macro      clkgen_clk_en
        (
        .l2clk  (l2clk  ),
        .l1en   (pce    ),
        .pce_ov (pce_ov ),
        .stop   (stop   ),
        .se     (tcu_se_scancollar_in),
        .l1clk  (l1clk  )
        );

n2_l2t_dp_16x160_cust_l1clkhdr_ctl_macro      clkgen_clk_en0
        (
        .l2clk  (l2clk  ),
        .l1en   (pce    ),
        .pce_ov (pce_ov ),
        .stop   (stop   ),
        .se     (tcu_scan_en),
        .l1clk  (l1clk_mem  )
        );


// msff_ctl_macro ff_wdata_2 (width = 32)
//        (
//        .scan_in(ff_wdata_2_scanin),
//        .scan_out(ff_wdata_2_scanout),
//        .l1clk          (l1clk),
//        .din            (din[159:128]),
//        .dout           (wrdata_d1[159:128])
//        );
// msff_ctl_macro ff_wdata_1 (width = 64)
//        (
//        .scan_in(ff_wdata_1_scanin),
//        .scan_out(ff_wdata_1_scanout),
//        .l1clk          (l1clk),
//        .din            (din[127:64]),
//        .dout           (wrdata_d1[127:64])
//        );
// 
// msff_ctl_macro ff_wdata_0 (width = 64) 
// 	(
//        .scan_in(ff_wdata_0_scanin),
//        .scan_out(ff_wdata_0_scanout),
//        .l1clk		(l1clk),
//        .din		(din[63:0]),
//        .dout		(wrdata_d1[63:0])
//        );


n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_79   
(
.scan_in(ff_wdata_79_scanin),
.scan_out(ff_wdata_79_scanout),
.l1clk          (l1clk),
.din            (din[159:158]),
.dout           (wrdata_d1[159:158]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_78   
(
.scan_in(ff_wdata_78_scanin),
.scan_out(ff_wdata_78_scanout),
.l1clk          (l1clk),
.din            (din[157:156]),
.dout           (wrdata_d1[157:156]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_77   
(
.scan_in(ff_wdata_77_scanin),
.scan_out(ff_wdata_77_scanout),
.l1clk          (l1clk),
.din            (din[155:154]),
.dout           (wrdata_d1[155:154]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_76   
(
.scan_in(ff_wdata_76_scanin),
.scan_out(ff_wdata_76_scanout),
.l1clk          (l1clk),
.din            (din[153:152]),
.dout           (wrdata_d1[153:152]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_75   
(
.scan_in(ff_wdata_75_scanin),
.scan_out(ff_wdata_75_scanout),
.l1clk          (l1clk),
.din            (din[151:150]),
.dout           (wrdata_d1[151:150]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_74   
(
.scan_in(ff_wdata_74_scanin),
.scan_out(ff_wdata_74_scanout),
.l1clk          (l1clk),
.din            (din[149:148]),
.dout           (wrdata_d1[149:148]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_73   
(
.scan_in(ff_wdata_73_scanin),
.scan_out(ff_wdata_73_scanout),
.l1clk          (l1clk),
.din            (din[147:146]),
.dout           (wrdata_d1[147:146]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_72   
(
.scan_in(ff_wdata_72_scanin),
.scan_out(ff_wdata_72_scanout),
.l1clk          (l1clk),
.din            (din[145:144]),
.dout           (wrdata_d1[145:144]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_71   
(
.scan_in(ff_wdata_71_scanin),
.scan_out(ff_wdata_71_scanout),
.l1clk          (l1clk),
.din            (din[143:142]),
.dout           (wrdata_d1[143:142]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_70   
(
.scan_in(ff_wdata_70_scanin),
.scan_out(ff_wdata_70_scanout),
.l1clk          (l1clk),
.din            (din[141:140]),
.dout           (wrdata_d1[141:140]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_69   
(
.scan_in(ff_wdata_69_scanin),
.scan_out(ff_wdata_69_scanout),
.l1clk          (l1clk),
.din            (din[139:138]),
.dout           (wrdata_d1[139:138]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_68   
(
.scan_in(ff_wdata_68_scanin),
.scan_out(ff_wdata_68_scanout),
.l1clk          (l1clk),
.din            (din[137:136]),
.dout           (wrdata_d1[137:136]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_67   
(
.scan_in(ff_wdata_67_scanin),
.scan_out(ff_wdata_67_scanout),
.l1clk          (l1clk),
.din            (din[135:134]),
.dout           (wrdata_d1[135:134]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_66   
(
.scan_in(ff_wdata_66_scanin),
.scan_out(ff_wdata_66_scanout),
.l1clk          (l1clk),
.din            (din[133:132]),
.dout           (wrdata_d1[133:132]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_65   
(
.scan_in(ff_wdata_65_scanin),
.scan_out(ff_wdata_65_scanout),
.l1clk          (l1clk),
.din            (din[131:130]),
.dout           (wrdata_d1[131:130]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_64   
(
.scan_in(ff_wdata_64_scanin),
.scan_out(ff_wdata_64_scanout),
.l1clk          (l1clk),
.din            (din[129:128]),
.dout           (wrdata_d1[129:128]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_63   
(
.scan_in(ff_wdata_63_scanin),
.scan_out(ff_wdata_63_scanout),
.l1clk          (l1clk),
.din            (din[127:126]),
.dout           (wrdata_d1[127:126]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_62   
(
.scan_in(ff_wdata_62_scanin),
.scan_out(ff_wdata_62_scanout),
.l1clk          (l1clk),
.din            (din[125:124]),
.dout           (wrdata_d1[125:124]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_61   
(
.scan_in(ff_wdata_61_scanin),
.scan_out(ff_wdata_61_scanout),
.l1clk          (l1clk),
.din            (din[123:122]),
.dout           (wrdata_d1[123:122]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_60   
(
.scan_in(ff_wdata_60_scanin),
.scan_out(ff_wdata_60_scanout),
.l1clk          (l1clk),
.din            (din[121:120]),
.dout           (wrdata_d1[121:120]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_59   
(
.scan_in(ff_wdata_59_scanin),
.scan_out(ff_wdata_59_scanout),
.l1clk          (l1clk),
.din            (din[119:118]),
.dout           (wrdata_d1[119:118]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_58   
(
.scan_in(ff_wdata_58_scanin),
.scan_out(ff_wdata_58_scanout),
.l1clk          (l1clk),
.din            (din[117:116]),
.dout           (wrdata_d1[117:116]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_57   
(
.scan_in(ff_wdata_57_scanin),
.scan_out(ff_wdata_57_scanout),
.l1clk          (l1clk),
.din            (din[115:114]),
.dout           (wrdata_d1[115:114]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_56   
(
.scan_in(ff_wdata_56_scanin),
.scan_out(ff_wdata_56_scanout),
.l1clk          (l1clk),
.din            (din[113:112]),
.dout           (wrdata_d1[113:112]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_55   
(
.scan_in(ff_wdata_55_scanin),
.scan_out(ff_wdata_55_scanout),
.l1clk          (l1clk),
.din            (din[111:110]),
.dout           (wrdata_d1[111:110]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_54   
(
.scan_in(ff_wdata_54_scanin),
.scan_out(ff_wdata_54_scanout),
.l1clk          (l1clk),
.din            (din[109:108]),
.dout           (wrdata_d1[109:108]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_53   
(
.scan_in(ff_wdata_53_scanin),
.scan_out(ff_wdata_53_scanout),
.l1clk          (l1clk),
.din            (din[107:106]),
.dout           (wrdata_d1[107:106]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_52   
(
.scan_in(ff_wdata_52_scanin),
.scan_out(ff_wdata_52_scanout),
.l1clk          (l1clk),
.din            (din[105:104]),
.dout           (wrdata_d1[105:104]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_51   
(
.scan_in(ff_wdata_51_scanin),
.scan_out(ff_wdata_51_scanout),
.l1clk          (l1clk),
.din            (din[103:102]),
.dout           (wrdata_d1[103:102]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_50   
(
.scan_in(ff_wdata_50_scanin),
.scan_out(ff_wdata_50_scanout),
.l1clk          (l1clk),
.din            (din[101:100]),
.dout           (wrdata_d1[101:100]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_49   
(
.scan_in(ff_wdata_49_scanin),
.scan_out(ff_wdata_49_scanout),
.l1clk          (l1clk),
.din            (din[99:98]),
.dout           (wrdata_d1[99:98]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_48   
(
.scan_in(ff_wdata_48_scanin),
.scan_out(ff_wdata_48_scanout),
.l1clk          (l1clk),
.din            (din[97:96]),
.dout           (wrdata_d1[97:96]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_47   
(
.scan_in(ff_wdata_47_scanin),
.scan_out(ff_wdata_47_scanout),
.l1clk          (l1clk),
.din            (din[95:94]),
.dout           (wrdata_d1[95:94]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_46   
(
.scan_in(ff_wdata_46_scanin),
.scan_out(ff_wdata_46_scanout),
.l1clk          (l1clk),
.din            (din[93:92]),
.dout           (wrdata_d1[93:92]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_45   
(
.scan_in(ff_wdata_45_scanin),
.scan_out(ff_wdata_45_scanout),
.l1clk          (l1clk),
.din            (din[91:90]),
.dout           (wrdata_d1[91:90]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_44   
(
.scan_in(ff_wdata_44_scanin),
.scan_out(ff_wdata_44_scanout),
.l1clk          (l1clk),
.din            (din[89:88]),
.dout           (wrdata_d1[89:88]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_43   
(
.scan_in(ff_wdata_43_scanin),
.scan_out(ff_wdata_43_scanout),
.l1clk          (l1clk),
.din            (din[87:86]),
.dout           (wrdata_d1[87:86]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_42   
(
.scan_in(ff_wdata_42_scanin),
.scan_out(ff_wdata_42_scanout),
.l1clk          (l1clk),
.din            (din[85:84]),
.dout           (wrdata_d1[85:84]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_41   
(
.scan_in(ff_wdata_41_scanin),
.scan_out(ff_wdata_41_scanout),
.l1clk          (l1clk),
.din            (din[83:82]),
.dout           (wrdata_d1[83:82]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_40   
(
.scan_in(ff_wdata_40_scanin),
.scan_out(ff_wdata_40_scanout),
.l1clk          (l1clk),
.din            (din[81:80]),
.dout           (wrdata_d1[81:80]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_39   
(
.scan_in(ff_wdata_39_scanin),
.scan_out(ff_wdata_39_scanout),
.l1clk          (l1clk),
.din            (din[79:78]),
.dout           (wrdata_d1[79:78]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_38   
(
.scan_in(ff_wdata_38_scanin),
.scan_out(ff_wdata_38_scanout),
.l1clk          (l1clk),
.din            (din[77:76]),
.dout           (wrdata_d1[77:76]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_37   
(
.scan_in(ff_wdata_37_scanin),
.scan_out(ff_wdata_37_scanout),
.l1clk          (l1clk),
.din            (din[75:74]),
.dout           (wrdata_d1[75:74]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_36   
(
.scan_in(ff_wdata_36_scanin),
.scan_out(ff_wdata_36_scanout),
.l1clk          (l1clk),
.din            (din[73:72]),
.dout           (wrdata_d1[73:72]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_35   
(
.scan_in(ff_wdata_35_scanin),
.scan_out(ff_wdata_35_scanout),
.l1clk          (l1clk),
.din            (din[71:70]),
.dout           (wrdata_d1[71:70]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_34   
(
.scan_in(ff_wdata_34_scanin),
.scan_out(ff_wdata_34_scanout),
.l1clk          (l1clk),
.din            (din[69:68]),
.dout           (wrdata_d1[69:68]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_33   
(
.scan_in(ff_wdata_33_scanin),
.scan_out(ff_wdata_33_scanout),
.l1clk          (l1clk),
.din            (din[67:66]),
.dout           (wrdata_d1[67:66]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_32   
(
.scan_in(ff_wdata_32_scanin),
.scan_out(ff_wdata_32_scanout),
.l1clk          (l1clk),
.din            (din[65:64]),
.dout           (wrdata_d1[65:64]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_31   
(
.scan_in(ff_wdata_31_scanin),
.scan_out(ff_wdata_31_scanout),
.l1clk          (l1clk),
.din            (din[63:62]),
.dout           (wrdata_d1[63:62]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_30   
(
.scan_in(ff_wdata_30_scanin),
.scan_out(ff_wdata_30_scanout),
.l1clk          (l1clk),
.din            (din[61:60]),
.dout           (wrdata_d1[61:60]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_29   
(
.scan_in(ff_wdata_29_scanin),
.scan_out(ff_wdata_29_scanout),
.l1clk          (l1clk),
.din            (din[59:58]),
.dout           (wrdata_d1[59:58]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_28   
(
.scan_in(ff_wdata_28_scanin),
.scan_out(ff_wdata_28_scanout),
.l1clk          (l1clk),
.din            (din[57:56]),
.dout           (wrdata_d1[57:56]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_27   
(
.scan_in(ff_wdata_27_scanin),
.scan_out(ff_wdata_27_scanout),
.l1clk          (l1clk),
.din            (din[55:54]),
.dout           (wrdata_d1[55:54]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_26   
(
.scan_in(ff_wdata_26_scanin),
.scan_out(ff_wdata_26_scanout),
.l1clk          (l1clk),
.din            (din[53:52]),
.dout           (wrdata_d1[53:52]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_25   
(
.scan_in(ff_wdata_25_scanin),
.scan_out(ff_wdata_25_scanout),
.l1clk          (l1clk),
.din            (din[51:50]),
.dout           (wrdata_d1[51:50]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_24   
(
.scan_in(ff_wdata_24_scanin),
.scan_out(ff_wdata_24_scanout),
.l1clk          (l1clk),
.din            (din[49:48]),
.dout           (wrdata_d1[49:48]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_23   
(
.scan_in(ff_wdata_23_scanin),
.scan_out(ff_wdata_23_scanout),
.l1clk          (l1clk),
.din            (din[47:46]),
.dout           (wrdata_d1[47:46]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_22   
(
.scan_in(ff_wdata_22_scanin),
.scan_out(ff_wdata_22_scanout),
.l1clk          (l1clk),
.din            (din[45:44]),
.dout           (wrdata_d1[45:44]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_21   
(
.scan_in(ff_wdata_21_scanin),
.scan_out(ff_wdata_21_scanout),
.l1clk          (l1clk),
.din            (din[43:42]),
.dout           (wrdata_d1[43:42]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_20   
(
.scan_in(ff_wdata_20_scanin),
.scan_out(ff_wdata_20_scanout),
.l1clk          (l1clk),
.din            (din[41:40]),
.dout           (wrdata_d1[41:40]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_19   
(
.scan_in(ff_wdata_19_scanin),
.scan_out(ff_wdata_19_scanout),
.l1clk          (l1clk),
.din            (din[39:38]),
.dout           (wrdata_d1[39:38]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_18   
(
.scan_in(ff_wdata_18_scanin),
.scan_out(ff_wdata_18_scanout),
.l1clk          (l1clk),
.din            (din[37:36]),
.dout           (wrdata_d1[37:36]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_17   
(
.scan_in(ff_wdata_17_scanin),
.scan_out(ff_wdata_17_scanout),
.l1clk          (l1clk),
.din            (din[35:34]),
.dout           (wrdata_d1[35:34]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_16   
(
.scan_in(ff_wdata_16_scanin),
.scan_out(ff_wdata_16_scanout),
.l1clk          (l1clk),
.din            (din[33:32]),
.dout           (wrdata_d1[33:32]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_15   
(
.scan_in(ff_wdata_15_scanin),
.scan_out(ff_wdata_15_scanout),
.l1clk          (l1clk),
.din            (din[31:30]),
.dout           (wrdata_d1[31:30]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_14   
(
.scan_in(ff_wdata_14_scanin),
.scan_out(ff_wdata_14_scanout),
.l1clk          (l1clk),
.din            (din[29:28]),
.dout           (wrdata_d1[29:28]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_13   
(
.scan_in(ff_wdata_13_scanin),
.scan_out(ff_wdata_13_scanout),
.l1clk          (l1clk),
.din            (din[27:26]),
.dout           (wrdata_d1[27:26]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_12   
(
.scan_in(ff_wdata_12_scanin),
.scan_out(ff_wdata_12_scanout),
.l1clk          (l1clk),
.din            (din[25:24]),
.dout           (wrdata_d1[25:24]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_11   
(
.scan_in(ff_wdata_11_scanin),
.scan_out(ff_wdata_11_scanout),
.l1clk          (l1clk),
.din            (din[23:22]),
.dout           (wrdata_d1[23:22]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_10   
(
.scan_in(ff_wdata_10_scanin),
.scan_out(ff_wdata_10_scanout),
.l1clk          (l1clk),
.din            (din[21:20]),
.dout           (wrdata_d1[21:20]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_9   
(
.scan_in(ff_wdata_9_scanin),
.scan_out(ff_wdata_9_scanout),
.l1clk          (l1clk),
.din            (din[19:18]),
.dout           (wrdata_d1[19:18]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_8   
(
.scan_in(ff_wdata_8_scanin),
.scan_out(ff_wdata_8_scanout),
.l1clk          (l1clk),
.din            (din[17:16]),
.dout           (wrdata_d1[17:16]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_7   
(
.scan_in(ff_wdata_7_scanin),
.scan_out(ff_wdata_7_scanout),
.l1clk          (l1clk),
.din            (din[15:14]),
.dout           (wrdata_d1[15:14]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_6   
(
.scan_in(ff_wdata_6_scanin),
.scan_out(ff_wdata_6_scanout),
.l1clk          (l1clk),
.din            (din[13:12]),
.dout           (wrdata_d1[13:12]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_5   
(
.scan_in(ff_wdata_5_scanin),
.scan_out(ff_wdata_5_scanout),
.l1clk          (l1clk),
.din            (din[11:10]),
.dout           (wrdata_d1[11:10]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_4   
(
.scan_in(ff_wdata_4_scanin),
.scan_out(ff_wdata_4_scanout),
.l1clk          (l1clk),
.din            (din[9:8]),
.dout           (wrdata_d1[9:8]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_3   
(
.scan_in(ff_wdata_3_scanin),
.scan_out(ff_wdata_3_scanout),
.l1clk          (l1clk),
.din            (din[7:6]),
.dout           (wrdata_d1[7:6]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_2   
(
.scan_in(ff_wdata_2_scanin),
.scan_out(ff_wdata_2_scanout),
.l1clk          (l1clk),
.din            (din[5:4]),
.dout           (wrdata_d1[5:4]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_1   
(
.scan_in(ff_wdata_1_scanin),
.scan_out(ff_wdata_1_scanout),
.l1clk          (l1clk),
.din            (din[3:2]),
.dout           (wrdata_d1[3:2]),
  .siclk(siclk),
  .soclk(soclk)
 );
n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 ff_wdata_0   
(
.scan_in(ff_wdata_0_scanin),
.scan_out(ff_wdata_0_scanout),
.l1clk          (l1clk),
.din            (din[1:0]),
.dout           (wrdata_d1[1:0]),
  .siclk(siclk),
  .soclk(soclk)
 );

n2_l2t_dp_16x160_cust_msff_ctl_macro__width_4 ff_word_wen   
        (
        .scan_in(ff_word_wen_scanin),
        .scan_out(ff_word_wen_scanout),
        .l1clk(l1clk),
        .din(word_wen[3:0]),
        .dout(word_wen_d1[3:0]),
  .siclk(siclk),
  .soclk(soclk)
        );

n2_l2t_dp_16x160_cust_msff_ctl_macro__width_20 ff_byte_wen   
        (
        .scan_in(ff_byte_wen_scanin),
        .scan_out(ff_byte_wen_scanout),
        .l1clk(l1clk),
        .din(byte_wen[19:0]),
        .dout(byte_wen_d1[19:0]),
  .siclk(siclk),
  .soclk(soclk)
        );

n2_l2t_dp_16x160_cust_msff_ctl_macro__width_8 ff_mbist_wdata     // not a real flop. ONly used as a trigger
        (
        .scan_in(ff_mbist_wdata_scanin),
        .scan_out(ff_mbist_wdata_scanout),
        .l1clk(l1clk),
        .din(mbist_wdata[7:0]),
        .dout(mbist_wdata_d1[7:0]),
  .siclk(siclk),
  .soclk(soclk)
        );

n2_l2t_dp_16x160_cust_msff_ctl_macro__width_1 ff_mbist_run     // not a real flop. ONly used as a trigger
        (
        .scan_in(ff_mbist_run_scanin),
        .scan_out(ff_mbist_run_scanout),
        .l1clk(l1clk),
        .din(mbist_run),
        .dout(mbist_run_d1),
  .siclk(siclk),
  .soclk(soclk)
        );


n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_4 ff_wr_adr   
        (
        .scan_in(ff_wr_adr_scanin),
        .scan_out(ff_wr_adr_scanout),
        .l1clk(l1clk),
        .din(wr_adr[3:0]),
        .dout(wrptr_d1[3:0]),
  .siclk(siclk),
  .soclk(soclk)
        );

n2_l2t_dp_16x160_cust_msff_ctl_macro__width_1 ff_wr_en    
	(
        .scan_in(ff_wr_en_scanin),
        .scan_out(ff_wr_en_scanout),
        .l1clk(l1clk),
        .din(wr_en),
        .dout(wr_en_d1),
  .siclk(siclk),
  .soclk(soclk)
        );

n2_l2t_dp_16x160_cust_inv_macro__width_1 inv_read_en 
	(
	.dout	(collusion_n),
	.din	(collusion)
	);

n2_l2t_dp_16x160_cust_and_macro__width_1 and_read_en_qual 
	(
	.dout	(read_en_qualed),
	.din0	(collusion_n),
	.din1	(read_en)
	);

n2_l2t_dp_16x160_cust_sram_msff_mo_macro__width_1 ff_read_enable  
         (
         .scan_in(ff_read_enable_scanin),
         .scan_out(ff_read_enable_scanout),
         .l1clk(l1clk),
         .and_clk(l1clk_mem),
         .d(read_en_qualed),
         .mq_l(ff_read_enable0_unused),
	 .q(ff_read_enable1_unused),
	 .q_l(ff_read_enable2_unused),
         .mq(ren_d1),
  .siclk(siclk),
  .soclk(soclk)
         );

n2_l2t_dp_16x160_cust_sram_msff_mo_macro__scanreverse_1__width_4 ff_read_addr  
         (
         .scan_in(ff_read_addr_scanin),
         .scan_out(ff_read_addr_scanout),
         .l1clk(l1clk),
         .and_clk(l1clk_mem),
         .d(rd_adr[3:0]),
	 .q(ff_read_addr0_unused[3:0]),
	 .q_l(ff_read_addr1_unused[3:0]),
         .mq(rd_ptr_d1[3:0]),
         .mq_l(ff_read_addr2_unused[3:0]),
  .siclk(siclk),
  .soclk(soclk)
         );

////////  Muxed for timing reasons //////////////////
n2_l2t_dp_16x160_cust_inv_macro__width_1 inv_mbist_run 
	(
	.dout	(mbist_run_d1_n),
	.din	(mbist_run_d1)
	);

n2_l2t_dp_16x160_cust_mux_macro__mux_aonpe__ports_2__width_64 mux_din_0 
        (
        .dout (data_input[63:0]),
        .din0 (wrdata_d1[63:0]),
        .din1 ({8{mbist_wdata_d1[7:0]}}),
        .sel0 (mbist_run_d1_n),
        .sel1 (mbist_run_d1)
        ) ;

n2_l2t_dp_16x160_cust_mux_macro__mux_aonpe__ports_2__width_64 mux_din_1 
        (
        .dout (data_input[127:64]),
        .din0 (wrdata_d1[127:64]),
        .din1 ({8{mbist_wdata_d1[7:0]}}),
        .sel0 (mbist_run_d1_n),
        .sel1 (mbist_run_d1)
        ) ;

n2_l2t_dp_16x160_cust_mux_macro__mux_aonpe__ports_2__width_32 mux_din_2 
        (
        .dout (data_input[159:128]),
        .din0 (wrdata_d1[159:128]),
        .din1 ({4{mbist_wdata_d1[7:0]}}),
        .sel0 (mbist_run_d1_n),
        .sel1 (mbist_run_d1)
        ) ;


n2_l2t_dp_16x160_cust_cmp_macro__width_8 cmp_input_address 
	(
	.dout	(collusion),
	.din0	({3'b0,wr_adr[3:0],wr_en}),
	.din1	({3'b0,rd_adr[3:0],read_en})
	);


/// Memory array ////
n2_l2t_dp_16x160_cust_array array 
	(
	.l1clk		(l1clk_mem),
        .wr_en 		(wr_en_d1),
        .rd_en 		(ren_d1),
        .wr_addr	(wrptr_d1[3:0]),
        .rd_addr	(rd_ptr_d1[3:0]),
        .din		(data_input[159:0]),
        .dout		(dout[159:0]),
        .tcu_array_wr_inhibit  (tcu_array_wr_inhibit),
        .word_wen	(word_wen_d1[3:0]),
        .byte_wen	(byte_wen_d1[19:0])
        );


// fixscan start:
assign ff_wdata_79_scanin        = scan_in                  ;
assign ff_wdata_78_scanin        = ff_wdata_79_scanout      ;
assign ff_wdata_77_scanin        = ff_wdata_78_scanout      ;
assign ff_wdata_76_scanin        = ff_wdata_77_scanout      ;
assign ff_wdata_75_scanin        = ff_wdata_76_scanout      ;
assign ff_wdata_74_scanin        = ff_wdata_75_scanout      ;
assign ff_wdata_73_scanin        = ff_wdata_74_scanout      ;
assign ff_wdata_72_scanin        = ff_wdata_73_scanout      ;
assign ff_wdata_71_scanin        = ff_wdata_72_scanout      ;
assign ff_wdata_70_scanin        = ff_wdata_71_scanout      ;
assign ff_wdata_69_scanin        = ff_wdata_70_scanout      ;
assign ff_wdata_68_scanin        = ff_wdata_69_scanout      ;
assign ff_wdata_67_scanin        = ff_wdata_68_scanout      ;
assign ff_wdata_66_scanin        = ff_wdata_67_scanout      ;
assign ff_wdata_65_scanin        = ff_wdata_66_scanout      ;
assign ff_wdata_64_scanin        = ff_wdata_65_scanout      ;
assign ff_wdata_63_scanin        = ff_wdata_64_scanout      ;
assign ff_wdata_62_scanin        = ff_wdata_63_scanout      ;
assign ff_wdata_61_scanin        = ff_wdata_62_scanout      ;
assign ff_wdata_60_scanin        = ff_wdata_61_scanout      ;
assign ff_wdata_59_scanin        = ff_wdata_60_scanout      ;
assign ff_wdata_58_scanin        = ff_wdata_59_scanout      ;
assign ff_wdata_57_scanin        = ff_wdata_58_scanout      ;
assign ff_wdata_56_scanin        = ff_wdata_57_scanout      ;
assign ff_wdata_55_scanin        = ff_wdata_56_scanout      ;
assign ff_wdata_54_scanin        = ff_wdata_55_scanout      ;
assign ff_wdata_53_scanin        = ff_wdata_54_scanout      ;
assign ff_wdata_52_scanin        = ff_wdata_53_scanout      ;
assign ff_wdata_51_scanin        = ff_wdata_52_scanout      ;
assign ff_wdata_50_scanin        = ff_wdata_51_scanout      ;
assign ff_wdata_49_scanin        = ff_wdata_50_scanout      ;
assign ff_wdata_48_scanin        = ff_wdata_49_scanout      ;
assign ff_wdata_47_scanin        = ff_wdata_48_scanout      ;
assign ff_wdata_46_scanin        = ff_wdata_47_scanout      ;
assign ff_wdata_45_scanin        = ff_wdata_46_scanout      ;
assign ff_wdata_44_scanin        = ff_wdata_45_scanout      ;
assign ff_wdata_43_scanin        = ff_wdata_44_scanout      ;
assign ff_wdata_42_scanin        = ff_wdata_43_scanout      ;
assign ff_wdata_41_scanin        = ff_wdata_42_scanout      ;
assign ff_wdata_40_scanin        = ff_wdata_41_scanout      ;
assign ff_wdata_39_scanin        = ff_wdata_40_scanout      ;
assign ff_wdata_38_scanin        = ff_wdata_39_scanout      ;
assign ff_wdata_37_scanin        = ff_wdata_38_scanout      ;
assign ff_wdata_36_scanin        = ff_wdata_37_scanout      ;
assign ff_wdata_35_scanin        = ff_wdata_36_scanout      ;
assign ff_wdata_34_scanin        = ff_wdata_35_scanout      ;
assign ff_wdata_33_scanin        = ff_wdata_34_scanout      ;
assign ff_wdata_32_scanin        = ff_wdata_33_scanout      ;
assign ff_wdata_31_scanin        = ff_wdata_32_scanout      ;
assign ff_wdata_30_scanin        = ff_wdata_31_scanout      ;
assign ff_wdata_29_scanin        = ff_wdata_30_scanout      ;
assign ff_wdata_28_scanin        = ff_wdata_29_scanout      ;
assign ff_wdata_27_scanin        = ff_wdata_28_scanout      ;
assign ff_wdata_26_scanin        = ff_wdata_27_scanout      ;
assign ff_wdata_25_scanin        = ff_wdata_26_scanout      ;
assign ff_wdata_24_scanin        = ff_wdata_25_scanout      ;
assign ff_wdata_23_scanin        = ff_wdata_24_scanout      ;
assign ff_wdata_22_scanin        = ff_wdata_23_scanout      ;
assign ff_wdata_21_scanin        = ff_wdata_22_scanout      ;
assign ff_wdata_20_scanin        = ff_wdata_21_scanout      ;
assign ff_wdata_19_scanin        = ff_wdata_20_scanout      ;
assign ff_wdata_18_scanin        = ff_wdata_19_scanout      ;
assign ff_wdata_17_scanin        = ff_wdata_18_scanout      ;
assign ff_wdata_16_scanin        = ff_wdata_17_scanout      ;
assign ff_wdata_15_scanin        = ff_wdata_16_scanout      ;
assign ff_wdata_14_scanin        = ff_wdata_15_scanout      ;
assign ff_wdata_13_scanin        = ff_wdata_14_scanout      ;
assign ff_wdata_12_scanin        = ff_wdata_13_scanout      ;
assign ff_wdata_11_scanin        = ff_wdata_12_scanout      ;
assign ff_wdata_10_scanin        = ff_wdata_11_scanout      ;
assign ff_wdata_9_scanin         = ff_wdata_10_scanout      ;
assign ff_wdata_8_scanin         = ff_wdata_9_scanout       ;
assign ff_wdata_7_scanin         = ff_wdata_8_scanout       ;
assign ff_wdata_6_scanin         = ff_wdata_7_scanout       ;
assign ff_wdata_5_scanin         = ff_wdata_6_scanout       ;
assign ff_wdata_4_scanin         = ff_wdata_5_scanout       ;
assign ff_wdata_3_scanin         = ff_wdata_4_scanout       ;
assign ff_wdata_2_scanin         = ff_wdata_3_scanout       ;
assign ff_wdata_1_scanin         = ff_wdata_2_scanout       ;
assign ff_wdata_0_scanin         = ff_wdata_1_scanout       ;
assign ff_word_wen_scanin        = ff_wdata_0_scanout       ;
assign ff_byte_wen_scanin        = ff_word_wen_scanout      ;
assign ff_mbist_wdata_scanin     = ff_byte_wen_scanout      ;
assign ff_mbist_run_scanin       = ff_mbist_wdata_scanout   ;
assign ff_wr_adr_scanin          = ff_mbist_run_scanout     ;
assign ff_wr_en_scanin           = ff_wr_adr_scanout        ;
assign ff_read_enable_scanin     = ff_wr_en_scanout         ;
assign ff_read_addr_scanin       = ff_read_enable_scanout   ;
assign scan_out       		 = ff_read_addr_scanout     ;
// fixscan end:

// synopsys translate_on

endmodule 




module n2_l2t_dp_16x160_cust_array (
  l1clk, 
  wr_en, 
  rd_en, 
  tcu_array_wr_inhibit, 
  word_wen, 
  wr_addr, 
  rd_addr, 
  din, 
  byte_wen, 
  dout);
wire write_disable;


input		l1clk;
input 		wr_en;
input 		rd_en;
input 		tcu_array_wr_inhibit;
input [3:0] 	word_wen;
input [3:0] 	wr_addr;
input [3:0] 	rd_addr;
input [159:0] 	din;
input [19:0] 	byte_wen;

output [159:0] 	dout;


assign write_disable = tcu_array_wr_inhibit;


wire reset_l;
assign reset_l = 1'b1;











 
// memory array
reg [159:0]  inq_ary [15:0];

integer     rd_i; 
integer     wr_i; 
integer	    rd_j; 
integer     wr_j;

reg [159:0] dout;
reg [159:0] data_in;
reg [159:0] temp;
reg [159:0] tmp_dout;

`ifndef NOINITMEM
// Emulate reset
integer i;
initial begin
  for (i=0; i<16; i=i+1) begin
   inq_ary[i] = {160{1'b0}};
  end
end
`endif


// Moved into always block for AXIs
//   assign tmp_dout = inq_ary[rd_addr] ;
//   assign temp = inq_ary[wr_addr];

//////////////////////////////////////////////////////////////////////
//
// 			Read Operation
//
//////////////////////////////////////////////////////////////////////

always @( byte_wen or rd_addr or rd_en or reset_l or write_disable  
	  or word_wen or wr_en or wr_addr or l1clk)


    #0

begin
          if ((rd_en==1'b1) & l1clk & ~write_disable)
            begin
              rd_j = 0;
	      tmp_dout = inq_ary[rd_addr] ;
              for (rd_i=0; rd_i<= 159; rd_i=rd_i+8)
                begin
                  if (rd_addr == wr_addr)
                    begin
                      dout[rd_i]   = (wr_en & word_wen[0] & byte_wen[rd_j] & ~write_disable) ?
                                      1'bx : tmp_dout[rd_i] ;
                      dout[rd_i+1] = (wr_en & word_wen[1] & byte_wen[rd_j] & ~write_disable) ?
                                      1'bx : tmp_dout[rd_i+1] ;
                      dout[rd_i+2] = (wr_en & word_wen[2] & byte_wen[rd_j] & ~write_disable) ?
                                      1'bx : tmp_dout[rd_i+2] ;
                      dout[rd_i+3] = (wr_en & word_wen[3] & byte_wen[rd_j] & ~write_disable) ?
                                      1'bx : tmp_dout[rd_i+3] ;
                      dout[rd_i+4] = (wr_en & word_wen[0] & byte_wen[rd_j] & ~write_disable) ?
                                      1'bx : tmp_dout[rd_i+4] ;
                      dout[rd_i+5] = (wr_en & word_wen[1] & byte_wen[rd_j] & ~write_disable) ?
                                      1'bx : tmp_dout[rd_i+5] ;
                      dout[rd_i+6] = (wr_en & word_wen[2] & byte_wen[rd_j] & ~write_disable) ?
                                      1'bx : tmp_dout[rd_i+6] ;
                      dout[rd_i+7] = (wr_en & word_wen[3] & byte_wen[rd_j] & ~write_disable) ?
                                      1'bx : tmp_dout[rd_i+7] ;
                      rd_j = rd_j+1;
                    end
                  else
                    begin
                      dout[rd_i]   = tmp_dout[rd_i] ;
                      dout[rd_i+1] = tmp_dout[rd_i+1] ;
                      dout[rd_i+2] = tmp_dout[rd_i+2] ;
                      dout[rd_i+3] = tmp_dout[rd_i+3] ;
                      dout[rd_i+4] = tmp_dout[rd_i+4] ;
                      dout[rd_i+5] = tmp_dout[rd_i+5] ;
                      dout[rd_i+6] = tmp_dout[rd_i+6] ;
                      dout[rd_i+7] = tmp_dout[rd_i+7] ;
                    end
                end
            end
      else 
		dout[159:0] = dout[159:0];
  end 



//////////////////////////////////////////////////////////////////////
//
// 			Write Operation
//
//////////////////////////////////////////////////////////////////////

always @ (byte_wen or reset_l or write_disable or word_wen 
	  or wr_en or din or wr_addr or l1clk)


    #0

begin
//if (reset_l)
//  begin
    if (wr_en & ~write_disable & ~l1clk)
    begin
        wr_j = 0;
	temp = inq_ary[wr_addr];
        for (wr_i=0; wr_i<=159; wr_i=wr_i+8)
             begin // for
             data_in[wr_i]   = (wr_en & word_wen[0] & byte_wen[wr_j] & ~write_disable) ?
                              din[wr_i]   : temp[wr_i] ;
             data_in[wr_i+1] = (wr_en & word_wen[1] & byte_wen[wr_j] & ~write_disable) ?
                              din[wr_i+1] : temp[wr_i+1] ;
             data_in[wr_i+2] = (wr_en & word_wen[2] & byte_wen[wr_j] & ~write_disable) ?
                              din[wr_i+2] : temp[wr_i+2] ;
             data_in[wr_i+3] = (wr_en & word_wen[3] & byte_wen[wr_j] & ~write_disable) ?
                              din[wr_i+3] : temp[wr_i+3] ;
             data_in[wr_i+4] = (wr_en & word_wen[0] & byte_wen[wr_j] & ~write_disable) ?
                              din[wr_i+4] : temp[wr_i+4] ;
             data_in[wr_i+5] = (wr_en & word_wen[1] & byte_wen[wr_j] & ~write_disable) ?
                              din[wr_i+5] : temp[wr_i+5] ;
             data_in[wr_i+6] = (wr_en & word_wen[2] & byte_wen[wr_j] & ~write_disable) ?
                              din[wr_i+6] : temp[wr_i+6] ;
             data_in[wr_i+7] = (wr_en & word_wen[3] & byte_wen[wr_j] & ~write_disable) ?
                              din[wr_i+7] : temp[wr_i+7] ;
             wr_j = wr_j+1;
             end // for
             	inq_ary[wr_addr] = data_in ;
        end  // if(wr_en.....
   //end // if reset
end  // always


endmodule







// any PARAMS parms go into naming of macro

module n2_l2t_dp_16x160_cust_l1clkhdr_ctl_macro (
  l2clk, 
  l1en, 
  pce_ov, 
  stop, 
  se, 
  l1clk);


  input l2clk;
  input l1en;
  input pce_ov;
  input stop;
  input se;
  output l1clk;



 

cl_sc1_l1hdr_8x c_0 (


   .l2clk(l2clk),
   .pce(l1en),
   .l1clk(l1clk),
  .se(se),
  .pce_ov(pce_ov),
  .stop(stop)
);



endmodule













// any PARAMS parms go into naming of macro

module n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_2 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [1:0] fdin;
wire [0:0] so;

  input [1:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [1:0] dout;
  output scan_out;
assign fdin[1:0] = din[1:0];






dff #(2)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[1:0]),
.si({so[0:0],scan_in}),
.so({scan_out,so[0:0]}),
.q(dout[1:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_l2t_dp_16x160_cust_msff_ctl_macro__width_4 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [3:0] fdin;
wire [2:0] so;

  input [3:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [3:0] dout;
  output scan_out;
assign fdin[3:0] = din[3:0];






dff #(4)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[3:0]),
.si({scan_in,so[2:0]}),
.so({so[2:0],scan_out}),
.q(dout[3:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_l2t_dp_16x160_cust_msff_ctl_macro__width_20 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [19:0] fdin;
wire [18:0] so;

  input [19:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [19:0] dout;
  output scan_out;
assign fdin[19:0] = din[19:0];






dff #(20)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[19:0]),
.si({scan_in,so[18:0]}),
.so({so[18:0],scan_out}),
.q(dout[19:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_l2t_dp_16x160_cust_msff_ctl_macro__width_8 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [7:0] fdin;
wire [6:0] so;

  input [7:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [7:0] dout;
  output scan_out;
assign fdin[7:0] = din[7:0];






dff #(8)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[7:0]),
.si({scan_in,so[6:0]}),
.so({so[6:0],scan_out}),
.q(dout[7:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_l2t_dp_16x160_cust_msff_ctl_macro__width_1 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [0:0] fdin;

  input [0:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [0:0] dout;
  output scan_out;
assign fdin[0:0] = din[0:0];






dff #(1)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[0:0]),
.si(scan_in),
.so(scan_out),
.q(dout[0:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_l2t_dp_16x160_cust_msff_ctl_macro__scanreverse_1__width_4 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [3:0] fdin;
wire [0:2] so;

  input [3:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [3:0] dout;
  output scan_out;
assign fdin[3:0] = din[3:0];






dff #(4)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[3:0]),
.si({so[0:2],scan_in}),
.so({scan_out,so[0:2]}),
.q(dout[3:0])
);












endmodule









//
//   invert macro
//
//





module n2_l2t_dp_16x160_cust_inv_macro__width_1 (
  din, 
  dout);
  input [0:0] din;
  output [0:0] dout;






inv #(1)  d0_0 (
.in(din[0:0]),
.out(dout[0:0])
);









endmodule





//  
//   and macro for ports = 2,3,4
//
//





module n2_l2t_dp_16x160_cust_and_macro__width_1 (
  din0, 
  din1, 
  dout);
  input [0:0] din0;
  input [0:0] din1;
  output [0:0] dout;






and2 #(1)  d0_0 (
.in0(din0[0:0]),
.in1(din1[0:0]),
.out(dout[0:0])
);









endmodule





//
//   macro for cl_mc1_sram_msff_mo_{16,8,4}x flops
//
//





module n2_l2t_dp_16x160_cust_sram_msff_mo_macro__width_1 (
  d, 
  scan_in, 
  l1clk, 
  and_clk, 
  siclk, 
  soclk, 
  mq, 
  mq_l, 
  scan_out, 
  q, 
  q_l);
input [0:0] d;
  input scan_in;
input l1clk;
input and_clk;
input siclk;
input soclk;
output [0:0] mq;
output [0:0] mq_l;
  output scan_out;
output [0:0] q;
output [0:0] q_l;






new_dlata #(1)  d0_0 (
.d(d[0:0]),
.si(scan_in),
.so(scan_out),
.l1clk(l1clk),
.and_clk(and_clk),
.siclk(siclk),
.soclk(soclk),
.q(q[0:0]),
.q_l(q_l[0:0]),
.mq(mq[0:0]),
.mq_l(mq_l[0:0])
);










//place::generic_place($width,$stack,$left);

endmodule





//
//   macro for cl_mc1_sram_msff_mo_{16,8,4}x flops
//
//





module n2_l2t_dp_16x160_cust_sram_msff_mo_macro__scanreverse_1__width_4 (
  d, 
  scan_in, 
  l1clk, 
  and_clk, 
  siclk, 
  soclk, 
  mq, 
  mq_l, 
  scan_out, 
  q, 
  q_l);
wire [0:2] so;

input [3:0] d;
  input scan_in;
input l1clk;
input and_clk;
input siclk;
input soclk;
output [3:0] mq;
output [3:0] mq_l;
  output scan_out;
output [3:0] q;
output [3:0] q_l;






new_dlata #(4)  d0_0 (
.d(d[3:0]),
.si({so[0:2],scan_in}),
.so({scan_out,so[0:2]}),
.l1clk(l1clk),
.and_clk(and_clk),
.siclk(siclk),
.soclk(soclk),
.q(q[3:0]),
.q_l(q_l[3:0]),
.mq(mq[3:0]),
.mq_l(mq_l[3:0])
);










//place::generic_place($width,$stack,$left);

endmodule





// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_l2t_dp_16x160_cust_mux_macro__mux_aonpe__ports_2__width_64 (
  din0, 
  sel0, 
  din1, 
  sel1, 
  dout);
wire buffout0;
wire buffout1;

  input [63:0] din0;
  input sel0;
  input [63:0] din1;
  input sel1;
  output [63:0] dout;





cl_dp1_muxbuff2_8x  c0_0 (
 .in0(sel0),
 .in1(sel1),
 .out0(buffout0),
 .out1(buffout1)
);
mux2s #(64)  d0_0 (
  .sel0(buffout0),
  .sel1(buffout1),
  .in0(din0[63:0]),
  .in1(din1[63:0]),
.dout(dout[63:0])
);









  



endmodule


// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_l2t_dp_16x160_cust_mux_macro__mux_aonpe__ports_2__width_32 (
  din0, 
  sel0, 
  din1, 
  sel1, 
  dout);
wire buffout0;
wire buffout1;

  input [31:0] din0;
  input sel0;
  input [31:0] din1;
  input sel1;
  output [31:0] dout;





cl_dp1_muxbuff2_8x  c0_0 (
 .in0(sel0),
 .in1(sel1),
 .out0(buffout0),
 .out1(buffout1)
);
mux2s #(32)  d0_0 (
  .sel0(buffout0),
  .sel1(buffout1),
  .in0(din0[31:0]),
  .in1(din1[31:0]),
.dout(dout[31:0])
);









  



endmodule


//
//   comparator macro (output is 1 if both inputs are equal; 0 otherwise)
//
//





module n2_l2t_dp_16x160_cust_cmp_macro__width_8 (
  din0, 
  din1, 
  dout);
  input [7:0] din0;
  input [7:0] din1;
  output dout;






cmp #(8)  m0_0 (
.in0(din0[7:0]),
.in1(din1[7:0]),
.out(dout)
);










endmodule




