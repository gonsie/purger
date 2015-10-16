// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: n2_icd_sp_16p5kb_cust.v
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
module n2_icd_sp_16p5kb_cust (
  l2clk, 
  scan_in, 
  tcu_pce_ov, 
  tcu_aclk, 
  tcu_bclk, 
  tcu_array_wr_inhibit, 
  tcu_se_scancollar_in, 
  tcu_se_scancollar_out, 
  tcu_scan_en, 
  red_en_in, 
  red_d_in, 
  rid_in, 
  red_wen, 
  red_arst, 
  ftp_icd_quad_0_en_bf, 
  ftp_icd_quad_1_en_bf, 
  ftp_icd_quad_2_en_bf, 
  ftp_icd_quad_3_en_bf, 
  agd_ic_index_bf, 
  agc_fill_wrway_bf, 
  cmu_ic_data, 
  agd_asi_bist_wrdata, 
  itb_icd_waysel_c, 
  agc_word_en_bf, 
  ftp_ic_rd_req_bf, 
  ftp_ic_wr_req_bf, 
  ftp_ic_wr_ps_en_bf, 
  ftp_asi_mbist_access_bf, 
  vnw_ary, 
  icd_bus_0_instr_c, 
  icd_bus_1_instr_c, 
  icd_bus_2_instr_c, 
  icd_bus_3_instr_c, 
  scan_out, 
  red_d_out, 
  red_en_out) ;
wire pce_ov;
wire stop;
wire siclk;
wire soclk;
wire wr_inhibit;
wire l1clk_in;
wire icd_quad_0_en_f_qual;
wire l1clk_q0_out;
wire icd_quad_1_en_f_qual;
wire l1clk_q1_out;
wire icd_quad_2_en_f_qual;
wire l1clk_q2_out;
wire icd_quad_3_en_f_qual;
wire l1clk_q3_out;
wire l1clk_free;
wire l1clk_fuse_clk1;
wire l1clk_red_in;
wire l1clk_red_out;
wire l1clk_int;
wire l1clk_out;
wire l1clk_wr;
wire [10:2] index_bf_l;
wire [2:0] wrway_bf_l;
wire [7:0] word_en_bf_l;
wire wr_inhibit_in_l;
wire ic_rd_req_bf_l;
wire ic_wr_req_bf_l;
wire ftp_icd_quad_0_en_l_bf;
wire ftp_icd_quad_1_en_l_bf;
wire ftp_icd_quad_2_en_l_bf;
wire ftp_icd_quad_3_en_l_bf;
wire quad_en_0_latch_scanin;
wire quad_en_0_latch_scanout;
wire icd_quad_0_en_f_lat;
wire icd_quad_0_en_f_lat_l;
wire quad_en_1_latch_scanin;
wire quad_en_1_latch_scanout;
wire icd_quad_1_en_f_lat;
wire icd_quad_1_en_f_lat_l;
wire quad_en_2_latch_scanin;
wire quad_en_2_latch_scanout;
wire icd_quad_2_en_f_lat;
wire icd_quad_2_en_f_lat_l;
wire quad_en_3_latch_scanin;
wire quad_en_3_latch_scanout;
wire icd_quad_3_en_f_lat;
wire icd_quad_3_en_f_lat_l;
wire icd_quad_0_en_f_lat_unused;
wire icd_quad_1_en_f_lat_unused;
wire icd_quad_2_en_f_lat_unused;
wire icd_quad_3_en_f_lat_unused;
wire index_reg_i_scanin;
wire index_reg_i_scanout;
wire [10:2] index_f;
wire [10:5] index_f_l;
wire [4:2] index_f_l_unused;
wire wrway_0_reg_scanin;
wire wrway_0_reg_scanout;
wire [2:0] wrway_f;
wire [2:0] wrway_f_unused;
wire wrway_1_reg_scanin;
wire wrway_1_reg_scanout;
wire wrway_2_reg_scanin;
wire wrway_2_reg_scanout;
wire wr_word_en_0_reg_scanin;
wire wr_word_en_0_reg_scanout;
wire [7:0] word_en_f;
wire [7:0] word_en_f_unused;
wire wr_word_en_1_reg_scanin;
wire wr_word_en_1_reg_scanout;
wire wr_word_en_2_reg_scanin;
wire wr_word_en_2_reg_scanout;
wire wr_word_en_3_reg_scanin;
wire wr_word_en_3_reg_scanout;
wire wr_word_en_4_reg_scanin;
wire wr_word_en_4_reg_scanout;
wire wr_word_en_5_reg_scanin;
wire wr_word_en_5_reg_scanout;
wire wr_word_en_6_reg_scanin;
wire wr_word_en_6_reg_scanout;
wire wr_word_en_7_reg_scanin;
wire wr_word_en_7_reg_scanout;
wire [3:0] quad_en_reg_scanin;
wire [3:0] quad_en_reg_scanout;
wire icd_quad_3_en_l_f;
wire icd_quad_2_en_l_f;
wire icd_quad_1_en_l_f;
wire icd_quad_0_en_l_f;
wire icd_quad_3_en_f;
wire icd_quad_2_en_f;
wire icd_quad_1_en_f;
wire icd_quad_0_en_f;
wire [0:0] wrreq_reg_scanin;
wire [0:0] wrreq_reg_scanout;
wire wrreq_f;
wire wrreq_f_l_unused;
wire wrreq_reg_b_scanin;
wire wrreq_reg_b_scanout;
wire wrreq_f_l;
wire [0:0] ftp_access_f_reg_scanin;
wire [0:0] ftp_access_f_reg_scanout;
wire asi_access_f;
wire rdreq_reg_scanin;
wire rdreq_reg_scanout;
wire rdreq_f_l_unused;
wire rdreq_f_unused;
wire rdreq_reg_b_scanin;
wire rdreq_reg_b_scanout;
wire rdreq_f;
wire [263:0] wrdata_in;
wire [32:0] wrdata_q0_0_scanin;
wire [32:0] wrdata_q0_0_scanout;
wire [263:0] wrdata_f;
wire [32:0] wrdata_q1_1_scanin;
wire [32:0] wrdata_q1_1_scanout;
wire [32:0] wrdata_q2_2_scanin;
wire [32:0] wrdata_q2_2_scanout;
wire [32:0] wrdata_q3_3_scanin;
wire [32:0] wrdata_q3_3_scanout;
wire [32:0] wrdata_q0_4_scanin;
wire [32:0] wrdata_q0_4_scanout;
wire [32:0] wrdata_q1_5_scanin;
wire [32:0] wrdata_q1_5_scanout;
wire [32:0] wrdata_q2_6_scanin;
wire [32:0] wrdata_q2_6_scanout;
wire [32:0] wrdata_q3_7_scanin;
wire [32:0] wrdata_q3_7_scanout;
wire [4:0] red_d_reg_scanin;
wire [4:0] red_d_reg_scanout;
wire [4:0] red_d_ff;
wire [1:0] red_en_reg_scanin;
wire [1:0] red_en_reg_scanout;
wire [1:0] red_en_ff;
wire [3:0] rid_reg_scanin;
wire [3:0] rid_reg_scanout;
wire [3:0] rid_ff;
wire [0:0] red_wen_reg_scanin;
wire [0:0] red_wen_reg_scanout;
wire red_wen_ff_and;
wire red_wen_ff;
wire [0:0] red_arst_reg_scanin;
wire [0:0] red_arst_reg_scanout;
wire red_arst_ff_and;
wire red_arst_ff;
wire [7:0] way_f_reg_scanin;
wire [7:0] way_f_reg_scanout;
wire [7:0] wrway_dec_bf;
wire [7:0] wrway_dec_f;
wire [7:0] way_c_reg_scanin;
wire [7:0] way_c_reg_scanout;
wire [7:0] wrway_dec_c;
wire [0:0] ftp_access_c_reg_scanin;
wire [0:0] ftp_access_c_reg_scanout;
wire asi_access_c;
wire ftp_access_c_dum_scanin;
wire ftp_access_c_dum_scanout;
wire asi_access_c_l;
wire asi_access_c_l_inv;
wire asi_access_c_inv;
wire [7:0] muxed_way_sel_c;
wire i4_i0_sel_upper;
wire i4_i0_sel_upper_;
wire i5_i1_sel_upper;
wire i5_i1_sel_upper_;
wire i6_i2_sel_upper_or_2;
wire i6_i2_sel_upper;
wire i6_i2_sel_upper_;
wire i7_i3_sel_upper;
wire i7_i3_sel_upper_;
wire [7:0] wr_word_en_f_l;
wire rdreq_f_q0_l;
wire rdreq_f_q0;
wire rdreq_f_q1_l;
wire rdreq_f_q1;
wire rdreq_f_q2_l;
wire rdreq_f_q2;
wire rdreq_f_q3_l;
wire rdreq_f_q3;
wire [7:0] wrway_dec_f_;
wire [7:0] rid_sel_dec;
wire [15:0] rid_sel;
wire [32:0] rd_data_w0_i4_or_i0;
wire [32:0] rd_data_w1_i4_or_i0;
wire [32:0] rd_data_w2_i4_or_i0;
wire [32:0] rd_data_w3_i4_or_i0;
wire [32:0] rd_data_w4_i4_or_i0;
wire [32:0] rd_data_w5_i4_or_i0;
wire [32:0] rd_data_w6_i4_or_i0;
wire [32:0] rd_data_w7_i4_or_i0;
wire [4:0] reg_d_q0_w3_w0_lft_d;
wire [1:0] reg_d_q0_w3_w0_lft_en;
wire [4:0] reg_d_q0_w3_w0_rgt_d;
wire [1:0] reg_d_q0_w3_w0_rgt_en;
wire [4:0] reg_d_q0_w7_w4_lft_d;
wire [1:0] reg_d_q0_w7_w4_lft_en;
wire [4:0] reg_d_q0_w7_w4_rgt_d;
wire [1:0] reg_d_q0_w7_w4_rgt_en;
wire [32:0] rd_data_w0_i5_or_i1;
wire [32:0] rd_data_w1_i5_or_i1;
wire [32:0] rd_data_w2_i5_or_i1;
wire [32:0] rd_data_w3_i5_or_i1;
wire [32:0] rd_data_w4_i5_or_i1;
wire [32:0] rd_data_w5_i5_or_i1;
wire [32:0] rd_data_w6_i5_or_i1;
wire [32:0] rd_data_w7_i5_or_i1;
wire [4:0] reg_d_q1_w3_w0_lft_d;
wire [1:0] reg_d_q1_w3_w0_lft_en;
wire [4:0] reg_d_q1_w3_w0_rgt_d;
wire [1:0] reg_d_q1_w3_w0_rgt_en;
wire [4:0] reg_d_q1_w7_w4_lft_d;
wire [1:0] reg_d_q1_w7_w4_lft_en;
wire [4:0] reg_d_q1_w7_w4_rgt_d;
wire [1:0] reg_d_q1_w7_w4_rgt_en;
wire [32:0] rd_data_w0_i6_or_i2;
wire [32:0] rd_data_w1_i6_or_i2;
wire [32:0] rd_data_w2_i6_or_i2;
wire [32:0] rd_data_w3_i6_or_i2;
wire [32:0] rd_data_w4_i6_or_i2;
wire [32:0] rd_data_w5_i6_or_i2;
wire [32:0] rd_data_w6_i6_or_i2;
wire [32:0] rd_data_w7_i6_or_i2;
wire [4:0] reg_d_q2_w3_w0_lft_d;
wire [1:0] reg_d_q2_w3_w0_lft_en;
wire [4:0] reg_d_q2_w3_w0_rgt_d;
wire [1:0] reg_d_q2_w3_w0_rgt_en;
wire [4:0] reg_d_q2_w7_w4_lft_d;
wire [1:0] reg_d_q2_w7_w4_lft_en;
wire [4:0] reg_d_q2_w7_w4_rgt_d;
wire [1:0] reg_d_q2_w7_w4_rgt_en;
wire [32:0] rd_data_w0_i7_or_i3;
wire [32:0] rd_data_w1_i7_or_i3;
wire [32:0] rd_data_w2_i7_or_i3;
wire [32:0] rd_data_w3_i7_or_i3;
wire [32:0] rd_data_w4_i7_or_i3;
wire [32:0] rd_data_w5_i7_or_i3;
wire [32:0] rd_data_w6_i7_or_i3;
wire [32:0] rd_data_w7_i7_or_i3;
wire [4:0] reg_d_q3_w3_w0_lft_d;
wire [1:0] reg_d_q3_w3_w0_lft_en;
wire [4:0] reg_d_q3_w3_w0_rgt_d;
wire [1:0] reg_d_q3_w3_w0_rgt_en;
wire [4:0] reg_d_q3_w7_w4_lft_d;
wire [1:0] reg_d_q3_w7_w4_lft_en;
wire [4:0] reg_d_q3_w7_w4_rgt_d;
wire [1:0] reg_d_q3_w7_w4_rgt_en;
wire [32:0] data_bus_0_w0_reg_scanin;
wire [32:0] data_bus_0_w0_reg_scanout;
wire [32:0] data_bus_0_w0_c;
wire [32:0] data_bus_1_w0_reg_scanin;
wire [32:0] data_bus_1_w0_reg_scanout;
wire [32:0] data_bus_1_w0_c;
wire [32:0] data_bus_2_w0_reg_scanin;
wire [32:0] data_bus_2_w0_reg_scanout;
wire [32:0] data_bus_2_w0_c;
wire [32:0] data_bus_3_w0_reg_scanin;
wire [32:0] data_bus_3_w0_reg_scanout;
wire [32:0] data_bus_3_w0_c;
wire [32:0] data_bus_0_w1_reg_scanin;
wire [32:0] data_bus_0_w1_reg_scanout;
wire [32:0] data_bus_0_w1_c;
wire [32:0] data_bus_1_w1_reg_scanin;
wire [32:0] data_bus_1_w1_reg_scanout;
wire [32:0] data_bus_1_w1_c;
wire [32:0] data_bus_2_w1_reg_scanin;
wire [32:0] data_bus_2_w1_reg_scanout;
wire [32:0] data_bus_2_w1_c;
wire [32:0] data_bus_3_w1_reg_scanin;
wire [32:0] data_bus_3_w1_reg_scanout;
wire [32:0] data_bus_3_w1_c;
wire [32:0] data_bus_0_w2_reg_scanin;
wire [32:0] data_bus_0_w2_reg_scanout;
wire [32:0] data_bus_0_w2_c;
wire [32:0] data_bus_1_w2_reg_scanin;
wire [32:0] data_bus_1_w2_reg_scanout;
wire [32:0] data_bus_1_w2_c;
wire [32:0] data_bus_2_w2_reg_scanin;
wire [32:0] data_bus_2_w2_reg_scanout;
wire [32:0] data_bus_2_w2_c;
wire [32:0] data_bus_3_w2_reg_scanin;
wire [32:0] data_bus_3_w2_reg_scanout;
wire [32:0] data_bus_3_w2_c;
wire [32:0] data_bus_0_w3_reg_scanin;
wire [32:0] data_bus_0_w3_reg_scanout;
wire [32:0] data_bus_0_w3_c;
wire [32:0] data_bus_1_w3_reg_scanin;
wire [32:0] data_bus_1_w3_reg_scanout;
wire [32:0] data_bus_1_w3_c;
wire [32:0] data_bus_2_w3_reg_scanin;
wire [32:0] data_bus_2_w3_reg_scanout;
wire [32:0] data_bus_2_w3_c;
wire [32:0] data_bus_3_w3_reg_scanin;
wire [32:0] data_bus_3_w3_reg_scanout;
wire [32:0] data_bus_3_w3_c;
wire [32:0] data_bus_0_w4_reg_scanin;
wire [32:0] data_bus_0_w4_reg_scanout;
wire [32:0] data_bus_0_w4_c;
wire [32:0] data_bus_1_w4_reg_scanin;
wire [32:0] data_bus_1_w4_reg_scanout;
wire [32:0] data_bus_1_w4_c;
wire [32:0] data_bus_2_w4_reg_scanin;
wire [32:0] data_bus_2_w4_reg_scanout;
wire [32:0] data_bus_2_w4_c;
wire [32:0] data_bus_3_w4_reg_scanin;
wire [32:0] data_bus_3_w4_reg_scanout;
wire [32:0] data_bus_3_w4_c;
wire [32:0] data_bus_0_w5_reg_scanin;
wire [32:0] data_bus_0_w5_reg_scanout;
wire [32:0] data_bus_0_w5_c;
wire [32:0] data_bus_1_w5_reg_scanin;
wire [32:0] data_bus_1_w5_reg_scanout;
wire [32:0] data_bus_1_w5_c;
wire [32:0] data_bus_2_w5_reg_scanin;
wire [32:0] data_bus_2_w5_reg_scanout;
wire [32:0] data_bus_2_w5_c;
wire [32:0] data_bus_3_w5_reg_scanin;
wire [32:0] data_bus_3_w5_reg_scanout;
wire [32:0] data_bus_3_w5_c;
wire [32:0] data_bus_0_w6_reg_scanin;
wire [32:0] data_bus_0_w6_reg_scanout;
wire [32:0] data_bus_0_w6_c;
wire [32:0] data_bus_1_w6_reg_scanin;
wire [32:0] data_bus_1_w6_reg_scanout;
wire [32:0] data_bus_1_w6_c;
wire [32:0] data_bus_2_w6_reg_scanin;
wire [32:0] data_bus_2_w6_reg_scanout;
wire [32:0] data_bus_2_w6_c;
wire [32:0] data_bus_3_w6_reg_scanin;
wire [32:0] data_bus_3_w6_reg_scanout;
wire [32:0] data_bus_3_w6_c;
wire [32:0] data_bus_0_w7_reg_scanin;
wire [32:0] data_bus_0_w7_reg_scanout;
wire [32:0] data_bus_0_w7_c;
wire [32:0] data_bus_1_w7_reg_scanin;
wire [32:0] data_bus_1_w7_reg_scanout;
wire [32:0] data_bus_1_w7_c;
wire [32:0] data_bus_2_w7_reg_scanin;
wire [32:0] data_bus_2_w7_reg_scanout;
wire [32:0] data_bus_2_w7_c;
wire [32:0] data_bus_3_w7_reg_scanin;
wire [32:0] data_bus_3_w7_reg_scanout;
wire [32:0] data_bus_3_w7_c;
wire [4:0] reg_d_out_mux_0;
wire [1:0] reg_en_out_mux_0;
wire [4:0] reg_d_out_mux_1;
wire [1:0] reg_en_out_mux_1;
wire [4:0] red_mux_d_out;
wire [1:0] red_mux_en_out;
wire [4:0] red_d_out_reg_scanin;
wire [4:0] red_d_out_reg_scanout;
wire [1:0] red_en_out_reg_scanin;
wire [1:0] red_en_out_reg_scanout;
 





// make sure you have .l2clk(l2clk), 1 level up; run fixscan



   input          l2clk;
   input          scan_in;
   input          tcu_pce_ov;
   input          tcu_aclk;
   input          tcu_bclk;
   input          tcu_array_wr_inhibit;
   input          tcu_se_scancollar_in;
   input          tcu_se_scancollar_out;
   input          tcu_scan_en;

   input [1:0]    red_en_in ;
   input [4:0]    red_d_in ;
   input [3:0]    rid_in ;
   input          red_wen ;
   input          red_arst ;

   input      ftp_icd_quad_0_en_bf;    // enable quad 0
   input      ftp_icd_quad_1_en_bf;    // enable quad 1
   input      ftp_icd_quad_2_en_bf;    // enable quad 2
   input      ftp_icd_quad_3_en_bf;    // enable quad 3



   input [10:2]                agd_ic_index_bf;    // index to write to/read from
   input [2:0]                 agc_fill_wrway_bf;  // way to write to
   input [263:0]               cmu_ic_data;        // 128b data, 4b parity
   input [32:0]                agd_asi_bist_wrdata;     // Debug wr data 
   input [7:0]                 itb_icd_waysel_c;   // read way select encoded
   input [7:0]                 agc_word_en_bf;     // read/write  word enable 

   input          ftp_ic_rd_req_bf;
   input          ftp_ic_wr_req_bf;
   input          ftp_ic_wr_ps_en_bf;
   input          ftp_asi_mbist_access_bf;

   input          vnw_ary;


   // outputs
   output [32:0]  icd_bus_0_instr_c ;
   output [32:0]  icd_bus_1_instr_c ;
   output [32:0]  icd_bus_2_instr_c ;
   output [32:0]  icd_bus_3_instr_c ;
   output         scan_out;
   output [4:0]   red_d_out  ;
   output [1:0]   red_en_out ;

   `ifndef FPGA 
   // synopsys translate_off
   `endif

   assign pce_ov = tcu_pce_ov;
   assign stop   = 1'b0 ;
   assign siclk  = tcu_aclk ;
   assign soclk  = tcu_bclk;
   assign wr_inhibit  = tcu_array_wr_inhibit;

// Temporary

// assign red_d_out[4:0]  = 5'b00000 ;
// assign red_en_out[1:0] = 2'b00 ;
//================================================
// Clock headers
//================================================
n2_icd_sp_16p5kb_cust_l1clkhdr_ctl_macro l1ch_in (
        .l2clk  (l2clk),
        .l1en   (1'b1),
        .se     (tcu_se_scancollar_in),
        .l1clk  (l1clk_in),
  .pce_ov(pce_ov),
  .stop(stop)
);

// l1clkhdr_ctl_macro l1ch_q0_in (
//         .l2clk  (l2clk),
//         .l1en	(ftp_icd_quad_0_en_bf),
//         .se     (tcu_se_scancollar_in),
//         .l1clk  (l1clk_q0_in)
// );

// l1clkhdr_ctl_macro l1ch_q1_in (
//         .l2clk  (l2clk),
//         .l1en	(ftp_icd_quad_1_en_bf),
//         .se     (tcu_se_scancollar_in),
//         .l1clk  (l1clk_q1_in)
// );

// l1clkhdr_ctl_macro l1ch_q2_in (
//         .l2clk  (l2clk),
//         .l1en	(ftp_icd_quad_2_en_bf),
//         .se     (tcu_se_scancollar_in),
//         .l1clk  (l1clk_q2_in)
// );

// l1clkhdr_ctl_macro l1ch_q3_in (
//         .l2clk  (l2clk),
//         .l1en	(ftp_icd_quad_3_en_bf),
//         .se     (tcu_se_scancollar_in),
//         .l1clk  (l1clk_q3_in)
// );


n2_icd_sp_16p5kb_cust_l1clkhdr_ctl_macro l1ch_q0_out (
        .l2clk  (l2clk),
        .l1en	(icd_quad_0_en_f_qual),
        .se     (tcu_se_scancollar_out),
        .l1clk  (l1clk_q0_out),
  .pce_ov(pce_ov),
  .stop(stop)
);

n2_icd_sp_16p5kb_cust_l1clkhdr_ctl_macro l1ch_q1_out (
        .l2clk  (l2clk),
        .l1en	(icd_quad_1_en_f_qual),
        .se     (tcu_se_scancollar_out),
        .l1clk  (l1clk_q1_out),
  .pce_ov(pce_ov),
  .stop(stop)
);

n2_icd_sp_16p5kb_cust_l1clkhdr_ctl_macro l1ch_q2_out (
        .l2clk  (l2clk),
        .l1en	(icd_quad_2_en_f_qual),
        .se     (tcu_se_scancollar_out),
        .l1clk  (l1clk_q2_out),
  .pce_ov(pce_ov),
  .stop(stop)
);

n2_icd_sp_16p5kb_cust_l1clkhdr_ctl_macro l1ch_q3_out (
        .l2clk  (l2clk),
        .l1en	(icd_quad_3_en_f_qual),
        .se     (tcu_se_scancollar_out),
        .l1clk  (l1clk_q3_out),
  .pce_ov(pce_ov),
  .stop(stop)
);


n2_icd_sp_16p5kb_cust_l1clkhdr_ctl_macro l1ch_free (
        .l2clk  (l2clk),
        .l1en	(1'b1),
        .se     (tcu_scan_en),
        .l1clk  (l1clk_free),
  .pce_ov(pce_ov),
  .stop(stop)
);

 n2_icd_sp_16p5kb_cust_l1clkhdr_ctl_macro l1ch_red_free (
  .l2clk  (l2clk),
  .l1en   (1'b1),
  .se     (1'b0),
  .l1clk  (l1clk_fuse_clk1),
  .pce_ov(1'b1),
  .stop(1'b0)
);

 n2_icd_sp_16p5kb_cust_l1clkhdr_ctl_macro l1ch_red_in (
  .l2clk  (l2clk),
  .l1en   (1'b1),
  .se     (tcu_se_scancollar_in),
  .l1clk  (l1clk_red_in),
  .pce_ov(1'b1),
  .stop(1'b0)
);

 n2_icd_sp_16p5kb_cust_l1clkhdr_ctl_macro l1ch_red_out (
  .l2clk  (l2clk),
  .l1en   (1'b1),
  .se     (tcu_se_scancollar_out),
  .l1clk  (l1clk_red_out),
  .pce_ov(1'b1),
  .stop(1'b0)
);

n2_icd_sp_16p5kb_cust_l1clkhdr_ctl_macro l1ch_int (
        .l2clk  (l2clk),
        .l1en   (1'b1),
        .se     (tcu_scan_en),
        .l1clk  (l1clk_int),
  .pce_ov(pce_ov),
  .stop(stop)
);

n2_icd_sp_16p5kb_cust_l1clkhdr_ctl_macro l1ch_out (
        .l2clk  (l2clk),
        .l1en   (1'b1),
        .se     (tcu_se_scancollar_out),
        .l1clk  (l1clk_out),
  .pce_ov(pce_ov),
  .stop(stop)
);

 n2_icd_sp_16p5kb_cust_l1clkhdr_ctl_macro l1ch_wr (
        .l2clk  (l2clk),
        .l1en	(ftp_ic_wr_ps_en_bf),
        .se     (tcu_se_scancollar_in),
        .l1clk  (l1clk_wr),
  .pce_ov(pce_ov),
  .stop(stop)
);



   //----------------------------------------------------------------------
   // Declarations
   //----------------------------------------------------------------------

   // local signals


  

  
 ////////////////////////////////////////////////////////////
 //
 // Code start here
 //
 ////////////////////////////////////////////////////////////
 // Inverters before the flops                             //

n2_icd_sp_16p5kb_cust_inv_macro__stack_50c__width_9 index_inv    (
    .din(agd_ic_index_bf[10:2]),
    .dout(index_bf_l[10:2])
);


n2_icd_sp_16p5kb_cust_inv_macro__stack_50c__width_3 wrway_inv    (
    .din(agc_fill_wrway_bf[2:0]),
    .dout(wrway_bf_l[2:0])
);

n2_icd_sp_16p5kb_cust_inv_macro__stack_50c__width_8 word_en_inv    (
    .din(agc_word_en_bf[7:0]),
    .dout(word_en_bf_l[7:0])
);

n2_icd_sp_16p5kb_cust_inv_macro__stack_50c__width_1 wr_inhibit_inv    (
    .din(wr_inhibit),
    .dout(wr_inhibit_in_l)
);

n2_icd_sp_16p5kb_cust_inv_macro__stack_50c__width_1 ic_rd_req_inv    (
    .din(ftp_ic_rd_req_bf),
    .dout(ic_rd_req_bf_l)
);

n2_icd_sp_16p5kb_cust_inv_macro__stack_50c__width_1 ic_wr_req_inv    (
    .din(ftp_ic_wr_req_bf),
    .dout(ic_wr_req_bf_l)
);

n2_icd_sp_16p5kb_cust_inv_macro__stack_50c__width_4 quad_en_in_inv    (
    .din ({ftp_icd_quad_0_en_bf, ftp_icd_quad_1_en_bf , ftp_icd_quad_2_en_bf , ftp_icd_quad_3_en_bf}),
    .dout({ftp_icd_quad_0_en_l_bf, ftp_icd_quad_1_en_l_bf , ftp_icd_quad_2_en_l_bf , ftp_icd_quad_3_en_l_bf}) 
);

n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1 quad_0_en_latch  (
    .scan_in(quad_en_0_latch_scanin),
    .scan_out(quad_en_0_latch_scanout),
    .l1clk(l1clk_in),
    .d(ftp_icd_quad_0_en_l_bf),
    .latout_l(icd_quad_0_en_f_lat),
    .latout(icd_quad_0_en_f_lat_l),
  .siclk(siclk),
  .soclk(soclk)
    );
n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1 quad_1_en_latch  (
    .scan_in(quad_en_1_latch_scanin),
    .scan_out(quad_en_1_latch_scanout),
    .l1clk(l1clk_in),
    .d(ftp_icd_quad_1_en_l_bf),
    .latout_l(icd_quad_1_en_f_lat),
    .latout(icd_quad_1_en_f_lat_l),
  .siclk(siclk),
  .soclk(soclk)
    );

n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1 quad_2_en_latch  (
    .scan_in(quad_en_2_latch_scanin),
    .scan_out(quad_en_2_latch_scanout),
    .l1clk(l1clk_in),
    .d(ftp_icd_quad_2_en_l_bf),
    .latout_l(icd_quad_2_en_f_lat),
    .latout(icd_quad_2_en_f_lat_l),
  .siclk(siclk),
  .soclk(soclk)
    );

n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1 quad_3_en_latch  (
    .scan_in(quad_en_3_latch_scanin),
    .scan_out(quad_en_3_latch_scanout),
    .l1clk(l1clk_in),
    .d(ftp_icd_quad_3_en_l_bf),
    .latout_l(icd_quad_3_en_f_lat),
    .latout(icd_quad_3_en_f_lat_l),
  .siclk(siclk),
  .soclk(soclk)
    );
assign icd_quad_0_en_f_lat_unused = icd_quad_0_en_f_lat ;
assign icd_quad_1_en_f_lat_unused = icd_quad_1_en_f_lat ;
assign icd_quad_2_en_f_lat_unused = icd_quad_2_en_f_lat ;
assign icd_quad_3_en_f_lat_unused = icd_quad_3_en_f_lat ;


 ///////////////////////////////////////////////////////////////
 // Flop the inputs                                           //
 ///////////////////////////////////////////////////////////////


 n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_9	index_reg_i		 (
  .scan_in(index_reg_i_scanin),
  .scan_out(index_reg_i_scanout),
  .l1clk ( l1clk_in				),
  .d ( index_bf_l[10:2]			),
  .latout_l( index_f[10:2] 			),
  .latout( {index_f_l[10:5],index_f_l_unused[4:2]}		),
  .siclk(siclk),
  .soclk(soclk));



 n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1	wrway_0_reg		 (
  .scan_in(wrway_0_reg_scanin),
  .scan_out(wrway_0_reg_scanout),
  .l1clk ( l1clk_in				),
  .d ( wrway_bf_l[0]			),
  .latout_l( wrway_f[0] 			),
  .latout( wrway_f_unused[0]		),
  .siclk(siclk),
  .soclk(soclk));

 n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1	wrway_1_reg		 (
  .scan_in(wrway_1_reg_scanin),
  .scan_out(wrway_1_reg_scanout),
  .l1clk ( l1clk_in				),
  .d ( wrway_bf_l[1]			),
  .latout_l( wrway_f[1] 			),
  .latout( wrway_f_unused[1]		),
  .siclk(siclk),
  .soclk(soclk));

 n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1	wrway_2_reg		 (
  .scan_in(wrway_2_reg_scanin),
  .scan_out(wrway_2_reg_scanout),
  .l1clk ( l1clk_in				),
  .d ( wrway_bf_l[2]			),
  .latout_l( wrway_f[2] 			),
  .latout( wrway_f_unused[2]		),
  .siclk(siclk),
  .soclk(soclk));



 n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1	wr_word_en_0_reg		 (
  .scan_in(wr_word_en_0_reg_scanin),
  .scan_out(wr_word_en_0_reg_scanout),
  .l1clk ( l1clk_in				),
  .d ( word_en_bf_l[0]			),
  .latout_l( word_en_f[0]			),
  .latout( word_en_f_unused[0]		),
  .siclk(siclk),
  .soclk(soclk));


 n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1	wr_word_en_1_reg		 (
  .scan_in(wr_word_en_1_reg_scanin),
  .scan_out(wr_word_en_1_reg_scanout),
  .l1clk ( l1clk_in				),
  .d ( word_en_bf_l[1]			),
  .latout_l( word_en_f[1]			),
  .latout( word_en_f_unused[1]		),
  .siclk(siclk),
  .soclk(soclk));


 n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1	wr_word_en_2_reg		 (
  .scan_in(wr_word_en_2_reg_scanin),
  .scan_out(wr_word_en_2_reg_scanout),
  .l1clk ( l1clk_in				),
  .d ( word_en_bf_l[2]			),
  .latout_l( word_en_f[2]			),
  .latout( word_en_f_unused[2]		),
  .siclk(siclk),
  .soclk(soclk));


 n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1	wr_word_en_3_reg		 (
  .scan_in(wr_word_en_3_reg_scanin),
  .scan_out(wr_word_en_3_reg_scanout),
  .l1clk ( l1clk_in				),
  .d ( word_en_bf_l[3]			),
  .latout_l( word_en_f[3]			),
  .latout( word_en_f_unused[3]		),
  .siclk(siclk),
  .soclk(soclk));




 n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1	wr_word_en_4_reg		 (
  .scan_in(wr_word_en_4_reg_scanin),
  .scan_out(wr_word_en_4_reg_scanout),
  .l1clk ( l1clk_in				),
  .d ( word_en_bf_l[4]			),
  .latout_l( word_en_f[4]			),
  .latout( word_en_f_unused[4]		),
  .siclk(siclk),
  .soclk(soclk));


 n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1	wr_word_en_5_reg		 (
  .scan_in(wr_word_en_5_reg_scanin),
  .scan_out(wr_word_en_5_reg_scanout),
  .l1clk ( l1clk_in				),
  .d ( word_en_bf_l[5]			),
  .latout_l( word_en_f[5]			),
  .latout( word_en_f_unused[5]		),
  .siclk(siclk),
  .soclk(soclk));


 n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1	wr_word_en_6_reg		 (
  .scan_in(wr_word_en_6_reg_scanin),
  .scan_out(wr_word_en_6_reg_scanout),
  .l1clk ( l1clk_in				),
  .d ( word_en_bf_l[6]			),
  .latout_l( word_en_f[6]			),
  .latout( word_en_f_unused[6]		),
  .siclk(siclk),
  .soclk(soclk));


 n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1	wr_word_en_7_reg		 (
  .scan_in(wr_word_en_7_reg_scanin),
  .scan_out(wr_word_en_7_reg_scanout),
  .l1clk ( l1clk_in				),
  .d ( word_en_bf_l[7]			),
  .latout_l( word_en_f[7]			),
  .latout( word_en_f_unused[7]		),
  .siclk(siclk),
  .soclk(soclk));



   n2_icd_sp_16p5kb_cust_msffi_ctl_macro__fs_1__width_4 quad_en_reg  (
     .scan_in(quad_en_reg_scanin[3:0]),
     .scan_out(quad_en_reg_scanout[3:0]),
    .l1clk(l1clk_in),
    .din( {ftp_icd_quad_3_en_bf,ftp_icd_quad_2_en_bf,ftp_icd_quad_1_en_bf,ftp_icd_quad_0_en_bf}),
    .q_l({icd_quad_3_en_l_f,icd_quad_2_en_l_f,icd_quad_1_en_l_f,icd_quad_0_en_l_f}),
  .siclk(siclk),
  .soclk(soclk) 
    );

n2_icd_sp_16p5kb_cust_inv_macro__width_4 quad_inv  (
    .din ({icd_quad_3_en_l_f,icd_quad_2_en_l_f,icd_quad_1_en_l_f,icd_quad_0_en_l_f}) ,
    .dout({icd_quad_3_en_f,icd_quad_2_en_f,icd_quad_1_en_f,icd_quad_0_en_f}) 
    );

   n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1 wrreq_reg  (
    .scan_in(wrreq_reg_scanin[0:0]),
    .scan_out(wrreq_reg_scanout[0:0]),
    .l1clk(l1clk_in),
    .d(ic_wr_req_bf_l),
    .latout_l(wrreq_f),
    .latout(wrreq_f_l_unused),
  .siclk(siclk),
  .soclk(soclk)
    );


n2_icd_sp_16p5kb_cust_msffi_ctl_macro__width_1	wrreq_reg_b			 (
  .scan_in(wrreq_reg_b_scanin),
  .scan_out(wrreq_reg_b_scanout),
  .l1clk ( l1clk_in				),
  .din ( ftp_ic_wr_req_bf			),
  .q_l ( wrreq_f_l				),
  .siclk(siclk),
  .soclk(soclk));

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_1 ftp_access_f_reg  (
     .scan_in(ftp_access_f_reg_scanin[0:0]),
     .scan_out(ftp_access_f_reg_scanout[0:0]),
    .l1clk(l1clk_in),
    .din(ftp_asi_mbist_access_bf),
    .dout(asi_access_f),
  .siclk(siclk),
  .soclk(soclk)
    );


n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1	rdreq_reg			 (
  .scan_in(rdreq_reg_scanin),
  .scan_out(rdreq_reg_scanout),
  .l1clk ( l1clk_in                             ),
  .d ( ic_rd_req_bf_l                   ),
  .latout ( rdreq_f_l_unused                           ),
  .latout_l ( rdreq_f_unused                          ),
  .siclk(siclk),
  .soclk(soclk));


n2_icd_sp_16p5kb_cust_msff_ctl_macro__width_1	rdreq_reg_b			 (
  .scan_in(rdreq_reg_b_scanin),
  .scan_out(rdreq_reg_b_scanout),
  .l1clk ( l1clk_in				),
  .din ( ftp_ic_rd_req_bf			),
  .dout ( rdreq_f				),
  .siclk(siclk),
  .soclk(soclk));



   // write data regsiter

n2_icd_sp_16p5kb_cust_mux_macro__mux_aope__ports_2__stack_66c__width_66 wrdata_reg_lo_1_mux     (
    .din0({agd_asi_bist_wrdata[32:0],agd_asi_bist_wrdata[32:0]}),
    .din1(cmu_ic_data[65:0]),
    .sel0(ftp_asi_mbist_access_bf),
    .dout(wrdata_in[65:0])
);


   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 wrdata_q0_0  (
     .scan_in(wrdata_q0_0_scanin[32:0]),
     .scan_out(wrdata_q0_0_scanout[32:0]),
    .l1clk(l1clk_wr),
    .din(wrdata_in[32:0]),
    .dout(wrdata_f[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 wrdata_q1_1  (
     .scan_in(wrdata_q1_1_scanin[32:0]),
     .scan_out(wrdata_q1_1_scanout[32:0]),
    .l1clk(l1clk_wr),
    .din(wrdata_in[65:33]),
    .dout(wrdata_f[65:33]),
  .siclk(siclk),
  .soclk(soclk)
    );

n2_icd_sp_16p5kb_cust_mux_macro__mux_aope__ports_2__stack_66c__width_66 wrdata_reg_lo_2_mux     (
    .din0({agd_asi_bist_wrdata[32:0],agd_asi_bist_wrdata[32:0]}),
    .din1(cmu_ic_data[131:66]),
    .sel0(ftp_asi_mbist_access_bf),
    .dout(wrdata_in[131:66])
);

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 wrdata_q2_2  (
     .scan_in(wrdata_q2_2_scanin[32:0]),
     .scan_out(wrdata_q2_2_scanout[32:0]),
    .l1clk(l1clk_wr),
    .din(wrdata_in[98:66]),
    .dout(wrdata_f[98:66]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 wrdata_q3_3  (
     .scan_in(wrdata_q3_3_scanin[32:0]),
     .scan_out(wrdata_q3_3_scanout[32:0]),
    .l1clk(l1clk_wr),
    .din(wrdata_in[131:99]),
    .dout(wrdata_f[131:99]),
  .siclk(siclk),
  .soclk(soclk)
    );


n2_icd_sp_16p5kb_cust_mux_macro__mux_aope__ports_2__stack_66c__width_66 wrdata_reg_hi_1_mux     (
    .din0({agd_asi_bist_wrdata[32:0],agd_asi_bist_wrdata[32:0]}),
    .din1(cmu_ic_data[197:132]),
    .sel0(ftp_asi_mbist_access_bf),
    .dout(wrdata_in[197:132])
);

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 wrdata_q0_4  (
     .scan_in(wrdata_q0_4_scanin[32:0]),
     .scan_out(wrdata_q0_4_scanout[32:0]),
    .l1clk(l1clk_wr),
    .din(wrdata_in[164:132]),
    .dout(wrdata_f[164:132]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 wrdata_q1_5  (
     .scan_in(wrdata_q1_5_scanin[32:0]),
     .scan_out(wrdata_q1_5_scanout[32:0]),
    .l1clk(l1clk_wr),
    .din(wrdata_in[197:165]),
    .dout(wrdata_f[197:165]),
  .siclk(siclk),
  .soclk(soclk)
    );

n2_icd_sp_16p5kb_cust_mux_macro__mux_aope__ports_2__stack_66c__width_66 wrdata_reg_hi_2_mux     (
    .din0({agd_asi_bist_wrdata[32:0],agd_asi_bist_wrdata[32:0]}),
    .din1(cmu_ic_data[263:198]),
    .sel0(ftp_asi_mbist_access_bf),
    .dout(wrdata_in[263:198])
);


   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 wrdata_q2_6  (
     .scan_in(wrdata_q2_6_scanin[32:0]),
     .scan_out(wrdata_q2_6_scanout[32:0]),
    .l1clk(l1clk_wr),
    .din(wrdata_in[230:198]),
    .dout(wrdata_f[230:198]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 wrdata_q3_7  (
     .scan_in(wrdata_q3_7_scanin[32:0]),
     .scan_out(wrdata_q3_7_scanout[32:0]),
    .l1clk(l1clk_wr),
    .din(wrdata_in[263:231]),
    .dout(wrdata_f[263:231]),
  .siclk(siclk),
  .soclk(soclk)
    );



  n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_5  red_d_reg  (
     .scan_in(red_d_reg_scanin[4:0]),
     .scan_out(red_d_reg_scanout[4:0]),
    .l1clk(l1clk_red_in),
    .din(red_d_in[4:0]),
    .dout(red_d_ff[4:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

  n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_2  red_en_reg  (
     .scan_in(red_en_reg_scanin[1:0]),
     .scan_out(red_en_reg_scanout[1:0]),
    .l1clk(l1clk_red_in),
    .din(red_en_in[1:0]),
    .dout(red_en_ff[1:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

  n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_4  rid_reg  (
     .scan_in(rid_reg_scanin[3:0]),
     .scan_out(rid_reg_scanout[3:0]),
    .l1clk(l1clk_red_in),
    .din(rid_in[3:0]),
    .dout(rid_ff[3:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

  n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_1  red_wen_reg  (
     .scan_in(red_wen_reg_scanin[0:0]),
     .scan_out(red_wen_reg_scanout[0:0]),
    .l1clk(l1clk_red_in),
    .din(red_wen),
    .dout(red_wen_ff_and),
  .siclk(siclk),
  .soclk(soclk)
    );

n2_icd_sp_16p5kb_cust_and_macro__ports_2__width_1 red_wen_wrinhib_and_gate      (
    .din0(red_wen_ff_and),
    .din1(wr_inhibit_in_l),
    .dout(red_wen_ff)
);

  n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_1  red_arst_reg  (
     .scan_in(red_arst_reg_scanin[0:0]),
     .scan_out(red_arst_reg_scanout[0:0]),
    .l1clk(l1clk_red_in),
    .din(red_arst),
    .dout(red_arst_ff_and),
  .siclk(siclk),
  .soclk(soclk)
    );

n2_icd_sp_16p5kb_cust_and_macro__ports_2__width_1 red_arst_wrinhib_and_gate     (
    .din0(red_arst_ff_and),
    .din1(wr_inhibit_in_l),
    .dout(red_arst_ff)
);



////////////////////////////////////////////////////
// C-stage flops and muxes on the input side      //
////////////////////////////////////////////////////

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_8 way_f_reg  (
     .scan_in(way_f_reg_scanin[7:0]),
     .scan_out(way_f_reg_scanout[7:0]),
    .l1clk(l1clk_int),
    .din(wrway_dec_bf[7:0]),
    .dout(wrway_dec_f[7:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_8 way_c_reg  (
     .scan_in(way_c_reg_scanin[7:0]),
     .scan_out(way_c_reg_scanout[7:0]),
    .l1clk(l1clk_out),
    .din(wrway_dec_f[7:0]),
    .dout(wrway_dec_c[7:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_1 ftp_access_c_reg  (
     .scan_in(ftp_access_c_reg_scanin[0:0]),
     .scan_out(ftp_access_c_reg_scanout[0:0]),
    .l1clk(l1clk_out),
    .din(asi_access_f),
    .dout(asi_access_c),
  .siclk(siclk),
  .soclk(soclk)
    );

n2_icd_sp_16p5kb_cust_msffi_ctl_macro__width_1 ftp_access_c_dum          (
  .scan_in(ftp_access_c_dum_scanin),
  .scan_out(ftp_access_c_dum_scanout),
  .l1clk ( l1clk_out             ),
  .din ( asi_access_f           ),
  .q_l ( asi_access_c_l             ),
  .siclk(siclk),
  .soclk(soclk));

n2_icd_sp_16p5kb_cust_inv_macro__width_1 asi_access_c_l_invt   (
    .din(asi_access_c_l),
    .dout(asi_access_c_l_inv)
);

n2_icd_sp_16p5kb_cust_inv_macro__width_1 asi_access_c_invt   (
    .din(asi_access_c),
    .dout(asi_access_c_inv)
);


n2_icd_sp_16p5kb_cust_mux_macro__mux_aonpe__ports_2__stack_50c__width_8 way_sel_mux  (
 .din1(wrway_dec_c[7:0]),
 .din0(itb_icd_waysel_c[7:0]),
 .sel0 ( asi_access_c_inv),
 .sel1 ( asi_access_c_l_inv),
 .dout( muxed_way_sel_c[7:0] ));





//////////////////////////////////////////////////////////////////////////////////////////////
//   assign i4_i0_sel_upper = ~(index_f[4:2] == 3'b000) ;
//   assign i5_i1_sel_upper = ~( ~index_f[4] & ~index_f[3] ); 
//   assign i6_i2_sel_upper = ~((~index_f[4] & ~index_f[3]) | (~index_f[4] & ~index_f[2]));
//   assign i7_i3_sel_upper =     index_f[4] ;
//////////////////////////////////////////////////////////////////////////////////////////////
n2_icd_sp_16p5kb_cust_or_macro__ports_3__stack_50c__width_1 i4_i0_sel_upper_or     (
    .din0(index_f[4]),
    .din1(index_f[3]),
    .din2(index_f[2]),
    .dout(i4_i0_sel_upper)
);

n2_icd_sp_16p5kb_cust_inv_macro__stack_50c__width_1 i4_i0_sel_upper_gate_l    (
    .din(i4_i0_sel_upper),
    .dout(i4_i0_sel_upper_)
);

n2_icd_sp_16p5kb_cust_or_macro__ports_2__stack_50c__width_1 i5_i1_sel_upper_or     (
    .din0(index_f[4]),
    .din1(index_f[3]),
    .dout(i5_i1_sel_upper)
);

n2_icd_sp_16p5kb_cust_inv_macro__stack_50c__width_1 i5_i1_sel_upper_gate_l    (
    .din(i5_i1_sel_upper),
    .dout(i5_i1_sel_upper_)
);

n2_icd_sp_16p5kb_cust_or_macro__ports_2__stack_50c__width_1 i6_i2_sel_upper_or_2_gate     (
    .din0(index_f[4]),
    .din1(index_f[2]),
    .dout(i6_i2_sel_upper_or_2)
);

n2_icd_sp_16p5kb_cust_and_macro__ports_2__stack_50c__width_1 i6_i2_sel_upper_and_gate     (
    .din0(i6_i2_sel_upper_or_2),
    .din1(i5_i1_sel_upper),
    .dout(i6_i2_sel_upper)
);

n2_icd_sp_16p5kb_cust_inv_macro__stack_50c__width_1 i6_i2_sel_upper_gate_l    (
    .din(i6_i2_sel_upper),
    .dout(i6_i2_sel_upper_)
);

n2_icd_sp_16p5kb_cust_buff_macro__stack_50c__width_1 i7_i3_sel_upper_gate    (
    .din(index_f[4]),
    .dout(i7_i3_sel_upper)
);

n2_icd_sp_16p5kb_cust_inv_macro__stack_50c__width_1 i7_i3_sel_upper_gate_l    (
    .din(i7_i3_sel_upper),
    .dout(i7_i3_sel_upper_)
);
//////////////////////////////////////////////////////////
// write_enable                                         //
//////////////////////////////////////////////////////////

// tisram_msff_macro	wr_inh_ff		(width=1) (
//   .scan_in(wr_inh_ff_scanin),
//   .scan_out(wr_inh_ff_scanout),
//   .l1clk ( l1clk_in				),
//   .d ( wr_inhibit_in_l					),
//   .latout_l( wr_inhibit_unused			),
//   .latout( wr_inhibit_l		));

n2_icd_sp_16p5kb_cust_nand_macro__ports_3__stack_50c__width_8 wr_word_en_nand     (
    .din0({8{wr_inhibit_in_l}}),
    .din1({8{wrreq_f}}),
    .din2(word_en_f[7:0]),
    .dout(wr_word_en_f_l[7:0])
);


//////////////////////////////////////////////////////////
// Disable reads when quad is not enabled
//////////////////////////////////////////////////////////
n2_icd_sp_16p5kb_cust_nand_macro__ports_4__stack_50c__width_1 rd_req_q_0_en        (
    .din0(icd_quad_0_en_f),
    .din1(rdreq_f),
    .din2(wrreq_f_l),
    .din3(wr_inhibit_in_l),
    .dout(rdreq_f_q0_l)
);

n2_icd_sp_16p5kb_cust_inv_macro rd_req_q_0_en_inv ( 
    .din  (rdreq_f_q0_l),
    .dout (rdreq_f_q0)) ; 

n2_icd_sp_16p5kb_cust_and_macro quad_0_en_qualify (
     .din0 (rdreq_f_q0)       ,
     .din1 (icd_quad_0_en_f)  ,
     .dout (icd_quad_0_en_f_qual)) ;


n2_icd_sp_16p5kb_cust_nand_macro__ports_4__stack_50c__width_1 rd_req_q_1_en        (
    .din0(icd_quad_1_en_f),
    .din1(rdreq_f),
    .din2(wrreq_f_l),
    .din3(wr_inhibit_in_l),
    .dout(rdreq_f_q1_l)
);

n2_icd_sp_16p5kb_cust_inv_macro rd_req_q_1_en_inv ( 
    .din  (rdreq_f_q1_l),
    .dout (rdreq_f_q1)) ; 

n2_icd_sp_16p5kb_cust_and_macro quad_1_en_qualify (
     .din0 (rdreq_f_q1)       ,
     .din1 (icd_quad_1_en_f)  ,
     .dout (icd_quad_1_en_f_qual)) ;


n2_icd_sp_16p5kb_cust_nand_macro__ports_4__stack_50c__width_1 rd_req_q_2_en        (
    .din0(icd_quad_2_en_f),
    .din1(rdreq_f),
    .din2(wrreq_f_l),
    .din3(wr_inhibit_in_l),
    .dout(rdreq_f_q2_l)
);

n2_icd_sp_16p5kb_cust_inv_macro rd_req_q_2_en_inv ( 
    .din  (rdreq_f_q2_l),
    .dout (rdreq_f_q2)) ; 

n2_icd_sp_16p5kb_cust_and_macro quad_2_en_qualify (
     .din0 (rdreq_f_q2)       ,
     .din1 (icd_quad_2_en_f)  ,
     .dout (icd_quad_2_en_f_qual)) ;


n2_icd_sp_16p5kb_cust_nand_macro__ports_4__stack_50c__width_1 rd_req_q_3_en        (
    .din0(icd_quad_3_en_f),
    .din1(rdreq_f),
    .din2(wrreq_f_l),
    .din3(wr_inhibit_in_l),
    .dout(rdreq_f_q3_l)
);


n2_icd_sp_16p5kb_cust_inv_macro rd_req_q_3_en_inv ( 
    .din  (rdreq_f_q3_l),
    .dout (rdreq_f_q3)) ; 

n2_icd_sp_16p5kb_cust_and_macro quad_3_en_qualify (
     .din0 (rdreq_f_q3)       ,
     .din1 (icd_quad_3_en_f)  ,
     .dout (icd_quad_3_en_f_qual)) ;


//////////////////////////////////////////////////////////
// 4:8 decode                                           //
//////////////////////////////////////////////////////////
n2_icd_sp_16p5kb_cust_mux_macro__mux_aodec__ports_8__width_8 wr_way_decode    (
        .din0   (8'b00000001),
        .din1   (8'b00000010),
        .din2   (8'b00000100),
        .din3   (8'b00001000),
        .din4   (8'b00010000),
        .din5   (8'b00100000),
        .din6   (8'b01000000),
        .din7   (8'b10000000),
        .sel    (wrway_f[2:0]), // This changed
        .dout   (wrway_dec_bf[7:0])
);

n2_icd_sp_16p5kb_cust_mux_macro__mux_aodec__ports_8__width_8 wr_way_decode_l    (
        .din0   (8'b11111110),
        .din1   (8'b11111101),
        .din2   (8'b11111011),
        .din3   (8'b11110111),
        .din4   (8'b11101111),
        .din5   (8'b11011111),
        .din6   (8'b10111111),
        .din7   (8'b01111111),
        .sel    (wrway_f[2:0]),
        .dout   (wrway_dec_f_[7:0])
);

//////////////////////////////////////////////////////////
n2_icd_sp_16p5kb_cust_mux_macro__mux_aodec__ports_8__width_8 rid_sel_mux0    (
        .din0   (8'b00000001),
        .din1   (8'b00000010),
        .din2   (8'b00000100),
        .din3   (8'b00001000),
        .din4   (8'b00010000),
        .din5   (8'b00100000),
        .din6   (8'b01000000),
        .din7   (8'b10000000),
        .sel    (rid_ff[2:0]),
        .dout   (rid_sel_dec[7:0])
);

n2_icd_sp_16p5kb_cust_mux_macro__mux_aope__ports_2__width_16 rid_sel_mux1    (
        .din0   ({rid_sel_dec[7:0],8'b00000000}),
        .din1   ({8'b00000000,rid_sel_dec[7:0]}),
        .sel0    (rid_ff[3]),
        .dout   (rid_sel[15:0])
);


/////////////////////////////////////////////////////////////////
// Instantiate each way ARRAY.                                 //
/////////////////////////////////////////////////////////////////
// The Icache is divided in four quads.                        //
// Each quad    is made of two Banks.                          //
// Each quad    has two words for all the 8 ways.              //
// ----------------------------------------------------------- //
// quad_0 has I0/I4 for ways 7 to 0                            //
// quad-1 has I1/I5 for ways 7 to 0                            //
// quad-2 has I2/I6 for ways 7 to 0                            //
// quad-3 has I3/I7 for ways 7 to 0                            //
// ----------------------------------------------------------- //
// Inside quad-0 top bank has ways 3 to 0                      //
// Inside quad-0 bottom bank has ways 7 to 4                   //
// ----------------------------------------------------------- //
// Other quads   are arranged similarly.                       //
///////////////////////////////////////////////////////////////// 

///////////////////////////////////////////////////////////////// 
///////////////////////////////////////////////////////////////// 
// quad-0                                                      //
///////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////
// quad-0                                   //
/////////////////////////////////////////////
n2_icd_quad_array        quad_0 	      (.adr_ac_h(index_f[10:5]),
                                               .adr_ac_l(index_f_l[10:5]),
                                               .rd_en_a_l(rdreq_f_q0_l),
                                               .quaden_f_l(icd_quad_0_en_f_lat_l),
                                               .wr_word_en_ac_l({wr_word_en_f_l[4],wr_word_en_f_l[0]}),
                                               .wr_waysel0_ac_l(wrway_dec_f_[7:0]),
                                               .wr_waysel1_ac_l(wrway_dec_f_[7:0]),
                                               .din0_a(wrdata_f[32:0]),
                                               .din1_a(wrdata_f[164:132]),
                                               .dout_wy0_bc(rd_data_w0_i4_or_i0[32:0]),
                                               .dout_wy1_bc(rd_data_w1_i4_or_i0[32:0]),
                                               .dout_wy2_bc(rd_data_w2_i4_or_i0[32:0]),
                                               .dout_wy3_bc(rd_data_w3_i4_or_i0[32:0]),
                                               .dout_wy4_bc(rd_data_w4_i4_or_i0[32:0]),
                                               .dout_wy5_bc(rd_data_w5_i4_or_i0[32:0]),
                                               .dout_wy6_bc(rd_data_w6_i4_or_i0[32:0]),
                                               .dout_wy7_bc(rd_data_w7_i4_or_i0[32:0]),
						.reg_d_lft_top(reg_d_q0_w3_w0_lft_d[4:0]) ,
						.reg_en_lft_top(reg_d_q0_w3_w0_lft_en[1:0]) ,
						.reg_d_rgt_top(reg_d_q0_w3_w0_rgt_d[4:0]) ,
						.reg_en_rgt_top(reg_d_q0_w3_w0_rgt_en[1:0]) ,
						.reg_d_lft_bot(reg_d_q0_w7_w4_lft_d[4:0]) ,
						.reg_en_lft_bot(reg_d_q0_w7_w4_lft_en[1:0]) ,
						.reg_d_rgt_bot(reg_d_q0_w7_w4_rgt_d[4:0]) ,
						.reg_en_rgt_bot(reg_d_q0_w7_w4_rgt_en[1:0]) ,
                                               .red_d_ff(red_d_ff[4:0]),
                                               .red_en_ff(red_en_ff[1:0]),
                                               .rid_sel(rid_sel[3:0]) ,
   					       .red_wen_ff(red_wen_ff) ,
   					       .red_arst_ff(red_arst_ff), 
                                               .rd_worden_ac_l({i4_i0_sel_upper_,i4_i0_sel_upper}),
                                               .l1clk_fuse(l1clk_fuse_clk1),
                                               .l1clk(l1clk_free),
  .vnw_ary(vnw_ary)
                                               );


///////////////////////////////////////////////////////////////// 
///////////////////////////////////////////////////////////////// 
// quad-1                                                      //
///////////////////////////////////////////////////////////////// 
n2_icd_quad_array        quad_1 	      (.adr_ac_h(index_f[10:5]),
                                               .adr_ac_l(index_f_l[10:5]),
                                               .rd_en_a_l(rdreq_f_q1_l),
                                               .quaden_f_l(icd_quad_1_en_f_lat_l),
                                               .wr_word_en_ac_l({wr_word_en_f_l[5],wr_word_en_f_l[1]}),
                                               .wr_waysel0_ac_l(wrway_dec_f_[7:0]),
                                               .wr_waysel1_ac_l(wrway_dec_f_[7:0]),
                                               .din0_a(wrdata_f[65:33]),
                                               .din1_a(wrdata_f[197:165]),
                                               .dout_wy0_bc(rd_data_w0_i5_or_i1[32:0]),
                                               .dout_wy1_bc(rd_data_w1_i5_or_i1[32:0]),
                                               .dout_wy2_bc(rd_data_w2_i5_or_i1[32:0]),
                                               .dout_wy3_bc(rd_data_w3_i5_or_i1[32:0]),
                                               .dout_wy4_bc(rd_data_w4_i5_or_i1[32:0]),
                                               .dout_wy5_bc(rd_data_w5_i5_or_i1[32:0]),
                                               .dout_wy6_bc(rd_data_w6_i5_or_i1[32:0]),
                                               .dout_wy7_bc(rd_data_w7_i5_or_i1[32:0]),
						.reg_d_lft_top(reg_d_q1_w3_w0_lft_d[4:0]) ,
						.reg_en_lft_top(reg_d_q1_w3_w0_lft_en[1:0]) ,
						.reg_d_rgt_top(reg_d_q1_w3_w0_rgt_d[4:0]) ,
						.reg_en_rgt_top(reg_d_q1_w3_w0_rgt_en[1:0]) ,
						.reg_d_lft_bot(reg_d_q1_w7_w4_lft_d[4:0]) ,
						.reg_en_lft_bot(reg_d_q1_w7_w4_lft_en[1:0]) ,
						.reg_d_rgt_bot(reg_d_q1_w7_w4_rgt_d[4:0]) ,
						.reg_en_rgt_bot(reg_d_q1_w7_w4_rgt_en[1:0]) ,
                                               .red_d_ff(red_d_ff[4:0]),
                                               .red_en_ff(red_en_ff[1:0]),
                                               .rid_sel(rid_sel[7:4]) ,
   					       .red_wen_ff(red_wen_ff) ,
   					       .red_arst_ff(red_arst_ff), 
                                               .rd_worden_ac_l({i5_i1_sel_upper_,i5_i1_sel_upper}),
                                               .l1clk_fuse(l1clk_fuse_clk1),
                                               .l1clk(l1clk_free),
  .vnw_ary(vnw_ary)
                                               );


///////////////////////////////////////////////////////////////// 
///////////////////////////////////////////////////////////////// 
// quad-2                                                      //
///////////////////////////////////////////////////////////////// 
n2_icd_quad_array        quad_2 	      (.adr_ac_h(index_f[10:5]),
                                               .adr_ac_l(index_f_l[10:5]),
                                               .rd_en_a_l(rdreq_f_q2_l),
                                               .quaden_f_l(icd_quad_2_en_f_lat_l),
                                               .wr_word_en_ac_l({wr_word_en_f_l[6],wr_word_en_f_l[2]}),
                                               .wr_waysel0_ac_l(wrway_dec_f_[7:0]),
                                               .wr_waysel1_ac_l(wrway_dec_f_[7:0]),
                                               .din0_a(wrdata_f[98:66]),
                                               .din1_a(wrdata_f[230:198]),
                                               .dout_wy0_bc(rd_data_w0_i6_or_i2[32:0]),
                                               .dout_wy1_bc(rd_data_w1_i6_or_i2[32:0]),
                                               .dout_wy2_bc(rd_data_w2_i6_or_i2[32:0]),
                                               .dout_wy3_bc(rd_data_w3_i6_or_i2[32:0]),
                                               .dout_wy4_bc(rd_data_w4_i6_or_i2[32:0]),
                                               .dout_wy5_bc(rd_data_w5_i6_or_i2[32:0]),
                                               .dout_wy6_bc(rd_data_w6_i6_or_i2[32:0]),
                                               .dout_wy7_bc(rd_data_w7_i6_or_i2[32:0]),
						.reg_d_lft_top(reg_d_q2_w3_w0_lft_d[4:0]) ,
						.reg_en_lft_top(reg_d_q2_w3_w0_lft_en[1:0]) ,
						.reg_d_rgt_top(reg_d_q2_w3_w0_rgt_d[4:0]) ,
						.reg_en_rgt_top(reg_d_q2_w3_w0_rgt_en[1:0]) ,
						.reg_d_lft_bot(reg_d_q2_w7_w4_lft_d[4:0]) ,
						.reg_en_lft_bot(reg_d_q2_w7_w4_lft_en[1:0]) ,
						.reg_d_rgt_bot(reg_d_q2_w7_w4_rgt_d[4:0]) ,
						.reg_en_rgt_bot(reg_d_q2_w7_w4_rgt_en[1:0]) ,
                                               .red_d_ff(red_d_ff[4:0]),
                                               .red_en_ff(red_en_ff[1:0]),
                                               .rid_sel(rid_sel[11:8]) ,
   					       .red_wen_ff(red_wen_ff) ,
   					       .red_arst_ff(red_arst_ff), 
                                               .rd_worden_ac_l({i6_i2_sel_upper_,i6_i2_sel_upper}),
                                               .l1clk_fuse(l1clk_fuse_clk1),
                                               .l1clk(l1clk_free),
  .vnw_ary(vnw_ary)
                                               );




///////////////////////////////////////////////////////////////// 
///////////////////////////////////////////////////////////////// 
// quad-3                                                      //
///////////////////////////////////////////////////////////////// 
n2_icd_quad_array        quad_3 	      (.adr_ac_h(index_f[10:5]),
                                               .adr_ac_l(index_f_l[10:5]),
                                               .rd_en_a_l(rdreq_f_q3_l),
                                               .quaden_f_l(icd_quad_3_en_f_lat_l),
                                               .wr_word_en_ac_l({wr_word_en_f_l[7],wr_word_en_f_l[3]}),
                                               .wr_waysel0_ac_l(wrway_dec_f_[7:0]),
                                               .wr_waysel1_ac_l(wrway_dec_f_[7:0]),
                                               .din0_a(wrdata_f[131:99]),
                                               .din1_a(wrdata_f[263:231]),
                                               .dout_wy0_bc(rd_data_w0_i7_or_i3[32:0]),
                                               .dout_wy1_bc(rd_data_w1_i7_or_i3[32:0]),
                                               .dout_wy2_bc(rd_data_w2_i7_or_i3[32:0]),
                                               .dout_wy3_bc(rd_data_w3_i7_or_i3[32:0]),
                                               .dout_wy4_bc(rd_data_w4_i7_or_i3[32:0]),
                                               .dout_wy5_bc(rd_data_w5_i7_or_i3[32:0]),
                                               .dout_wy6_bc(rd_data_w6_i7_or_i3[32:0]),
                                               .dout_wy7_bc(rd_data_w7_i7_or_i3[32:0]),
						.reg_d_lft_top(reg_d_q3_w3_w0_lft_d[4:0]) ,
						.reg_en_lft_top(reg_d_q3_w3_w0_lft_en[1:0]) ,
						.reg_d_rgt_top(reg_d_q3_w3_w0_rgt_d[4:0]) ,
						.reg_en_rgt_top(reg_d_q3_w3_w0_rgt_en[1:0]) ,
						.reg_d_lft_bot(reg_d_q3_w7_w4_lft_d[4:0]) ,
						.reg_en_lft_bot(reg_d_q3_w7_w4_lft_en[1:0]) ,
						.reg_d_rgt_bot(reg_d_q3_w7_w4_rgt_d[4:0]) ,
						.reg_en_rgt_bot(reg_d_q3_w7_w4_rgt_en[1:0]) ,
                                               .red_d_ff(red_d_ff[4:0]),
                                               .red_en_ff(red_en_ff[1:0]),
                                               .rid_sel(rid_sel[15:12]) ,
   					       .red_wen_ff(red_wen_ff) ,
   					       .red_arst_ff(red_arst_ff), 
                                               .rd_worden_ac_l({i7_i3_sel_upper_,i7_i3_sel_upper}),
                                               .l1clk_fuse(l1clk_fuse_clk1),
                                               .l1clk(l1clk_free),
  .vnw_ary(vnw_ary)
                                               );




//////////////////////////////////////////////////////////////////////////
// Mux the instructions in each way to four buses                       //
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
// Flop all the way outputs.                                            //
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////
// way 0 flops                                  //
//////////////////////////////////////////////////
   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_0_w0_reg  (
     .scan_in(data_bus_0_w0_reg_scanin[32:0]),
     .scan_out(data_bus_0_w0_reg_scanout[32:0]),
    .l1clk(l1clk_q0_out),
    .din(rd_data_w0_i4_or_i0[32:0]),
    .dout(data_bus_0_w0_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_1_w0_reg  (
     .scan_in(data_bus_1_w0_reg_scanin[32:0]),
     .scan_out(data_bus_1_w0_reg_scanout[32:0]),
    .l1clk(l1clk_q1_out),
    .din(rd_data_w0_i5_or_i1[32:0]),
    .dout(data_bus_1_w0_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );


   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_2_w0_reg  (
     .scan_in(data_bus_2_w0_reg_scanin[32:0]),
     .scan_out(data_bus_2_w0_reg_scanout[32:0]),
    .l1clk(l1clk_q2_out),
    .din(rd_data_w0_i6_or_i2[32:0]),
    .dout(data_bus_2_w0_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_3_w0_reg  (
     .scan_in(data_bus_3_w0_reg_scanin[32:0]),
     .scan_out(data_bus_3_w0_reg_scanout[32:0]),
    .l1clk(l1clk_q3_out),
    .din(rd_data_w0_i7_or_i3[32:0]),
    .dout(data_bus_3_w0_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );
//////////////////////////////////////////////////
// way 1 flops                                  //
//////////////////////////////////////////////////
   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_0_w1_reg  (
     .scan_in(data_bus_0_w1_reg_scanin[32:0]),
     .scan_out(data_bus_0_w1_reg_scanout[32:0]),
    .l1clk(l1clk_q0_out),
    .din(rd_data_w1_i4_or_i0[32:0]),
    .dout(data_bus_0_w1_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_1_w1_reg  (
     .scan_in(data_bus_1_w1_reg_scanin[32:0]),
     .scan_out(data_bus_1_w1_reg_scanout[32:0]),
    .l1clk(l1clk_q1_out),
    .din(rd_data_w1_i5_or_i1[32:0]),
    .dout(data_bus_1_w1_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );


   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_2_w1_reg  (
     .scan_in(data_bus_2_w1_reg_scanin[32:0]),
     .scan_out(data_bus_2_w1_reg_scanout[32:0]),
    .l1clk(l1clk_q2_out),
    .din(rd_data_w1_i6_or_i2[32:0]),
    .dout(data_bus_2_w1_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_3_w1_reg  (
     .scan_in(data_bus_3_w1_reg_scanin[32:0]),
     .scan_out(data_bus_3_w1_reg_scanout[32:0]),
    .l1clk(l1clk_q3_out),
    .din(rd_data_w1_i7_or_i3[32:0]),
    .dout(data_bus_3_w1_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );
//////////////////////////////////////////////////
// way 2 flops                                  //
//////////////////////////////////////////////////
   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_0_w2_reg  (
     .scan_in(data_bus_0_w2_reg_scanin[32:0]),
     .scan_out(data_bus_0_w2_reg_scanout[32:0]),
    .l1clk(l1clk_q0_out),
    .din(rd_data_w2_i4_or_i0[32:0]),
    .dout(data_bus_0_w2_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_1_w2_reg  (
     .scan_in(data_bus_1_w2_reg_scanin[32:0]),
     .scan_out(data_bus_1_w2_reg_scanout[32:0]),
    .l1clk(l1clk_q1_out),
    .din(rd_data_w2_i5_or_i1[32:0]),
    .dout(data_bus_1_w2_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_2_w2_reg  (
     .scan_in(data_bus_2_w2_reg_scanin[32:0]),
     .scan_out(data_bus_2_w2_reg_scanout[32:0]),
    .l1clk(l1clk_q2_out),
    .din(rd_data_w2_i6_or_i2[32:0]),
    .dout(data_bus_2_w2_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_3_w2_reg  (
     .scan_in(data_bus_3_w2_reg_scanin[32:0]),
     .scan_out(data_bus_3_w2_reg_scanout[32:0]),
    .l1clk(l1clk_q3_out),
    .din(rd_data_w2_i7_or_i3[32:0]),
    .dout(data_bus_3_w2_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );
//////////////////////////////////////////////////
// way 3 flops                                  //
//////////////////////////////////////////////////
   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_0_w3_reg  (
     .scan_in(data_bus_0_w3_reg_scanin[32:0]),
     .scan_out(data_bus_0_w3_reg_scanout[32:0]),
    .l1clk(l1clk_q0_out),
    .din(rd_data_w3_i4_or_i0[32:0]),
    .dout(data_bus_0_w3_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_1_w3_reg  (
     .scan_in(data_bus_1_w3_reg_scanin[32:0]),
     .scan_out(data_bus_1_w3_reg_scanout[32:0]),
   .l1clk(l1clk_q1_out),
    .din(rd_data_w3_i5_or_i1[32:0]),
    .dout(data_bus_1_w3_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_2_w3_reg  (
     .scan_in(data_bus_2_w3_reg_scanin[32:0]),
     .scan_out(data_bus_2_w3_reg_scanout[32:0]),
    .l1clk(l1clk_q2_out),
    .din(rd_data_w3_i6_or_i2[32:0]),
    .dout(data_bus_2_w3_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_3_w3_reg  (
     .scan_in(data_bus_3_w3_reg_scanin[32:0]),
     .scan_out(data_bus_3_w3_reg_scanout[32:0]),
    .l1clk(l1clk_q3_out),
    .din(rd_data_w3_i7_or_i3[32:0]),
    .dout(data_bus_3_w3_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );
//////////////////////////////////////////////////
// way 4 flops                                  //
//////////////////////////////////////////////////
   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_0_w4_reg  (
     .scan_in(data_bus_0_w4_reg_scanin[32:0]),
     .scan_out(data_bus_0_w4_reg_scanout[32:0]),
    .l1clk(l1clk_q0_out),
    .din(rd_data_w4_i4_or_i0[32:0]),
    .dout(data_bus_0_w4_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_1_w4_reg  (
     .scan_in(data_bus_1_w4_reg_scanin[32:0]),
     .scan_out(data_bus_1_w4_reg_scanout[32:0]),
    .l1clk(l1clk_q1_out),
    .din(rd_data_w4_i5_or_i1[32:0]),
    .dout(data_bus_1_w4_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_2_w4_reg  (
     .scan_in(data_bus_2_w4_reg_scanin[32:0]),
     .scan_out(data_bus_2_w4_reg_scanout[32:0]),
    .l1clk(l1clk_q2_out),
    .din(rd_data_w4_i6_or_i2[32:0]),
    .dout(data_bus_2_w4_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_3_w4_reg  (
     .scan_in(data_bus_3_w4_reg_scanin[32:0]),
     .scan_out(data_bus_3_w4_reg_scanout[32:0]),
    .l1clk(l1clk_q3_out),
    .din(rd_data_w4_i7_or_i3[32:0]),
    .dout(data_bus_3_w4_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );
//////////////////////////////////////////////////
// way 5 flops                                  //
//////////////////////////////////////////////////
   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_0_w5_reg  (
     .scan_in(data_bus_0_w5_reg_scanin[32:0]),
     .scan_out(data_bus_0_w5_reg_scanout[32:0]),
    .l1clk(l1clk_q0_out),
    .din(rd_data_w5_i4_or_i0[32:0]),
    .dout(data_bus_0_w5_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_1_w5_reg  (
     .scan_in(data_bus_1_w5_reg_scanin[32:0]),
     .scan_out(data_bus_1_w5_reg_scanout[32:0]),
    .l1clk(l1clk_q1_out),
    .din(rd_data_w5_i5_or_i1[32:0]),
    .dout(data_bus_1_w5_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_2_w5_reg  (
     .scan_in(data_bus_2_w5_reg_scanin[32:0]),
     .scan_out(data_bus_2_w5_reg_scanout[32:0]),
    .l1clk(l1clk_q2_out),
    .din(rd_data_w5_i6_or_i2[32:0]),
    .dout(data_bus_2_w5_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_3_w5_reg  (
     .scan_in(data_bus_3_w5_reg_scanin[32:0]),
     .scan_out(data_bus_3_w5_reg_scanout[32:0]),
    .l1clk(l1clk_q3_out),
    .din(rd_data_w5_i7_or_i3[32:0]),
    .dout(data_bus_3_w5_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );
//////////////////////////////////////////////////
// way 6 flops                                  //
//////////////////////////////////////////////////
   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_0_w6_reg  (
     .scan_in(data_bus_0_w6_reg_scanin[32:0]),
     .scan_out(data_bus_0_w6_reg_scanout[32:0]),
    .l1clk(l1clk_q0_out),
    .din(rd_data_w6_i4_or_i0[32:0]),
    .dout(data_bus_0_w6_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_1_w6_reg  (
     .scan_in(data_bus_1_w6_reg_scanin[32:0]),
     .scan_out(data_bus_1_w6_reg_scanout[32:0]),
    .l1clk(l1clk_q1_out),
    .din(rd_data_w6_i5_or_i1[32:0]),
    .dout(data_bus_1_w6_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_2_w6_reg  (
     .scan_in(data_bus_2_w6_reg_scanin[32:0]),
     .scan_out(data_bus_2_w6_reg_scanout[32:0]),
    .l1clk(l1clk_q2_out),
    .din(rd_data_w6_i6_or_i2[32:0]),
    .dout(data_bus_2_w6_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_3_w6_reg  (
     .scan_in(data_bus_3_w6_reg_scanin[32:0]),
     .scan_out(data_bus_3_w6_reg_scanout[32:0]),
    .l1clk(l1clk_q3_out),
    .din(rd_data_w6_i7_or_i3[32:0]),
    .dout(data_bus_3_w6_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );
//////////////////////////////////////////////////
// way 7 flops                                  //
//////////////////////////////////////////////////
   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_0_w7_reg  (
     .scan_in(data_bus_0_w7_reg_scanin[32:0]),
     .scan_out(data_bus_0_w7_reg_scanout[32:0]),
    .l1clk(l1clk_q0_out),
    .din(rd_data_w7_i4_or_i0[32:0]),
    .dout(data_bus_0_w7_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_1_w7_reg  (
     .scan_in(data_bus_1_w7_reg_scanin[32:0]),
     .scan_out(data_bus_1_w7_reg_scanout[32:0]),
    .l1clk(l1clk_q1_out),
    .din(rd_data_w7_i5_or_i1[32:0]),
    .dout(data_bus_1_w7_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_2_w7_reg  (
     .scan_in(data_bus_2_w7_reg_scanin[32:0]),
     .scan_out(data_bus_2_w7_reg_scanout[32:0]),
    .l1clk(l1clk_q2_out),
    .din(rd_data_w7_i6_or_i2[32:0]),
    .dout(data_bus_2_w7_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );

   n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 data_bus_3_w7_reg  (
     .scan_in(data_bus_3_w7_reg_scanin[32:0]),
     .scan_out(data_bus_3_w7_reg_scanout[32:0]),
    .l1clk(l1clk_q3_out),
    .din(rd_data_w7_i7_or_i3[32:0]),
    .dout(data_bus_3_w7_c[32:0]),
  .siclk(siclk),
  .soclk(soclk)
    );
//////////////////////////////////////////////////////////////////////////
// Muxing ALL ways to get instr 0,1,2,3  based on the way select from   //
// Icache tags and TLB.                                                 //
// NOTE: These instructions are unordered.                              //
//////////////////////////////////////////////////////////////////////////

 
n2_icd_sp_16p5kb_cust_mux_macro__mux_aonpe__ports_8__stack_50c__width_33 bus_0_mux  (
 .din0({data_bus_0_w0_c[32],data_bus_0_w0_c[31:0]}),
 .din1({data_bus_0_w1_c[32],data_bus_0_w1_c[31:0]}),
 .din2({data_bus_0_w2_c[32],data_bus_0_w2_c[31:0]}),
 .din3({data_bus_0_w3_c[32],data_bus_0_w3_c[31:0]}),
 .din4({data_bus_0_w4_c[32],data_bus_0_w4_c[31:0]}),
 .din5({data_bus_0_w5_c[32],data_bus_0_w5_c[31:0]}),
 .din6({data_bus_0_w6_c[32],data_bus_0_w6_c[31:0]}),
 .din7({data_bus_0_w7_c[32],data_bus_0_w7_c[31:0]} ),
 .sel0 ( muxed_way_sel_c[0]),
 .sel1 ( muxed_way_sel_c[1]),
 .sel2 ( muxed_way_sel_c[2]),
 .sel3 ( muxed_way_sel_c[3]),
 .sel4 ( muxed_way_sel_c[4]),
 .sel5 ( muxed_way_sel_c[5]),
 .sel6 ( muxed_way_sel_c[6]),
 .sel7 ( muxed_way_sel_c[7]),
 .dout( icd_bus_0_instr_c[32:0] ));

n2_icd_sp_16p5kb_cust_mux_macro__mux_aonpe__ports_8__stack_50c__width_33 bus_1_mux  (
 .din0({data_bus_1_w0_c[32],data_bus_1_w0_c[31:0]}),
 .din1({data_bus_1_w1_c[32],data_bus_1_w1_c[31:0]}),
 .din2({data_bus_1_w2_c[32],data_bus_1_w2_c[31:0]}),
 .din3({data_bus_1_w3_c[32],data_bus_1_w3_c[31:0]}),
 .din4({data_bus_1_w4_c[32],data_bus_1_w4_c[31:0]}),
 .din5({data_bus_1_w5_c[32],data_bus_1_w5_c[31:0]}),
 .din6({data_bus_1_w6_c[32],data_bus_1_w6_c[31:0]}),
 .din7({data_bus_1_w7_c[32],data_bus_1_w7_c[31:0]} ),
 .sel0 ( muxed_way_sel_c[0]),
 .sel1 ( muxed_way_sel_c[1]),
 .sel2 ( muxed_way_sel_c[2]),
 .sel3 ( muxed_way_sel_c[3]),
 .sel4 ( muxed_way_sel_c[4]),
 .sel5 ( muxed_way_sel_c[5]),
 .sel6 ( muxed_way_sel_c[6]),
 .sel7 ( muxed_way_sel_c[7]),
 .dout( icd_bus_1_instr_c[32:0] ));

n2_icd_sp_16p5kb_cust_mux_macro__mux_aonpe__ports_8__stack_50c__width_33 bus_2_mux  (
 .din0({data_bus_2_w0_c[32],data_bus_2_w0_c[31:0]}),
 .din1({data_bus_2_w1_c[32],data_bus_2_w1_c[31:0]}),
 .din2({data_bus_2_w2_c[32],data_bus_2_w2_c[31:0]}),
 .din3({data_bus_2_w3_c[32],data_bus_2_w3_c[31:0]}),
 .din4({data_bus_2_w4_c[32],data_bus_2_w4_c[31:0]}),
 .din5({data_bus_2_w5_c[32],data_bus_2_w5_c[31:0]}),
 .din6({data_bus_2_w6_c[32],data_bus_2_w6_c[31:0]}),
 .din7({data_bus_2_w7_c[32],data_bus_2_w7_c[31:0]} ),
 .sel0 ( muxed_way_sel_c[0]),
 .sel1 ( muxed_way_sel_c[1]),
 .sel2 ( muxed_way_sel_c[2]),
 .sel3 ( muxed_way_sel_c[3]),
 .sel4 ( muxed_way_sel_c[4]),
 .sel5 ( muxed_way_sel_c[5]),
 .sel6 ( muxed_way_sel_c[6]),
 .sel7 ( muxed_way_sel_c[7]),
 .dout( icd_bus_2_instr_c[32:0] ));

n2_icd_sp_16p5kb_cust_mux_macro__mux_aonpe__ports_8__stack_50c__width_33 bus_3_mux  (
 .din0({data_bus_3_w0_c[32],data_bus_3_w0_c[31:0]}),
 .din1({data_bus_3_w1_c[32],data_bus_3_w1_c[31:0]}),
 .din2({data_bus_3_w2_c[32],data_bus_3_w2_c[31:0]}),
 .din3({data_bus_3_w3_c[32],data_bus_3_w3_c[31:0]}),
 .din4({data_bus_3_w4_c[32],data_bus_3_w4_c[31:0]}),
 .din5({data_bus_3_w5_c[32],data_bus_3_w5_c[31:0]}),
 .din6({data_bus_3_w6_c[32],data_bus_3_w6_c[31:0]}),
 .din7({data_bus_3_w7_c[32],data_bus_3_w7_c[31:0]} ),
 .sel0 ( muxed_way_sel_c[0]),
 .sel1 ( muxed_way_sel_c[1]),
 .sel2 ( muxed_way_sel_c[2]),
 .sel3 ( muxed_way_sel_c[3]),
 .sel4 ( muxed_way_sel_c[4]),
 .sel5 ( muxed_way_sel_c[5]),
 .sel6 ( muxed_way_sel_c[6]),
 .sel7 ( muxed_way_sel_c[7]),
 .dout( icd_bus_3_instr_c[32:0] ));
////////////////////////////////////////////////////////////
// Redunduncy Data out muxing                             //
////////////////////////////////////////////////////////////

n2_icd_sp_16p5kb_cust_mux_macro__mux_aodec__ports_8__width_7 red_data_out_mux0    (
        .din0   ({reg_d_q0_w7_w4_lft_d[4:0],reg_d_q0_w7_w4_lft_en[1:0]}),
        .din1   ({reg_d_q0_w7_w4_rgt_d[4:0],reg_d_q0_w7_w4_rgt_en[1:0]}),
        .din2   ({reg_d_q0_w3_w0_lft_d[4:0],reg_d_q0_w3_w0_lft_en[1:0]}),
        .din3   ({reg_d_q0_w3_w0_rgt_d[4:0],reg_d_q0_w3_w0_rgt_en[1:0]}),
        .din4   ({reg_d_q1_w7_w4_lft_d[4:0],reg_d_q1_w7_w4_lft_en[1:0]}),
        .din5   ({reg_d_q1_w7_w4_rgt_d[4:0],reg_d_q1_w7_w4_rgt_en[1:0]}),
        .din6   ({reg_d_q1_w3_w0_lft_d[4:0],reg_d_q1_w3_w0_lft_en[1:0]}),
        .din7   ({reg_d_q1_w3_w0_rgt_d[4:0],reg_d_q1_w3_w0_rgt_en[1:0]}),
        .sel    (rid_ff[2:0]),
        .dout   ({reg_d_out_mux_0[4:0],reg_en_out_mux_0[1:0]})
);

n2_icd_sp_16p5kb_cust_mux_macro__mux_aodec__ports_8__width_7 red_data_out_mux1    (
        .din0   ({reg_d_q2_w7_w4_lft_d[4:0],reg_d_q2_w7_w4_lft_en[1:0]}),
        .din1   ({reg_d_q2_w7_w4_rgt_d[4:0],reg_d_q2_w7_w4_rgt_en[1:0]}),
        .din2   ({reg_d_q2_w3_w0_lft_d[4:0],reg_d_q2_w3_w0_lft_en[1:0]}),
        .din3   ({reg_d_q2_w3_w0_rgt_d[4:0],reg_d_q2_w3_w0_rgt_en[1:0]}),
        .din4   ({reg_d_q3_w7_w4_lft_d[4:0],reg_d_q3_w7_w4_lft_en[1:0]}),
        .din5   ({reg_d_q3_w7_w4_rgt_d[4:0],reg_d_q3_w7_w4_rgt_en[1:0]}),
        .din6   ({reg_d_q3_w3_w0_lft_d[4:0],reg_d_q3_w3_w0_lft_en[1:0]}),
        .din7   ({reg_d_q3_w3_w0_rgt_d[4:0],reg_d_q3_w3_w0_rgt_en[1:0]}),
        .sel    (rid_ff[2:0]),
        .dout   ({reg_d_out_mux_1[4:0],reg_en_out_mux_1[1:0]})
);

n2_icd_sp_16p5kb_cust_mux_macro__mux_aope__ports_2__width_7 red_data_out_mux2    (
        .din0   ({reg_d_out_mux_1[4:0],reg_en_out_mux_1[1:0]}),
        .din1   ({reg_d_out_mux_0[4:0],reg_en_out_mux_0[1:0]}),
        .sel0    (rid_ff[3]),
        .dout   ({red_mux_d_out[4:0],red_mux_en_out[1:0]})
);

n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_5 red_d_out_reg  (
     .scan_in(red_d_out_reg_scanin[4:0]),
     .scan_out(red_d_out_reg_scanout[4:0]),
    .l1clk(l1clk_red_out),
    .din(red_mux_d_out[4:0]),
    .dout(red_d_out[4:0]),
  .siclk(siclk),
  .soclk(soclk)
);


n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_2 red_en_out_reg   (
     .scan_in(red_en_out_reg_scanin[1:0]),
     .scan_out(red_en_out_reg_scanout[1:0]),
    .l1clk(l1clk_red_out),
    .din(red_mux_en_out[1:0]),
    .dout(red_en_out[1:0]),
  .siclk(siclk),
  .soclk(soclk)
);


supply0 vss;
supply1 vdd;

assign ftp_access_f_reg_scanin[0]=scan_in;
assign ftp_access_c_reg_scanin[0]=ftp_access_f_reg_scanout;
assign ftp_access_c_dum_scanin=ftp_access_c_reg_scanout[0];
assign wrdata_q1_5_scanin[32]=ftp_access_c_dum_scanout;
assign wrdata_q1_1_scanin[32]=wrdata_q1_5_scanout[32];
assign wrdata_q1_5_scanin[31]=wrdata_q1_1_scanout[32];
assign wrdata_q1_1_scanin[31]=wrdata_q1_5_scanout[31];
assign wrdata_q1_5_scanin[30]=wrdata_q1_1_scanout[31];
assign wrdata_q1_1_scanin[30]=wrdata_q1_5_scanout[30];
assign wrdata_q1_5_scanin[29]=wrdata_q1_1_scanout[30];
assign wrdata_q1_1_scanin[29]=wrdata_q1_5_scanout[29];
assign wrdata_q1_5_scanin[28]=wrdata_q1_1_scanout[29];
assign wrdata_q1_1_scanin[28]=wrdata_q1_5_scanout[28];
assign wrdata_q1_5_scanin[27]=wrdata_q1_1_scanout[28];
assign wrdata_q1_1_scanin[27]=wrdata_q1_5_scanout[27];
assign wrdata_q1_5_scanin[26]=wrdata_q1_1_scanout[27];
assign wrdata_q1_1_scanin[26]=wrdata_q1_5_scanout[26];
assign wrdata_q1_5_scanin[25]=wrdata_q1_1_scanout[26];
assign wrdata_q1_1_scanin[25]=wrdata_q1_5_scanout[25];
assign wrdata_q1_5_scanin[24]=wrdata_q1_1_scanout[25];
assign wrdata_q1_1_scanin[24]=wrdata_q1_5_scanout[24];
assign wrdata_q1_5_scanin[23]=wrdata_q1_1_scanout[24];
assign wrdata_q1_1_scanin[23]=wrdata_q1_5_scanout[23];
assign wrdata_q1_5_scanin[22]=wrdata_q1_1_scanout[23];
assign wrdata_q1_1_scanin[22]=wrdata_q1_5_scanout[22];
assign wrdata_q1_5_scanin[21]=wrdata_q1_1_scanout[22];
assign wrdata_q1_1_scanin[21]=wrdata_q1_5_scanout[21];
assign wrdata_q1_5_scanin[20]=wrdata_q1_1_scanout[21];
assign wrdata_q1_1_scanin[20]=wrdata_q1_5_scanout[20];
assign wrdata_q1_5_scanin[19]=wrdata_q1_1_scanout[20];
assign wrdata_q1_1_scanin[19]=wrdata_q1_5_scanout[19];
assign wrdata_q1_5_scanin[18]=wrdata_q1_1_scanout[19];
assign wrdata_q1_1_scanin[18]=wrdata_q1_5_scanout[18];
assign wrdata_q1_5_scanin[17]=wrdata_q1_1_scanout[18];
assign wrdata_q1_1_scanin[17]=wrdata_q1_5_scanout[17];
assign wrdata_q1_5_scanin[16]=wrdata_q1_1_scanout[17];
assign wrdata_q1_1_scanin[16]=wrdata_q1_5_scanout[16];
assign wrdata_q1_5_scanin[15]=wrdata_q1_1_scanout[16];
assign wrdata_q1_1_scanin[15]=wrdata_q1_5_scanout[15];
assign wrdata_q1_5_scanin[14]=wrdata_q1_1_scanout[15];
assign wrdata_q1_1_scanin[14]=wrdata_q1_5_scanout[14];
assign wrdata_q1_5_scanin[13]=wrdata_q1_1_scanout[14];
assign wrdata_q1_1_scanin[13]=wrdata_q1_5_scanout[13];
assign wrdata_q1_5_scanin[12]=wrdata_q1_1_scanout[13];
assign wrdata_q1_1_scanin[12]=wrdata_q1_5_scanout[12];
assign wrdata_q1_5_scanin[11]=wrdata_q1_1_scanout[12];
assign wrdata_q1_1_scanin[11]=wrdata_q1_5_scanout[11];
assign wrdata_q1_5_scanin[10]=wrdata_q1_1_scanout[11];
assign wrdata_q1_1_scanin[10]=wrdata_q1_5_scanout[10];
assign wrdata_q1_5_scanin[9]=wrdata_q1_1_scanout[10];
assign wrdata_q1_1_scanin[9]=wrdata_q1_5_scanout[9];
assign wrdata_q1_5_scanin[8]=wrdata_q1_1_scanout[9];
assign wrdata_q1_1_scanin[8]=wrdata_q1_5_scanout[8];
assign wrdata_q1_5_scanin[7]=wrdata_q1_1_scanout[8];
assign wrdata_q1_1_scanin[7]=wrdata_q1_5_scanout[7];
assign wrdata_q1_5_scanin[6]=wrdata_q1_1_scanout[7];
assign wrdata_q1_1_scanin[6]=wrdata_q1_5_scanout[6];
assign wrdata_q1_5_scanin[5]=wrdata_q1_1_scanout[6];
assign wrdata_q1_1_scanin[5]=wrdata_q1_5_scanout[5];
assign wrdata_q1_5_scanin[4]=wrdata_q1_1_scanout[5];
assign wrdata_q1_1_scanin[4]=wrdata_q1_5_scanout[4];
assign wrdata_q1_5_scanin[3]=wrdata_q1_1_scanout[4];
assign wrdata_q1_1_scanin[3]=wrdata_q1_5_scanout[3];
assign wrdata_q1_5_scanin[2]=wrdata_q1_1_scanout[3];
assign wrdata_q1_1_scanin[2]=wrdata_q1_5_scanout[2];
assign wrdata_q1_5_scanin[1]=wrdata_q1_1_scanout[2];
assign wrdata_q1_1_scanin[1]=wrdata_q1_5_scanout[1];
assign wrdata_q1_5_scanin[0]=wrdata_q1_1_scanout[1];
assign wrdata_q1_1_scanin[0]=wrdata_q1_5_scanout[0];


// ***************************BEGIN SECTION*************************

assign data_bus_1_w2_reg_scanin[32]=wrdata_q1_1_scanout[0];
assign data_bus_1_w3_reg_scanin[32]=data_bus_1_w2_reg_scanout[32];
assign data_bus_1_w6_reg_scanin[32]=data_bus_1_w3_reg_scanout[32];
assign data_bus_1_w7_reg_scanin[32]=data_bus_1_w6_reg_scanout[32];
assign data_bus_1_w0_reg_scanin[32]=data_bus_1_w7_reg_scanout[32];
assign data_bus_1_w1_reg_scanin[32]=data_bus_1_w0_reg_scanout[32];
assign data_bus_1_w4_reg_scanin[32]=data_bus_1_w1_reg_scanout[32];
assign data_bus_1_w5_reg_scanin[32]=data_bus_1_w4_reg_scanout[32];

assign data_bus_1_w2_reg_scanin[31]=data_bus_1_w5_reg_scanout[32];
assign data_bus_1_w3_reg_scanin[31]=data_bus_1_w2_reg_scanout[31];
assign data_bus_1_w6_reg_scanin[31]=data_bus_1_w3_reg_scanout[31];
assign data_bus_1_w7_reg_scanin[31]=data_bus_1_w6_reg_scanout[31];
assign data_bus_1_w0_reg_scanin[31]=data_bus_1_w7_reg_scanout[31];
assign data_bus_1_w1_reg_scanin[31]=data_bus_1_w0_reg_scanout[31];
assign data_bus_1_w4_reg_scanin[31]=data_bus_1_w1_reg_scanout[31];
assign data_bus_1_w5_reg_scanin[31]=data_bus_1_w4_reg_scanout[31];

assign data_bus_1_w2_reg_scanin[30]=data_bus_1_w5_reg_scanout[31];
assign data_bus_1_w3_reg_scanin[30]=data_bus_1_w2_reg_scanout[30];
assign data_bus_1_w6_reg_scanin[30]=data_bus_1_w3_reg_scanout[30];
assign data_bus_1_w7_reg_scanin[30]=data_bus_1_w6_reg_scanout[30];
assign data_bus_1_w0_reg_scanin[30]=data_bus_1_w7_reg_scanout[30];
assign data_bus_1_w1_reg_scanin[30]=data_bus_1_w0_reg_scanout[30];
assign data_bus_1_w4_reg_scanin[30]=data_bus_1_w1_reg_scanout[30];
assign data_bus_1_w5_reg_scanin[30]=data_bus_1_w4_reg_scanout[30];

assign data_bus_1_w2_reg_scanin[29]=data_bus_1_w5_reg_scanout[30];
assign data_bus_1_w3_reg_scanin[29]=data_bus_1_w2_reg_scanout[29];
assign data_bus_1_w6_reg_scanin[29]=data_bus_1_w3_reg_scanout[29];
assign data_bus_1_w7_reg_scanin[29]=data_bus_1_w6_reg_scanout[29];
assign data_bus_1_w0_reg_scanin[29]=data_bus_1_w7_reg_scanout[29];
assign data_bus_1_w1_reg_scanin[29]=data_bus_1_w0_reg_scanout[29];
assign data_bus_1_w4_reg_scanin[29]=data_bus_1_w1_reg_scanout[29];
assign data_bus_1_w5_reg_scanin[29]=data_bus_1_w4_reg_scanout[29];

assign data_bus_1_w2_reg_scanin[28]=data_bus_1_w5_reg_scanout[29];
assign data_bus_1_w3_reg_scanin[28]=data_bus_1_w2_reg_scanout[28];
assign data_bus_1_w6_reg_scanin[28]=data_bus_1_w3_reg_scanout[28];
assign data_bus_1_w7_reg_scanin[28]=data_bus_1_w6_reg_scanout[28];
assign data_bus_1_w0_reg_scanin[28]=data_bus_1_w7_reg_scanout[28];
assign data_bus_1_w1_reg_scanin[28]=data_bus_1_w0_reg_scanout[28];
assign data_bus_1_w4_reg_scanin[28]=data_bus_1_w1_reg_scanout[28];
assign data_bus_1_w5_reg_scanin[28]=data_bus_1_w4_reg_scanout[28];

assign data_bus_1_w2_reg_scanin[27]=data_bus_1_w5_reg_scanout[28];
assign data_bus_1_w3_reg_scanin[27]=data_bus_1_w2_reg_scanout[27];
assign data_bus_1_w6_reg_scanin[27]=data_bus_1_w3_reg_scanout[27];
assign data_bus_1_w7_reg_scanin[27]=data_bus_1_w6_reg_scanout[27];
assign data_bus_1_w0_reg_scanin[27]=data_bus_1_w7_reg_scanout[27];
assign data_bus_1_w1_reg_scanin[27]=data_bus_1_w0_reg_scanout[27];
assign data_bus_1_w4_reg_scanin[27]=data_bus_1_w1_reg_scanout[27];
assign data_bus_1_w5_reg_scanin[27]=data_bus_1_w4_reg_scanout[27];

assign data_bus_1_w2_reg_scanin[26]=data_bus_1_w5_reg_scanout[27];
assign data_bus_1_w3_reg_scanin[26]=data_bus_1_w2_reg_scanout[26];
assign data_bus_1_w6_reg_scanin[26]=data_bus_1_w3_reg_scanout[26];
assign data_bus_1_w7_reg_scanin[26]=data_bus_1_w6_reg_scanout[26];
assign data_bus_1_w0_reg_scanin[26]=data_bus_1_w7_reg_scanout[26];
assign data_bus_1_w1_reg_scanin[26]=data_bus_1_w0_reg_scanout[26];
assign data_bus_1_w4_reg_scanin[26]=data_bus_1_w1_reg_scanout[26];
assign data_bus_1_w5_reg_scanin[26]=data_bus_1_w4_reg_scanout[26];

assign data_bus_1_w2_reg_scanin[25]=data_bus_1_w5_reg_scanout[26];
assign data_bus_1_w3_reg_scanin[25]=data_bus_1_w2_reg_scanout[25];
assign data_bus_1_w6_reg_scanin[25]=data_bus_1_w3_reg_scanout[25];
assign data_bus_1_w7_reg_scanin[25]=data_bus_1_w6_reg_scanout[25];
assign data_bus_1_w0_reg_scanin[25]=data_bus_1_w7_reg_scanout[25];
assign data_bus_1_w1_reg_scanin[25]=data_bus_1_w0_reg_scanout[25];
assign data_bus_1_w4_reg_scanin[25]=data_bus_1_w1_reg_scanout[25];
assign data_bus_1_w5_reg_scanin[25]=data_bus_1_w4_reg_scanout[25];

assign data_bus_1_w2_reg_scanin[24]=data_bus_1_w5_reg_scanout[25];
assign data_bus_1_w3_reg_scanin[24]=data_bus_1_w2_reg_scanout[24];
assign data_bus_1_w6_reg_scanin[24]=data_bus_1_w3_reg_scanout[24];
assign data_bus_1_w7_reg_scanin[24]=data_bus_1_w6_reg_scanout[24];
assign data_bus_1_w0_reg_scanin[24]=data_bus_1_w7_reg_scanout[24];
assign data_bus_1_w1_reg_scanin[24]=data_bus_1_w0_reg_scanout[24];
assign data_bus_1_w4_reg_scanin[24]=data_bus_1_w1_reg_scanout[24];
assign data_bus_1_w5_reg_scanin[24]=data_bus_1_w4_reg_scanout[24];

assign data_bus_1_w2_reg_scanin[23]=data_bus_1_w5_reg_scanout[24];
assign data_bus_1_w3_reg_scanin[23]=data_bus_1_w2_reg_scanout[23];
assign data_bus_1_w6_reg_scanin[23]=data_bus_1_w3_reg_scanout[23];
assign data_bus_1_w7_reg_scanin[23]=data_bus_1_w6_reg_scanout[23];
assign data_bus_1_w0_reg_scanin[23]=data_bus_1_w7_reg_scanout[23];
assign data_bus_1_w1_reg_scanin[23]=data_bus_1_w0_reg_scanout[23];
assign data_bus_1_w4_reg_scanin[23]=data_bus_1_w1_reg_scanout[23];
assign data_bus_1_w5_reg_scanin[23]=data_bus_1_w4_reg_scanout[23];

assign data_bus_1_w2_reg_scanin[22]=data_bus_1_w5_reg_scanout[23];
assign data_bus_1_w3_reg_scanin[22]=data_bus_1_w2_reg_scanout[22];
assign data_bus_1_w6_reg_scanin[22]=data_bus_1_w3_reg_scanout[22];
assign data_bus_1_w7_reg_scanin[22]=data_bus_1_w6_reg_scanout[22];
assign data_bus_1_w0_reg_scanin[22]=data_bus_1_w7_reg_scanout[22];
assign data_bus_1_w1_reg_scanin[22]=data_bus_1_w0_reg_scanout[22];
assign data_bus_1_w4_reg_scanin[22]=data_bus_1_w1_reg_scanout[22];
assign data_bus_1_w5_reg_scanin[22]=data_bus_1_w4_reg_scanout[22];

assign data_bus_1_w2_reg_scanin[21]=data_bus_1_w5_reg_scanout[22];
assign data_bus_1_w3_reg_scanin[21]=data_bus_1_w2_reg_scanout[21];
assign data_bus_1_w6_reg_scanin[21]=data_bus_1_w3_reg_scanout[21];
assign data_bus_1_w7_reg_scanin[21]=data_bus_1_w6_reg_scanout[21];
assign data_bus_1_w0_reg_scanin[21]=data_bus_1_w7_reg_scanout[21];
assign data_bus_1_w1_reg_scanin[21]=data_bus_1_w0_reg_scanout[21];
assign data_bus_1_w4_reg_scanin[21]=data_bus_1_w1_reg_scanout[21];
assign data_bus_1_w5_reg_scanin[21]=data_bus_1_w4_reg_scanout[21];

assign data_bus_1_w2_reg_scanin[20]=data_bus_1_w5_reg_scanout[21];
assign data_bus_1_w3_reg_scanin[20]=data_bus_1_w2_reg_scanout[20];
assign data_bus_1_w6_reg_scanin[20]=data_bus_1_w3_reg_scanout[20];
assign data_bus_1_w7_reg_scanin[20]=data_bus_1_w6_reg_scanout[20];
assign data_bus_1_w0_reg_scanin[20]=data_bus_1_w7_reg_scanout[20];
assign data_bus_1_w1_reg_scanin[20]=data_bus_1_w0_reg_scanout[20];
assign data_bus_1_w4_reg_scanin[20]=data_bus_1_w1_reg_scanout[20];
assign data_bus_1_w5_reg_scanin[20]=data_bus_1_w4_reg_scanout[20];

assign data_bus_1_w2_reg_scanin[19]=data_bus_1_w5_reg_scanout[20];
assign data_bus_1_w3_reg_scanin[19]=data_bus_1_w2_reg_scanout[19];
assign data_bus_1_w6_reg_scanin[19]=data_bus_1_w3_reg_scanout[19];
assign data_bus_1_w7_reg_scanin[19]=data_bus_1_w6_reg_scanout[19];
assign data_bus_1_w0_reg_scanin[19]=data_bus_1_w7_reg_scanout[19];
assign data_bus_1_w1_reg_scanin[19]=data_bus_1_w0_reg_scanout[19];
assign data_bus_1_w4_reg_scanin[19]=data_bus_1_w1_reg_scanout[19];
assign data_bus_1_w5_reg_scanin[19]=data_bus_1_w4_reg_scanout[19];

assign data_bus_1_w2_reg_scanin[18]=data_bus_1_w5_reg_scanout[19];
assign data_bus_1_w3_reg_scanin[18]=data_bus_1_w2_reg_scanout[18];
assign data_bus_1_w6_reg_scanin[18]=data_bus_1_w3_reg_scanout[18];
assign data_bus_1_w7_reg_scanin[18]=data_bus_1_w6_reg_scanout[18];
assign data_bus_1_w0_reg_scanin[18]=data_bus_1_w7_reg_scanout[18];
assign data_bus_1_w1_reg_scanin[18]=data_bus_1_w0_reg_scanout[18];
assign data_bus_1_w4_reg_scanin[18]=data_bus_1_w1_reg_scanout[18];
assign data_bus_1_w5_reg_scanin[18]=data_bus_1_w4_reg_scanout[18];

assign data_bus_1_w2_reg_scanin[17]=data_bus_1_w5_reg_scanout[18];
assign data_bus_1_w3_reg_scanin[17]=data_bus_1_w2_reg_scanout[17];
assign data_bus_1_w6_reg_scanin[17]=data_bus_1_w3_reg_scanout[17];
assign data_bus_1_w7_reg_scanin[17]=data_bus_1_w6_reg_scanout[17];
assign data_bus_1_w0_reg_scanin[17]=data_bus_1_w7_reg_scanout[17];
assign data_bus_1_w1_reg_scanin[17]=data_bus_1_w0_reg_scanout[17];
assign data_bus_1_w4_reg_scanin[17]=data_bus_1_w1_reg_scanout[17];
assign data_bus_1_w5_reg_scanin[17]=data_bus_1_w4_reg_scanout[17];

assign data_bus_1_w0_reg_scanin[16]=data_bus_1_w5_reg_scanout[17];
assign data_bus_1_w1_reg_scanin[16]=data_bus_1_w0_reg_scanout[16];
assign data_bus_1_w4_reg_scanin[16]=data_bus_1_w1_reg_scanout[16];
assign data_bus_1_w5_reg_scanin[16]=data_bus_1_w4_reg_scanout[16];
assign data_bus_1_w2_reg_scanin[16]=data_bus_1_w5_reg_scanout[16];
assign data_bus_1_w3_reg_scanin[16]=data_bus_1_w2_reg_scanout[16];
assign data_bus_1_w6_reg_scanin[16]=data_bus_1_w3_reg_scanout[16];
assign data_bus_1_w7_reg_scanin[16]=data_bus_1_w6_reg_scanout[16];

assign data_bus_1_w0_reg_scanin[15]=data_bus_1_w7_reg_scanout[16];
assign data_bus_1_w1_reg_scanin[15]=data_bus_1_w0_reg_scanout[15];
assign data_bus_1_w4_reg_scanin[15]=data_bus_1_w1_reg_scanout[15];
assign data_bus_1_w5_reg_scanin[15]=data_bus_1_w4_reg_scanout[15];
assign data_bus_1_w2_reg_scanin[15]=data_bus_1_w5_reg_scanout[15];
assign data_bus_1_w3_reg_scanin[15]=data_bus_1_w2_reg_scanout[15];
assign data_bus_1_w6_reg_scanin[15]=data_bus_1_w3_reg_scanout[15];
assign data_bus_1_w7_reg_scanin[15]=data_bus_1_w6_reg_scanout[15];

assign data_bus_1_w0_reg_scanin[14]=data_bus_1_w7_reg_scanout[15];
assign data_bus_1_w1_reg_scanin[14]=data_bus_1_w0_reg_scanout[14];
assign data_bus_1_w4_reg_scanin[14]=data_bus_1_w1_reg_scanout[14];
assign data_bus_1_w5_reg_scanin[14]=data_bus_1_w4_reg_scanout[14];
assign data_bus_1_w2_reg_scanin[14]=data_bus_1_w5_reg_scanout[14];
assign data_bus_1_w3_reg_scanin[14]=data_bus_1_w2_reg_scanout[14];
assign data_bus_1_w6_reg_scanin[14]=data_bus_1_w3_reg_scanout[14];
assign data_bus_1_w7_reg_scanin[14]=data_bus_1_w6_reg_scanout[14];

assign data_bus_1_w0_reg_scanin[13]=data_bus_1_w7_reg_scanout[14];
assign data_bus_1_w1_reg_scanin[13]=data_bus_1_w0_reg_scanout[13];
assign data_bus_1_w4_reg_scanin[13]=data_bus_1_w1_reg_scanout[13];
assign data_bus_1_w5_reg_scanin[13]=data_bus_1_w4_reg_scanout[13];
assign data_bus_1_w2_reg_scanin[13]=data_bus_1_w5_reg_scanout[13];
assign data_bus_1_w3_reg_scanin[13]=data_bus_1_w2_reg_scanout[13];
assign data_bus_1_w6_reg_scanin[13]=data_bus_1_w3_reg_scanout[13];
assign data_bus_1_w7_reg_scanin[13]=data_bus_1_w6_reg_scanout[13];

assign data_bus_1_w0_reg_scanin[12]=data_bus_1_w7_reg_scanout[13];
assign data_bus_1_w1_reg_scanin[12]=data_bus_1_w0_reg_scanout[12];
assign data_bus_1_w4_reg_scanin[12]=data_bus_1_w1_reg_scanout[12];
assign data_bus_1_w5_reg_scanin[12]=data_bus_1_w4_reg_scanout[12];
assign data_bus_1_w2_reg_scanin[12]=data_bus_1_w5_reg_scanout[12];
assign data_bus_1_w3_reg_scanin[12]=data_bus_1_w2_reg_scanout[12];
assign data_bus_1_w6_reg_scanin[12]=data_bus_1_w3_reg_scanout[12];
assign data_bus_1_w7_reg_scanin[12]=data_bus_1_w6_reg_scanout[12];

assign data_bus_1_w0_reg_scanin[11]=data_bus_1_w7_reg_scanout[12];
assign data_bus_1_w1_reg_scanin[11]=data_bus_1_w0_reg_scanout[11];
assign data_bus_1_w4_reg_scanin[11]=data_bus_1_w1_reg_scanout[11];
assign data_bus_1_w5_reg_scanin[11]=data_bus_1_w4_reg_scanout[11];
assign data_bus_1_w2_reg_scanin[11]=data_bus_1_w5_reg_scanout[11];
assign data_bus_1_w3_reg_scanin[11]=data_bus_1_w2_reg_scanout[11];
assign data_bus_1_w6_reg_scanin[11]=data_bus_1_w3_reg_scanout[11];
assign data_bus_1_w7_reg_scanin[11]=data_bus_1_w6_reg_scanout[11];

assign data_bus_1_w0_reg_scanin[10]=data_bus_1_w7_reg_scanout[11];
assign data_bus_1_w1_reg_scanin[10]=data_bus_1_w0_reg_scanout[10];
assign data_bus_1_w4_reg_scanin[10]=data_bus_1_w1_reg_scanout[10];
assign data_bus_1_w5_reg_scanin[10]=data_bus_1_w4_reg_scanout[10];
assign data_bus_1_w2_reg_scanin[10]=data_bus_1_w5_reg_scanout[10];
assign data_bus_1_w3_reg_scanin[10]=data_bus_1_w2_reg_scanout[10];
assign data_bus_1_w6_reg_scanin[10]=data_bus_1_w3_reg_scanout[10];
assign data_bus_1_w7_reg_scanin[10]=data_bus_1_w6_reg_scanout[10];

assign data_bus_1_w0_reg_scanin[9]=data_bus_1_w7_reg_scanout[10];
assign data_bus_1_w1_reg_scanin[9]=data_bus_1_w0_reg_scanout[9];
assign data_bus_1_w4_reg_scanin[9]=data_bus_1_w1_reg_scanout[9];
assign data_bus_1_w5_reg_scanin[9]=data_bus_1_w4_reg_scanout[9];
assign data_bus_1_w2_reg_scanin[9]=data_bus_1_w5_reg_scanout[9];
assign data_bus_1_w3_reg_scanin[9]=data_bus_1_w2_reg_scanout[9];
assign data_bus_1_w6_reg_scanin[9]=data_bus_1_w3_reg_scanout[9];
assign data_bus_1_w7_reg_scanin[9]=data_bus_1_w6_reg_scanout[9];

assign data_bus_1_w0_reg_scanin[8]=data_bus_1_w7_reg_scanout[9];
assign data_bus_1_w1_reg_scanin[8]=data_bus_1_w0_reg_scanout[8];
assign data_bus_1_w4_reg_scanin[8]=data_bus_1_w1_reg_scanout[8];
assign data_bus_1_w5_reg_scanin[8]=data_bus_1_w4_reg_scanout[8];
assign data_bus_1_w2_reg_scanin[8]=data_bus_1_w5_reg_scanout[8];
assign data_bus_1_w3_reg_scanin[8]=data_bus_1_w2_reg_scanout[8];
assign data_bus_1_w6_reg_scanin[8]=data_bus_1_w3_reg_scanout[8];
assign data_bus_1_w7_reg_scanin[8]=data_bus_1_w6_reg_scanout[8];

assign data_bus_1_w0_reg_scanin[7]=data_bus_1_w7_reg_scanout[8];
assign data_bus_1_w1_reg_scanin[7]=data_bus_1_w0_reg_scanout[7];
assign data_bus_1_w4_reg_scanin[7]=data_bus_1_w1_reg_scanout[7];
assign data_bus_1_w5_reg_scanin[7]=data_bus_1_w4_reg_scanout[7];
assign data_bus_1_w2_reg_scanin[7]=data_bus_1_w5_reg_scanout[7];
assign data_bus_1_w3_reg_scanin[7]=data_bus_1_w2_reg_scanout[7];
assign data_bus_1_w6_reg_scanin[7]=data_bus_1_w3_reg_scanout[7];
assign data_bus_1_w7_reg_scanin[7]=data_bus_1_w6_reg_scanout[7];

assign data_bus_1_w0_reg_scanin[6]=data_bus_1_w7_reg_scanout[7];
assign data_bus_1_w1_reg_scanin[6]=data_bus_1_w0_reg_scanout[6];
assign data_bus_1_w4_reg_scanin[6]=data_bus_1_w1_reg_scanout[6];
assign data_bus_1_w5_reg_scanin[6]=data_bus_1_w4_reg_scanout[6];
assign data_bus_1_w2_reg_scanin[6]=data_bus_1_w5_reg_scanout[6];
assign data_bus_1_w3_reg_scanin[6]=data_bus_1_w2_reg_scanout[6];
assign data_bus_1_w6_reg_scanin[6]=data_bus_1_w3_reg_scanout[6];
assign data_bus_1_w7_reg_scanin[6]=data_bus_1_w6_reg_scanout[6];

assign data_bus_1_w0_reg_scanin[5]=data_bus_1_w7_reg_scanout[6];
assign data_bus_1_w1_reg_scanin[5]=data_bus_1_w0_reg_scanout[5];
assign data_bus_1_w4_reg_scanin[5]=data_bus_1_w1_reg_scanout[5];
assign data_bus_1_w5_reg_scanin[5]=data_bus_1_w4_reg_scanout[5];
assign data_bus_1_w2_reg_scanin[5]=data_bus_1_w5_reg_scanout[5];
assign data_bus_1_w3_reg_scanin[5]=data_bus_1_w2_reg_scanout[5];
assign data_bus_1_w6_reg_scanin[5]=data_bus_1_w3_reg_scanout[5];
assign data_bus_1_w7_reg_scanin[5]=data_bus_1_w6_reg_scanout[5];

assign data_bus_1_w0_reg_scanin[4]=data_bus_1_w7_reg_scanout[5];
assign data_bus_1_w1_reg_scanin[4]=data_bus_1_w0_reg_scanout[4];
assign data_bus_1_w4_reg_scanin[4]=data_bus_1_w1_reg_scanout[4];
assign data_bus_1_w5_reg_scanin[4]=data_bus_1_w4_reg_scanout[4];
assign data_bus_1_w2_reg_scanin[4]=data_bus_1_w5_reg_scanout[4];
assign data_bus_1_w3_reg_scanin[4]=data_bus_1_w2_reg_scanout[4];
assign data_bus_1_w6_reg_scanin[4]=data_bus_1_w3_reg_scanout[4];
assign data_bus_1_w7_reg_scanin[4]=data_bus_1_w6_reg_scanout[4];

assign data_bus_1_w0_reg_scanin[3]=data_bus_1_w7_reg_scanout[4];
assign data_bus_1_w1_reg_scanin[3]=data_bus_1_w0_reg_scanout[3];
assign data_bus_1_w4_reg_scanin[3]=data_bus_1_w1_reg_scanout[3];
assign data_bus_1_w5_reg_scanin[3]=data_bus_1_w4_reg_scanout[3];
assign data_bus_1_w2_reg_scanin[3]=data_bus_1_w5_reg_scanout[3];
assign data_bus_1_w3_reg_scanin[3]=data_bus_1_w2_reg_scanout[3];
assign data_bus_1_w6_reg_scanin[3]=data_bus_1_w3_reg_scanout[3];
assign data_bus_1_w7_reg_scanin[3]=data_bus_1_w6_reg_scanout[3];

assign data_bus_1_w0_reg_scanin[2]=data_bus_1_w7_reg_scanout[3];
assign data_bus_1_w1_reg_scanin[2]=data_bus_1_w0_reg_scanout[2];
assign data_bus_1_w4_reg_scanin[2]=data_bus_1_w1_reg_scanout[2];
assign data_bus_1_w5_reg_scanin[2]=data_bus_1_w4_reg_scanout[2];
assign data_bus_1_w2_reg_scanin[2]=data_bus_1_w5_reg_scanout[2];
assign data_bus_1_w3_reg_scanin[2]=data_bus_1_w2_reg_scanout[2];
assign data_bus_1_w6_reg_scanin[2]=data_bus_1_w3_reg_scanout[2];
assign data_bus_1_w7_reg_scanin[2]=data_bus_1_w6_reg_scanout[2];

assign data_bus_1_w0_reg_scanin[1]=data_bus_1_w7_reg_scanout[2];
assign data_bus_1_w1_reg_scanin[1]=data_bus_1_w0_reg_scanout[1];
assign data_bus_1_w4_reg_scanin[1]=data_bus_1_w1_reg_scanout[1];
assign data_bus_1_w5_reg_scanin[1]=data_bus_1_w4_reg_scanout[1];
assign data_bus_1_w2_reg_scanin[1]=data_bus_1_w5_reg_scanout[1];
assign data_bus_1_w3_reg_scanin[1]=data_bus_1_w2_reg_scanout[1];
assign data_bus_1_w6_reg_scanin[1]=data_bus_1_w3_reg_scanout[1];
assign data_bus_1_w7_reg_scanin[1]=data_bus_1_w6_reg_scanout[1];

assign data_bus_1_w0_reg_scanin[0]=data_bus_1_w7_reg_scanout[1];
assign data_bus_1_w1_reg_scanin[0]=data_bus_1_w0_reg_scanout[0];
assign data_bus_1_w4_reg_scanin[0]=data_bus_1_w1_reg_scanout[0];
assign data_bus_1_w5_reg_scanin[0]=data_bus_1_w4_reg_scanout[0];
assign data_bus_1_w2_reg_scanin[0]=data_bus_1_w5_reg_scanout[0];
assign data_bus_1_w3_reg_scanin[0]=data_bus_1_w2_reg_scanout[0];
assign data_bus_1_w6_reg_scanin[0]=data_bus_1_w3_reg_scanout[0];
assign data_bus_1_w7_reg_scanin[0]=data_bus_1_w6_reg_scanout[0];


// ***************************END SECTION***************************

assign wrdata_q0_4_scanin[32]=data_bus_1_w7_reg_scanout[0];
assign wrdata_q0_0_scanin[32]=wrdata_q0_4_scanout[32];
assign wrdata_q0_4_scanin[31]=wrdata_q0_0_scanout[32];
assign wrdata_q0_0_scanin[31]=wrdata_q0_4_scanout[31];
assign wrdata_q0_4_scanin[30]=wrdata_q0_0_scanout[31];
assign wrdata_q0_0_scanin[30]=wrdata_q0_4_scanout[30];
assign wrdata_q0_4_scanin[29]=wrdata_q0_0_scanout[30];
assign wrdata_q0_0_scanin[29]=wrdata_q0_4_scanout[29];
assign wrdata_q0_4_scanin[28]=wrdata_q0_0_scanout[29];
assign wrdata_q0_0_scanin[28]=wrdata_q0_4_scanout[28];
assign wrdata_q0_4_scanin[27]=wrdata_q0_0_scanout[28];
assign wrdata_q0_0_scanin[27]=wrdata_q0_4_scanout[27];
assign wrdata_q0_4_scanin[26]=wrdata_q0_0_scanout[27];
assign wrdata_q0_0_scanin[26]=wrdata_q0_4_scanout[26];
assign wrdata_q0_4_scanin[25]=wrdata_q0_0_scanout[26];
assign wrdata_q0_0_scanin[25]=wrdata_q0_4_scanout[25];
assign wrdata_q0_4_scanin[24]=wrdata_q0_0_scanout[25];
assign wrdata_q0_0_scanin[24]=wrdata_q0_4_scanout[24];
assign wrdata_q0_4_scanin[23]=wrdata_q0_0_scanout[24];
assign wrdata_q0_0_scanin[23]=wrdata_q0_4_scanout[23];
assign wrdata_q0_4_scanin[22]=wrdata_q0_0_scanout[23];
assign wrdata_q0_0_scanin[22]=wrdata_q0_4_scanout[22];
assign wrdata_q0_4_scanin[21]=wrdata_q0_0_scanout[22];
assign wrdata_q0_0_scanin[21]=wrdata_q0_4_scanout[21];
assign wrdata_q0_4_scanin[20]=wrdata_q0_0_scanout[21];
assign wrdata_q0_0_scanin[20]=wrdata_q0_4_scanout[20];
assign wrdata_q0_4_scanin[19]=wrdata_q0_0_scanout[20];
assign wrdata_q0_0_scanin[19]=wrdata_q0_4_scanout[19];
assign wrdata_q0_4_scanin[18]=wrdata_q0_0_scanout[19];
assign wrdata_q0_0_scanin[18]=wrdata_q0_4_scanout[18];
assign wrdata_q0_4_scanin[17]=wrdata_q0_0_scanout[18];
assign wrdata_q0_0_scanin[17]=wrdata_q0_4_scanout[17];
assign wrdata_q0_4_scanin[16]=wrdata_q0_0_scanout[17];
assign wrdata_q0_0_scanin[16]=wrdata_q0_4_scanout[16];
assign wrdata_q0_4_scanin[15]=wrdata_q0_0_scanout[16];
assign wrdata_q0_0_scanin[15]=wrdata_q0_4_scanout[15];
assign wrdata_q0_4_scanin[14]=wrdata_q0_0_scanout[15];
assign wrdata_q0_0_scanin[14]=wrdata_q0_4_scanout[14];
assign wrdata_q0_4_scanin[13]=wrdata_q0_0_scanout[14];
assign wrdata_q0_0_scanin[13]=wrdata_q0_4_scanout[13];
assign wrdata_q0_4_scanin[12]=wrdata_q0_0_scanout[13];
assign wrdata_q0_0_scanin[12]=wrdata_q0_4_scanout[12];
assign wrdata_q0_4_scanin[11]=wrdata_q0_0_scanout[12];
assign wrdata_q0_0_scanin[11]=wrdata_q0_4_scanout[11];
assign wrdata_q0_4_scanin[10]=wrdata_q0_0_scanout[11];
assign wrdata_q0_0_scanin[10]=wrdata_q0_4_scanout[10];
assign wrdata_q0_4_scanin[9]=wrdata_q0_0_scanout[10];
assign wrdata_q0_0_scanin[9]=wrdata_q0_4_scanout[9];
assign wrdata_q0_4_scanin[8]=wrdata_q0_0_scanout[9];
assign wrdata_q0_0_scanin[8]=wrdata_q0_4_scanout[8];
assign wrdata_q0_4_scanin[7]=wrdata_q0_0_scanout[8];
assign wrdata_q0_0_scanin[7]=wrdata_q0_4_scanout[7];
assign wrdata_q0_4_scanin[6]=wrdata_q0_0_scanout[7];
assign wrdata_q0_0_scanin[6]=wrdata_q0_4_scanout[6];
assign wrdata_q0_4_scanin[5]=wrdata_q0_0_scanout[6];
assign wrdata_q0_0_scanin[5]=wrdata_q0_4_scanout[5];
assign wrdata_q0_4_scanin[4]=wrdata_q0_0_scanout[5];
assign wrdata_q0_0_scanin[4]=wrdata_q0_4_scanout[4];
assign wrdata_q0_4_scanin[3]=wrdata_q0_0_scanout[4];
assign wrdata_q0_0_scanin[3]=wrdata_q0_4_scanout[3];
assign wrdata_q0_4_scanin[2]=wrdata_q0_0_scanout[3];
assign wrdata_q0_0_scanin[2]=wrdata_q0_4_scanout[2];
assign wrdata_q0_4_scanin[1]=wrdata_q0_0_scanout[2];
assign wrdata_q0_0_scanin[1]=wrdata_q0_4_scanout[1];
assign wrdata_q0_4_scanin[0]=wrdata_q0_0_scanout[1];
assign wrdata_q0_0_scanin[0]=wrdata_q0_4_scanout[0];

// ***************************BEGIN SECTION*************************

assign data_bus_0_w2_reg_scanin[32]=wrdata_q0_0_scanout[0];
assign data_bus_0_w3_reg_scanin[32]=data_bus_0_w2_reg_scanout[32];
assign data_bus_0_w6_reg_scanin[32]=data_bus_0_w3_reg_scanout[32];
assign data_bus_0_w7_reg_scanin[32]=data_bus_0_w6_reg_scanout[32];
assign data_bus_0_w0_reg_scanin[32]=data_bus_0_w7_reg_scanout[32];
assign data_bus_0_w1_reg_scanin[32]=data_bus_0_w0_reg_scanout[32];
assign data_bus_0_w4_reg_scanin[32]=data_bus_0_w1_reg_scanout[32];
assign data_bus_0_w5_reg_scanin[32]=data_bus_0_w4_reg_scanout[32];

assign data_bus_0_w2_reg_scanin[31]=data_bus_0_w5_reg_scanout[32];
assign data_bus_0_w3_reg_scanin[31]=data_bus_0_w2_reg_scanout[31];
assign data_bus_0_w6_reg_scanin[31]=data_bus_0_w3_reg_scanout[31];
assign data_bus_0_w7_reg_scanin[31]=data_bus_0_w6_reg_scanout[31];
assign data_bus_0_w0_reg_scanin[31]=data_bus_0_w7_reg_scanout[31];
assign data_bus_0_w1_reg_scanin[31]=data_bus_0_w0_reg_scanout[31];
assign data_bus_0_w4_reg_scanin[31]=data_bus_0_w1_reg_scanout[31];
assign data_bus_0_w5_reg_scanin[31]=data_bus_0_w4_reg_scanout[31];

assign data_bus_0_w2_reg_scanin[30]=data_bus_0_w5_reg_scanout[31];
assign data_bus_0_w3_reg_scanin[30]=data_bus_0_w2_reg_scanout[30];
assign data_bus_0_w6_reg_scanin[30]=data_bus_0_w3_reg_scanout[30];
assign data_bus_0_w7_reg_scanin[30]=data_bus_0_w6_reg_scanout[30];
assign data_bus_0_w0_reg_scanin[30]=data_bus_0_w7_reg_scanout[30];
assign data_bus_0_w1_reg_scanin[30]=data_bus_0_w0_reg_scanout[30];
assign data_bus_0_w4_reg_scanin[30]=data_bus_0_w1_reg_scanout[30];
assign data_bus_0_w5_reg_scanin[30]=data_bus_0_w4_reg_scanout[30];

assign data_bus_0_w2_reg_scanin[29]=data_bus_0_w5_reg_scanout[30];
assign data_bus_0_w3_reg_scanin[29]=data_bus_0_w2_reg_scanout[29];
assign data_bus_0_w6_reg_scanin[29]=data_bus_0_w3_reg_scanout[29];
assign data_bus_0_w7_reg_scanin[29]=data_bus_0_w6_reg_scanout[29];
assign data_bus_0_w0_reg_scanin[29]=data_bus_0_w7_reg_scanout[29];
assign data_bus_0_w1_reg_scanin[29]=data_bus_0_w0_reg_scanout[29];
assign data_bus_0_w4_reg_scanin[29]=data_bus_0_w1_reg_scanout[29];
assign data_bus_0_w5_reg_scanin[29]=data_bus_0_w4_reg_scanout[29];

assign data_bus_0_w2_reg_scanin[28]=data_bus_0_w5_reg_scanout[29];
assign data_bus_0_w3_reg_scanin[28]=data_bus_0_w2_reg_scanout[28];
assign data_bus_0_w6_reg_scanin[28]=data_bus_0_w3_reg_scanout[28];
assign data_bus_0_w7_reg_scanin[28]=data_bus_0_w6_reg_scanout[28];
assign data_bus_0_w0_reg_scanin[28]=data_bus_0_w7_reg_scanout[28];
assign data_bus_0_w1_reg_scanin[28]=data_bus_0_w0_reg_scanout[28];
assign data_bus_0_w4_reg_scanin[28]=data_bus_0_w1_reg_scanout[28];
assign data_bus_0_w5_reg_scanin[28]=data_bus_0_w4_reg_scanout[28];

assign data_bus_0_w2_reg_scanin[27]=data_bus_0_w5_reg_scanout[28];
assign data_bus_0_w3_reg_scanin[27]=data_bus_0_w2_reg_scanout[27];
assign data_bus_0_w6_reg_scanin[27]=data_bus_0_w3_reg_scanout[27];
assign data_bus_0_w7_reg_scanin[27]=data_bus_0_w6_reg_scanout[27];
assign data_bus_0_w0_reg_scanin[27]=data_bus_0_w7_reg_scanout[27];
assign data_bus_0_w1_reg_scanin[27]=data_bus_0_w0_reg_scanout[27];
assign data_bus_0_w4_reg_scanin[27]=data_bus_0_w1_reg_scanout[27];
assign data_bus_0_w5_reg_scanin[27]=data_bus_0_w4_reg_scanout[27];

assign data_bus_0_w2_reg_scanin[26]=data_bus_0_w5_reg_scanout[27];
assign data_bus_0_w3_reg_scanin[26]=data_bus_0_w2_reg_scanout[26];
assign data_bus_0_w6_reg_scanin[26]=data_bus_0_w3_reg_scanout[26];
assign data_bus_0_w7_reg_scanin[26]=data_bus_0_w6_reg_scanout[26];
assign data_bus_0_w0_reg_scanin[26]=data_bus_0_w7_reg_scanout[26];
assign data_bus_0_w1_reg_scanin[26]=data_bus_0_w0_reg_scanout[26];
assign data_bus_0_w4_reg_scanin[26]=data_bus_0_w1_reg_scanout[26];
assign data_bus_0_w5_reg_scanin[26]=data_bus_0_w4_reg_scanout[26];

assign data_bus_0_w2_reg_scanin[25]=data_bus_0_w5_reg_scanout[26];
assign data_bus_0_w3_reg_scanin[25]=data_bus_0_w2_reg_scanout[25];
assign data_bus_0_w6_reg_scanin[25]=data_bus_0_w3_reg_scanout[25];
assign data_bus_0_w7_reg_scanin[25]=data_bus_0_w6_reg_scanout[25];
assign data_bus_0_w0_reg_scanin[25]=data_bus_0_w7_reg_scanout[25];
assign data_bus_0_w1_reg_scanin[25]=data_bus_0_w0_reg_scanout[25];
assign data_bus_0_w4_reg_scanin[25]=data_bus_0_w1_reg_scanout[25];
assign data_bus_0_w5_reg_scanin[25]=data_bus_0_w4_reg_scanout[25];

assign data_bus_0_w2_reg_scanin[24]=data_bus_0_w5_reg_scanout[25];
assign data_bus_0_w3_reg_scanin[24]=data_bus_0_w2_reg_scanout[24];
assign data_bus_0_w6_reg_scanin[24]=data_bus_0_w3_reg_scanout[24];
assign data_bus_0_w7_reg_scanin[24]=data_bus_0_w6_reg_scanout[24];
assign data_bus_0_w0_reg_scanin[24]=data_bus_0_w7_reg_scanout[24];
assign data_bus_0_w1_reg_scanin[24]=data_bus_0_w0_reg_scanout[24];
assign data_bus_0_w4_reg_scanin[24]=data_bus_0_w1_reg_scanout[24];
assign data_bus_0_w5_reg_scanin[24]=data_bus_0_w4_reg_scanout[24];

assign data_bus_0_w2_reg_scanin[23]=data_bus_0_w5_reg_scanout[24];
assign data_bus_0_w3_reg_scanin[23]=data_bus_0_w2_reg_scanout[23];
assign data_bus_0_w6_reg_scanin[23]=data_bus_0_w3_reg_scanout[23];
assign data_bus_0_w7_reg_scanin[23]=data_bus_0_w6_reg_scanout[23];
assign data_bus_0_w0_reg_scanin[23]=data_bus_0_w7_reg_scanout[23];
assign data_bus_0_w1_reg_scanin[23]=data_bus_0_w0_reg_scanout[23];
assign data_bus_0_w4_reg_scanin[23]=data_bus_0_w1_reg_scanout[23];
assign data_bus_0_w5_reg_scanin[23]=data_bus_0_w4_reg_scanout[23];

assign data_bus_0_w2_reg_scanin[22]=data_bus_0_w5_reg_scanout[23];
assign data_bus_0_w3_reg_scanin[22]=data_bus_0_w2_reg_scanout[22];
assign data_bus_0_w6_reg_scanin[22]=data_bus_0_w3_reg_scanout[22];
assign data_bus_0_w7_reg_scanin[22]=data_bus_0_w6_reg_scanout[22];
assign data_bus_0_w0_reg_scanin[22]=data_bus_0_w7_reg_scanout[22];
assign data_bus_0_w1_reg_scanin[22]=data_bus_0_w0_reg_scanout[22];
assign data_bus_0_w4_reg_scanin[22]=data_bus_0_w1_reg_scanout[22];
assign data_bus_0_w5_reg_scanin[22]=data_bus_0_w4_reg_scanout[22];

assign data_bus_0_w2_reg_scanin[21]=data_bus_0_w5_reg_scanout[22];
assign data_bus_0_w3_reg_scanin[21]=data_bus_0_w2_reg_scanout[21];
assign data_bus_0_w6_reg_scanin[21]=data_bus_0_w3_reg_scanout[21];
assign data_bus_0_w7_reg_scanin[21]=data_bus_0_w6_reg_scanout[21];
assign data_bus_0_w0_reg_scanin[21]=data_bus_0_w7_reg_scanout[21];
assign data_bus_0_w1_reg_scanin[21]=data_bus_0_w0_reg_scanout[21];
assign data_bus_0_w4_reg_scanin[21]=data_bus_0_w1_reg_scanout[21];
assign data_bus_0_w5_reg_scanin[21]=data_bus_0_w4_reg_scanout[21];

assign data_bus_0_w2_reg_scanin[20]=data_bus_0_w5_reg_scanout[21];
assign data_bus_0_w3_reg_scanin[20]=data_bus_0_w2_reg_scanout[20];
assign data_bus_0_w6_reg_scanin[20]=data_bus_0_w3_reg_scanout[20];
assign data_bus_0_w7_reg_scanin[20]=data_bus_0_w6_reg_scanout[20];
assign data_bus_0_w0_reg_scanin[20]=data_bus_0_w7_reg_scanout[20];
assign data_bus_0_w1_reg_scanin[20]=data_bus_0_w0_reg_scanout[20];
assign data_bus_0_w4_reg_scanin[20]=data_bus_0_w1_reg_scanout[20];
assign data_bus_0_w5_reg_scanin[20]=data_bus_0_w4_reg_scanout[20];

assign data_bus_0_w2_reg_scanin[19]=data_bus_0_w5_reg_scanout[20];
assign data_bus_0_w3_reg_scanin[19]=data_bus_0_w2_reg_scanout[19];
assign data_bus_0_w6_reg_scanin[19]=data_bus_0_w3_reg_scanout[19];
assign data_bus_0_w7_reg_scanin[19]=data_bus_0_w6_reg_scanout[19];
assign data_bus_0_w0_reg_scanin[19]=data_bus_0_w7_reg_scanout[19];
assign data_bus_0_w1_reg_scanin[19]=data_bus_0_w0_reg_scanout[19];
assign data_bus_0_w4_reg_scanin[19]=data_bus_0_w1_reg_scanout[19];
assign data_bus_0_w5_reg_scanin[19]=data_bus_0_w4_reg_scanout[19];

assign data_bus_0_w2_reg_scanin[18]=data_bus_0_w5_reg_scanout[19];
assign data_bus_0_w3_reg_scanin[18]=data_bus_0_w2_reg_scanout[18];
assign data_bus_0_w6_reg_scanin[18]=data_bus_0_w3_reg_scanout[18];
assign data_bus_0_w7_reg_scanin[18]=data_bus_0_w6_reg_scanout[18];
assign data_bus_0_w0_reg_scanin[18]=data_bus_0_w7_reg_scanout[18];
assign data_bus_0_w1_reg_scanin[18]=data_bus_0_w0_reg_scanout[18];
assign data_bus_0_w4_reg_scanin[18]=data_bus_0_w1_reg_scanout[18];
assign data_bus_0_w5_reg_scanin[18]=data_bus_0_w4_reg_scanout[18];

assign data_bus_0_w2_reg_scanin[17]=data_bus_0_w5_reg_scanout[18];
assign data_bus_0_w3_reg_scanin[17]=data_bus_0_w2_reg_scanout[17];
assign data_bus_0_w6_reg_scanin[17]=data_bus_0_w3_reg_scanout[17];
assign data_bus_0_w7_reg_scanin[17]=data_bus_0_w6_reg_scanout[17];
assign data_bus_0_w0_reg_scanin[17]=data_bus_0_w7_reg_scanout[17];
assign data_bus_0_w1_reg_scanin[17]=data_bus_0_w0_reg_scanout[17];
assign data_bus_0_w4_reg_scanin[17]=data_bus_0_w1_reg_scanout[17];
assign data_bus_0_w5_reg_scanin[17]=data_bus_0_w4_reg_scanout[17];

assign data_bus_0_w0_reg_scanin[16]=data_bus_0_w5_reg_scanout[17];
assign data_bus_0_w1_reg_scanin[16]=data_bus_0_w0_reg_scanout[16];
assign data_bus_0_w4_reg_scanin[16]=data_bus_0_w1_reg_scanout[16];
assign data_bus_0_w5_reg_scanin[16]=data_bus_0_w4_reg_scanout[16];
assign data_bus_0_w2_reg_scanin[16]=data_bus_0_w5_reg_scanout[16];
assign data_bus_0_w3_reg_scanin[16]=data_bus_0_w2_reg_scanout[16];
assign data_bus_0_w6_reg_scanin[16]=data_bus_0_w3_reg_scanout[16];
assign data_bus_0_w7_reg_scanin[16]=data_bus_0_w6_reg_scanout[16];

assign data_bus_0_w0_reg_scanin[15]=data_bus_0_w7_reg_scanout[16];
assign data_bus_0_w1_reg_scanin[15]=data_bus_0_w0_reg_scanout[15];
assign data_bus_0_w4_reg_scanin[15]=data_bus_0_w1_reg_scanout[15];
assign data_bus_0_w5_reg_scanin[15]=data_bus_0_w4_reg_scanout[15];
assign data_bus_0_w2_reg_scanin[15]=data_bus_0_w5_reg_scanout[15];
assign data_bus_0_w3_reg_scanin[15]=data_bus_0_w2_reg_scanout[15];
assign data_bus_0_w6_reg_scanin[15]=data_bus_0_w3_reg_scanout[15];
assign data_bus_0_w7_reg_scanin[15]=data_bus_0_w6_reg_scanout[15];

assign data_bus_0_w0_reg_scanin[14]=data_bus_0_w7_reg_scanout[15];
assign data_bus_0_w1_reg_scanin[14]=data_bus_0_w0_reg_scanout[14];
assign data_bus_0_w4_reg_scanin[14]=data_bus_0_w1_reg_scanout[14];
assign data_bus_0_w5_reg_scanin[14]=data_bus_0_w4_reg_scanout[14];
assign data_bus_0_w2_reg_scanin[14]=data_bus_0_w5_reg_scanout[14];
assign data_bus_0_w3_reg_scanin[14]=data_bus_0_w2_reg_scanout[14];
assign data_bus_0_w6_reg_scanin[14]=data_bus_0_w3_reg_scanout[14];
assign data_bus_0_w7_reg_scanin[14]=data_bus_0_w6_reg_scanout[14];

assign data_bus_0_w0_reg_scanin[13]=data_bus_0_w7_reg_scanout[14];
assign data_bus_0_w1_reg_scanin[13]=data_bus_0_w0_reg_scanout[13];
assign data_bus_0_w4_reg_scanin[13]=data_bus_0_w1_reg_scanout[13];
assign data_bus_0_w5_reg_scanin[13]=data_bus_0_w4_reg_scanout[13];
assign data_bus_0_w2_reg_scanin[13]=data_bus_0_w5_reg_scanout[13];
assign data_bus_0_w3_reg_scanin[13]=data_bus_0_w2_reg_scanout[13];
assign data_bus_0_w6_reg_scanin[13]=data_bus_0_w3_reg_scanout[13];
assign data_bus_0_w7_reg_scanin[13]=data_bus_0_w6_reg_scanout[13];

assign data_bus_0_w0_reg_scanin[12]=data_bus_0_w7_reg_scanout[13];
assign data_bus_0_w1_reg_scanin[12]=data_bus_0_w0_reg_scanout[12];
assign data_bus_0_w4_reg_scanin[12]=data_bus_0_w1_reg_scanout[12];
assign data_bus_0_w5_reg_scanin[12]=data_bus_0_w4_reg_scanout[12];
assign data_bus_0_w2_reg_scanin[12]=data_bus_0_w5_reg_scanout[12];
assign data_bus_0_w3_reg_scanin[12]=data_bus_0_w2_reg_scanout[12];
assign data_bus_0_w6_reg_scanin[12]=data_bus_0_w3_reg_scanout[12];
assign data_bus_0_w7_reg_scanin[12]=data_bus_0_w6_reg_scanout[12];

assign data_bus_0_w0_reg_scanin[11]=data_bus_0_w7_reg_scanout[12];
assign data_bus_0_w1_reg_scanin[11]=data_bus_0_w0_reg_scanout[11];
assign data_bus_0_w4_reg_scanin[11]=data_bus_0_w1_reg_scanout[11];
assign data_bus_0_w5_reg_scanin[11]=data_bus_0_w4_reg_scanout[11];
assign data_bus_0_w2_reg_scanin[11]=data_bus_0_w5_reg_scanout[11];
assign data_bus_0_w3_reg_scanin[11]=data_bus_0_w2_reg_scanout[11];
assign data_bus_0_w6_reg_scanin[11]=data_bus_0_w3_reg_scanout[11];
assign data_bus_0_w7_reg_scanin[11]=data_bus_0_w6_reg_scanout[11];

assign data_bus_0_w0_reg_scanin[10]=data_bus_0_w7_reg_scanout[11];
assign data_bus_0_w1_reg_scanin[10]=data_bus_0_w0_reg_scanout[10];
assign data_bus_0_w4_reg_scanin[10]=data_bus_0_w1_reg_scanout[10];
assign data_bus_0_w5_reg_scanin[10]=data_bus_0_w4_reg_scanout[10];
assign data_bus_0_w2_reg_scanin[10]=data_bus_0_w5_reg_scanout[10];
assign data_bus_0_w3_reg_scanin[10]=data_bus_0_w2_reg_scanout[10];
assign data_bus_0_w6_reg_scanin[10]=data_bus_0_w3_reg_scanout[10];
assign data_bus_0_w7_reg_scanin[10]=data_bus_0_w6_reg_scanout[10];

assign data_bus_0_w0_reg_scanin[9]=data_bus_0_w7_reg_scanout[10];
assign data_bus_0_w1_reg_scanin[9]=data_bus_0_w0_reg_scanout[9];
assign data_bus_0_w4_reg_scanin[9]=data_bus_0_w1_reg_scanout[9];
assign data_bus_0_w5_reg_scanin[9]=data_bus_0_w4_reg_scanout[9];
assign data_bus_0_w2_reg_scanin[9]=data_bus_0_w5_reg_scanout[9];
assign data_bus_0_w3_reg_scanin[9]=data_bus_0_w2_reg_scanout[9];
assign data_bus_0_w6_reg_scanin[9]=data_bus_0_w3_reg_scanout[9];
assign data_bus_0_w7_reg_scanin[9]=data_bus_0_w6_reg_scanout[9];

assign data_bus_0_w0_reg_scanin[8]=data_bus_0_w7_reg_scanout[9];
assign data_bus_0_w1_reg_scanin[8]=data_bus_0_w0_reg_scanout[8];
assign data_bus_0_w4_reg_scanin[8]=data_bus_0_w1_reg_scanout[8];
assign data_bus_0_w5_reg_scanin[8]=data_bus_0_w4_reg_scanout[8];
assign data_bus_0_w2_reg_scanin[8]=data_bus_0_w5_reg_scanout[8];
assign data_bus_0_w3_reg_scanin[8]=data_bus_0_w2_reg_scanout[8];
assign data_bus_0_w6_reg_scanin[8]=data_bus_0_w3_reg_scanout[8];
assign data_bus_0_w7_reg_scanin[8]=data_bus_0_w6_reg_scanout[8];

assign data_bus_0_w0_reg_scanin[7]=data_bus_0_w7_reg_scanout[8];
assign data_bus_0_w1_reg_scanin[7]=data_bus_0_w0_reg_scanout[7];
assign data_bus_0_w4_reg_scanin[7]=data_bus_0_w1_reg_scanout[7];
assign data_bus_0_w5_reg_scanin[7]=data_bus_0_w4_reg_scanout[7];
assign data_bus_0_w2_reg_scanin[7]=data_bus_0_w5_reg_scanout[7];
assign data_bus_0_w3_reg_scanin[7]=data_bus_0_w2_reg_scanout[7];
assign data_bus_0_w6_reg_scanin[7]=data_bus_0_w3_reg_scanout[7];
assign data_bus_0_w7_reg_scanin[7]=data_bus_0_w6_reg_scanout[7];

assign data_bus_0_w0_reg_scanin[6]=data_bus_0_w7_reg_scanout[7];
assign data_bus_0_w1_reg_scanin[6]=data_bus_0_w0_reg_scanout[6];
assign data_bus_0_w4_reg_scanin[6]=data_bus_0_w1_reg_scanout[6];
assign data_bus_0_w5_reg_scanin[6]=data_bus_0_w4_reg_scanout[6];
assign data_bus_0_w2_reg_scanin[6]=data_bus_0_w5_reg_scanout[6];
assign data_bus_0_w3_reg_scanin[6]=data_bus_0_w2_reg_scanout[6];
assign data_bus_0_w6_reg_scanin[6]=data_bus_0_w3_reg_scanout[6];
assign data_bus_0_w7_reg_scanin[6]=data_bus_0_w6_reg_scanout[6];

assign data_bus_0_w0_reg_scanin[5]=data_bus_0_w7_reg_scanout[6];
assign data_bus_0_w1_reg_scanin[5]=data_bus_0_w0_reg_scanout[5];
assign data_bus_0_w4_reg_scanin[5]=data_bus_0_w1_reg_scanout[5];
assign data_bus_0_w5_reg_scanin[5]=data_bus_0_w4_reg_scanout[5];
assign data_bus_0_w2_reg_scanin[5]=data_bus_0_w5_reg_scanout[5];
assign data_bus_0_w3_reg_scanin[5]=data_bus_0_w2_reg_scanout[5];
assign data_bus_0_w6_reg_scanin[5]=data_bus_0_w3_reg_scanout[5];
assign data_bus_0_w7_reg_scanin[5]=data_bus_0_w6_reg_scanout[5];

assign data_bus_0_w0_reg_scanin[4]=data_bus_0_w7_reg_scanout[5];
assign data_bus_0_w1_reg_scanin[4]=data_bus_0_w0_reg_scanout[4];
assign data_bus_0_w4_reg_scanin[4]=data_bus_0_w1_reg_scanout[4];
assign data_bus_0_w5_reg_scanin[4]=data_bus_0_w4_reg_scanout[4];
assign data_bus_0_w2_reg_scanin[4]=data_bus_0_w5_reg_scanout[4];
assign data_bus_0_w3_reg_scanin[4]=data_bus_0_w2_reg_scanout[4];
assign data_bus_0_w6_reg_scanin[4]=data_bus_0_w3_reg_scanout[4];
assign data_bus_0_w7_reg_scanin[4]=data_bus_0_w6_reg_scanout[4];

assign data_bus_0_w0_reg_scanin[3]=data_bus_0_w7_reg_scanout[4];
assign data_bus_0_w1_reg_scanin[3]=data_bus_0_w0_reg_scanout[3];
assign data_bus_0_w4_reg_scanin[3]=data_bus_0_w1_reg_scanout[3];
assign data_bus_0_w5_reg_scanin[3]=data_bus_0_w4_reg_scanout[3];
assign data_bus_0_w2_reg_scanin[3]=data_bus_0_w5_reg_scanout[3];
assign data_bus_0_w3_reg_scanin[3]=data_bus_0_w2_reg_scanout[3];
assign data_bus_0_w6_reg_scanin[3]=data_bus_0_w3_reg_scanout[3];
assign data_bus_0_w7_reg_scanin[3]=data_bus_0_w6_reg_scanout[3];

assign data_bus_0_w0_reg_scanin[2]=data_bus_0_w7_reg_scanout[3];
assign data_bus_0_w1_reg_scanin[2]=data_bus_0_w0_reg_scanout[2];
assign data_bus_0_w4_reg_scanin[2]=data_bus_0_w1_reg_scanout[2];
assign data_bus_0_w5_reg_scanin[2]=data_bus_0_w4_reg_scanout[2];
assign data_bus_0_w2_reg_scanin[2]=data_bus_0_w5_reg_scanout[2];
assign data_bus_0_w3_reg_scanin[2]=data_bus_0_w2_reg_scanout[2];
assign data_bus_0_w6_reg_scanin[2]=data_bus_0_w3_reg_scanout[2];
assign data_bus_0_w7_reg_scanin[2]=data_bus_0_w6_reg_scanout[2];

assign data_bus_0_w0_reg_scanin[1]=data_bus_0_w7_reg_scanout[2];
assign data_bus_0_w1_reg_scanin[1]=data_bus_0_w0_reg_scanout[1];
assign data_bus_0_w4_reg_scanin[1]=data_bus_0_w1_reg_scanout[1];
assign data_bus_0_w5_reg_scanin[1]=data_bus_0_w4_reg_scanout[1];
assign data_bus_0_w2_reg_scanin[1]=data_bus_0_w5_reg_scanout[1];
assign data_bus_0_w3_reg_scanin[1]=data_bus_0_w2_reg_scanout[1];
assign data_bus_0_w6_reg_scanin[1]=data_bus_0_w3_reg_scanout[1];
assign data_bus_0_w7_reg_scanin[1]=data_bus_0_w6_reg_scanout[1];

assign data_bus_0_w0_reg_scanin[0]=data_bus_0_w7_reg_scanout[1];
assign data_bus_0_w1_reg_scanin[0]=data_bus_0_w0_reg_scanout[0];
assign data_bus_0_w4_reg_scanin[0]=data_bus_0_w1_reg_scanout[0];
assign data_bus_0_w5_reg_scanin[0]=data_bus_0_w4_reg_scanout[0];
assign data_bus_0_w2_reg_scanin[0]=data_bus_0_w5_reg_scanout[0];
assign data_bus_0_w3_reg_scanin[0]=data_bus_0_w2_reg_scanout[0];
assign data_bus_0_w6_reg_scanin[0]=data_bus_0_w3_reg_scanout[0];
assign data_bus_0_w7_reg_scanin[0]=data_bus_0_w6_reg_scanout[0];


// ***************************END SECTION***************************

//////////////////////////
// Middle section scan  //   
//////////////////////////


assign red_en_reg_scanin[0] = data_bus_0_w7_reg_scanout[0];
assign red_en_reg_scanin[1] = red_en_reg_scanout[0];
assign red_en_out_reg_scanin[0] = red_en_reg_scanout[1];
assign red_en_out_reg_scanin[1] = red_en_out_reg_scanout[0];
assign red_arst_reg_scanin  =  red_en_out_reg_scanout[1];
assign red_wen_reg_scanin   =  red_arst_reg_scanout;
assign red_d_out_reg_scanin[0]  =  red_wen_reg_scanout;
assign red_d_out_reg_scanin[1]  =  red_d_out_reg_scanout[0];
assign red_d_out_reg_scanin[3]  =  red_d_out_reg_scanout[1];
assign red_d_out_reg_scanin[2]  =  red_d_out_reg_scanout[3];
assign red_d_out_reg_scanin[4]  =  red_d_out_reg_scanout[2];
assign rid_reg_scanin[1]    =  red_d_out_reg_scanout[4];
assign rid_reg_scanin[0]    =  rid_reg_scanout[1];
assign rid_reg_scanin[3]    =  rid_reg_scanout[0];
assign rid_reg_scanin[2]    =  rid_reg_scanout[3];
assign red_d_reg_scanin[0]  =  rid_reg_scanout[2];
assign red_d_reg_scanin[3]  =  red_d_reg_scanout[0];
assign red_d_reg_scanin[4]  =  red_d_reg_scanout[3];
assign red_d_reg_scanin[1]  =  red_d_reg_scanout[4];
assign red_d_reg_scanin[2]  =  red_d_reg_scanout[1];
assign quad_en_reg_scanin[2]= red_d_reg_scanout[2];   
assign quad_en_reg_scanin[0]= quad_en_reg_scanout[2]; 
assign index_reg_i_scanin    =  quad_en_reg_scanout[0] ;
assign way_f_reg_scanin[4]   =  index_reg_i_scanout ; 
assign way_f_reg_scanin[5]   =  way_f_reg_scanout[4] ; 
assign way_f_reg_scanin[6]   =  way_f_reg_scanout[5] ; 
assign way_f_reg_scanin[7]   =  way_f_reg_scanout[6] ; 
assign quad_en_1_latch_scanin = way_f_reg_scanout[7] ;
assign quad_en_0_latch_scanin = quad_en_1_latch_scanout ;  
assign wr_word_en_5_reg_scanin =  quad_en_0_latch_scanout ; 
assign wr_word_en_1_reg_scanin =  wr_word_en_5_reg_scanout ;
assign wr_word_en_0_reg_scanin =  wr_word_en_1_reg_scanout ;
assign wr_word_en_4_reg_scanin =  wr_word_en_0_reg_scanout ;
assign wr_word_en_6_reg_scanin =  wr_word_en_4_reg_scanout ;
assign wr_word_en_2_reg_scanin =  wr_word_en_6_reg_scanout ;
assign wr_word_en_7_reg_scanin =  wr_word_en_2_reg_scanout ;
assign wr_word_en_3_reg_scanin =  wr_word_en_7_reg_scanout ;
assign quad_en_3_latch_scanin = wr_word_en_3_reg_scanout ;  
assign quad_en_2_latch_scanin = quad_en_3_latch_scanout ;  
assign way_f_reg_scanin[0]   =  quad_en_2_latch_scanout ; 
assign way_f_reg_scanin[1]   =  way_f_reg_scanout[0] ;     
assign way_f_reg_scanin[2]   =  way_f_reg_scanout[1] ;     
assign way_f_reg_scanin[3]   =  way_f_reg_scanout[2] ;     
assign wrway_0_reg_scanin      =  way_f_reg_scanout[3] ;
assign wrway_1_reg_scanin      =  wrway_0_reg_scanout ;
assign wrway_2_reg_scanin      =  wrway_1_reg_scanout ;
assign wrreq_reg_scanin      =  wrway_2_reg_scanout    ;
assign rdreq_reg_scanin      =  wrreq_reg_scanout    ;
assign quad_en_reg_scanin[3]= rdreq_reg_scanout   ;   
assign quad_en_reg_scanin[1]= quad_en_reg_scanout[3]; 
assign rdreq_reg_b_scanin    =  quad_en_reg_scanout[1]    ;
assign wrreq_reg_b_scanin    =  rdreq_reg_b_scanout  ;
assign way_c_reg_scanin[7]   =  wrreq_reg_b_scanout  ; 
assign way_c_reg_scanin[6]   =  way_c_reg_scanout[7] ; 
assign way_c_reg_scanin[5]   =  way_c_reg_scanout[6] ; 
assign way_c_reg_scanin[4]   =  way_c_reg_scanout[5] ; 
assign way_c_reg_scanin[3]   =  way_c_reg_scanout[4] ; 
assign way_c_reg_scanin[2]   =  way_c_reg_scanout[3] ; 
assign way_c_reg_scanin[1]   =  way_c_reg_scanout[2] ; 
assign way_c_reg_scanin[0]   =  way_c_reg_scanout[1] ; 



/////// end of middle section                 ///////////////////

assign wrdata_q3_7_scanin[32]=way_c_reg_scanout[0];
assign wrdata_q3_3_scanin[32]=wrdata_q3_7_scanout[32];
assign wrdata_q3_7_scanin[31]=wrdata_q3_3_scanout[32];
assign wrdata_q3_3_scanin[31]=wrdata_q3_7_scanout[31];
assign wrdata_q3_7_scanin[30]=wrdata_q3_3_scanout[31];
assign wrdata_q3_3_scanin[30]=wrdata_q3_7_scanout[30];
assign wrdata_q3_7_scanin[29]=wrdata_q3_3_scanout[30];
assign wrdata_q3_3_scanin[29]=wrdata_q3_7_scanout[29];
assign wrdata_q3_7_scanin[28]=wrdata_q3_3_scanout[29];
assign wrdata_q3_3_scanin[28]=wrdata_q3_7_scanout[28];
assign wrdata_q3_7_scanin[27]=wrdata_q3_3_scanout[28];
assign wrdata_q3_3_scanin[27]=wrdata_q3_7_scanout[27];
assign wrdata_q3_7_scanin[26]=wrdata_q3_3_scanout[27];
assign wrdata_q3_3_scanin[26]=wrdata_q3_7_scanout[26];
assign wrdata_q3_7_scanin[25]=wrdata_q3_3_scanout[26];
assign wrdata_q3_3_scanin[25]=wrdata_q3_7_scanout[25];
assign wrdata_q3_7_scanin[24]=wrdata_q3_3_scanout[25];
assign wrdata_q3_3_scanin[24]=wrdata_q3_7_scanout[24];
assign wrdata_q3_7_scanin[23]=wrdata_q3_3_scanout[24];
assign wrdata_q3_3_scanin[23]=wrdata_q3_7_scanout[23];
assign wrdata_q3_7_scanin[22]=wrdata_q3_3_scanout[23];
assign wrdata_q3_3_scanin[22]=wrdata_q3_7_scanout[22];
assign wrdata_q3_7_scanin[21]=wrdata_q3_3_scanout[22];
assign wrdata_q3_3_scanin[21]=wrdata_q3_7_scanout[21];
assign wrdata_q3_7_scanin[20]=wrdata_q3_3_scanout[21];
assign wrdata_q3_3_scanin[20]=wrdata_q3_7_scanout[20];
assign wrdata_q3_7_scanin[19]=wrdata_q3_3_scanout[20];
assign wrdata_q3_3_scanin[19]=wrdata_q3_7_scanout[19];
assign wrdata_q3_7_scanin[18]=wrdata_q3_3_scanout[19];
assign wrdata_q3_3_scanin[18]=wrdata_q3_7_scanout[18];
assign wrdata_q3_7_scanin[17]=wrdata_q3_3_scanout[18];
assign wrdata_q3_3_scanin[17]=wrdata_q3_7_scanout[17];
assign wrdata_q3_7_scanin[16]=wrdata_q3_3_scanout[17];
assign wrdata_q3_3_scanin[16]=wrdata_q3_7_scanout[16];
assign wrdata_q3_7_scanin[15]=wrdata_q3_3_scanout[16];
assign wrdata_q3_3_scanin[15]=wrdata_q3_7_scanout[15];
assign wrdata_q3_7_scanin[14]=wrdata_q3_3_scanout[15];
assign wrdata_q3_3_scanin[14]=wrdata_q3_7_scanout[14];
assign wrdata_q3_7_scanin[13]=wrdata_q3_3_scanout[14];
assign wrdata_q3_3_scanin[13]=wrdata_q3_7_scanout[13];
assign wrdata_q3_7_scanin[12]=wrdata_q3_3_scanout[13];
assign wrdata_q3_3_scanin[12]=wrdata_q3_7_scanout[12];
assign wrdata_q3_7_scanin[11]=wrdata_q3_3_scanout[12];
assign wrdata_q3_3_scanin[11]=wrdata_q3_7_scanout[11];
assign wrdata_q3_7_scanin[10]=wrdata_q3_3_scanout[11];
assign wrdata_q3_3_scanin[10]=wrdata_q3_7_scanout[10];
assign wrdata_q3_7_scanin[9]=wrdata_q3_3_scanout[10];
assign wrdata_q3_3_scanin[9]=wrdata_q3_7_scanout[9];
assign wrdata_q3_7_scanin[8]=wrdata_q3_3_scanout[9];
assign wrdata_q3_3_scanin[8]=wrdata_q3_7_scanout[8];
assign wrdata_q3_7_scanin[7]=wrdata_q3_3_scanout[8];
assign wrdata_q3_3_scanin[7]=wrdata_q3_7_scanout[7];
assign wrdata_q3_7_scanin[6]=wrdata_q3_3_scanout[7];
assign wrdata_q3_3_scanin[6]=wrdata_q3_7_scanout[6];
assign wrdata_q3_7_scanin[5]=wrdata_q3_3_scanout[6];
assign wrdata_q3_3_scanin[5]=wrdata_q3_7_scanout[5];
assign wrdata_q3_7_scanin[4]=wrdata_q3_3_scanout[5];
assign wrdata_q3_3_scanin[4]=wrdata_q3_7_scanout[4];
assign wrdata_q3_7_scanin[3]=wrdata_q3_3_scanout[4];
assign wrdata_q3_3_scanin[3]=wrdata_q3_7_scanout[3];
assign wrdata_q3_7_scanin[2]=wrdata_q3_3_scanout[3];
assign wrdata_q3_3_scanin[2]=wrdata_q3_7_scanout[2];
assign wrdata_q3_7_scanin[1]=wrdata_q3_3_scanout[2];
assign wrdata_q3_3_scanin[1]=wrdata_q3_7_scanout[1];
assign wrdata_q3_7_scanin[0]=wrdata_q3_3_scanout[1];
assign wrdata_q3_3_scanin[0]=wrdata_q3_7_scanout[0];

// ***************************BEGIN SECTION*************************

assign data_bus_3_w2_reg_scanin[32]=wrdata_q3_3_scanout[0];
assign data_bus_3_w3_reg_scanin[32]=data_bus_3_w2_reg_scanout[32];
assign data_bus_3_w6_reg_scanin[32]=data_bus_3_w3_reg_scanout[32];
assign data_bus_3_w7_reg_scanin[32]=data_bus_3_w6_reg_scanout[32];
assign data_bus_3_w0_reg_scanin[32]=data_bus_3_w7_reg_scanout[32];
assign data_bus_3_w1_reg_scanin[32]=data_bus_3_w0_reg_scanout[32];
assign data_bus_3_w4_reg_scanin[32]=data_bus_3_w1_reg_scanout[32];
assign data_bus_3_w5_reg_scanin[32]=data_bus_3_w4_reg_scanout[32];

assign data_bus_3_w2_reg_scanin[31]=data_bus_3_w5_reg_scanout[32];
assign data_bus_3_w3_reg_scanin[31]=data_bus_3_w2_reg_scanout[31];
assign data_bus_3_w6_reg_scanin[31]=data_bus_3_w3_reg_scanout[31];
assign data_bus_3_w7_reg_scanin[31]=data_bus_3_w6_reg_scanout[31];
assign data_bus_3_w0_reg_scanin[31]=data_bus_3_w7_reg_scanout[31];
assign data_bus_3_w1_reg_scanin[31]=data_bus_3_w0_reg_scanout[31];
assign data_bus_3_w4_reg_scanin[31]=data_bus_3_w1_reg_scanout[31];
assign data_bus_3_w5_reg_scanin[31]=data_bus_3_w4_reg_scanout[31];

assign data_bus_3_w2_reg_scanin[30]=data_bus_3_w5_reg_scanout[31];
assign data_bus_3_w3_reg_scanin[30]=data_bus_3_w2_reg_scanout[30];
assign data_bus_3_w6_reg_scanin[30]=data_bus_3_w3_reg_scanout[30];
assign data_bus_3_w7_reg_scanin[30]=data_bus_3_w6_reg_scanout[30];
assign data_bus_3_w0_reg_scanin[30]=data_bus_3_w7_reg_scanout[30];
assign data_bus_3_w1_reg_scanin[30]=data_bus_3_w0_reg_scanout[30];
assign data_bus_3_w4_reg_scanin[30]=data_bus_3_w1_reg_scanout[30];
assign data_bus_3_w5_reg_scanin[30]=data_bus_3_w4_reg_scanout[30];

assign data_bus_3_w2_reg_scanin[29]=data_bus_3_w5_reg_scanout[30];
assign data_bus_3_w3_reg_scanin[29]=data_bus_3_w2_reg_scanout[29];
assign data_bus_3_w6_reg_scanin[29]=data_bus_3_w3_reg_scanout[29];
assign data_bus_3_w7_reg_scanin[29]=data_bus_3_w6_reg_scanout[29];
assign data_bus_3_w0_reg_scanin[29]=data_bus_3_w7_reg_scanout[29];
assign data_bus_3_w1_reg_scanin[29]=data_bus_3_w0_reg_scanout[29];
assign data_bus_3_w4_reg_scanin[29]=data_bus_3_w1_reg_scanout[29];
assign data_bus_3_w5_reg_scanin[29]=data_bus_3_w4_reg_scanout[29];

assign data_bus_3_w2_reg_scanin[28]=data_bus_3_w5_reg_scanout[29];
assign data_bus_3_w3_reg_scanin[28]=data_bus_3_w2_reg_scanout[28];
assign data_bus_3_w6_reg_scanin[28]=data_bus_3_w3_reg_scanout[28];
assign data_bus_3_w7_reg_scanin[28]=data_bus_3_w6_reg_scanout[28];
assign data_bus_3_w0_reg_scanin[28]=data_bus_3_w7_reg_scanout[28];
assign data_bus_3_w1_reg_scanin[28]=data_bus_3_w0_reg_scanout[28];
assign data_bus_3_w4_reg_scanin[28]=data_bus_3_w1_reg_scanout[28];
assign data_bus_3_w5_reg_scanin[28]=data_bus_3_w4_reg_scanout[28];

assign data_bus_3_w2_reg_scanin[27]=data_bus_3_w5_reg_scanout[28];
assign data_bus_3_w3_reg_scanin[27]=data_bus_3_w2_reg_scanout[27];
assign data_bus_3_w6_reg_scanin[27]=data_bus_3_w3_reg_scanout[27];
assign data_bus_3_w7_reg_scanin[27]=data_bus_3_w6_reg_scanout[27];
assign data_bus_3_w0_reg_scanin[27]=data_bus_3_w7_reg_scanout[27];
assign data_bus_3_w1_reg_scanin[27]=data_bus_3_w0_reg_scanout[27];
assign data_bus_3_w4_reg_scanin[27]=data_bus_3_w1_reg_scanout[27];
assign data_bus_3_w5_reg_scanin[27]=data_bus_3_w4_reg_scanout[27];

assign data_bus_3_w2_reg_scanin[26]=data_bus_3_w5_reg_scanout[27];
assign data_bus_3_w3_reg_scanin[26]=data_bus_3_w2_reg_scanout[26];
assign data_bus_3_w6_reg_scanin[26]=data_bus_3_w3_reg_scanout[26];
assign data_bus_3_w7_reg_scanin[26]=data_bus_3_w6_reg_scanout[26];
assign data_bus_3_w0_reg_scanin[26]=data_bus_3_w7_reg_scanout[26];
assign data_bus_3_w1_reg_scanin[26]=data_bus_3_w0_reg_scanout[26];
assign data_bus_3_w4_reg_scanin[26]=data_bus_3_w1_reg_scanout[26];
assign data_bus_3_w5_reg_scanin[26]=data_bus_3_w4_reg_scanout[26];

assign data_bus_3_w2_reg_scanin[25]=data_bus_3_w5_reg_scanout[26];
assign data_bus_3_w3_reg_scanin[25]=data_bus_3_w2_reg_scanout[25];
assign data_bus_3_w6_reg_scanin[25]=data_bus_3_w3_reg_scanout[25];
assign data_bus_3_w7_reg_scanin[25]=data_bus_3_w6_reg_scanout[25];
assign data_bus_3_w0_reg_scanin[25]=data_bus_3_w7_reg_scanout[25];
assign data_bus_3_w1_reg_scanin[25]=data_bus_3_w0_reg_scanout[25];
assign data_bus_3_w4_reg_scanin[25]=data_bus_3_w1_reg_scanout[25];
assign data_bus_3_w5_reg_scanin[25]=data_bus_3_w4_reg_scanout[25];

assign data_bus_3_w2_reg_scanin[24]=data_bus_3_w5_reg_scanout[25];
assign data_bus_3_w3_reg_scanin[24]=data_bus_3_w2_reg_scanout[24];
assign data_bus_3_w6_reg_scanin[24]=data_bus_3_w3_reg_scanout[24];
assign data_bus_3_w7_reg_scanin[24]=data_bus_3_w6_reg_scanout[24];
assign data_bus_3_w0_reg_scanin[24]=data_bus_3_w7_reg_scanout[24];
assign data_bus_3_w1_reg_scanin[24]=data_bus_3_w0_reg_scanout[24];
assign data_bus_3_w4_reg_scanin[24]=data_bus_3_w1_reg_scanout[24];
assign data_bus_3_w5_reg_scanin[24]=data_bus_3_w4_reg_scanout[24];

assign data_bus_3_w2_reg_scanin[23]=data_bus_3_w5_reg_scanout[24];
assign data_bus_3_w3_reg_scanin[23]=data_bus_3_w2_reg_scanout[23];
assign data_bus_3_w6_reg_scanin[23]=data_bus_3_w3_reg_scanout[23];
assign data_bus_3_w7_reg_scanin[23]=data_bus_3_w6_reg_scanout[23];
assign data_bus_3_w0_reg_scanin[23]=data_bus_3_w7_reg_scanout[23];
assign data_bus_3_w1_reg_scanin[23]=data_bus_3_w0_reg_scanout[23];
assign data_bus_3_w4_reg_scanin[23]=data_bus_3_w1_reg_scanout[23];
assign data_bus_3_w5_reg_scanin[23]=data_bus_3_w4_reg_scanout[23];

assign data_bus_3_w2_reg_scanin[22]=data_bus_3_w5_reg_scanout[23];
assign data_bus_3_w3_reg_scanin[22]=data_bus_3_w2_reg_scanout[22];
assign data_bus_3_w6_reg_scanin[22]=data_bus_3_w3_reg_scanout[22];
assign data_bus_3_w7_reg_scanin[22]=data_bus_3_w6_reg_scanout[22];
assign data_bus_3_w0_reg_scanin[22]=data_bus_3_w7_reg_scanout[22];
assign data_bus_3_w1_reg_scanin[22]=data_bus_3_w0_reg_scanout[22];
assign data_bus_3_w4_reg_scanin[22]=data_bus_3_w1_reg_scanout[22];
assign data_bus_3_w5_reg_scanin[22]=data_bus_3_w4_reg_scanout[22];

assign data_bus_3_w2_reg_scanin[21]=data_bus_3_w5_reg_scanout[22];
assign data_bus_3_w3_reg_scanin[21]=data_bus_3_w2_reg_scanout[21];
assign data_bus_3_w6_reg_scanin[21]=data_bus_3_w3_reg_scanout[21];
assign data_bus_3_w7_reg_scanin[21]=data_bus_3_w6_reg_scanout[21];
assign data_bus_3_w0_reg_scanin[21]=data_bus_3_w7_reg_scanout[21];
assign data_bus_3_w1_reg_scanin[21]=data_bus_3_w0_reg_scanout[21];
assign data_bus_3_w4_reg_scanin[21]=data_bus_3_w1_reg_scanout[21];
assign data_bus_3_w5_reg_scanin[21]=data_bus_3_w4_reg_scanout[21];

assign data_bus_3_w2_reg_scanin[20]=data_bus_3_w5_reg_scanout[21];
assign data_bus_3_w3_reg_scanin[20]=data_bus_3_w2_reg_scanout[20];
assign data_bus_3_w6_reg_scanin[20]=data_bus_3_w3_reg_scanout[20];
assign data_bus_3_w7_reg_scanin[20]=data_bus_3_w6_reg_scanout[20];
assign data_bus_3_w0_reg_scanin[20]=data_bus_3_w7_reg_scanout[20];
assign data_bus_3_w1_reg_scanin[20]=data_bus_3_w0_reg_scanout[20];
assign data_bus_3_w4_reg_scanin[20]=data_bus_3_w1_reg_scanout[20];
assign data_bus_3_w5_reg_scanin[20]=data_bus_3_w4_reg_scanout[20];

assign data_bus_3_w2_reg_scanin[19]=data_bus_3_w5_reg_scanout[20];
assign data_bus_3_w3_reg_scanin[19]=data_bus_3_w2_reg_scanout[19];
assign data_bus_3_w6_reg_scanin[19]=data_bus_3_w3_reg_scanout[19];
assign data_bus_3_w7_reg_scanin[19]=data_bus_3_w6_reg_scanout[19];
assign data_bus_3_w0_reg_scanin[19]=data_bus_3_w7_reg_scanout[19];
assign data_bus_3_w1_reg_scanin[19]=data_bus_3_w0_reg_scanout[19];
assign data_bus_3_w4_reg_scanin[19]=data_bus_3_w1_reg_scanout[19];
assign data_bus_3_w5_reg_scanin[19]=data_bus_3_w4_reg_scanout[19];

assign data_bus_3_w2_reg_scanin[18]=data_bus_3_w5_reg_scanout[19];
assign data_bus_3_w3_reg_scanin[18]=data_bus_3_w2_reg_scanout[18];
assign data_bus_3_w6_reg_scanin[18]=data_bus_3_w3_reg_scanout[18];
assign data_bus_3_w7_reg_scanin[18]=data_bus_3_w6_reg_scanout[18];
assign data_bus_3_w0_reg_scanin[18]=data_bus_3_w7_reg_scanout[18];
assign data_bus_3_w1_reg_scanin[18]=data_bus_3_w0_reg_scanout[18];
assign data_bus_3_w4_reg_scanin[18]=data_bus_3_w1_reg_scanout[18];
assign data_bus_3_w5_reg_scanin[18]=data_bus_3_w4_reg_scanout[18];

assign data_bus_3_w2_reg_scanin[17]=data_bus_3_w5_reg_scanout[18];
assign data_bus_3_w3_reg_scanin[17]=data_bus_3_w2_reg_scanout[17];
assign data_bus_3_w6_reg_scanin[17]=data_bus_3_w3_reg_scanout[17];
assign data_bus_3_w7_reg_scanin[17]=data_bus_3_w6_reg_scanout[17];
assign data_bus_3_w0_reg_scanin[17]=data_bus_3_w7_reg_scanout[17];
assign data_bus_3_w1_reg_scanin[17]=data_bus_3_w0_reg_scanout[17];
assign data_bus_3_w4_reg_scanin[17]=data_bus_3_w1_reg_scanout[17];
assign data_bus_3_w5_reg_scanin[17]=data_bus_3_w4_reg_scanout[17];

assign data_bus_3_w0_reg_scanin[16]=data_bus_3_w5_reg_scanout[17];
assign data_bus_3_w1_reg_scanin[16]=data_bus_3_w0_reg_scanout[16];
assign data_bus_3_w4_reg_scanin[16]=data_bus_3_w1_reg_scanout[16];
assign data_bus_3_w5_reg_scanin[16]=data_bus_3_w4_reg_scanout[16];
assign data_bus_3_w2_reg_scanin[16]=data_bus_3_w5_reg_scanout[16];
assign data_bus_3_w3_reg_scanin[16]=data_bus_3_w2_reg_scanout[16];
assign data_bus_3_w6_reg_scanin[16]=data_bus_3_w3_reg_scanout[16];
assign data_bus_3_w7_reg_scanin[16]=data_bus_3_w6_reg_scanout[16];

assign data_bus_3_w0_reg_scanin[15]=data_bus_3_w7_reg_scanout[16];
assign data_bus_3_w1_reg_scanin[15]=data_bus_3_w0_reg_scanout[15];
assign data_bus_3_w4_reg_scanin[15]=data_bus_3_w1_reg_scanout[15];
assign data_bus_3_w5_reg_scanin[15]=data_bus_3_w4_reg_scanout[15];
assign data_bus_3_w2_reg_scanin[15]=data_bus_3_w5_reg_scanout[15];
assign data_bus_3_w3_reg_scanin[15]=data_bus_3_w2_reg_scanout[15];
assign data_bus_3_w6_reg_scanin[15]=data_bus_3_w3_reg_scanout[15];
assign data_bus_3_w7_reg_scanin[15]=data_bus_3_w6_reg_scanout[15];

assign data_bus_3_w0_reg_scanin[14]=data_bus_3_w7_reg_scanout[15];
assign data_bus_3_w1_reg_scanin[14]=data_bus_3_w0_reg_scanout[14];
assign data_bus_3_w4_reg_scanin[14]=data_bus_3_w1_reg_scanout[14];
assign data_bus_3_w5_reg_scanin[14]=data_bus_3_w4_reg_scanout[14];
assign data_bus_3_w2_reg_scanin[14]=data_bus_3_w5_reg_scanout[14];
assign data_bus_3_w3_reg_scanin[14]=data_bus_3_w2_reg_scanout[14];
assign data_bus_3_w6_reg_scanin[14]=data_bus_3_w3_reg_scanout[14];
assign data_bus_3_w7_reg_scanin[14]=data_bus_3_w6_reg_scanout[14];

assign data_bus_3_w0_reg_scanin[13]=data_bus_3_w7_reg_scanout[14];
assign data_bus_3_w1_reg_scanin[13]=data_bus_3_w0_reg_scanout[13];
assign data_bus_3_w4_reg_scanin[13]=data_bus_3_w1_reg_scanout[13];
assign data_bus_3_w5_reg_scanin[13]=data_bus_3_w4_reg_scanout[13];
assign data_bus_3_w2_reg_scanin[13]=data_bus_3_w5_reg_scanout[13];
assign data_bus_3_w3_reg_scanin[13]=data_bus_3_w2_reg_scanout[13];
assign data_bus_3_w6_reg_scanin[13]=data_bus_3_w3_reg_scanout[13];
assign data_bus_3_w7_reg_scanin[13]=data_bus_3_w6_reg_scanout[13];

assign data_bus_3_w0_reg_scanin[12]=data_bus_3_w7_reg_scanout[13];
assign data_bus_3_w1_reg_scanin[12]=data_bus_3_w0_reg_scanout[12];
assign data_bus_3_w4_reg_scanin[12]=data_bus_3_w1_reg_scanout[12];
assign data_bus_3_w5_reg_scanin[12]=data_bus_3_w4_reg_scanout[12];
assign data_bus_3_w2_reg_scanin[12]=data_bus_3_w5_reg_scanout[12];
assign data_bus_3_w3_reg_scanin[12]=data_bus_3_w2_reg_scanout[12];
assign data_bus_3_w6_reg_scanin[12]=data_bus_3_w3_reg_scanout[12];
assign data_bus_3_w7_reg_scanin[12]=data_bus_3_w6_reg_scanout[12];

assign data_bus_3_w0_reg_scanin[11]=data_bus_3_w7_reg_scanout[12];
assign data_bus_3_w1_reg_scanin[11]=data_bus_3_w0_reg_scanout[11];
assign data_bus_3_w4_reg_scanin[11]=data_bus_3_w1_reg_scanout[11];
assign data_bus_3_w5_reg_scanin[11]=data_bus_3_w4_reg_scanout[11];
assign data_bus_3_w2_reg_scanin[11]=data_bus_3_w5_reg_scanout[11];
assign data_bus_3_w3_reg_scanin[11]=data_bus_3_w2_reg_scanout[11];
assign data_bus_3_w6_reg_scanin[11]=data_bus_3_w3_reg_scanout[11];
assign data_bus_3_w7_reg_scanin[11]=data_bus_3_w6_reg_scanout[11];

assign data_bus_3_w0_reg_scanin[10]=data_bus_3_w7_reg_scanout[11];
assign data_bus_3_w1_reg_scanin[10]=data_bus_3_w0_reg_scanout[10];
assign data_bus_3_w4_reg_scanin[10]=data_bus_3_w1_reg_scanout[10];
assign data_bus_3_w5_reg_scanin[10]=data_bus_3_w4_reg_scanout[10];
assign data_bus_3_w2_reg_scanin[10]=data_bus_3_w5_reg_scanout[10];
assign data_bus_3_w3_reg_scanin[10]=data_bus_3_w2_reg_scanout[10];
assign data_bus_3_w6_reg_scanin[10]=data_bus_3_w3_reg_scanout[10];
assign data_bus_3_w7_reg_scanin[10]=data_bus_3_w6_reg_scanout[10];

assign data_bus_3_w0_reg_scanin[9]=data_bus_3_w7_reg_scanout[10];
assign data_bus_3_w1_reg_scanin[9]=data_bus_3_w0_reg_scanout[9];
assign data_bus_3_w4_reg_scanin[9]=data_bus_3_w1_reg_scanout[9];
assign data_bus_3_w5_reg_scanin[9]=data_bus_3_w4_reg_scanout[9];
assign data_bus_3_w2_reg_scanin[9]=data_bus_3_w5_reg_scanout[9];
assign data_bus_3_w3_reg_scanin[9]=data_bus_3_w2_reg_scanout[9];
assign data_bus_3_w6_reg_scanin[9]=data_bus_3_w3_reg_scanout[9];
assign data_bus_3_w7_reg_scanin[9]=data_bus_3_w6_reg_scanout[9];

assign data_bus_3_w0_reg_scanin[8]=data_bus_3_w7_reg_scanout[9];
assign data_bus_3_w1_reg_scanin[8]=data_bus_3_w0_reg_scanout[8];
assign data_bus_3_w4_reg_scanin[8]=data_bus_3_w1_reg_scanout[8];
assign data_bus_3_w5_reg_scanin[8]=data_bus_3_w4_reg_scanout[8];
assign data_bus_3_w2_reg_scanin[8]=data_bus_3_w5_reg_scanout[8];
assign data_bus_3_w3_reg_scanin[8]=data_bus_3_w2_reg_scanout[8];
assign data_bus_3_w6_reg_scanin[8]=data_bus_3_w3_reg_scanout[8];
assign data_bus_3_w7_reg_scanin[8]=data_bus_3_w6_reg_scanout[8];

assign data_bus_3_w0_reg_scanin[7]=data_bus_3_w7_reg_scanout[8];
assign data_bus_3_w1_reg_scanin[7]=data_bus_3_w0_reg_scanout[7];
assign data_bus_3_w4_reg_scanin[7]=data_bus_3_w1_reg_scanout[7];
assign data_bus_3_w5_reg_scanin[7]=data_bus_3_w4_reg_scanout[7];
assign data_bus_3_w2_reg_scanin[7]=data_bus_3_w5_reg_scanout[7];
assign data_bus_3_w3_reg_scanin[7]=data_bus_3_w2_reg_scanout[7];
assign data_bus_3_w6_reg_scanin[7]=data_bus_3_w3_reg_scanout[7];
assign data_bus_3_w7_reg_scanin[7]=data_bus_3_w6_reg_scanout[7];

assign data_bus_3_w0_reg_scanin[6]=data_bus_3_w7_reg_scanout[7];
assign data_bus_3_w1_reg_scanin[6]=data_bus_3_w0_reg_scanout[6];
assign data_bus_3_w4_reg_scanin[6]=data_bus_3_w1_reg_scanout[6];
assign data_bus_3_w5_reg_scanin[6]=data_bus_3_w4_reg_scanout[6];
assign data_bus_3_w2_reg_scanin[6]=data_bus_3_w5_reg_scanout[6];
assign data_bus_3_w3_reg_scanin[6]=data_bus_3_w2_reg_scanout[6];
assign data_bus_3_w6_reg_scanin[6]=data_bus_3_w3_reg_scanout[6];
assign data_bus_3_w7_reg_scanin[6]=data_bus_3_w6_reg_scanout[6];

assign data_bus_3_w0_reg_scanin[5]=data_bus_3_w7_reg_scanout[6];
assign data_bus_3_w1_reg_scanin[5]=data_bus_3_w0_reg_scanout[5];
assign data_bus_3_w4_reg_scanin[5]=data_bus_3_w1_reg_scanout[5];
assign data_bus_3_w5_reg_scanin[5]=data_bus_3_w4_reg_scanout[5];
assign data_bus_3_w2_reg_scanin[5]=data_bus_3_w5_reg_scanout[5];
assign data_bus_3_w3_reg_scanin[5]=data_bus_3_w2_reg_scanout[5];
assign data_bus_3_w6_reg_scanin[5]=data_bus_3_w3_reg_scanout[5];
assign data_bus_3_w7_reg_scanin[5]=data_bus_3_w6_reg_scanout[5];

assign data_bus_3_w0_reg_scanin[4]=data_bus_3_w7_reg_scanout[5];
assign data_bus_3_w1_reg_scanin[4]=data_bus_3_w0_reg_scanout[4];
assign data_bus_3_w4_reg_scanin[4]=data_bus_3_w1_reg_scanout[4];
assign data_bus_3_w5_reg_scanin[4]=data_bus_3_w4_reg_scanout[4];
assign data_bus_3_w2_reg_scanin[4]=data_bus_3_w5_reg_scanout[4];
assign data_bus_3_w3_reg_scanin[4]=data_bus_3_w2_reg_scanout[4];
assign data_bus_3_w6_reg_scanin[4]=data_bus_3_w3_reg_scanout[4];
assign data_bus_3_w7_reg_scanin[4]=data_bus_3_w6_reg_scanout[4];

assign data_bus_3_w0_reg_scanin[3]=data_bus_3_w7_reg_scanout[4];
assign data_bus_3_w1_reg_scanin[3]=data_bus_3_w0_reg_scanout[3];
assign data_bus_3_w4_reg_scanin[3]=data_bus_3_w1_reg_scanout[3];
assign data_bus_3_w5_reg_scanin[3]=data_bus_3_w4_reg_scanout[3];
assign data_bus_3_w2_reg_scanin[3]=data_bus_3_w5_reg_scanout[3];
assign data_bus_3_w3_reg_scanin[3]=data_bus_3_w2_reg_scanout[3];
assign data_bus_3_w6_reg_scanin[3]=data_bus_3_w3_reg_scanout[3];
assign data_bus_3_w7_reg_scanin[3]=data_bus_3_w6_reg_scanout[3];

assign data_bus_3_w0_reg_scanin[2]=data_bus_3_w7_reg_scanout[3];
assign data_bus_3_w1_reg_scanin[2]=data_bus_3_w0_reg_scanout[2];
assign data_bus_3_w4_reg_scanin[2]=data_bus_3_w1_reg_scanout[2];
assign data_bus_3_w5_reg_scanin[2]=data_bus_3_w4_reg_scanout[2];
assign data_bus_3_w2_reg_scanin[2]=data_bus_3_w5_reg_scanout[2];
assign data_bus_3_w3_reg_scanin[2]=data_bus_3_w2_reg_scanout[2];
assign data_bus_3_w6_reg_scanin[2]=data_bus_3_w3_reg_scanout[2];
assign data_bus_3_w7_reg_scanin[2]=data_bus_3_w6_reg_scanout[2];

assign data_bus_3_w0_reg_scanin[1]=data_bus_3_w7_reg_scanout[2];
assign data_bus_3_w1_reg_scanin[1]=data_bus_3_w0_reg_scanout[1];
assign data_bus_3_w4_reg_scanin[1]=data_bus_3_w1_reg_scanout[1];
assign data_bus_3_w5_reg_scanin[1]=data_bus_3_w4_reg_scanout[1];
assign data_bus_3_w2_reg_scanin[1]=data_bus_3_w5_reg_scanout[1];
assign data_bus_3_w3_reg_scanin[1]=data_bus_3_w2_reg_scanout[1];
assign data_bus_3_w6_reg_scanin[1]=data_bus_3_w3_reg_scanout[1];
assign data_bus_3_w7_reg_scanin[1]=data_bus_3_w6_reg_scanout[1];

assign data_bus_3_w0_reg_scanin[0]=data_bus_3_w7_reg_scanout[1];
assign data_bus_3_w1_reg_scanin[0]=data_bus_3_w0_reg_scanout[0];
assign data_bus_3_w4_reg_scanin[0]=data_bus_3_w1_reg_scanout[0];
assign data_bus_3_w5_reg_scanin[0]=data_bus_3_w4_reg_scanout[0];
assign data_bus_3_w2_reg_scanin[0]=data_bus_3_w5_reg_scanout[0];
assign data_bus_3_w3_reg_scanin[0]=data_bus_3_w2_reg_scanout[0];
assign data_bus_3_w6_reg_scanin[0]=data_bus_3_w3_reg_scanout[0];
assign data_bus_3_w7_reg_scanin[0]=data_bus_3_w6_reg_scanout[0];


// ***************************END SECTION***************************
assign wrdata_q2_6_scanin[32]=data_bus_3_w7_reg_scanout[0];
assign wrdata_q2_2_scanin[32]=wrdata_q2_6_scanout[32];
assign wrdata_q2_6_scanin[31]=wrdata_q2_2_scanout[32];
assign wrdata_q2_2_scanin[31]=wrdata_q2_6_scanout[31];
assign wrdata_q2_6_scanin[30]=wrdata_q2_2_scanout[31];
assign wrdata_q2_2_scanin[30]=wrdata_q2_6_scanout[30];
assign wrdata_q2_6_scanin[29]=wrdata_q2_2_scanout[30];
assign wrdata_q2_2_scanin[29]=wrdata_q2_6_scanout[29];
assign wrdata_q2_6_scanin[28]=wrdata_q2_2_scanout[29];
assign wrdata_q2_2_scanin[28]=wrdata_q2_6_scanout[28];
assign wrdata_q2_6_scanin[27]=wrdata_q2_2_scanout[28];
assign wrdata_q2_2_scanin[27]=wrdata_q2_6_scanout[27];
assign wrdata_q2_6_scanin[26]=wrdata_q2_2_scanout[27];
assign wrdata_q2_2_scanin[26]=wrdata_q2_6_scanout[26];
assign wrdata_q2_6_scanin[25]=wrdata_q2_2_scanout[26];
assign wrdata_q2_2_scanin[25]=wrdata_q2_6_scanout[25];
assign wrdata_q2_6_scanin[24]=wrdata_q2_2_scanout[25];
assign wrdata_q2_2_scanin[24]=wrdata_q2_6_scanout[24];
assign wrdata_q2_6_scanin[23]=wrdata_q2_2_scanout[24];
assign wrdata_q2_2_scanin[23]=wrdata_q2_6_scanout[23];
assign wrdata_q2_6_scanin[22]=wrdata_q2_2_scanout[23];
assign wrdata_q2_2_scanin[22]=wrdata_q2_6_scanout[22];
assign wrdata_q2_6_scanin[21]=wrdata_q2_2_scanout[22];
assign wrdata_q2_2_scanin[21]=wrdata_q2_6_scanout[21];
assign wrdata_q2_6_scanin[20]=wrdata_q2_2_scanout[21];
assign wrdata_q2_2_scanin[20]=wrdata_q2_6_scanout[20];
assign wrdata_q2_6_scanin[19]=wrdata_q2_2_scanout[20];
assign wrdata_q2_2_scanin[19]=wrdata_q2_6_scanout[19];
assign wrdata_q2_6_scanin[18]=wrdata_q2_2_scanout[19];
assign wrdata_q2_2_scanin[18]=wrdata_q2_6_scanout[18];
assign wrdata_q2_6_scanin[17]=wrdata_q2_2_scanout[18];
assign wrdata_q2_2_scanin[17]=wrdata_q2_6_scanout[17];
assign wrdata_q2_6_scanin[16]=wrdata_q2_2_scanout[17];
assign wrdata_q2_2_scanin[16]=wrdata_q2_6_scanout[16];
assign wrdata_q2_6_scanin[15]=wrdata_q2_2_scanout[16];
assign wrdata_q2_2_scanin[15]=wrdata_q2_6_scanout[15];
assign wrdata_q2_6_scanin[14]=wrdata_q2_2_scanout[15];
assign wrdata_q2_2_scanin[14]=wrdata_q2_6_scanout[14];
assign wrdata_q2_6_scanin[13]=wrdata_q2_2_scanout[14];
assign wrdata_q2_2_scanin[13]=wrdata_q2_6_scanout[13];
assign wrdata_q2_6_scanin[12]=wrdata_q2_2_scanout[13];
assign wrdata_q2_2_scanin[12]=wrdata_q2_6_scanout[12];
assign wrdata_q2_6_scanin[11]=wrdata_q2_2_scanout[12];
assign wrdata_q2_2_scanin[11]=wrdata_q2_6_scanout[11];
assign wrdata_q2_6_scanin[10]=wrdata_q2_2_scanout[11];
assign wrdata_q2_2_scanin[10]=wrdata_q2_6_scanout[10];
assign wrdata_q2_6_scanin[9]=wrdata_q2_2_scanout[10];
assign wrdata_q2_2_scanin[9]=wrdata_q2_6_scanout[9];
assign wrdata_q2_6_scanin[8]=wrdata_q2_2_scanout[9];
assign wrdata_q2_2_scanin[8]=wrdata_q2_6_scanout[8];
assign wrdata_q2_6_scanin[7]=wrdata_q2_2_scanout[8];
assign wrdata_q2_2_scanin[7]=wrdata_q2_6_scanout[7];
assign wrdata_q2_6_scanin[6]=wrdata_q2_2_scanout[7];
assign wrdata_q2_2_scanin[6]=wrdata_q2_6_scanout[6];
assign wrdata_q2_6_scanin[5]=wrdata_q2_2_scanout[6];
assign wrdata_q2_2_scanin[5]=wrdata_q2_6_scanout[5];
assign wrdata_q2_6_scanin[4]=wrdata_q2_2_scanout[5];
assign wrdata_q2_2_scanin[4]=wrdata_q2_6_scanout[4];
assign wrdata_q2_6_scanin[3]=wrdata_q2_2_scanout[4];
assign wrdata_q2_2_scanin[3]=wrdata_q2_6_scanout[3];
assign wrdata_q2_6_scanin[2]=wrdata_q2_2_scanout[3];
assign wrdata_q2_2_scanin[2]=wrdata_q2_6_scanout[2];
assign wrdata_q2_6_scanin[1]=wrdata_q2_2_scanout[2];
assign wrdata_q2_2_scanin[1]=wrdata_q2_6_scanout[1];
assign wrdata_q2_6_scanin[0]=wrdata_q2_2_scanout[1];
assign wrdata_q2_2_scanin[0]=wrdata_q2_6_scanout[0];

// ***************************BEGIN SECTION*************************

assign data_bus_2_w2_reg_scanin[32]=wrdata_q2_2_scanout[0];
assign data_bus_2_w3_reg_scanin[32]=data_bus_2_w2_reg_scanout[32];
assign data_bus_2_w6_reg_scanin[32]=data_bus_2_w3_reg_scanout[32];
assign data_bus_2_w7_reg_scanin[32]=data_bus_2_w6_reg_scanout[32];
assign data_bus_2_w0_reg_scanin[32]=data_bus_2_w7_reg_scanout[32];
assign data_bus_2_w1_reg_scanin[32]=data_bus_2_w0_reg_scanout[32];
assign data_bus_2_w4_reg_scanin[32]=data_bus_2_w1_reg_scanout[32];
assign data_bus_2_w5_reg_scanin[32]=data_bus_2_w4_reg_scanout[32];

assign data_bus_2_w2_reg_scanin[31]=data_bus_2_w5_reg_scanout[32];
assign data_bus_2_w3_reg_scanin[31]=data_bus_2_w2_reg_scanout[31];
assign data_bus_2_w6_reg_scanin[31]=data_bus_2_w3_reg_scanout[31];
assign data_bus_2_w7_reg_scanin[31]=data_bus_2_w6_reg_scanout[31];
assign data_bus_2_w0_reg_scanin[31]=data_bus_2_w7_reg_scanout[31];
assign data_bus_2_w1_reg_scanin[31]=data_bus_2_w0_reg_scanout[31];
assign data_bus_2_w4_reg_scanin[31]=data_bus_2_w1_reg_scanout[31];
assign data_bus_2_w5_reg_scanin[31]=data_bus_2_w4_reg_scanout[31];

assign data_bus_2_w2_reg_scanin[30]=data_bus_2_w5_reg_scanout[31];
assign data_bus_2_w3_reg_scanin[30]=data_bus_2_w2_reg_scanout[30];
assign data_bus_2_w6_reg_scanin[30]=data_bus_2_w3_reg_scanout[30];
assign data_bus_2_w7_reg_scanin[30]=data_bus_2_w6_reg_scanout[30];
assign data_bus_2_w0_reg_scanin[30]=data_bus_2_w7_reg_scanout[30];
assign data_bus_2_w1_reg_scanin[30]=data_bus_2_w0_reg_scanout[30];
assign data_bus_2_w4_reg_scanin[30]=data_bus_2_w1_reg_scanout[30];
assign data_bus_2_w5_reg_scanin[30]=data_bus_2_w4_reg_scanout[30];

assign data_bus_2_w2_reg_scanin[29]=data_bus_2_w5_reg_scanout[30];
assign data_bus_2_w3_reg_scanin[29]=data_bus_2_w2_reg_scanout[29];
assign data_bus_2_w6_reg_scanin[29]=data_bus_2_w3_reg_scanout[29];
assign data_bus_2_w7_reg_scanin[29]=data_bus_2_w6_reg_scanout[29];
assign data_bus_2_w0_reg_scanin[29]=data_bus_2_w7_reg_scanout[29];
assign data_bus_2_w1_reg_scanin[29]=data_bus_2_w0_reg_scanout[29];
assign data_bus_2_w4_reg_scanin[29]=data_bus_2_w1_reg_scanout[29];
assign data_bus_2_w5_reg_scanin[29]=data_bus_2_w4_reg_scanout[29];

assign data_bus_2_w2_reg_scanin[28]=data_bus_2_w5_reg_scanout[29];
assign data_bus_2_w3_reg_scanin[28]=data_bus_2_w2_reg_scanout[28];
assign data_bus_2_w6_reg_scanin[28]=data_bus_2_w3_reg_scanout[28];
assign data_bus_2_w7_reg_scanin[28]=data_bus_2_w6_reg_scanout[28];
assign data_bus_2_w0_reg_scanin[28]=data_bus_2_w7_reg_scanout[28];
assign data_bus_2_w1_reg_scanin[28]=data_bus_2_w0_reg_scanout[28];
assign data_bus_2_w4_reg_scanin[28]=data_bus_2_w1_reg_scanout[28];
assign data_bus_2_w5_reg_scanin[28]=data_bus_2_w4_reg_scanout[28];

assign data_bus_2_w2_reg_scanin[27]=data_bus_2_w5_reg_scanout[28];
assign data_bus_2_w3_reg_scanin[27]=data_bus_2_w2_reg_scanout[27];
assign data_bus_2_w6_reg_scanin[27]=data_bus_2_w3_reg_scanout[27];
assign data_bus_2_w7_reg_scanin[27]=data_bus_2_w6_reg_scanout[27];
assign data_bus_2_w0_reg_scanin[27]=data_bus_2_w7_reg_scanout[27];
assign data_bus_2_w1_reg_scanin[27]=data_bus_2_w0_reg_scanout[27];
assign data_bus_2_w4_reg_scanin[27]=data_bus_2_w1_reg_scanout[27];
assign data_bus_2_w5_reg_scanin[27]=data_bus_2_w4_reg_scanout[27];

assign data_bus_2_w2_reg_scanin[26]=data_bus_2_w5_reg_scanout[27];
assign data_bus_2_w3_reg_scanin[26]=data_bus_2_w2_reg_scanout[26];
assign data_bus_2_w6_reg_scanin[26]=data_bus_2_w3_reg_scanout[26];
assign data_bus_2_w7_reg_scanin[26]=data_bus_2_w6_reg_scanout[26];
assign data_bus_2_w0_reg_scanin[26]=data_bus_2_w7_reg_scanout[26];
assign data_bus_2_w1_reg_scanin[26]=data_bus_2_w0_reg_scanout[26];
assign data_bus_2_w4_reg_scanin[26]=data_bus_2_w1_reg_scanout[26];
assign data_bus_2_w5_reg_scanin[26]=data_bus_2_w4_reg_scanout[26];

assign data_bus_2_w2_reg_scanin[25]=data_bus_2_w5_reg_scanout[26];
assign data_bus_2_w3_reg_scanin[25]=data_bus_2_w2_reg_scanout[25];
assign data_bus_2_w6_reg_scanin[25]=data_bus_2_w3_reg_scanout[25];
assign data_bus_2_w7_reg_scanin[25]=data_bus_2_w6_reg_scanout[25];
assign data_bus_2_w0_reg_scanin[25]=data_bus_2_w7_reg_scanout[25];
assign data_bus_2_w1_reg_scanin[25]=data_bus_2_w0_reg_scanout[25];
assign data_bus_2_w4_reg_scanin[25]=data_bus_2_w1_reg_scanout[25];
assign data_bus_2_w5_reg_scanin[25]=data_bus_2_w4_reg_scanout[25];

assign data_bus_2_w2_reg_scanin[24]=data_bus_2_w5_reg_scanout[25];
assign data_bus_2_w3_reg_scanin[24]=data_bus_2_w2_reg_scanout[24];
assign data_bus_2_w6_reg_scanin[24]=data_bus_2_w3_reg_scanout[24];
assign data_bus_2_w7_reg_scanin[24]=data_bus_2_w6_reg_scanout[24];
assign data_bus_2_w0_reg_scanin[24]=data_bus_2_w7_reg_scanout[24];
assign data_bus_2_w1_reg_scanin[24]=data_bus_2_w0_reg_scanout[24];
assign data_bus_2_w4_reg_scanin[24]=data_bus_2_w1_reg_scanout[24];
assign data_bus_2_w5_reg_scanin[24]=data_bus_2_w4_reg_scanout[24];

assign data_bus_2_w2_reg_scanin[23]=data_bus_2_w5_reg_scanout[24];
assign data_bus_2_w3_reg_scanin[23]=data_bus_2_w2_reg_scanout[23];
assign data_bus_2_w6_reg_scanin[23]=data_bus_2_w3_reg_scanout[23];
assign data_bus_2_w7_reg_scanin[23]=data_bus_2_w6_reg_scanout[23];
assign data_bus_2_w0_reg_scanin[23]=data_bus_2_w7_reg_scanout[23];
assign data_bus_2_w1_reg_scanin[23]=data_bus_2_w0_reg_scanout[23];
assign data_bus_2_w4_reg_scanin[23]=data_bus_2_w1_reg_scanout[23];
assign data_bus_2_w5_reg_scanin[23]=data_bus_2_w4_reg_scanout[23];

assign data_bus_2_w2_reg_scanin[22]=data_bus_2_w5_reg_scanout[23];
assign data_bus_2_w3_reg_scanin[22]=data_bus_2_w2_reg_scanout[22];
assign data_bus_2_w6_reg_scanin[22]=data_bus_2_w3_reg_scanout[22];
assign data_bus_2_w7_reg_scanin[22]=data_bus_2_w6_reg_scanout[22];
assign data_bus_2_w0_reg_scanin[22]=data_bus_2_w7_reg_scanout[22];
assign data_bus_2_w1_reg_scanin[22]=data_bus_2_w0_reg_scanout[22];
assign data_bus_2_w4_reg_scanin[22]=data_bus_2_w1_reg_scanout[22];
assign data_bus_2_w5_reg_scanin[22]=data_bus_2_w4_reg_scanout[22];

assign data_bus_2_w2_reg_scanin[21]=data_bus_2_w5_reg_scanout[22];
assign data_bus_2_w3_reg_scanin[21]=data_bus_2_w2_reg_scanout[21];
assign data_bus_2_w6_reg_scanin[21]=data_bus_2_w3_reg_scanout[21];
assign data_bus_2_w7_reg_scanin[21]=data_bus_2_w6_reg_scanout[21];
assign data_bus_2_w0_reg_scanin[21]=data_bus_2_w7_reg_scanout[21];
assign data_bus_2_w1_reg_scanin[21]=data_bus_2_w0_reg_scanout[21];
assign data_bus_2_w4_reg_scanin[21]=data_bus_2_w1_reg_scanout[21];
assign data_bus_2_w5_reg_scanin[21]=data_bus_2_w4_reg_scanout[21];

assign data_bus_2_w2_reg_scanin[20]=data_bus_2_w5_reg_scanout[21];
assign data_bus_2_w3_reg_scanin[20]=data_bus_2_w2_reg_scanout[20];
assign data_bus_2_w6_reg_scanin[20]=data_bus_2_w3_reg_scanout[20];
assign data_bus_2_w7_reg_scanin[20]=data_bus_2_w6_reg_scanout[20];
assign data_bus_2_w0_reg_scanin[20]=data_bus_2_w7_reg_scanout[20];
assign data_bus_2_w1_reg_scanin[20]=data_bus_2_w0_reg_scanout[20];
assign data_bus_2_w4_reg_scanin[20]=data_bus_2_w1_reg_scanout[20];
assign data_bus_2_w5_reg_scanin[20]=data_bus_2_w4_reg_scanout[20];

assign data_bus_2_w2_reg_scanin[19]=data_bus_2_w5_reg_scanout[20];
assign data_bus_2_w3_reg_scanin[19]=data_bus_2_w2_reg_scanout[19];
assign data_bus_2_w6_reg_scanin[19]=data_bus_2_w3_reg_scanout[19];
assign data_bus_2_w7_reg_scanin[19]=data_bus_2_w6_reg_scanout[19];
assign data_bus_2_w0_reg_scanin[19]=data_bus_2_w7_reg_scanout[19];
assign data_bus_2_w1_reg_scanin[19]=data_bus_2_w0_reg_scanout[19];
assign data_bus_2_w4_reg_scanin[19]=data_bus_2_w1_reg_scanout[19];
assign data_bus_2_w5_reg_scanin[19]=data_bus_2_w4_reg_scanout[19];

assign data_bus_2_w2_reg_scanin[18]=data_bus_2_w5_reg_scanout[19];
assign data_bus_2_w3_reg_scanin[18]=data_bus_2_w2_reg_scanout[18];
assign data_bus_2_w6_reg_scanin[18]=data_bus_2_w3_reg_scanout[18];
assign data_bus_2_w7_reg_scanin[18]=data_bus_2_w6_reg_scanout[18];
assign data_bus_2_w0_reg_scanin[18]=data_bus_2_w7_reg_scanout[18];
assign data_bus_2_w1_reg_scanin[18]=data_bus_2_w0_reg_scanout[18];
assign data_bus_2_w4_reg_scanin[18]=data_bus_2_w1_reg_scanout[18];
assign data_bus_2_w5_reg_scanin[18]=data_bus_2_w4_reg_scanout[18];

assign data_bus_2_w2_reg_scanin[17]=data_bus_2_w5_reg_scanout[18];
assign data_bus_2_w3_reg_scanin[17]=data_bus_2_w2_reg_scanout[17];
assign data_bus_2_w6_reg_scanin[17]=data_bus_2_w3_reg_scanout[17];
assign data_bus_2_w7_reg_scanin[17]=data_bus_2_w6_reg_scanout[17];
assign data_bus_2_w0_reg_scanin[17]=data_bus_2_w7_reg_scanout[17];
assign data_bus_2_w1_reg_scanin[17]=data_bus_2_w0_reg_scanout[17];
assign data_bus_2_w4_reg_scanin[17]=data_bus_2_w1_reg_scanout[17];
assign data_bus_2_w5_reg_scanin[17]=data_bus_2_w4_reg_scanout[17];

assign data_bus_2_w0_reg_scanin[16]=data_bus_2_w5_reg_scanout[17];
assign data_bus_2_w1_reg_scanin[16]=data_bus_2_w0_reg_scanout[16];
assign data_bus_2_w4_reg_scanin[16]=data_bus_2_w1_reg_scanout[16];
assign data_bus_2_w5_reg_scanin[16]=data_bus_2_w4_reg_scanout[16];
assign data_bus_2_w2_reg_scanin[16]=data_bus_2_w5_reg_scanout[16];
assign data_bus_2_w3_reg_scanin[16]=data_bus_2_w2_reg_scanout[16];
assign data_bus_2_w6_reg_scanin[16]=data_bus_2_w3_reg_scanout[16];
assign data_bus_2_w7_reg_scanin[16]=data_bus_2_w6_reg_scanout[16];

assign data_bus_2_w0_reg_scanin[15]=data_bus_2_w7_reg_scanout[16];
assign data_bus_2_w1_reg_scanin[15]=data_bus_2_w0_reg_scanout[15];
assign data_bus_2_w4_reg_scanin[15]=data_bus_2_w1_reg_scanout[15];
assign data_bus_2_w5_reg_scanin[15]=data_bus_2_w4_reg_scanout[15];
assign data_bus_2_w2_reg_scanin[15]=data_bus_2_w5_reg_scanout[15];
assign data_bus_2_w3_reg_scanin[15]=data_bus_2_w2_reg_scanout[15];
assign data_bus_2_w6_reg_scanin[15]=data_bus_2_w3_reg_scanout[15];
assign data_bus_2_w7_reg_scanin[15]=data_bus_2_w6_reg_scanout[15];

assign data_bus_2_w0_reg_scanin[14]=data_bus_2_w7_reg_scanout[15];
assign data_bus_2_w1_reg_scanin[14]=data_bus_2_w0_reg_scanout[14];
assign data_bus_2_w4_reg_scanin[14]=data_bus_2_w1_reg_scanout[14];
assign data_bus_2_w5_reg_scanin[14]=data_bus_2_w4_reg_scanout[14];
assign data_bus_2_w2_reg_scanin[14]=data_bus_2_w5_reg_scanout[14];
assign data_bus_2_w3_reg_scanin[14]=data_bus_2_w2_reg_scanout[14];
assign data_bus_2_w6_reg_scanin[14]=data_bus_2_w3_reg_scanout[14];
assign data_bus_2_w7_reg_scanin[14]=data_bus_2_w6_reg_scanout[14];

assign data_bus_2_w0_reg_scanin[13]=data_bus_2_w7_reg_scanout[14];
assign data_bus_2_w1_reg_scanin[13]=data_bus_2_w0_reg_scanout[13];
assign data_bus_2_w4_reg_scanin[13]=data_bus_2_w1_reg_scanout[13];
assign data_bus_2_w5_reg_scanin[13]=data_bus_2_w4_reg_scanout[13];
assign data_bus_2_w2_reg_scanin[13]=data_bus_2_w5_reg_scanout[13];
assign data_bus_2_w3_reg_scanin[13]=data_bus_2_w2_reg_scanout[13];
assign data_bus_2_w6_reg_scanin[13]=data_bus_2_w3_reg_scanout[13];
assign data_bus_2_w7_reg_scanin[13]=data_bus_2_w6_reg_scanout[13];

assign data_bus_2_w0_reg_scanin[12]=data_bus_2_w7_reg_scanout[13];
assign data_bus_2_w1_reg_scanin[12]=data_bus_2_w0_reg_scanout[12];
assign data_bus_2_w4_reg_scanin[12]=data_bus_2_w1_reg_scanout[12];
assign data_bus_2_w5_reg_scanin[12]=data_bus_2_w4_reg_scanout[12];
assign data_bus_2_w2_reg_scanin[12]=data_bus_2_w5_reg_scanout[12];
assign data_bus_2_w3_reg_scanin[12]=data_bus_2_w2_reg_scanout[12];
assign data_bus_2_w6_reg_scanin[12]=data_bus_2_w3_reg_scanout[12];
assign data_bus_2_w7_reg_scanin[12]=data_bus_2_w6_reg_scanout[12];

assign data_bus_2_w0_reg_scanin[11]=data_bus_2_w7_reg_scanout[12];
assign data_bus_2_w1_reg_scanin[11]=data_bus_2_w0_reg_scanout[11];
assign data_bus_2_w4_reg_scanin[11]=data_bus_2_w1_reg_scanout[11];
assign data_bus_2_w5_reg_scanin[11]=data_bus_2_w4_reg_scanout[11];
assign data_bus_2_w2_reg_scanin[11]=data_bus_2_w5_reg_scanout[11];
assign data_bus_2_w3_reg_scanin[11]=data_bus_2_w2_reg_scanout[11];
assign data_bus_2_w6_reg_scanin[11]=data_bus_2_w3_reg_scanout[11];
assign data_bus_2_w7_reg_scanin[11]=data_bus_2_w6_reg_scanout[11];

assign data_bus_2_w0_reg_scanin[10]=data_bus_2_w7_reg_scanout[11];
assign data_bus_2_w1_reg_scanin[10]=data_bus_2_w0_reg_scanout[10];
assign data_bus_2_w4_reg_scanin[10]=data_bus_2_w1_reg_scanout[10];
assign data_bus_2_w5_reg_scanin[10]=data_bus_2_w4_reg_scanout[10];
assign data_bus_2_w2_reg_scanin[10]=data_bus_2_w5_reg_scanout[10];
assign data_bus_2_w3_reg_scanin[10]=data_bus_2_w2_reg_scanout[10];
assign data_bus_2_w6_reg_scanin[10]=data_bus_2_w3_reg_scanout[10];
assign data_bus_2_w7_reg_scanin[10]=data_bus_2_w6_reg_scanout[10];

assign data_bus_2_w0_reg_scanin[9]=data_bus_2_w7_reg_scanout[10];
assign data_bus_2_w1_reg_scanin[9]=data_bus_2_w0_reg_scanout[9];
assign data_bus_2_w4_reg_scanin[9]=data_bus_2_w1_reg_scanout[9];
assign data_bus_2_w5_reg_scanin[9]=data_bus_2_w4_reg_scanout[9];
assign data_bus_2_w2_reg_scanin[9]=data_bus_2_w5_reg_scanout[9];
assign data_bus_2_w3_reg_scanin[9]=data_bus_2_w2_reg_scanout[9];
assign data_bus_2_w6_reg_scanin[9]=data_bus_2_w3_reg_scanout[9];
assign data_bus_2_w7_reg_scanin[9]=data_bus_2_w6_reg_scanout[9];

assign data_bus_2_w0_reg_scanin[8]=data_bus_2_w7_reg_scanout[9];
assign data_bus_2_w1_reg_scanin[8]=data_bus_2_w0_reg_scanout[8];
assign data_bus_2_w4_reg_scanin[8]=data_bus_2_w1_reg_scanout[8];
assign data_bus_2_w5_reg_scanin[8]=data_bus_2_w4_reg_scanout[8];
assign data_bus_2_w2_reg_scanin[8]=data_bus_2_w5_reg_scanout[8];
assign data_bus_2_w3_reg_scanin[8]=data_bus_2_w2_reg_scanout[8];
assign data_bus_2_w6_reg_scanin[8]=data_bus_2_w3_reg_scanout[8];
assign data_bus_2_w7_reg_scanin[8]=data_bus_2_w6_reg_scanout[8];

assign data_bus_2_w0_reg_scanin[7]=data_bus_2_w7_reg_scanout[8];
assign data_bus_2_w1_reg_scanin[7]=data_bus_2_w0_reg_scanout[7];
assign data_bus_2_w4_reg_scanin[7]=data_bus_2_w1_reg_scanout[7];
assign data_bus_2_w5_reg_scanin[7]=data_bus_2_w4_reg_scanout[7];
assign data_bus_2_w2_reg_scanin[7]=data_bus_2_w5_reg_scanout[7];
assign data_bus_2_w3_reg_scanin[7]=data_bus_2_w2_reg_scanout[7];
assign data_bus_2_w6_reg_scanin[7]=data_bus_2_w3_reg_scanout[7];
assign data_bus_2_w7_reg_scanin[7]=data_bus_2_w6_reg_scanout[7];

assign data_bus_2_w0_reg_scanin[6]=data_bus_2_w7_reg_scanout[7];
assign data_bus_2_w1_reg_scanin[6]=data_bus_2_w0_reg_scanout[6];
assign data_bus_2_w4_reg_scanin[6]=data_bus_2_w1_reg_scanout[6];
assign data_bus_2_w5_reg_scanin[6]=data_bus_2_w4_reg_scanout[6];
assign data_bus_2_w2_reg_scanin[6]=data_bus_2_w5_reg_scanout[6];
assign data_bus_2_w3_reg_scanin[6]=data_bus_2_w2_reg_scanout[6];
assign data_bus_2_w6_reg_scanin[6]=data_bus_2_w3_reg_scanout[6];
assign data_bus_2_w7_reg_scanin[6]=data_bus_2_w6_reg_scanout[6];

assign data_bus_2_w0_reg_scanin[5]=data_bus_2_w7_reg_scanout[6];
assign data_bus_2_w1_reg_scanin[5]=data_bus_2_w0_reg_scanout[5];
assign data_bus_2_w4_reg_scanin[5]=data_bus_2_w1_reg_scanout[5];
assign data_bus_2_w5_reg_scanin[5]=data_bus_2_w4_reg_scanout[5];
assign data_bus_2_w2_reg_scanin[5]=data_bus_2_w5_reg_scanout[5];
assign data_bus_2_w3_reg_scanin[5]=data_bus_2_w2_reg_scanout[5];
assign data_bus_2_w6_reg_scanin[5]=data_bus_2_w3_reg_scanout[5];
assign data_bus_2_w7_reg_scanin[5]=data_bus_2_w6_reg_scanout[5];

assign data_bus_2_w0_reg_scanin[4]=data_bus_2_w7_reg_scanout[5];
assign data_bus_2_w1_reg_scanin[4]=data_bus_2_w0_reg_scanout[4];
assign data_bus_2_w4_reg_scanin[4]=data_bus_2_w1_reg_scanout[4];
assign data_bus_2_w5_reg_scanin[4]=data_bus_2_w4_reg_scanout[4];
assign data_bus_2_w2_reg_scanin[4]=data_bus_2_w5_reg_scanout[4];
assign data_bus_2_w3_reg_scanin[4]=data_bus_2_w2_reg_scanout[4];
assign data_bus_2_w6_reg_scanin[4]=data_bus_2_w3_reg_scanout[4];
assign data_bus_2_w7_reg_scanin[4]=data_bus_2_w6_reg_scanout[4];

assign data_bus_2_w0_reg_scanin[3]=data_bus_2_w7_reg_scanout[4];
assign data_bus_2_w1_reg_scanin[3]=data_bus_2_w0_reg_scanout[3];
assign data_bus_2_w4_reg_scanin[3]=data_bus_2_w1_reg_scanout[3];
assign data_bus_2_w5_reg_scanin[3]=data_bus_2_w4_reg_scanout[3];
assign data_bus_2_w2_reg_scanin[3]=data_bus_2_w5_reg_scanout[3];
assign data_bus_2_w3_reg_scanin[3]=data_bus_2_w2_reg_scanout[3];
assign data_bus_2_w6_reg_scanin[3]=data_bus_2_w3_reg_scanout[3];
assign data_bus_2_w7_reg_scanin[3]=data_bus_2_w6_reg_scanout[3];

assign data_bus_2_w0_reg_scanin[2]=data_bus_2_w7_reg_scanout[3];
assign data_bus_2_w1_reg_scanin[2]=data_bus_2_w0_reg_scanout[2];
assign data_bus_2_w4_reg_scanin[2]=data_bus_2_w1_reg_scanout[2];
assign data_bus_2_w5_reg_scanin[2]=data_bus_2_w4_reg_scanout[2];
assign data_bus_2_w2_reg_scanin[2]=data_bus_2_w5_reg_scanout[2];
assign data_bus_2_w3_reg_scanin[2]=data_bus_2_w2_reg_scanout[2];
assign data_bus_2_w6_reg_scanin[2]=data_bus_2_w3_reg_scanout[2];
assign data_bus_2_w7_reg_scanin[2]=data_bus_2_w6_reg_scanout[2];

assign data_bus_2_w0_reg_scanin[1]=data_bus_2_w7_reg_scanout[2];
assign data_bus_2_w1_reg_scanin[1]=data_bus_2_w0_reg_scanout[1];
assign data_bus_2_w4_reg_scanin[1]=data_bus_2_w1_reg_scanout[1];
assign data_bus_2_w5_reg_scanin[1]=data_bus_2_w4_reg_scanout[1];
assign data_bus_2_w2_reg_scanin[1]=data_bus_2_w5_reg_scanout[1];
assign data_bus_2_w3_reg_scanin[1]=data_bus_2_w2_reg_scanout[1];
assign data_bus_2_w6_reg_scanin[1]=data_bus_2_w3_reg_scanout[1];
assign data_bus_2_w7_reg_scanin[1]=data_bus_2_w6_reg_scanout[1];

assign data_bus_2_w0_reg_scanin[0]=data_bus_2_w7_reg_scanout[1];
assign data_bus_2_w1_reg_scanin[0]=data_bus_2_w0_reg_scanout[0];
assign data_bus_2_w4_reg_scanin[0]=data_bus_2_w1_reg_scanout[0];
assign data_bus_2_w5_reg_scanin[0]=data_bus_2_w4_reg_scanout[0];
assign data_bus_2_w2_reg_scanin[0]=data_bus_2_w5_reg_scanout[0];
assign data_bus_2_w3_reg_scanin[0]=data_bus_2_w2_reg_scanout[0];
assign data_bus_2_w6_reg_scanin[0]=data_bus_2_w3_reg_scanout[0];
assign data_bus_2_w7_reg_scanin[0]=data_bus_2_w6_reg_scanout[0];

assign scan_out			  =data_bus_2_w7_reg_scanout[0];

// ***************************END SECTION***************************


`ifndef FPGA
// synopsys translate_on
`endif

endmodule






// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_l1clkhdr_ctl_macro (
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









//
//   invert macro
//
//





module n2_icd_sp_16p5kb_cust_inv_macro__stack_50c__width_9 (
  din, 
  dout);
  input [8:0] din;
  output [8:0] dout;






inv #(9)  d0_0 (
.in(din[8:0]),
.out(dout[8:0])
);









endmodule





//
//   invert macro
//
//





module n2_icd_sp_16p5kb_cust_inv_macro__stack_50c__width_3 (
  din, 
  dout);
  input [2:0] din;
  output [2:0] dout;






inv #(3)  d0_0 (
.in(din[2:0]),
.out(dout[2:0])
);









endmodule





//
//   invert macro
//
//





module n2_icd_sp_16p5kb_cust_inv_macro__stack_50c__width_8 (
  din, 
  dout);
  input [7:0] din;
  output [7:0] dout;






inv #(8)  d0_0 (
.in(din[7:0]),
.out(dout[7:0])
);









endmodule





//
//   invert macro
//
//





module n2_icd_sp_16p5kb_cust_inv_macro__stack_50c__width_1 (
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
//   invert macro
//
//





module n2_icd_sp_16p5kb_cust_inv_macro__stack_50c__width_4 (
  din, 
  dout);
  input [3:0] din;
  output [3:0] dout;






inv #(4)  d0_0 (
.in(din[3:0]),
.out(dout[3:0])
);









endmodule





//
//   macro for cl_mc1_tisram_msff_{16,8}x flops
//
//





module n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_1 (
  d, 
  scan_in, 
  l1clk, 
  siclk, 
  soclk, 
  scan_out, 
  latout, 
  latout_l);
input [0:0] d;
  input scan_in;
input l1clk;
input siclk;
input soclk;
  output scan_out;
output [0:0] latout;
output [0:0] latout_l;






tisram_msff #(1)  d0_0 (
.d(d[0:0]),
.si(scan_in),
.so(scan_out),
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.latout(latout[0:0]),
.latout_l(latout_l[0:0])
);












//place::generic_place($width,$stack,$left);

endmodule





//
//   macro for cl_mc1_tisram_msff_{16,8}x flops
//
//





module n2_icd_sp_16p5kb_cust_tisram_msff_macro__width_9 (
  d, 
  scan_in, 
  l1clk, 
  siclk, 
  soclk, 
  scan_out, 
  latout, 
  latout_l);
wire [7:0] so;

input [8:0] d;
  input scan_in;
input l1clk;
input siclk;
input soclk;
  output scan_out;
output [8:0] latout;
output [8:0] latout_l;






tisram_msff #(9)  d0_0 (
.d(d[8:0]),
.si({scan_in,so[7:0]}),
.so({so[7:0],scan_out}),
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.latout(latout[8:0]),
.latout_l(latout_l[8:0])
);












//place::generic_place($width,$stack,$left);

endmodule









// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_msffi_ctl_macro__fs_1__width_4 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  q_l, 
  scan_out);
  input [3:0] din;
  input l1clk;
  input [3:0] scan_in;


  input siclk;
  input soclk;

  output [3:0] q_l;
  output [3:0] scan_out;






msffi #(4)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(din[3:0]),
.si(scan_in[3:0]),
.so(scan_out[3:0]),
.q_l(q_l[3:0])
);












endmodule









//
//   invert macro
//
//





module n2_icd_sp_16p5kb_cust_inv_macro__width_4 (
  din, 
  dout);
  input [3:0] din;
  output [3:0] dout;






inv #(4)  d0_0 (
.in(din[3:0]),
.out(dout[3:0])
);









endmodule









// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_msffi_ctl_macro__width_1 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  q_l, 
  scan_out);
  input [0:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [0:0] q_l;
  output scan_out;






msffi #(1)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(din[0:0]),
.si(scan_in),
.so(scan_out),
.q_l(q_l[0:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_1 (
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
  input [0:0] scan_in;


  input siclk;
  input soclk;

  output [0:0] dout;
  output [0:0] scan_out;
assign fdin[0:0] = din[0:0];






dff #(1)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[0:0]),
.si(scan_in[0:0]),
.so(scan_out[0:0]),
.q(dout[0:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_msff_ctl_macro__width_1 (
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









// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_mux_macro__mux_aope__ports_2__stack_66c__width_66 (
  din0, 
  din1, 
  sel0, 
  dout);
wire psel0;
wire psel1;

  input [65:0] din0;
  input [65:0] din1;
  input sel0;
  output [65:0] dout;





cl_dp1_penc2_8x  c0_0 (
 .sel0(sel0),
 .psel0(psel0),
 .psel1(psel1)
);

mux2s #(66)  d0_0 (
  .sel0(psel0),
  .sel1(psel1),
  .in0(din0[65:0]),
  .in1(din1[65:0]),
.dout(dout[65:0])
);









  



endmodule






// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_33 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [32:0] fdin;

  input [32:0] din;
  input l1clk;
  input [32:0] scan_in;


  input siclk;
  input soclk;

  output [32:0] dout;
  output [32:0] scan_out;
assign fdin[32:0] = din[32:0];






dff #(33)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[32:0]),
.si(scan_in[32:0]),
.so(scan_out[32:0]),
.q(dout[32:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_5 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [4:0] fdin;

  input [4:0] din;
  input l1clk;
  input [4:0] scan_in;


  input siclk;
  input soclk;

  output [4:0] dout;
  output [4:0] scan_out;
assign fdin[4:0] = din[4:0];






dff #(5)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[4:0]),
.si(scan_in[4:0]),
.so(scan_out[4:0]),
.q(dout[4:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_2 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [1:0] fdin;

  input [1:0] din;
  input l1clk;
  input [1:0] scan_in;


  input siclk;
  input soclk;

  output [1:0] dout;
  output [1:0] scan_out;
assign fdin[1:0] = din[1:0];






dff #(2)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[1:0]),
.si(scan_in[1:0]),
.so(scan_out[1:0]),
.q(dout[1:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_4 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [3:0] fdin;

  input [3:0] din;
  input l1clk;
  input [3:0] scan_in;


  input siclk;
  input soclk;

  output [3:0] dout;
  output [3:0] scan_out;
assign fdin[3:0] = din[3:0];






dff #(4)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[3:0]),
.si(scan_in[3:0]),
.so(scan_out[3:0]),
.q(dout[3:0])
);












endmodule









//  
//   and macro for ports = 2,3,4
//
//





module n2_icd_sp_16p5kb_cust_and_macro__ports_2__width_1 (
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









// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_msff_ctl_macro__fs_1__width_8 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [7:0] fdin;

  input [7:0] din;
  input l1clk;
  input [7:0] scan_in;


  input siclk;
  input soclk;

  output [7:0] dout;
  output [7:0] scan_out;
assign fdin[7:0] = din[7:0];






dff #(8)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[7:0]),
.si(scan_in[7:0]),
.so(scan_out[7:0]),
.q(dout[7:0])
);












endmodule









//
//   invert macro
//
//





module n2_icd_sp_16p5kb_cust_inv_macro__width_1 (
  din, 
  dout);
  input [0:0] din;
  output [0:0] dout;






inv #(1)  d0_0 (
.in(din[0:0]),
.out(dout[0:0])
);









endmodule





// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_mux_macro__mux_aonpe__ports_2__stack_50c__width_8 (
  din0, 
  sel0, 
  din1, 
  sel1, 
  dout);
wire buffout0;
wire buffout1;

  input [7:0] din0;
  input sel0;
  input [7:0] din1;
  input sel1;
  output [7:0] dout;





cl_dp1_muxbuff2_8x  c0_0 (
 .in0(sel0),
 .in1(sel1),
 .out0(buffout0),
 .out1(buffout1)
);
mux2s #(8)  d0_0 (
  .sel0(buffout0),
  .sel1(buffout1),
  .in0(din0[7:0]),
  .in1(din1[7:0]),
.dout(dout[7:0])
);









  



endmodule


//  
//   or macro for ports = 2,3
//
//





module n2_icd_sp_16p5kb_cust_or_macro__ports_3__stack_50c__width_1 (
  din0, 
  din1, 
  din2, 
  dout);
  input [0:0] din0;
  input [0:0] din1;
  input [0:0] din2;
  output [0:0] dout;






or3 #(1)  d0_0 (
.in0(din0[0:0]),
.in1(din1[0:0]),
.in2(din2[0:0]),
.out(dout[0:0])
);









endmodule





//  
//   or macro for ports = 2,3
//
//





module n2_icd_sp_16p5kb_cust_or_macro__ports_2__stack_50c__width_1 (
  din0, 
  din1, 
  dout);
  input [0:0] din0;
  input [0:0] din1;
  output [0:0] dout;






or2 #(1)  d0_0 (
.in0(din0[0:0]),
.in1(din1[0:0]),
.out(dout[0:0])
);









endmodule





//  
//   and macro for ports = 2,3,4
//
//





module n2_icd_sp_16p5kb_cust_and_macro__ports_2__stack_50c__width_1 (
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
//   buff macro
//
//





module n2_icd_sp_16p5kb_cust_buff_macro__stack_50c__width_1 (
  din, 
  dout);
  input [0:0] din;
  output [0:0] dout;






buff #(1)  d0_0 (
.in(din[0:0]),
.out(dout[0:0])
);








endmodule





//
//   nand macro for ports = 2,3,4
//
//





module n2_icd_sp_16p5kb_cust_nand_macro__ports_3__stack_50c__width_8 (
  din0, 
  din1, 
  din2, 
  dout);
  input [7:0] din0;
  input [7:0] din1;
  input [7:0] din2;
  output [7:0] dout;






nand3 #(8)  d0_0 (
.in0(din0[7:0]),
.in1(din1[7:0]),
.in2(din2[7:0]),
.out(dout[7:0])
);









endmodule





//
//   nand macro for ports = 2,3,4
//
//





module n2_icd_sp_16p5kb_cust_nand_macro__ports_4__stack_50c__width_1 (
  din0, 
  din1, 
  din2, 
  din3, 
  dout);
  input [0:0] din0;
  input [0:0] din1;
  input [0:0] din2;
  input [0:0] din3;
  output [0:0] dout;






nand4 #(1)  d0_0 (
.in0(din0[0:0]),
.in1(din1[0:0]),
.in2(din2[0:0]),
.in3(din3[0:0]),
.out(dout[0:0])
);









endmodule





//
//   invert macro
//
//





module n2_icd_sp_16p5kb_cust_inv_macro (
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





module n2_icd_sp_16p5kb_cust_and_macro (
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





// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_mux_macro__mux_aodec__ports_8__width_8 (
  din0, 
  din1, 
  din2, 
  din3, 
  din4, 
  din5, 
  din6, 
  din7, 
  sel, 
  dout);
wire psel0;
wire psel1;
wire psel2;
wire psel3;
wire psel4;
wire psel5;
wire psel6;
wire psel7;

  input [7:0] din0;
  input [7:0] din1;
  input [7:0] din2;
  input [7:0] din3;
  input [7:0] din4;
  input [7:0] din5;
  input [7:0] din6;
  input [7:0] din7;
  input [2:0] sel;
  output [7:0] dout;





cl_dp1_pdec8_8x  c0_0 (
  .test(1'b1),
 .sel0(sel[0]),
 .sel1(sel[1]),
 .sel2(sel[2]),
 .psel0(psel0),
 .psel1(psel1),
 .psel2(psel2),
 .psel3(psel3),
 .psel4(psel4),
 .psel5(psel5),
 .psel6(psel6),
 .psel7(psel7)
);

mux8s #(8)  d0_0 (
  .sel0(psel0),
  .sel1(psel1),
  .sel2(psel2),
  .sel3(psel3),
  .sel4(psel4),
  .sel5(psel5),
  .sel6(psel6),
  .sel7(psel7),
  .in0(din0[7:0]),
  .in1(din1[7:0]),
  .in2(din2[7:0]),
  .in3(din3[7:0]),
  .in4(din4[7:0]),
  .in5(din5[7:0]),
  .in6(din6[7:0]),
  .in7(din7[7:0]),
.dout(dout[7:0])
);









  



endmodule


// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_mux_macro__mux_aope__ports_2__width_16 (
  din0, 
  din1, 
  sel0, 
  dout);
wire psel0;
wire psel1;

  input [15:0] din0;
  input [15:0] din1;
  input sel0;
  output [15:0] dout;





cl_dp1_penc2_8x  c0_0 (
 .sel0(sel0),
 .psel0(psel0),
 .psel1(psel1)
);

mux2s #(16)  d0_0 (
  .sel0(psel0),
  .sel1(psel1),
  .in0(din0[15:0]),
  .in1(din1[15:0]),
.dout(dout[15:0])
);









  



endmodule


module n2_icd_quad_array (
  adr_ac_h, 
  adr_ac_l, 
  rd_en_a_l, 
  quaden_f_l, 
  wr_word_en_ac_l, 
  wr_waysel0_ac_l, 
  wr_waysel1_ac_l, 
  din0_a, 
  din1_a, 
  red_d_ff, 
  red_en_ff, 
  rid_sel, 
  red_arst_ff, 
  red_wen_ff, 
  rd_worden_ac_l, 
  l1clk, 
  l1clk_fuse,
  vnw_ary,
  dout_wy0_bc, 
  dout_wy1_bc, 
  dout_wy2_bc, 
  dout_wy3_bc, 
  dout_wy4_bc, 
  dout_wy5_bc, 
  dout_wy6_bc, 
  dout_wy7_bc, 
  reg_d_lft_top, 
  reg_en_lft_top, 
  reg_d_rgt_top, 
  reg_en_rgt_top, 
  reg_d_lft_bot, 
  reg_en_lft_bot, 
  reg_d_rgt_bot, 
  reg_en_rgt_bot) ;
wire [3:0] red_write;
wire [4:0] reg_d_lft_top_in;
wire [1:0] reg_en_lft_top_in;
wire [4:0] reg_d_rgt_top_in;
wire [1:0] reg_en_rgt_top_in;
wire [4:0] reg_d_lft_bot_in;
wire [1:0] reg_en_lft_bot_in;
wire [4:0] reg_d_rgt_bot_in;
wire [1:0] reg_en_rgt_bot_in;



input  [10:5] adr_ac_h;
input  [10:5] adr_ac_l;
input         rd_en_a_l;
input         quaden_f_l;
input  [1:0]  wr_word_en_ac_l;
input  [7:0]  wr_waysel0_ac_l;
input  [7:0]  wr_waysel1_ac_l;
input  [32:0] din0_a;
input  [32:0] din1_a;
input  [4:0]  red_d_ff;
input  [1:0]  red_en_ff;
input  [3:0]  rid_sel;
input         red_arst_ff;
input         red_wen_ff;
input  [1:0]  rd_worden_ac_l;
input         l1clk;
input         l1clk_fuse;
input         vnw_ary;

output [32:0] dout_wy0_bc;
output [32:0] dout_wy1_bc;
output [32:0] dout_wy2_bc;
output [32:0] dout_wy3_bc;
output [32:0] dout_wy4_bc;
output [32:0] dout_wy5_bc;
output [32:0] dout_wy6_bc;
output [32:0] dout_wy7_bc;

output [4:0]  reg_d_lft_top ;
output [1:0]  reg_en_lft_top ;
output [4:0]  reg_d_rgt_top ;
output [1:0]  reg_en_rgt_top ;
output [4:0]  reg_d_lft_bot ;
output [1:0]  reg_en_lft_bot ;
output [4:0]  reg_d_rgt_bot ;
output [1:0]  reg_en_rgt_bot ;

reg [4:0]     reg_d_lft_top ;
reg [1:0]     reg_en_lft_top ;
reg [4:0]     reg_d_rgt_top ;
reg [1:0]     reg_en_rgt_top ;
reg [4:0]     reg_d_lft_bot ;
reg [1:0]     reg_en_lft_bot ;
reg [4:0]     reg_d_rgt_bot ;
reg [1:0]     reg_en_rgt_bot ;

//////////////////////////////////////////
// top    bank                          //
//////////////////////////////////////////
n2_icd_bank              w3_to_w0_bank(.adr_ac_h(adr_ac_h[10:5]),
                                       .adr_ac_l(adr_ac_l[10:5]),
                                       .rd_en_a_l(rd_en_a_l),
                                       .quaden_f_l(quaden_f_l),
                                       .wr_word_en_ac_l(wr_word_en_ac_l[1:0]),
                                       .wr_waysel0_ac_l(wr_waysel0_ac_l[3:0]),
                                       .wr_waysel1_ac_l(wr_waysel1_ac_l[3:0]),
                                       .din0_a(din0_a[32:0]),
                                       .din1_a(din1_a[32:0]),
                                       .dout_wy0_bc(dout_wy0_bc[32:0]),
                                       .dout_wy1_bc(dout_wy1_bc[32:0]),
                                       .dout_wy2_bc(dout_wy2_bc[32:0]),
                                       .dout_wy3_bc(dout_wy3_bc[32:0]),
                                       .reg_d_lft(reg_d_lft_top[4:0]),
                                       .reg_en_lft(reg_en_lft_top[1:0]),
                                       .reg_d_rgt(reg_d_rgt_top[4:0]),
                                       .reg_en_rgt(reg_en_rgt_top[1:0]),
                                       .rd_worden_ac_l(rd_worden_ac_l[1:0]),
                                       .l1clk(l1clk),
  .vnw_ary(vnw_ary)
                                       );


//////////////////////////////////////////
// bottom bank                          //
//////////////////////////////////////////
n2_icd_bank              w7_to_w4_bank(.adr_ac_h(adr_ac_h[10:5]),
                                       .adr_ac_l(adr_ac_l[10:5]),
                                       .rd_en_a_l(rd_en_a_l),
                                       .quaden_f_l(quaden_f_l),
                                       .wr_word_en_ac_l(wr_word_en_ac_l[1:0]),
                                       .wr_waysel0_ac_l(wr_waysel0_ac_l[7:4]),
                                       .wr_waysel1_ac_l(wr_waysel1_ac_l[7:4]),
                                       .din0_a(din0_a[32:0]),
                                       .din1_a(din1_a[32:0]),
                                       .dout_wy0_bc(dout_wy4_bc[32:0]),
                                       .dout_wy1_bc(dout_wy5_bc[32:0]),
                                       .dout_wy2_bc(dout_wy6_bc[32:0]),
                                       .dout_wy3_bc(dout_wy7_bc[32:0]),
                                       .reg_d_lft(reg_d_lft_bot[4:0]),
                                       .reg_en_lft(reg_en_lft_bot[1:0]),
                                       .reg_d_rgt(reg_d_rgt_bot[4:0]),
                                       .reg_en_rgt(reg_en_rgt_bot[1:0]),
                                       .rd_worden_ac_l(rd_worden_ac_l[1:0]),
                                       .l1clk(l1clk),
  .vnw_ary(vnw_ary)
                                       );


assign red_write[3:0] = ({4{red_wen_ff}} & rid_sel[3:0]) ;
assign reg_d_lft_top_in[4:0]  = (red_arst_ff) ? 5'b00000 : 
                                (red_write[2]) ? red_d_ff[4:0]  : reg_d_lft_top[4:0] ;
assign reg_en_lft_top_in[1:0] = (red_arst_ff) ? 2'b00    : 
                                (red_write[2]) ? red_en_ff[1:0] : reg_en_lft_top[1:0];

assign reg_d_rgt_top_in[4:0]  = (red_arst_ff) ? 5'b00000 : 
                                (red_write[3]) ? red_d_ff[4:0]  : reg_d_rgt_top[4:0] ;
assign reg_en_rgt_top_in[1:0] = (red_arst_ff) ? 2'b00    : 
                                (red_write[3]) ? red_en_ff[1:0] : reg_en_rgt_top[1:0];

assign reg_d_lft_bot_in[4:0]  = (red_arst_ff) ? 5'b00000 : 
                                (red_write[0]) ? red_d_ff[4:0]  : reg_d_lft_bot[4:0] ;
assign reg_en_lft_bot_in[1:0] = (red_arst_ff) ? 2'b00    : 
                                (red_write[0]) ? red_en_ff[1:0] : reg_en_lft_bot[1:0];

assign reg_d_rgt_bot_in[4:0]  = (red_arst_ff) ? 5'b00000 : 
                                (red_write[1]) ? red_d_ff[4:0]  : reg_d_rgt_bot[4:0] ;
assign reg_en_rgt_bot_in[1:0] = (red_arst_ff) ? 2'b00    : 
                                (red_write[1]) ? red_en_ff[1:0] : reg_en_rgt_bot[1:0];



//always @(posedge l1clk) begin
always @(l1clk_fuse or red_arst_ff or red_wen_ff) begin

  // this is a b-latch so need to update when red_wen_ff or red_arst_ff changes
  // red_wen_ff or red_arst_ff can change in b-phase b/c of wr_inhibit signal
  if (~l1clk_fuse) begin
   reg_d_lft_top[4:0]  <= reg_d_lft_top_in[4:0] ;
   reg_en_lft_top[1:0] <= reg_en_lft_top_in[1:0] ;
   reg_d_rgt_top[4:0]  <= reg_d_rgt_top_in[4:0] ;
   reg_en_rgt_top[1:0] <= reg_en_rgt_top_in[1:0] ;
   reg_d_lft_bot[4:0]  <= reg_d_lft_bot_in[4:0] ;
   reg_en_lft_bot[1:0] <= reg_en_lft_bot_in[1:0] ;
   reg_d_rgt_bot[4:0]  <= reg_d_rgt_bot_in[4:0] ;
   reg_en_rgt_bot[1:0] <= reg_en_rgt_bot_in[1:0] ;
  end

end


endmodule


module n2_icd_bank (
  adr_ac_h, 
  adr_ac_l, 
  rd_en_a_l, 
  quaden_f_l, 
  wr_word_en_ac_l, 
  wr_waysel0_ac_l, 
  wr_waysel1_ac_l, 
  din0_a, 
  din1_a, 
  rd_worden_ac_l, 
  l1clk, 
  vnw_ary,
  reg_d_lft, 
  reg_d_rgt, 
  reg_en_lft, 
  reg_en_rgt, 
  dout_wy0_bc, 
  dout_wy1_bc, 
  dout_wy2_bc, 
  dout_wy3_bc);
wire [16:0] din0_a_rev;
wire [16:0] din1_a_rev;
wire [16:0] dout_wy0_bc_rev;
wire [16:0] dout_wy1_bc_rev;
wire [16:0] dout_wy2_bc_rev;
wire [16:0] dout_wy3_bc_rev;


input [5:0] 	adr_ac_h ;
input [5:0] 	adr_ac_l ;
input       	rd_en_a_l ;
input       	quaden_f_l ;
input [1:0] 	wr_word_en_ac_l ;
input [3:0] 	wr_waysel0_ac_l ;
input [3:0] 	wr_waysel1_ac_l ;
input [32:0] 	din0_a ;
input [32:0] 	din1_a ;
input [1:0]  	rd_worden_ac_l ;
input        	l1clk ;

input		vnw_ary;

input [4:0]     reg_d_lft;
input [4:0]     reg_d_rgt;
input [1:0]     reg_en_lft;
input [1:0]     reg_en_rgt;

output [32:0] 	dout_wy0_bc ;
output [32:0] 	dout_wy1_bc ;
output [32:0] 	dout_wy2_bc ;
output [32:0] 	dout_wy3_bc ;



assign din0_a_rev[16:0] = {din0_a[0],din0_a[1],din0_a[2],din0_a[3],din0_a[4],din0_a[5],din0_a[6],din0_a[7],din0_a[8],
                           din0_a[9],din0_a[10],din0_a[11],din0_a[12],din0_a[13],din0_a[14],din0_a[15],din0_a[16]};
assign din1_a_rev[16:0] = {din1_a[0],din1_a[1],din1_a[2],din1_a[3],din1_a[4],din1_a[5],din1_a[6],din1_a[7],din1_a[8],
                           din1_a[9],din1_a[10],din1_a[11],din1_a[12],din1_a[13],din1_a[14],din1_a[15],din1_a[16]};

n2_icd_lft_sb_array   left_sb_array (

	.adr_ac_h (adr_ac_h[5:0]),
	.adr_ac_l (adr_ac_l[5:0]),
	.rd_en_a_l (rd_en_a_l),
	.quaden_f_l (quaden_f_l),
	.wr_word_en_ac_l (wr_word_en_ac_l[1:0]) ,
	.wr_waysel0_ac_l (wr_waysel0_ac_l[3:0]),
	.wr_waysel1_ac_l (wr_waysel1_ac_l[3:0]),
	.din0_a (din0_a_rev[16:0]),
	.din1_a (din1_a_rev[16:0]),
	.rd_worden_ac_l (rd_worden_ac_l[1:0]),
	.l1clk (l1clk),

	.reg_d_lft (reg_d_lft[4:0]),
	.reg_en_lft (reg_en_lft[1:0]),

	.dout_wy0_bc (dout_wy0_bc_rev[16:0]),
	.dout_wy1_bc (dout_wy1_bc_rev[16:0]),
	.dout_wy2_bc (dout_wy2_bc_rev[16:0]),
	.dout_wy3_bc (dout_wy3_bc_rev[16:0]),
  .vnw_ary(vnw_ary) ) ; 

assign dout_wy0_bc[16:0] = {dout_wy0_bc_rev[0],dout_wy0_bc_rev[1],dout_wy0_bc_rev[2],dout_wy0_bc_rev[3],
                            dout_wy0_bc_rev[4], dout_wy0_bc_rev[5],dout_wy0_bc_rev[6],dout_wy0_bc_rev[7],
                            dout_wy0_bc_rev[8],dout_wy0_bc_rev[9], dout_wy0_bc_rev[10],dout_wy0_bc_rev[11],
                            dout_wy0_bc_rev[12],dout_wy0_bc_rev[13],dout_wy0_bc_rev[14], dout_wy0_bc_rev[15],dout_wy0_bc_rev[16]};

assign dout_wy1_bc[16:0] = {dout_wy1_bc_rev[0],dout_wy1_bc_rev[1],dout_wy1_bc_rev[2],dout_wy1_bc_rev[3],
                            dout_wy1_bc_rev[4],dout_wy1_bc_rev[5],dout_wy1_bc_rev[6],dout_wy1_bc_rev[7],
                            dout_wy1_bc_rev[8],dout_wy1_bc_rev[9],dout_wy1_bc_rev[10],dout_wy1_bc_rev[11],
                            dout_wy1_bc_rev[12],dout_wy1_bc_rev[13],dout_wy1_bc_rev[14],dout_wy1_bc_rev[15],dout_wy1_bc_rev[16]};

assign dout_wy2_bc[16:0] = {dout_wy2_bc_rev[0],dout_wy2_bc_rev[1],dout_wy2_bc_rev[2],dout_wy2_bc_rev[3],
                            dout_wy2_bc_rev[4],dout_wy2_bc_rev[5],dout_wy2_bc_rev[6],dout_wy2_bc_rev[7],
                            dout_wy2_bc_rev[8],dout_wy2_bc_rev[9],dout_wy2_bc_rev[10],dout_wy2_bc_rev[11],
                            dout_wy2_bc_rev[12],dout_wy2_bc_rev[13],dout_wy2_bc_rev[14],dout_wy2_bc_rev[15],dout_wy2_bc_rev[16]};

assign dout_wy3_bc[16:0] = {dout_wy3_bc_rev[0],dout_wy3_bc_rev[1],dout_wy3_bc_rev[2],dout_wy3_bc_rev[3],
                            dout_wy3_bc_rev[4],dout_wy3_bc_rev[5],dout_wy3_bc_rev[6],dout_wy3_bc_rev[7],
                            dout_wy3_bc_rev[8],dout_wy3_bc_rev[9],dout_wy3_bc_rev[10],dout_wy3_bc_rev[11],
                            dout_wy3_bc_rev[12],dout_wy3_bc_rev[13],dout_wy3_bc_rev[14],dout_wy3_bc_rev[15],dout_wy3_bc_rev[16]};

n2_icd_rgt_sb_array   right_sb_array (

	.adr_ac_h (adr_ac_h[5:0]),
	.adr_ac_l (adr_ac_l[5:0]),
	.rd_en_a_l (rd_en_a_l),
	.quaden_f_l (quaden_f_l),
	.wr_word_en_ac_l (wr_word_en_ac_l[1:0]) ,
	.wr_waysel0_ac_l (wr_waysel0_ac_l[3:0]),
	.wr_waysel1_ac_l (wr_waysel1_ac_l[3:0]),
	.din0_a (din0_a[32:17]),
	.din1_a (din1_a[32:17]),
	.rd_worden_ac_l (rd_worden_ac_l[1:0]),
	.l1clk (l1clk),

	.reg_d_rgt (reg_d_rgt[4:0]),
	.reg_en_rgt (reg_en_rgt[1:0]),

	.dout_wy0_bc (dout_wy0_bc[32:17]),
	.dout_wy1_bc (dout_wy1_bc[32:17]),
	.dout_wy2_bc (dout_wy2_bc[32:17]),
	.dout_wy3_bc (dout_wy3_bc[32:17]),
  .vnw_ary(vnw_ary) ) ; 


supply0 vss;
supply1 vdd;
endmodule


`ifndef FPGA

module n2_icd_lft_sb_array (
  adr_ac_h, 
  adr_ac_l, 
  rd_en_a_l, 
  quaden_f_l, 
  wr_word_en_ac_l, 
  wr_waysel0_ac_l, 
  wr_waysel1_ac_l, 
  din0_a, 
  din1_a, 
  rd_worden_ac_l, 
  l1clk, 
  reg_d_lft, 
  reg_en_lft, 
  vnw_ary, 
  dout_wy0_bc, 
  dout_wy1_bc, 
  dout_wy2_bc, 
  dout_wy3_bc);
wire [135:0] word_write_en;
wire [135:0] way_write_en;
wire [135:0] data_in;
wire rd_worden_ac_l_unused;
wire [5:0] adr_ac_l_unused;


input [5:0] 	adr_ac_h ;
input [5:0] 	adr_ac_l ;
input       	rd_en_a_l ;
input       	quaden_f_l ;
input [1:0] 	wr_word_en_ac_l ;
input [3:0] 	wr_waysel0_ac_l ;
input [3:0] 	wr_waysel1_ac_l ;
input [16:0] 	din0_a ;
input [16:0] 	din1_a ;
input [1:0]  	rd_worden_ac_l ;
input        	l1clk ;

input [4:0]     reg_d_lft;
input [1:0]     reg_en_lft;

input		vnw_ary;

output [16:0] 	dout_wy0_bc ;
output [16:0] 	dout_wy1_bc ;
output [16:0] 	dout_wy2_bc ;
output [16:0] 	dout_wy3_bc ;


reg     [143:0]   mem[63:0] ;


reg     [143:0]      local_dout;
reg     [135:0]      old_data;
reg     [143:0]      wr_data;
reg     [135:0]      dout;
wire    [143:0]      temp;
wire    [135:0]      din;

 reg    [16:0]  dout_wy0_bc ;
 reg    [16:0]  dout_wy1_bc ;
 reg    [16:0]  dout_wy2_bc ;
 reg    [16:0]  dout_wy3_bc ;

 reg    [16:0]  way3_word0 ;
 reg    [16:0]  way3_word1 ;
 reg    [16:0]  way2_word0 ;
 reg    [16:0]  way2_word1 ;
 reg    [16:0]  way1_word0 ;
 reg    [16:0]  way1_word1 ;
 reg    [16:0]  way0_word0 ;
 reg    [16:0]  way0_word1 ;
 reg    [31:0] 	n_reg1;
 reg    [31:0] 	n_reg2;
 reg    [31:0] 	n_reg3;
 reg            word_0_read;
integer n;

`ifndef NOINITMEM
// Emulate reset
integer i;
initial begin
  for (i=0; i<64; i=i+1) begin
   mem [i] = {144{1'b0}};
  end
  local_dout = {144{1'b0}};
end
`endif



// assign word_0_read    = ~rd_worden_ac_l[0] & ~rd_en_a_l ;
// assign red_value[4:0] = reg_d_lft[4:0] & {5{reg_en_lft[1] & reg_en_lft[0]}};
assign temp[143:0] = mem[adr_ac_h[5:0]] ;

////////////////////////////////
// Redunduncy Read shifter
////////////////////////////////
always @(reg_en_lft[1:0]  or reg_d_lft  or temp ) begin
	for (n = 0;  n < 136; n = n + 1 ) begin
		n_reg1 = n;
		if (reg_en_lft[1] & reg_en_lft[0] & ( reg_d_lft >= 5'b00000) & (reg_d_lft <= 5'b10000)) begin
     			if ( n_reg1[9:0] >= ((reg_d_lft + 5'h1) * 5'b01000))
				old_data[n] = temp[n+8] ;
		        else
				old_data[n] = temp[n] ;
		end else
			old_data[n] = temp[n+8] ;
	end 
end 

assign word_write_en[135:0] =  {68{~wr_word_en_ac_l[0], ~wr_word_en_ac_l[1]}} ;   
assign way_write_en[135:0]  =  {17{~wr_waysel0_ac_l[3] , ~wr_waysel1_ac_l[3] ,~wr_waysel0_ac_l[2] , ~wr_waysel1_ac_l[2],
                                   ~wr_waysel0_ac_l[1] , ~wr_waysel1_ac_l[1] ,~wr_waysel0_ac_l[0] , ~wr_waysel1_ac_l[0] }} ;

assign data_in[135:0] = {din0_a[16],din1_a[16] , din0_a[16],din1_a[16] ,  din0_a[16],din1_a[16] , din0_a[16],din1_a[16], // 135:128 
                         din0_a[15],din1_a[15] , din0_a[15],din1_a[15] ,  din0_a[15],din1_a[15] , din0_a[15],din1_a[15], // 127:120 
                         din0_a[14],din1_a[14] , din0_a[14],din1_a[14] ,  din0_a[14],din1_a[14] , din0_a[14],din1_a[14], // 119:112 
                         din0_a[13],din1_a[13] , din0_a[13],din1_a[13] ,  din0_a[13],din1_a[13] , din0_a[13],din1_a[13], // 111:104 
                         din0_a[12],din1_a[12] , din0_a[12],din1_a[12] ,  din0_a[12],din1_a[12] , din0_a[12],din1_a[12], // 103:096 
                         din0_a[11],din1_a[11] , din0_a[11],din1_a[11] ,  din0_a[11],din1_a[11] , din0_a[11],din1_a[11], // 095:088 
                         din0_a[10],din1_a[10] , din0_a[10],din1_a[10] ,  din0_a[10],din1_a[10] , din0_a[10],din1_a[10], // 087:080 
                         din0_a[9],din1_a[9] , din0_a[9],din1_a[9] ,  din0_a[9],din1_a[9] , din0_a[9],din1_a[9], // 079:072 
                         din0_a[8],din1_a[8] , din0_a[8],din1_a[8] ,  din0_a[8],din1_a[8] , din0_a[8],din1_a[8], // 071:064 
                         din0_a[7],din1_a[7] , din0_a[7],din1_a[7] ,  din0_a[7],din1_a[7] , din0_a[7],din1_a[7], // 063:056 
                         din0_a[6],din1_a[6] , din0_a[6],din1_a[6] ,  din0_a[6],din1_a[6] , din0_a[6],din1_a[6], // 055:048 
                         din0_a[5],din1_a[5] , din0_a[5],din1_a[5] ,  din0_a[5],din1_a[5] , din0_a[5],din1_a[5], // 047:040 
                         din0_a[4],din1_a[4] , din0_a[4],din1_a[4] ,  din0_a[4],din1_a[4] , din0_a[4],din1_a[4], // 039:032 
                         din0_a[3],din1_a[3] , din0_a[3],din1_a[3] ,  din0_a[3],din1_a[3] , din0_a[3],din1_a[3], // 031:024 
                         din0_a[2],din1_a[2] , din0_a[2],din1_a[2] ,  din0_a[2],din1_a[2] , din0_a[2],din1_a[2], // 023:016 
                         din0_a[1],din1_a[1] , din0_a[1],din1_a[1] ,  din0_a[1],din1_a[1] , din0_a[1],din1_a[1], // 015:008 
                         din0_a[0],din1_a[0] , din0_a[0],din1_a[0] ,  din0_a[0],din1_a[0] , din0_a[0],din1_a[0]};// 007:000


assign din[135:0] =  (   way_write_en[135:0] & word_write_en[135:0]  & data_in[135:0]  ) |
                     ( ~(way_write_en[135:0] & word_write_en[135:0]) & old_data[135:0] ) ;


////////////////////////////////
// Redunduncy write shifter
////////////////////////////////

always @(reg_en_lft[1:0] or reg_d_lft  or din ) begin
	for (n = 0;  n < 144; n = n + 1 ) begin
		n_reg2 = n;
		if (reg_en_lft[1] & reg_en_lft[0] & ( reg_d_lft >= 5'b00000) & (reg_d_lft <= 5'b10000)) begin
			if ( n_reg2[9:0] <  ((reg_d_lft + 5'h1) * 5'b01000 ))
				wr_data[n] = din[n] ;
			else begin
				if ( n_reg2[9:0] <  ((reg_d_lft + 5'h2)  * 5'b01000 ))
					wr_data[n] = 1'bx ; 
				else
					wr_data[n] = din[n-8] ;
			end
		end else begin
			if (n < 8 ) 
				wr_data[n] = 1'bx ;
			else  
				wr_data[n] = din[n-8] ;
		end
	end
end 

//////////////////////
// Read/write array
//////////////////////

always @ (l1clk or wr_data[143:0] or wr_word_en_ac_l[1:0] or adr_ac_h[5:0] or quaden_f_l or vnw_ary) begin
    if (l1clk & ~quaden_f_l & (~wr_word_en_ac_l[1] | ~wr_word_en_ac_l[0]) & vnw_ary) begin
        mem[adr_ac_h] <= wr_data[143:0] ;
        
        
    end // end if
end // end always



 always @(l1clk or rd_en_a_l or reg_en_lft[1:0] or  reg_d_lft or adr_ac_h[5:0] or rd_worden_ac_l[0] or vnw_ary) begin
    if (l1clk | rd_en_a_l) begin
     dout_wy0_bc[16:0] <= 17'h0;
     dout_wy1_bc[16:0] <= 17'h0;
     dout_wy2_bc[16:0] <= 17'h0;
     dout_wy3_bc[16:0] <= 17'h0;
     word_0_read       <= ~rd_worden_ac_l[0];
     local_dout[143:0] <=  rd_en_a_l ? 144'h0 : mem[adr_ac_h[5:0]];
    end
    if (~l1clk & ~rd_en_a_l & vnw_ary) begin


 
 

     		////////////////////////////////
     		// Redunduncy Read shifter
     		////////////////////////////////

		for (n = 0;  n < 136; n = n + 1 ) begin
			n_reg3 = n;
			if (reg_en_lft[1] & reg_en_lft[0] & ( reg_d_lft >= 5'b00000) & (reg_d_lft <= 5'b10000)) begin
     				if ( n_reg3[9:0] >= ((reg_d_lft + 5'h1) * 5'b01000))
					dout[n] = local_dout[n+8] ;
		       	 else
					dout[n] = local_dout[n] ;
			end else
				dout[n] = local_dout[n+8] ;
		end 
     		/////////////end redundacy shifter ///////////////////

     		way3_word0[16:0]  = {dout[135], dout[127], dout[119] , dout[111], 
	         		             dout[103], dout[95], dout[87] , dout[79],
                          	     dout[71], dout[63], dout[55] , dout[47],
                          	     dout[39], dout[31], dout[23] , dout[15],
                          	     dout[7] } ;

     		way3_word1[16:0]  = {dout[134], dout[126], dout[118] , dout[110], 
                          	     dout[102], dout[94], dout[86] , dout[78],
                          	     dout[70], dout[62], dout[54] , dout[46],
                          	     dout[38], dout[30], dout[22] , dout[14],
                          	     dout[6] } ;

     		way2_word0[16:0]  = {dout[133], dout[125], dout[117] , dout[109], 
                          	     dout[101], dout[93], dout[85] , dout[77],
                          	     dout[69], dout[61], dout[53] , dout[45],
                          	     dout[37], dout[29], dout[21] , dout[13],
                          	     dout[5] } ;

     		way2_word1[16:0]  = {dout[132], dout[124], dout[116] , dout[108], 
                          	     dout[100], dout[92], dout[84] , dout[76],
                          	     dout[68], dout[60], dout[52] , dout[44],
                          	     dout[36], dout[28], dout[20] , dout[12],
                          	     dout[4] } ;

     		way1_word0[16:0]  = {dout[131], dout[123], dout[115] , dout[107], 
                          	     dout[99], dout[91], dout[83] , dout[75],
                          	     dout[67], dout[59], dout[51] , dout[43],
                          	     dout[35], dout[27], dout[19] , dout[11],
                          	     dout[3] } ;

     		way1_word1[16:0]  = {dout[130], dout[122], dout[114] , dout[106], 
                          	     dout[98], dout[90], dout[82] , dout[74],
                          	     dout[66], dout[58], dout[50] , dout[42],
                          	     dout[34], dout[26], dout[18] , dout[10],
                          	     dout[2] } ;

		way0_word0[16:0]  = {dout[129], dout[121], dout[113] , dout[105], 
                          	     dout[97], dout[89], dout[81] , dout[73],
                          	     dout[65], dout[57], dout[49] , dout[41],
                          	     dout[33], dout[25], dout[17] , dout[9],
                          	     dout[1] } ;

		way0_word1[16:0]  = {dout[128], dout[120], dout[112] , dout[104], 
                          	     dout[96], dout[88], dout[80] , dout[72],
                          	     dout[64], dout[56], dout[48] , dout[40],
                          	     dout[32], dout[24], dout[16] , dout[8],
                          	     dout[0] } ;

		///////////////////////
		// rd_data column mux
		///////////////////////
       		dout_wy0_bc[16:0] <=  word_0_read ? way0_word0[16:0] : way0_word1[16:0] ;
       		dout_wy1_bc[16:0] <=  word_0_read ? way1_word0[16:0] : way1_word1[16:0] ;
       		dout_wy2_bc[16:0] <=  word_0_read ? way2_word0[16:0] : way2_word1[16:0] ;
       		dout_wy3_bc[16:0] <=  word_0_read ? way3_word0[16:0] : way3_word1[16:0] ;

    end // if (~rd_en_a_l) 
end // always

// Precharge
// always @ (posedge l1clk) begin
//      // local_dout[143:0] = 144'h0;
//      dout_wy0_bc[16:0] <= 17'h0;
//      dout_wy1_bc[16:0] <= 17'h0;
//      dout_wy2_bc[16:0] <= 17'h0;
//      dout_wy3_bc[16:0] <= 17'h0;
// end

////////////////////////////////
// Redunduncy Read shifter
////////////////////////////////
// always @(red_value or local_dout ) begin
//   for (n = 0;  n < 144; n = n + 1 ) begin
//      if ( n >= (red_value * 8 ))
//        dout[n] = local_dout[n+8] ;
//      else
//        dout[n] = local_dout[n] ;
//   end
// end 

assign rd_worden_ac_l_unused = rd_worden_ac_l[1] ;
assign adr_ac_l_unused[5:0]  = adr_ac_l[5:0] ;


supply0 vss;
supply1 vdd;
endmodule
`endif 	// `ifndef FPGA

`ifdef FPGA 

module n2_icd_lft_sb_array(adr_ac_h, adr_ac_l, rd_en_a_l, quaden_f_l, 
	wr_word_en_ac_l, wr_waysel0_ac_l, wr_waysel1_ac_l, din0_a, din1_a, 
	rd_worden_ac_l, l1clk, reg_d_lft, reg_en_lft, vnw_ary, dout_wy0_bc, 
	dout_wy1_bc, dout_wy2_bc, dout_wy3_bc);

	input	[5:0]		adr_ac_h;
	input	[5:0]		adr_ac_l;
	input			rd_en_a_l;
	input			quaden_f_l;
	input	[1:0]		wr_word_en_ac_l;
	input	[3:0]		wr_waysel0_ac_l;
	input	[3:0]		wr_waysel1_ac_l;
	input	[16:0]		din0_a;
	input	[16:0]		din1_a;
	input	[1:0]		rd_worden_ac_l;
	input			l1clk;
	input	[4:0]		reg_d_lft;
	input	[1:0]		reg_en_lft;
	input			vnw_ary;
	output	[16:0]		dout_wy0_bc;
	output	[16:0]		dout_wy1_bc;
	output	[16:0]		dout_wy2_bc;
	output	[16:0]		dout_wy3_bc;

	wire	[135:0]		word_write_en;
	wire	[135:0]		way_write_en;
	wire	[135:0]		data_in;
	wire			rd_worden_ac_l_unused;
	wire	[5:0]		adr_ac_l_unused;

	reg	[143:0]		mem[63:0];
	reg	[143:0]		local_dout;
	reg	[135:0]		old_data;
	reg	[143:0]		wr_data;
	reg	[135:0]		dout;
	wire	[143:0]		temp;
	wire	[135:0]		din;
	reg	[16:0]		dout_wy0_bc;
	reg	[16:0]		dout_wy1_bc;
	reg	[16:0]		dout_wy2_bc;
	reg	[16:0]		dout_wy3_bc;
	reg	[16:0]		way3_word0;
	reg	[16:0]		way3_word1;
	reg	[16:0]		way2_word0;
	reg	[16:0]		way2_word1;
	reg	[16:0]		way1_word0;
	reg	[16:0]		way1_word1;
	reg	[16:0]		way0_word0;
	reg	[16:0]		way0_word1;
	reg	[31:0]		n_reg1;
	reg	[31:0]		n_reg2;
	reg	[31:0]		n_reg3;
	reg			word_0_read;
	integer			n;
	integer			i;
	supply0			vss;
	supply1			vdd;

	assign temp[143:0] = mem[adr_ac_h[5:0]];
	assign word_write_en[135:0] = {68 {(~wr_word_en_ac_l[0]), 
		(~wr_word_en_ac_l[1])}};
	assign way_write_en[135:0] = {17 {(~wr_waysel0_ac_l[3]), 
		(~wr_waysel1_ac_l[3]), (~wr_waysel0_ac_l[2]), 
		(~wr_waysel1_ac_l[2]), (~wr_waysel0_ac_l[1]), 
		(~wr_waysel1_ac_l[1]), (~wr_waysel0_ac_l[0]), 
		(~wr_waysel1_ac_l[0])}};
	assign data_in[135:0] = {din0_a[16], din1_a[16], din0_a[16], din1_a[16],
		din0_a[16], din1_a[16], din0_a[16], din1_a[16], din0_a[15], 
		din1_a[15], din0_a[15], din1_a[15], din0_a[15], din1_a[15], 
		din0_a[15], din1_a[15], din0_a[14], din1_a[14], din0_a[14], 
		din1_a[14], din0_a[14], din1_a[14], din0_a[14], din1_a[14], 
		din0_a[13], din1_a[13], din0_a[13], din1_a[13], din0_a[13], 
		din1_a[13], din0_a[13], din1_a[13], din0_a[12], din1_a[12], 
		din0_a[12], din1_a[12], din0_a[12], din1_a[12], din0_a[12], 
		din1_a[12], din0_a[11], din1_a[11], din0_a[11], din1_a[11], 
		din0_a[11], din1_a[11], din0_a[11], din1_a[11], din0_a[10], 
		din1_a[10], din0_a[10], din1_a[10], din0_a[10], din1_a[10], 
		din0_a[10], din1_a[10], din0_a[9], din1_a[9], din0_a[9], 
		din1_a[9], din0_a[9], din1_a[9], din0_a[9], din1_a[9], 
		din0_a[8], din1_a[8], din0_a[8], din1_a[8], din0_a[8], 
		din1_a[8], din0_a[8], din1_a[8], din0_a[7], din1_a[7], 
		din0_a[7], din1_a[7], din0_a[7], din1_a[7], din0_a[7], 
		din1_a[7], din0_a[6], din1_a[6], din0_a[6], din1_a[6], 
		din0_a[6], din1_a[6], din0_a[6], din1_a[6], din0_a[5], 
		din1_a[5], din0_a[5], din1_a[5], din0_a[5], din1_a[5], 
		din0_a[5], din1_a[5], din0_a[4], din1_a[4], din0_a[4], 
		din1_a[4], din0_a[4], din1_a[4], din0_a[4], din1_a[4], 
		din0_a[3], din1_a[3], din0_a[3], din1_a[3], din0_a[3], 
		din1_a[3], din0_a[3], din1_a[3], din0_a[2], din1_a[2], 
		din0_a[2], din1_a[2], din0_a[2], din1_a[2], din0_a[2], 
		din1_a[2], din0_a[1], din1_a[1], din0_a[1], din1_a[1], 
		din0_a[1], din1_a[1], din0_a[1], din1_a[1], din0_a[0], 
		din1_a[0], din0_a[0], din1_a[0], din0_a[0], din1_a[0], 
		din0_a[0], din1_a[0]};
	assign din[135:0] = (((way_write_en[135:0] & word_write_en[135:0]) & 
		data_in[135:0]) | ((~(way_write_en[135:0] & word_write_en[135:0]
		)) & old_data[135:0]));
	assign rd_worden_ac_l_unused = rd_worden_ac_l[1];
	assign adr_ac_l_unused[5:0] = adr_ac_l[5:0];

	initial begin
	  for (i = 0; (i < 64); i = (i + 1)) begin
	    mem[i] = {144 {1'b0}};
	  end
	  local_dout = {144 {1'b0}};
	end
	always @(reg_en_lft[1:0] or reg_d_lft or temp) begin
	  for (n = 0; (n < 136); n = (n + 1)) begin
	    n_reg1 = n;
	    if (((reg_en_lft[1] & reg_en_lft[0]) & (reg_d_lft >= 5'b0)) & (
		    reg_d_lft <= 5'b10000)) begin
	      if (n_reg1[9:0] >= ((reg_d_lft + 5'b1) * 5'b01000)) begin
		old_data[n] = temp[(n + 8)];
	      end
	      else begin
		old_data[n] = temp[n];
	      end
	    end
	    else begin
	      old_data[n] = temp[(n + 8)];
	    end
	  end
	end
	always @(reg_en_lft[1:0] or reg_d_lft or din) begin
	  for (n = 0; (n < 144); n = (n + 1)) begin
	    n_reg2 = n;
	    if (((reg_en_lft[1] & reg_en_lft[0]) & (reg_d_lft >= 5'b0)) & (
		    reg_d_lft <= 5'b10000)) begin
	      if (n_reg2[9:0] < ((reg_d_lft + 5'b1) * 5'b01000)) begin
		wr_data[n] = din[n];
	      end
	      else
		begin
		  if (n_reg2[9:0] < ((reg_d_lft + 5'b00010) * 5'b01000)) begin
		    wr_data[n] = 1'bx;
		  end
		  else begin
		    wr_data[n] = din[(n - 8)];
		  end
		end
	    end
	    else
	      begin
		if (n < 8) begin
		  wr_data[n] = 1'bx;
		end
		else begin
		  wr_data[n] = din[(n - 8)];
		end
	      end
	  end
	end

	always @(l1clk or wr_data[143:0] or wr_word_en_ac_l[1:0] or 
		adr_ac_h[5:0] or quaden_f_l or vnw_ary) begin
	  if (((l1clk & (~quaden_f_l)) & ((~wr_word_en_ac_l[1]) | (~
		  wr_word_en_ac_l[0]))) & vnw_ary) begin
	    mem[adr_ac_h] <= wr_data[143:0];
	  end
	end
	always @(l1clk or adr_ac_h[5:0] or rd_worden_ac_l[0]) begin
	  if (l1clk) begin
	    word_0_read <= (~rd_worden_ac_l[0]);
	    local_dout[143:0] <= mem[adr_ac_h[5:0]];
	  end
	end

	always @(negedge l1clk) begin
	  if (~rd_en_a_l) begin
	    for (n = 0; (n < 136); n = (n + 1)) begin
	      n_reg3 = n;
	      if (((reg_en_lft[1] & reg_en_lft[0]) & (reg_d_lft >= 5'b0)) & (
		      reg_d_lft <= 5'b10000)) begin
		if (n_reg3[9:0] >= ((reg_d_lft + 5'b1) * 5'b01000)) begin
		  dout[n] = local_dout[(n + 8)];
		end
		else begin
		  dout[n] = local_dout[n];
		end
	      end
	      else begin
		dout[n] = local_dout[(n + 8)];
	      end
	    end
	    way3_word0[16:0] = {dout[135], dout[127], dout[119], dout[111], 
		    dout[103], dout[95], dout[87], dout[79], dout[71], dout[63],
		    dout[55], dout[47], dout[39], dout[31], dout[23], dout[15], 
		    dout[7]};
	    way3_word1[16:0] = {dout[134], dout[126], dout[118], dout[110], 
		    dout[102], dout[94], dout[86], dout[78], dout[70], dout[62],
		    dout[54], dout[46], dout[38], dout[30], dout[22], dout[14], 
		    dout[6]};
	    way2_word0[16:0] = {dout[133], dout[125], dout[117], dout[109], 
		    dout[101], dout[93], dout[85], dout[77], dout[69], dout[61],
		    dout[53], dout[45], dout[37], dout[29], dout[21], dout[13], 
		    dout[5]};
	    way2_word1[16:0] = {dout[132], dout[124], dout[116], dout[108], 
		    dout[100], dout[92], dout[84], dout[76], dout[68], dout[60],
		    dout[52], dout[44], dout[36], dout[28], dout[20], dout[12], 
		    dout[4]};
	    way1_word0[16:0] = {dout[131], dout[123], dout[115], dout[107], 
		    dout[99], dout[91], dout[83], dout[75], dout[67], dout[59], 
		    dout[51], dout[43], dout[35], dout[27], dout[19], dout[11], 
		    dout[3]};
	    way1_word1[16:0] = {dout[130], dout[122], dout[114], dout[106], 
		    dout[98], dout[90], dout[82], dout[74], dout[66], dout[58], 
		    dout[50], dout[42], dout[34], dout[26], dout[18], dout[10], 
		    dout[2]};
	    way0_word0[16:0] = {dout[129], dout[121], dout[113], dout[105], 
		    dout[97], dout[89], dout[81], dout[73], dout[65], dout[57], 
		    dout[49], dout[41], dout[33], dout[25], dout[17], dout[9], 
		    dout[1]};
	    way0_word1[16:0] = {dout[128], dout[120], dout[112], dout[104], 
		    dout[96], dout[88], dout[80], dout[72], dout[64], dout[56], 
		    dout[48], dout[40], dout[32], dout[24], dout[16], dout[8], 
		    dout[0]};
	    dout_wy0_bc[16:0] <= (word_0_read ? way0_word0[16:0] : 
		    way0_word1[16:0]);
	    dout_wy1_bc[16:0] <= (word_0_read ? way1_word0[16:0] : 
		    way1_word1[16:0]);
	    dout_wy2_bc[16:0] <= (word_0_read ? way2_word0[16:0] : 
		    way2_word1[16:0]);
	    dout_wy3_bc[16:0] <= (word_0_read ? way3_word0[16:0] : 
		    way3_word1[16:0]);
	  end
	end
endmodule

`endif 	// `ifdef FPGA






`ifndef FPGA
module n2_icd_rgt_sb_array (
  adr_ac_h, 
  adr_ac_l, 
  rd_en_a_l, 
  quaden_f_l, 
  wr_word_en_ac_l, 
  wr_waysel0_ac_l, 
  wr_waysel1_ac_l, 
  din0_a, 
  din1_a, 
  rd_worden_ac_l, 
  l1clk, 
  vnw_ary, 
  reg_d_rgt, 
  reg_en_rgt, 
  dout_wy0_bc, 
  dout_wy1_bc, 
  dout_wy2_bc, 
  dout_wy3_bc);
wire [127:0] word_write_en;
wire [127:0] way_write_en;
wire [127:0] data_in;
wire rd_worden_ac_l_unused;
wire [5:0] adr_ac_l_unused;


input [5:0] 	adr_ac_h ;
input [5:0] 	adr_ac_l ;
input       	rd_en_a_l ;
input       	quaden_f_l ;
input [1:0] 	wr_word_en_ac_l ;
input [3:0] 	wr_waysel0_ac_l ;
input [3:0] 	wr_waysel1_ac_l ;
input [32:17] 	din0_a ;
input [32:17] 	din1_a ;
input [1:0]  	rd_worden_ac_l ;
input        	l1clk ;

input		vnw_ary;

input [4:0]     reg_d_rgt;
input [1:0]     reg_en_rgt;

output [15:0] 	dout_wy0_bc ;
output [15:0] 	dout_wy1_bc ;
output [15:0] 	dout_wy2_bc ;
output [15:0] 	dout_wy3_bc ;




reg     [135:0]   mem[63:0] ;


reg     [135:0]      local_dout;
reg     [127:0]      old_data;
reg     [135:0]      wr_data;
reg     [127:0]      dout;
wire    [135:0]      temp;
wire    [127:0]      din;

 reg    [15:0]  dout_wy0_bc ;
 reg    [15:0]  dout_wy1_bc ;
 reg    [15:0]  dout_wy2_bc ;
 reg    [15:0]  dout_wy3_bc ;

 reg    [15:0]  way3_word0 ;
 reg    [15:0]  way3_word1 ;
 reg    [15:0]  way2_word0 ;
 reg    [15:0]  way2_word1 ;
 reg    [15:0]  way1_word0 ;
 reg    [15:0]  way1_word1 ;
 reg    [15:0]  way0_word0 ;
 reg    [15:0]  way0_word1 ;
 reg    [31:0] 	n_reg1;
 reg    [31:0] 	n_reg2;
 reg    [31:0] 	n_reg3;
 reg            word_0_read ;

integer n;


`ifndef NOINITMEM
// Emulate reset
integer i;
initial begin
  for (i=0; i<64; i=i+1) begin
   mem [i] = {136{1'b0}};
  end
  local_dout = {136{1'b0}};
end
`endif


// assign word_0_read = ~rd_worden_ac_l[0] & ~rd_en_a_l ;
// assign red_value[4:0] = reg_d_rgt[4:0] & {5{reg_en_rgt[1] & reg_en_rgt[0]}};
assign temp[135:0] = mem[adr_ac_h[5:0]] ;

////////////////////////////////
// Redunduncy Read shifter
////////////////////////////////
always @(reg_en_rgt[1:0]  or reg_d_rgt  or temp ) begin
        for (n = 0;  n < 128; n = n + 1 ) begin
		n_reg1 = n;
                if (reg_en_rgt[1] & reg_en_rgt[0] & ( reg_d_rgt >= 5'b00000) & (reg_d_rgt <= 5'b01111)) begin
                        if ( n_reg1[9:0] >= ((reg_d_rgt + 5'h1) * 5'b01000))
                                old_data[n] = temp[n+8] ;
                        else
                                old_data[n] = temp[n] ;
                end else
                        old_data[n] = temp[n+8] ;
        end
end

assign word_write_en[127:0] =  {64{~wr_word_en_ac_l[0], ~wr_word_en_ac_l[1]}} ;   
assign way_write_en[127:0]  =  {16{~wr_waysel0_ac_l[0] , ~wr_waysel1_ac_l[0] ,~wr_waysel0_ac_l[1] , ~wr_waysel1_ac_l[1],
                                   ~wr_waysel0_ac_l[2] , ~wr_waysel1_ac_l[2] ,~wr_waysel0_ac_l[3] , ~wr_waysel1_ac_l[3] }} ;

assign data_in[127:0] = {din0_a[32],din1_a[32] , din0_a[32],din1_a[32] ,  din0_a[32],din1_a[32] , din0_a[32],din1_a[32], // 127:120 
                         din0_a[31],din1_a[31] , din0_a[31],din1_a[31] ,  din0_a[31],din1_a[31] , din0_a[31],din1_a[31], // 119:112 
                         din0_a[30],din1_a[30] , din0_a[30],din1_a[30] ,  din0_a[30],din1_a[30] , din0_a[30],din1_a[30], // 111:104 
                         din0_a[29],din1_a[29] , din0_a[29],din1_a[29] ,  din0_a[29],din1_a[29] , din0_a[29],din1_a[29], // 103:096 
                         din0_a[28],din1_a[28] , din0_a[28],din1_a[28] ,  din0_a[28],din1_a[28] , din0_a[28],din1_a[28], // 095:088 
                         din0_a[27],din1_a[27] , din0_a[27],din1_a[27] ,  din0_a[27],din1_a[27] , din0_a[27],din1_a[27], // 087:080 
                         din0_a[26],din1_a[26] , din0_a[26],din1_a[26] ,  din0_a[26],din1_a[26] , din0_a[26],din1_a[26], // 079:072 
                         din0_a[25],din1_a[25] , din0_a[25],din1_a[25] ,  din0_a[25],din1_a[25] , din0_a[25],din1_a[25], // 071:064 
                         din0_a[24],din1_a[24] , din0_a[24],din1_a[24] ,  din0_a[24],din1_a[24] , din0_a[24],din1_a[24], // 063:056 
                         din0_a[23],din1_a[23] , din0_a[23],din1_a[23] ,  din0_a[23],din1_a[23] , din0_a[23],din1_a[23], // 055:048 
                         din0_a[22],din1_a[22] , din0_a[22],din1_a[22] ,  din0_a[22],din1_a[22] , din0_a[22],din1_a[22], // 047:040 
                         din0_a[21],din1_a[21] , din0_a[21],din1_a[21] ,  din0_a[21],din1_a[21] , din0_a[21],din1_a[21], // 039:032 
                         din0_a[20],din1_a[20] , din0_a[20],din1_a[20] ,  din0_a[20],din1_a[20] , din0_a[20],din1_a[20], // 031:024
                         din0_a[19],din1_a[19] , din0_a[19],din1_a[19] ,  din0_a[19],din1_a[19] , din0_a[19],din1_a[19], // 023:016 
                         din0_a[18],din1_a[18] , din0_a[18],din1_a[18] ,  din0_a[18],din1_a[18] , din0_a[18],din1_a[18], // 015:008 
                         din0_a[17],din1_a[17] , din0_a[17],din1_a[17] ,  din0_a[17],din1_a[17] , din0_a[17],din1_a[17]};// 007:000 


assign din[127:0] =  (   way_write_en[127:0] & word_write_en[127:0]  & data_in[127:0]  ) |
                     ( ~(way_write_en[127:0] & word_write_en[127:0]) & old_data[127:0] ) ;

////////////////////////////////
// Redunduncy write shifter
////////////////////////////////
always @(reg_en_rgt[1:0] or reg_d_rgt  or din ) begin
        for (n = 0;  n < 136; n = n + 1 ) begin
		n_reg2 = n;
                if (reg_en_rgt[1] & reg_en_rgt[0] & ( reg_d_rgt >= 5'b00000) & (reg_d_rgt <= 5'b01111)) begin
                        if ( n_reg2[9:0] <  ((reg_d_rgt + 5'h1) * 5'b01000 ))
                                wr_data[n] = din[n] ;
                        else begin
                                if ( n_reg2[9:0] <  ((reg_d_rgt + 5'h2)  * 5'b01000 ))
                                        wr_data[n] = 1'bx ;
                                else
                                        wr_data[n] = din[n-8] ;
                        end
                end else begin
			if (n < 8) 
				wr_data[n] = 1'bx ;
			else
				wr_data[n] = din[n-8] ;
		end
        end
end

//////////////////////
// Read/write array
//////////////////////


always @ (l1clk or wr_data[135:0] or wr_word_en_ac_l[1:0] or adr_ac_h[5:0] or quaden_f_l or vnw_ary) begin
    if (l1clk  & ~quaden_f_l & (~wr_word_en_ac_l[1] | ~wr_word_en_ac_l[0]) & vnw_ary) begin
        mem[adr_ac_h] <= wr_data[135:0] ;
        
        
    end // end if
end // end always




 always @(l1clk or rd_en_a_l or reg_en_rgt[1:0] or  reg_d_rgt or adr_ac_h[5:0] or rd_worden_ac_l[0] or vnw_ary) begin
    if (l1clk | rd_en_a_l) begin
     dout_wy0_bc[15:0] <= 16'h0;
     dout_wy1_bc[15:0] <= 16'h0;
     dout_wy2_bc[15:0] <= 16'h0;
     dout_wy3_bc[15:0] <= 16'h0;
     word_0_read       <= ~rd_worden_ac_l[0];
     local_dout[135:0] <=  rd_en_a_l ? 136'h0 : mem[adr_ac_h[5:0]];
    end
    if (~l1clk & ~rd_en_a_l & vnw_ary) begin


 
 


    		////////////////////////////////
    		// Redunduncy Read shifter
    		////////////////////////////////
        	for (n = 0;  n < 128; n = n + 1 ) begin
			n_reg3 = n;
			if (reg_en_rgt[1] & reg_en_rgt[0] & ( reg_d_rgt >= 5'b00000) & (reg_d_rgt <= 5'b01111)) begin
				if ( n_reg3[9:0] >= ((reg_d_rgt + 5'h1) * 5'b01000))
                                	dout[n] = local_dout[n+8] ;
                        	else
                                	dout[n] = local_dout[n] ;
                	end else
                        	dout[n] = local_dout[n+8] ;
        	end
    		///////////////////////
    		// rd_data column mux
    		///////////////////////

    		way0_word0[15:0]  = {dout[127], dout[119] , dout[111], dout[103], 
       		                     dout[95], dout[87] , dout[79], dout[71], 
       		                     dout[63], dout[55] , dout[47], dout[39], 
       		                     dout[31], dout[23] , dout[15], dout[7] } ;

    		way0_word1[15:0]  = {dout[126], dout[118] , dout[110], dout[102], 
       		                     dout[94], dout[86] , dout[78], dout[70], 
       		                     dout[62], dout[54] , dout[46], dout[38], 
       		                     dout[30], dout[22] , dout[14], dout[6] } ;

    		way1_word0[15:0]  = {dout[125], dout[117] , dout[109], dout[101], 
       		                     dout[93], dout[85] , dout[77], dout[69], 
       		                     dout[61], dout[53] , dout[45], dout[37], 
       		                     dout[29], dout[21] , dout[13], dout[5] } ;

    		way1_word1[15:0]  = {dout[124], dout[116] , dout[108], dout[100], 
       		                     dout[92], dout[84] , dout[76], dout[68], 
       		                     dout[60], dout[52] , dout[44], dout[36], 
       		                     dout[28], dout[20] , dout[12], dout[4] } ;

    		way2_word0[15:0]  = {dout[123], dout[115] , dout[107], dout[99], 
       		                     dout[91], dout[83] , dout[75], dout[67], 
       		                     dout[59], dout[51] , dout[43], dout[35], 
       		                     dout[27], dout[19] , dout[11], dout[3] } ;

    		way2_word1[15:0]  = {dout[122], dout[114] , dout[106], dout[98], 
       		                     dout[90], dout[82] , dout[74], dout[66], 
       		                     dout[58], dout[50] , dout[42], dout[34], 
       		                     dout[26], dout[18] , dout[10], dout[2] } ;

    		way3_word0[15:0]  = {dout[121], dout[113] , dout[105], dout[97], 
       		                     dout[89], dout[81] , dout[73], dout[65], 
       		                     dout[57], dout[49] , dout[41], dout[33], 
       		                     dout[25], dout[17] , dout[9], dout[1] } ;

    		way3_word1[15:0]  = {dout[120], dout[112] , dout[104], dout[96], 
       		                     dout[88], dout[80] , dout[72], dout[64], 
       		                     dout[56], dout[48] , dout[40], dout[32], 
       		                     dout[24], dout[16] , dout[8], dout[0] } ;

    		dout_wy0_bc[15:0] <=  word_0_read ? way0_word0[15:0] : way0_word1[15:0] ;  
    		dout_wy1_bc[15:0] <=  word_0_read ? way1_word0[15:0] : way1_word1[15:0] ;  
    		dout_wy2_bc[15:0] <=  word_0_read ? way2_word0[15:0] : way2_word1[15:0] ;  
    		dout_wy3_bc[15:0] <=  word_0_read ? way3_word0[15:0] : way3_word1[15:0] ;  

    end // if (~rd_en_a_l)
end // always

// Precharge
// always @ (posedge l1clk) begin
// local_dout[135:0] = 136'h0;
//	dout_wy0_bc[15:0] <= 16'b0;
//	dout_wy1_bc[15:0] <= 16'b0;
//	dout_wy2_bc[15:0] <= 16'b0;
//	dout_wy3_bc[15:0] <= 16'b0;
//end

////////////////////////////////
// Redunduncy Read shifter
////////////////////////////////
// always @(red_value or local_dout ) begin
//   for (n = 0;  n < 136; n = n + 1 ) begin
//      if ( n >= (red_value * 8 ))
//        dout[n] = local_dout[n+8] ;
//      else
//        dout[n] = local_dout[n] ;
//   end
// end

assign rd_worden_ac_l_unused = rd_worden_ac_l[1] ;
assign adr_ac_l_unused[5:0]  = adr_ac_l[5:0] ;


supply0 vss;
supply1 vdd;
endmodule
`endif	// `ifndef FPGA

`ifdef FPGA

module n2_icd_rgt_sb_array(adr_ac_h, adr_ac_l, rd_en_a_l, quaden_f_l, 
	wr_word_en_ac_l, wr_waysel0_ac_l, wr_waysel1_ac_l, din0_a, din1_a, 
	rd_worden_ac_l, l1clk, vnw_ary, reg_d_rgt, reg_en_rgt, dout_wy0_bc, 
	dout_wy1_bc, dout_wy2_bc, dout_wy3_bc);

	input	[5:0]		adr_ac_h;
	input	[5:0]		adr_ac_l;
	input			rd_en_a_l;
	input			quaden_f_l;
	input	[1:0]		wr_word_en_ac_l;
	input	[3:0]		wr_waysel0_ac_l;
	input	[3:0]		wr_waysel1_ac_l;
	input	[32:17]		din0_a;
	input	[32:17]		din1_a;
	input	[1:0]		rd_worden_ac_l;
	input			l1clk;
	input			vnw_ary;
	input	[4:0]		reg_d_rgt;
	input	[1:0]		reg_en_rgt;
	output	[15:0]		dout_wy0_bc;
	output	[15:0]		dout_wy1_bc;
	output	[15:0]		dout_wy2_bc;
	output	[15:0]		dout_wy3_bc;

	wire	[127:0]		word_write_en;
	wire	[127:0]		way_write_en;
	wire	[127:0]		data_in;
	wire			rd_worden_ac_l_unused;
	wire	[5:0]		adr_ac_l_unused;

	reg	[135:0]		mem[63:0];
	reg	[135:0]		local_dout;
	reg	[127:0]		old_data;
	reg	[135:0]		wr_data;
	reg	[127:0]		dout;
	wire	[135:0]		temp;
	wire	[127:0]		din;
	reg	[15:0]		dout_wy0_bc;
	reg	[15:0]		dout_wy1_bc;
	reg	[15:0]		dout_wy2_bc;
	reg	[15:0]		dout_wy3_bc;
	reg	[15:0]		way3_word0;
	reg	[15:0]		way3_word1;
	reg	[15:0]		way2_word0;
	reg	[15:0]		way2_word1;
	reg	[15:0]		way1_word0;
	reg	[15:0]		way1_word1;
	reg	[15:0]		way0_word0;
	reg	[15:0]		way0_word1;
	reg	[31:0]		n_reg1;
	reg	[31:0]		n_reg2;
	reg	[31:0]		n_reg3;
	reg			word_0_read;
	integer			n;
	integer			i;
	supply0			vss;
	supply1			vdd;

	assign temp[135:0] = mem[adr_ac_h[5:0]];
	assign word_write_en[127:0] = {64 {(~wr_word_en_ac_l[0]), 
		(~wr_word_en_ac_l[1])}};
	assign way_write_en[127:0] = {16 {(~wr_waysel0_ac_l[0]), 
		(~wr_waysel1_ac_l[0]), (~wr_waysel0_ac_l[1]), 
		(~wr_waysel1_ac_l[1]), (~wr_waysel0_ac_l[2]), 
		(~wr_waysel1_ac_l[2]), (~wr_waysel0_ac_l[3]), 
		(~wr_waysel1_ac_l[3])}};
	assign data_in[127:0] = {din0_a[32], din1_a[32], din0_a[32], din1_a[32],
		din0_a[32], din1_a[32], din0_a[32], din1_a[32], din0_a[31], 
		din1_a[31], din0_a[31], din1_a[31], din0_a[31], din1_a[31], 
		din0_a[31], din1_a[31], din0_a[30], din1_a[30], din0_a[30], 
		din1_a[30], din0_a[30], din1_a[30], din0_a[30], din1_a[30], 
		din0_a[29], din1_a[29], din0_a[29], din1_a[29], din0_a[29], 
		din1_a[29], din0_a[29], din1_a[29], din0_a[28], din1_a[28], 
		din0_a[28], din1_a[28], din0_a[28], din1_a[28], din0_a[28], 
		din1_a[28], din0_a[27], din1_a[27], din0_a[27], din1_a[27], 
		din0_a[27], din1_a[27], din0_a[27], din1_a[27], din0_a[26], 
		din1_a[26], din0_a[26], din1_a[26], din0_a[26], din1_a[26], 
		din0_a[26], din1_a[26], din0_a[25], din1_a[25], din0_a[25], 
		din1_a[25], din0_a[25], din1_a[25], din0_a[25], din1_a[25], 
		din0_a[24], din1_a[24], din0_a[24], din1_a[24], din0_a[24], 
		din1_a[24], din0_a[24], din1_a[24], din0_a[23], din1_a[23], 
		din0_a[23], din1_a[23], din0_a[23], din1_a[23], din0_a[23], 
		din1_a[23], din0_a[22], din1_a[22], din0_a[22], din1_a[22], 
		din0_a[22], din1_a[22], din0_a[22], din1_a[22], din0_a[21], 
		din1_a[21], din0_a[21], din1_a[21], din0_a[21], din1_a[21], 
		din0_a[21], din1_a[21], din0_a[20], din1_a[20], din0_a[20], 
		din1_a[20], din0_a[20], din1_a[20], din0_a[20], din1_a[20], 
		din0_a[19], din1_a[19], din0_a[19], din1_a[19], din0_a[19], 
		din1_a[19], din0_a[19], din1_a[19], din0_a[18], din1_a[18], 
		din0_a[18], din1_a[18], din0_a[18], din1_a[18], din0_a[18], 
		din1_a[18], din0_a[17], din1_a[17], din0_a[17], din1_a[17], 
		din0_a[17], din1_a[17], din0_a[17], din1_a[17]};
	assign din[127:0] = (((way_write_en[127:0] & word_write_en[127:0]) & 
		data_in[127:0]) | ((~(way_write_en[127:0] & word_write_en[127:0]
		)) & old_data[127:0]));
	assign rd_worden_ac_l_unused = rd_worden_ac_l[1];
	assign adr_ac_l_unused[5:0] = adr_ac_l[5:0];

	initial begin
	  for (i = 0; (i < 64); i = (i + 1)) begin
	    mem[i] = {136 {1'b0}};
	  end
	  local_dout = {136 {1'b0}};
	end
	always @(reg_en_rgt[1:0] or reg_d_rgt or temp) begin
	  for (n = 0; (n < 128); n = (n + 1)) begin
	    n_reg1 = n;
	    if (((reg_en_rgt[1] & reg_en_rgt[0]) & (reg_d_rgt >= 5'b0)) & (
		    reg_d_rgt <= 5'b01111)) begin
	      if (n_reg1[9:0] >= ((reg_d_rgt + 5'b1) * 5'b01000)) begin
		old_data[n] = temp[(n + 8)];
	      end
	      else begin
		old_data[n] = temp[n];
	      end
	    end
	    else begin
	      old_data[n] = temp[(n + 8)];
	    end
	  end
	end
	always @(reg_en_rgt[1:0] or reg_d_rgt or din) begin
	  for (n = 0; (n < 136); n = (n + 1)) begin
	    n_reg2 = n;
	    if (((reg_en_rgt[1] & reg_en_rgt[0]) & (reg_d_rgt >= 5'b0)) & (
		    reg_d_rgt <= 5'b01111)) begin
	      if (n_reg2[9:0] < ((reg_d_rgt + 5'b1) * 5'b01000)) begin
		wr_data[n] = din[n];
	      end
	      else
		begin
		  if (n_reg2[9:0] < ((reg_d_rgt + 5'b00010) * 5'b01000)) begin
		    wr_data[n] = 1'bx;
		  end
		  else begin
		    wr_data[n] = din[(n - 8)];
		  end
		end
	    end
	    else
	      begin
		if (n < 8) begin
		  wr_data[n] = 1'bx;
		end
		else begin
		  wr_data[n] = din[(n - 8)];
		end
	      end
	  end
	end


	always @(l1clk or wr_data[135:0] or wr_word_en_ac_l[1:0] or 
		adr_ac_h[5:0] or quaden_f_l or vnw_ary) begin
	  if (((l1clk & (~quaden_f_l)) & ((~wr_word_en_ac_l[1]) | (~
		  wr_word_en_ac_l[0]))) & vnw_ary) begin
	    mem[adr_ac_h] <= wr_data[135:0];
	  end
	end
	always @(l1clk or adr_ac_h[5:0] or rd_worden_ac_l[0]) begin
	  if (l1clk) begin
	    word_0_read <= (~rd_worden_ac_l[0]);
	    local_dout[135:0] <= mem[adr_ac_h[5:0]];
	  end
	end

	always @(negedge l1clk) begin
	  if (~rd_en_a_l) begin
	    for (n = 0; (n < 128); n = (n + 1)) begin
	      n_reg3 = n;
	      if (((reg_en_rgt[1] & reg_en_rgt[0]) & (reg_d_rgt >= 5'b0)) & (
		      reg_d_rgt <= 5'b01111)) begin
		if (n_reg3[9:0] >= ((reg_d_rgt + 5'b1) * 5'b01000)) begin
		  dout[n] = local_dout[(n + 8)];
		end
		else begin
		  dout[n] = local_dout[n];
		end
	      end
	      else begin
		dout[n] = local_dout[(n + 8)];
	      end
	    end
	    way0_word0[15:0] = {dout[127], dout[119], dout[111], dout[103], 
		    dout[95], dout[87], dout[79], dout[71], dout[63], dout[55], 
		    dout[47], dout[39], dout[31], dout[23], dout[15], dout[7]};
	    way0_word1[15:0] = {dout[126], dout[118], dout[110], dout[102], 
		    dout[94], dout[86], dout[78], dout[70], dout[62], dout[54], 
		    dout[46], dout[38], dout[30], dout[22], dout[14], dout[6]};
	    way1_word0[15:0] = {dout[125], dout[117], dout[109], dout[101], 
		    dout[93], dout[85], dout[77], dout[69], dout[61], dout[53], 
		    dout[45], dout[37], dout[29], dout[21], dout[13], dout[5]};
	    way1_word1[15:0] = {dout[124], dout[116], dout[108], dout[100], 
		    dout[92], dout[84], dout[76], dout[68], dout[60], dout[52], 
		    dout[44], dout[36], dout[28], dout[20], dout[12], dout[4]};
	    way2_word0[15:0] = {dout[123], dout[115], dout[107], dout[99], 
		    dout[91], dout[83], dout[75], dout[67], dout[59], dout[51], 
		    dout[43], dout[35], dout[27], dout[19], dout[11], dout[3]};
	    way2_word1[15:0] = {dout[122], dout[114], dout[106], dout[98], 
		    dout[90], dout[82], dout[74], dout[66], dout[58], dout[50], 
		    dout[42], dout[34], dout[26], dout[18], dout[10], dout[2]};
	    way3_word0[15:0] = {dout[121], dout[113], dout[105], dout[97], 
		    dout[89], dout[81], dout[73], dout[65], dout[57], dout[49], 
		    dout[41], dout[33], dout[25], dout[17], dout[9], dout[1]};
	    way3_word1[15:0] = {dout[120], dout[112], dout[104], dout[96], 
		    dout[88], dout[80], dout[72], dout[64], dout[56], dout[48], 
		    dout[40], dout[32], dout[24], dout[16], dout[8], dout[0]};
	    dout_wy0_bc[15:0] <= (word_0_read ? way0_word0[15:0] : 
		    way0_word1[15:0]);
	    dout_wy1_bc[15:0] <= (word_0_read ? way1_word0[15:0] : 
		    way1_word1[15:0]);
	    dout_wy2_bc[15:0] <= (word_0_read ? way2_word0[15:0] : 
		    way2_word1[15:0]);
	    dout_wy3_bc[15:0] <= (word_0_read ? way3_word0[15:0] : 
		    way3_word1[15:0]);
	  end
	end
endmodule

`endif	// `ifdef FPGA






// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_mux_macro__mux_aonpe__ports_8__stack_50c__width_33 (
  din0, 
  sel0, 
  din1, 
  sel1, 
  din2, 
  sel2, 
  din3, 
  sel3, 
  din4, 
  sel4, 
  din5, 
  sel5, 
  din6, 
  sel6, 
  din7, 
  sel7, 
  dout);
wire buffout0;
wire buffout1;
wire buffout2;
wire buffout3;
wire buffout4;
wire buffout5;
wire buffout6;
wire buffout7;

  input [32:0] din0;
  input sel0;
  input [32:0] din1;
  input sel1;
  input [32:0] din2;
  input sel2;
  input [32:0] din3;
  input sel3;
  input [32:0] din4;
  input sel4;
  input [32:0] din5;
  input sel5;
  input [32:0] din6;
  input sel6;
  input [32:0] din7;
  input sel7;
  output [32:0] dout;





cl_dp1_muxbuff8_8x  c0_0 (
 .in0(sel0),
 .in1(sel1),
 .in2(sel2),
 .in3(sel3),
 .in4(sel4),
 .in5(sel5),
 .in6(sel6),
 .in7(sel7),
 .out0(buffout0),
 .out1(buffout1),
 .out2(buffout2),
 .out3(buffout3),
 .out4(buffout4),
 .out5(buffout5),
 .out6(buffout6),
 .out7(buffout7)
);
mux8s #(33)  d0_0 (
  .sel0(buffout0),
  .sel1(buffout1),
  .sel2(buffout2),
  .sel3(buffout3),
  .sel4(buffout4),
  .sel5(buffout5),
  .sel6(buffout6),
  .sel7(buffout7),
  .in0(din0[32:0]),
  .in1(din1[32:0]),
  .in2(din2[32:0]),
  .in3(din3[32:0]),
  .in4(din4[32:0]),
  .in5(din5[32:0]),
  .in6(din6[32:0]),
  .in7(din7[32:0]),
.dout(dout[32:0])
);









  



endmodule


// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_mux_macro__mux_aodec__ports_8__width_7 (
  din0, 
  din1, 
  din2, 
  din3, 
  din4, 
  din5, 
  din6, 
  din7, 
  sel, 
  dout);
wire psel0;
wire psel1;
wire psel2;
wire psel3;
wire psel4;
wire psel5;
wire psel6;
wire psel7;

  input [6:0] din0;
  input [6:0] din1;
  input [6:0] din2;
  input [6:0] din3;
  input [6:0] din4;
  input [6:0] din5;
  input [6:0] din6;
  input [6:0] din7;
  input [2:0] sel;
  output [6:0] dout;





cl_dp1_pdec8_8x  c0_0 (
  .test(1'b1),
 .sel0(sel[0]),
 .sel1(sel[1]),
 .sel2(sel[2]),
 .psel0(psel0),
 .psel1(psel1),
 .psel2(psel2),
 .psel3(psel3),
 .psel4(psel4),
 .psel5(psel5),
 .psel6(psel6),
 .psel7(psel7)
);

mux8s #(7)  d0_0 (
  .sel0(psel0),
  .sel1(psel1),
  .sel2(psel2),
  .sel3(psel3),
  .sel4(psel4),
  .sel5(psel5),
  .sel6(psel6),
  .sel7(psel7),
  .in0(din0[6:0]),
  .in1(din1[6:0]),
  .in2(din2[6:0]),
  .in3(din3[6:0]),
  .in4(din4[6:0]),
  .in5(din5[6:0]),
  .in6(din6[6:0]),
  .in7(din7[6:0]),
.dout(dout[6:0])
);









  



endmodule


// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_icd_sp_16p5kb_cust_mux_macro__mux_aope__ports_2__width_7 (
  din0, 
  din1, 
  sel0, 
  dout);
wire psel0;
wire psel1;

  input [6:0] din0;
  input [6:0] din1;
  input sel0;
  output [6:0] dout;





cl_dp1_penc2_8x  c0_0 (
 .sel0(sel0),
 .psel0(psel0),
 .psel1(psel1)
);

mux2s #(7)  d0_0 (
  .sel0(psel0),
  .sel1(psel1),
  .in0(din0[6:0]),
  .in1(din1[6:0]),
.dout(dout[6:0])
);









  



endmodule

