// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: n2_tlb_tl_64x59_cust.v
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
module n2_tlb_tl_64x59_cust (
  l2clk, 
  scan_in, 
  tcu_pce_ov, 
  pce, 
  tcu_aclk, 
  tcu_bclk, 
  tcu_se_scancollar_in, 
  tcu_se_scancollar_out, 
  tcu_array_wr_inhibit, 
  tcu_scan_en, 
  disable_clear_ubit, 
  scan_out, 
  tlb_bypass, 
  tlb_wr_vld, 
  tlb_rd_vld, 
  tlb_cam_vld, 
  tlb_rw_index, 
  tlb_rw_index_vld, 
  tlb_demap, 
  tlb_demap_context, 
  tlb_demap_all, 
  tlb_demap_real, 
  tte_tag, 
  tte_ubit, 
  tte_page_size_mask, 
  tte_data, 
  tlb_va, 
  cache_ptag_w0, 
  cache_ptag_w1, 
  cache_ptag_w2, 
  cache_ptag_w3, 
  cache_ptag_w4, 
  cache_ptag_w5, 
  cache_ptag_w6, 
  cache_ptag_w7, 
  cache_set_vld, 
  cache_way_hit, 
  cache_hit, 
  tlb_cam_hit, 
  tlb_cam_mhit, 
  tlb_context0_hit, 
  tlb_pgnum_crit, 
  tlb_pgnum, 
  tlb_tte_data, 
  tlb_tte_tag, 
  tlb_tte_u_bit, 
  tlb_tte_data_parity) ;
wire pce_ov;
wire stop;
wire siclk;
wire soclk;
wire se;
wire l1clk_in;
wire l1clk_free;
wire [73:0] cam_ctl_lat_scanin;
wire [73:0] cam_ctl_lat_scanout;
wire [65:0] tte_tag_1;
wire tte_ubit_1;
wire tlb_wr_1_in_unused;
wire tlb_rd_1_unused;
wire tlb_cam_1_in;
wire demap_1_in;
wire demap_context_1;
wire demap_all_1;
wire demap_real_1;
wire [73:0] lat_l_unused;
wire [65:0] tte_tag_1_dout;
wire tte_ubit_1_unused;
wire tlb_wr_1_in_dout;
wire tlb_rd_1_in_dout;
wire tlb_cam_1_in_dout;
wire demap_1_in_unused;
wire demap_context_1_unused;
wire demap_all_1_unused;
wire demap_real_1_unused;
wire [73:0] dout_l_unused;
wire demap_page_1_unused;
wire wr_inhibit_;
wire tlb_wr_1_dout;
wire tlb_rd_1_dout;
wire tlb_cam_1;
wire tlb_cam_1_dout;
wire demap_1;
wire [2:0] page_size_mask_reg_scanin;
wire [2:0] page_size_mask_reg_scanout;
wire [2:0] tte_page_size_mask_1;
wire disable_clear_ubit_reg_scanin;
wire disable_clear_ubit_reg_scanout;
wire disable_clear_ubit_1_in;
wire disable_clear_ubit_1;
wire tlb_bypass_reg_scanin;
wire tlb_bypass_reg_scanout;
wire tlb_bypass_1;
wire [1:0] vaddr_reg_scanin;
wire [1:0] vaddr_reg_scanout;
wire [12:11] va_1;
wire [37:0] tte_data_reg_scanin;
wire [37:0] tte_data_reg_scanout;
wire [37:0] tte_data_1;
wire [5:0] tlb_replacement_index;
wire [5:0] rw_index_0;
wire [5:0] rw_index_reg_scanin;
wire [5:0] rw_index_reg_scanout;
wire [5:0] rw_index_1;
wire rw_index_vld_reg_scanin;
wire rw_index_vld_reg_scanout;
wire rw_index_vld_unused;
wire [39:11] pa_1;
wire tlb_cam_hit_1;
wire l1clk_out;
wire [2:0] tlb_cam_hit_reg_scanin;
wire [2:0] tlb_cam_hit_reg_scanout;
wire multiple_match;
wire context0_hit;
wire tlb_cam_mhit_b;
wire [26:0] pa_reg_scanin;
wire [26:0] pa_reg_scanout;
wire [39:13] pa_2;
wire [37:0] tte_data_out_reg_scanin;
wire [37:0] tte_data_out_reg_scanout;
wire [37:0] rd_tte_data;
wire [65:0] rd_tte_tag;
wire [65:0] rd_tte_tag_b;
wire [65:0] tte_tag_out_reg_scanin;
wire [65:0] tte_tag_out_reg_scanout;
wire [65:0] tlb_tte_tag_b;
wire rd_tte_u_bit;
wire rd_tte_u_bit_b;
wire tte_u_bit_out_reg_scanin;
wire tte_u_bit_out_reg_scanout;
wire tlb_tte_u_bit_b;
wire [7:0] cache_way_hit_in;
wire [7:0] cache_way_hit_in_b;
wire [7:0] cache_way_hit_reg_scanin;
wire [7:0] cache_way_hit_reg_scanout;
wire [7:0] cache_way_hit_b;
wire data_parity_0;
wire [3:0] mm_debug_reg_scanin;
wire [3:0] mm_debug_reg_scanout;
wire [3:0] mm_debug;
wire tag_read_mux_control;




input		l2clk;
input		scan_in;
input		tcu_pce_ov;
input 		pce;
input		tcu_aclk;
input		tcu_bclk;
input		tcu_se_scancollar_in;
input		tcu_se_scancollar_out;
input		tcu_array_wr_inhibit;
input		tcu_scan_en ;
input		disable_clear_ubit;
output		scan_out;

input		tlb_bypass;
input		tlb_wr_vld;
input		tlb_rd_vld;
input		tlb_cam_vld;
input	[5:0]	tlb_rw_index;
input		tlb_rw_index_vld;
input		tlb_demap;
input		tlb_demap_context;
input		tlb_demap_all;
input		tlb_demap_real;

input	[65:0]	tte_tag;
input		tte_ubit;
input	[2:0]	tte_page_size_mask;
input	[37:0]	tte_data;
input	[12:11]	tlb_va;		// Incoming VA

// Cache tag compare
input	[39:11]	cache_ptag_w0;
input	[39:11]	cache_ptag_w1;
input	[39:11]	cache_ptag_w2;
input	[39:11]	cache_ptag_w3;
input	[39:11]	cache_ptag_w4;
input	[39:11]	cache_ptag_w5;
input	[39:11]	cache_ptag_w6;
input	[39:11]	cache_ptag_w7;
input	[7:0]	cache_set_vld;

output	[7:0]	cache_way_hit;
output		cache_hit;
output		tlb_cam_hit;
output		tlb_cam_mhit;
output		tlb_context0_hit;
output	[39:13]	tlb_pgnum_crit; 	// PA unflopped
output	[39:13]	tlb_pgnum;	 	// PA flopped
output	[37:0]	tlb_tte_data;
output	[65:0]	tlb_tte_tag;
output		tlb_tte_u_bit;
output		tlb_tte_data_parity;

`ifndef FPGA
// synopsys translate_off
`endif

assign pce_ov = tcu_pce_ov;
assign stop   = 1'b0;
assign siclk  = tcu_aclk ;
assign soclk  = tcu_bclk;
assign se     = tcu_scan_en;


// 0in bits_on -var {tlb_wr_vld,tlb_rd_vld,tlb_cam_vld,tlb_demap} -max 1
// 0in bits_on -var {tlb_demap_context,tlb_demap_all,tlb_demap_real} -max 1
// 0in bits_on -var {tlb_cam_vld,tlb_bypass} -max 1
// 0in assert -var (~(tlb_demap_context & ~tlb_demap)) -message "Cannot asert tlb_demap_context without tlb_demap"
// 0in assert -var (~(tlb_demap_all     & ~tlb_demap)) -message "Cannot asert tlb_demap_all     without tlb_demap"
// 0in assert -var (~(tlb_demap_real    & ~tlb_demap)) -message "Cannot asert tlb_demap_real    without tlb_demap"
// 0in known_driven -var tlb_cam_hit


///////////////////////////////////////////////////////////////
// Input flops
///////////////////////////////////////////////////////////////

n2_tlb_tl_64x59_cust_l1clkhdr_ctl_macro in_clken (
 .l2clk(l2clk),
 .l1en(pce),
 .se(tcu_se_scancollar_in),
 .l1clk(l1clk_in),
  .pce_ov(pce_ov),
  .stop(stop)
);

n2_tlb_tl_64x59_cust_l1clkhdr_ctl_macro free_clken (
 .l2clk(l2clk),
 .l1en(pce),
 .se(se),
 .l1clk(l1clk_free),
  .pce_ov(pce_ov),
  .stop(stop)
);

// Put all the CAM controls and data in one latch to avoid races
// Doesn't really matter any more... also this gets split up in 
// gate level model
n2_tlb_tl_64x59_cust_sram_msff_mo_macro__fs_1__width_74 cam_ctl_lat   (
 .scan_in(cam_ctl_lat_scanin[73:0]),
 .scan_out(cam_ctl_lat_scanout[73:0]),
 .l1clk	(l1clk_in),
 .and_clk(l1clk_free),
//	            73:8      7        6
 .d	({tte_tag  [65:0],tte_ubit  ,tlb_wr_vld ,
//               5      4             3         2
	  tlb_rd_vld,tlb_cam_vld ,tlb_demap ,tlb_demap_context,
//	         1          0
	  tlb_demap_all,tlb_demap_real}),
 .mq	({tte_tag_1[65:0],tte_ubit_1,tlb_wr_1_in_unused,
	  tlb_rd_1_unused ,tlb_cam_1_in,demap_1_in,demap_context_1  ,
	  demap_all_1  ,demap_real_1  }),
 .mq_l	(lat_l_unused[73:0]),
// NOTE:  Some signals on dout port ARE used by bench (itlb_wr.v)!
 .q	({tte_tag_1_dout[65:0],tte_ubit_1_unused,tlb_wr_1_in_dout,
	  tlb_rd_1_in_dout,tlb_cam_1_in_dout,demap_1_in_unused,demap_context_1_unused  ,
	  demap_all_1_unused  ,demap_real_1_unused  }),
 .q_l	(dout_l_unused[73:0]),
  .siclk(siclk),
  .soclk(soclk)
);

// This is strictly for DV
assign demap_page_1_unused =
       demap_1_in_unused & ~demap_context_1_unused & ~demap_all_1_unused & 
       ~demap_real_1_unused;

n2_tlb_tl_64x59_cust_inv_macro__width_1 wr_inhibit_b_inv  (
 .din(tcu_array_wr_inhibit),
 .dout(wr_inhibit_)
);				  

n2_tlb_tl_64x59_cust_and_macro__ports_2__width_1 tlb_wr_dout_and   (
 .din0(tlb_wr_1_in_dout),
 .din1(wr_inhibit_),
 .dout(tlb_wr_1_dout)
);				  

n2_tlb_tl_64x59_cust_and_macro__ports_2__width_1 tlb_rd_dout_and   (
 .din0(tlb_rd_1_in_dout),
 .din1(wr_inhibit_),
 .dout(tlb_rd_1_dout)
);				  

n2_tlb_tl_64x59_cust_and_macro__ports_2__width_1 tlb_cam_and   (
 .din0(tlb_cam_1_in),
 .din1(wr_inhibit_),
 .dout(tlb_cam_1)
);				  

n2_tlb_tl_64x59_cust_and_macro__ports_2__width_1 tlb_cam_dout_and   (
 .din0(tlb_cam_1_in_dout),
 .din1(wr_inhibit_),
 .dout(tlb_cam_1_dout)
);				  

n2_tlb_tl_64x59_cust_and_macro__ports_2__width_1 demap_and   (
 .din0(demap_1_in),
 .din1(wr_inhibit_),
 .dout(demap_1)
);				  

n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_3 page_size_mask_reg   (
 .scan_in(page_size_mask_reg_scanin[2:0]),
 .scan_out(page_size_mask_reg_scanout[2:0]),
 .l1clk(l1clk_in),
 .din(tte_page_size_mask[2:0]),
 .dout(tte_page_size_mask_1[2:0]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_tlb_tl_64x59_cust_msff_ctl_macro__width_1 disable_clear_ubit_reg  (
 .scan_in(disable_clear_ubit_reg_scanin),
 .scan_out(disable_clear_ubit_reg_scanout),
 .l1clk(l1clk_in),
 .din(disable_clear_ubit),
 .dout(disable_clear_ubit_1_in),
  .siclk(siclk),
  .soclk(soclk)
);

n2_tlb_tl_64x59_cust_and_macro__ports_2__width_1 disable_clear_ubit_and   (
 .din0(disable_clear_ubit_1_in),
 .din1(wr_inhibit_),
 .dout(disable_clear_ubit_1)
);				  

n2_tlb_tl_64x59_cust_msff_ctl_macro__width_1 tlb_bypass_reg  (
 .scan_in(tlb_bypass_reg_scanin),
 .scan_out(tlb_bypass_reg_scanout),
 .l1clk(l1clk_in),
 .din(tlb_bypass),
 .dout(tlb_bypass_1),
  .siclk(siclk),
  .soclk(soclk)
);

n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_2 vaddr_reg   (
 .scan_in(vaddr_reg_scanin[1:0]),
 .scan_out(vaddr_reg_scanout[1:0]),
 .l1clk(l1clk_in),
 .din(tlb_va[12:11]),
 .dout(va_1[12:11]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_38 tte_data_reg   (
 .scan_in(tte_data_reg_scanin[37:0]),
 .scan_out(tte_data_reg_scanout[37:0]),
 .l1clk(l1clk_in),
 .din(tte_data[37:0]),
 .dout(tte_data_1[37:0]),
  .siclk(siclk),
  .soclk(soclk)
);


/////////////////////////////////////////////////////////////////////      
// Write index muxing
//////////////////////////////////////////////////////////////////////

n2_tlb_tl_64x59_cust_mux_macro__mux_aope__ports_2__width_6 rw_index_mux    (
 .din0	(tlb_rw_index[5:0]),
 .din1	(tlb_replacement_index[5:0]),
 .sel0	(tlb_rw_index_vld),
 .dout	(rw_index_0[5:0])	
);

// The output of this flop is used by the bench (dtlb_wr.vpal)
n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_6 rw_index_reg   (
 .scan_in(rw_index_reg_scanin[5:0]),
 .scan_out(rw_index_reg_scanout[5:0]),
 .l1clk(l1clk_in),
 .din(rw_index_0[5:0]),
 .dout(rw_index_1[5:0]),
  .siclk(siclk),
  .soclk(soclk)
);

// This flop is here to mirror the circuit; it has no functional purpose;
// just want it here for 'debug' even though this signal
// is flopped outside the circuit
n2_tlb_tl_64x59_cust_msff_ctl_macro__width_1 rw_index_vld_reg  (
 .scan_in(rw_index_vld_reg_scanin),
 .scan_out(rw_index_vld_reg_scanout),
 .l1clk(l1clk_in),
 .din(tlb_rw_index_vld),
 .dout(rw_index_vld_unused),
  .siclk(siclk),
  .soclk(soclk)
);


/////////////////////////////////////////////////////////////////////      
// Array behavioral
/////////////////////////////////////////////////////////////////////      

n2_tlb_tl_64x59_array array (
// Inputs
	.l1clk		(l1clk_free),
	.tlb_bypass	(tlb_bypass_1),
	.tlb_wr_flopped	(tlb_wr_1_dout),
	.tlb_rd_flopped	(tlb_rd_1_dout),
	.rw_index	(rw_index_1[5:0]),
	.tlb_cam	(tlb_cam_1),
	.tlb_cam_flopped(tlb_cam_1_dout),
	.disable_clear_ubit(disable_clear_ubit_1),
	.demap		(demap_1),
	.demap_context	(demap_context_1),
	.demap_all	(demap_all_1),
	.demap_real	(demap_real_1),
	.tte_tag	(tte_tag_1[65:0]),
	.tte_tag_flopped(tte_tag_1_dout[65:0]),
	.tte_ubit	(tte_ubit_1),			     
	.tte_page_size_mask(tte_page_size_mask_1[2:0]),
	.tte_data	(tte_data_1[37:0]),
	.va		(va_1[12:11]),
// Outputs
	.pa		(pa_1[39:11]),
	.tlb_cam_hit	(tlb_cam_hit_1),
  .tag_read_mux_control(tag_read_mux_control),
  .context0_hit(context0_hit),
  .multiple_match(multiple_match),
  .rd_tte_data(rd_tte_data[37:0]),
  .rd_tte_tag(rd_tte_tag[65:0]),
  .rd_tte_u_bit(rd_tte_u_bit),
  .tlb_replacement_index(tlb_replacement_index[5:0])
);

// Unflopped output
assign tlb_pgnum_crit[39:13] = pa_1[39:13];

//////////////////////////////////////////////////
// Flop the output data
//////////////////////////////////////////////////

n2_tlb_tl_64x59_cust_l1clkhdr_ctl_macro out_clken (
 .l2clk(l2clk),
 .l1en(pce),
 .se(tcu_se_scancollar_out),
 .l1clk(l1clk_out),
  .pce_ov(pce_ov),
  .stop(stop)
);

n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_3 tlb_cam_hit_reg   (
 .scan_in(tlb_cam_hit_reg_scanin[2:0]),
 .scan_out(tlb_cam_hit_reg_scanout[2:0]),
 .l1clk(l1clk_out),
 .din({tlb_cam_hit_1,multiple_match,context0_hit}),
 .dout({tlb_cam_hit,tlb_cam_mhit,tlb_context0_hit}),
  .siclk(siclk),
  .soclk(soclk)
);

n2_tlb_tl_64x59_cust_inv_macro__width_1 tlb_cam_mhit_b_inv  (
 .din(tlb_cam_mhit),
 .dout(tlb_cam_mhit_b)
);					

n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_27 pa_reg   (
 .scan_in(pa_reg_scanin[26:0]),
 .scan_out(pa_reg_scanout[26:0]),
 .l1clk(l1clk_out),
 .din(pa_1[39:13]),
 .dout(pa_2[39:13]),
  .siclk(siclk),
  .soclk(soclk)
);

assign tlb_pgnum[39:13] = pa_2[39:13];

n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_38 tte_data_out_reg   (
 .scan_in(tte_data_out_reg_scanin[37:0]),
 .scan_out(tte_data_out_reg_scanout[37:0]),
 .l1clk(l1clk_out),
 .din(rd_tte_data[37:0]),
 .dout(tlb_tte_data[37:0]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_tlb_tl_64x59_cust_inv_macro__stack_66c__width_66 rd_tte_tag_b_inv   (
 .din(rd_tte_tag[65:0]),
 .dout(rd_tte_tag_b[65:0])
);					

n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_66 tte_tag_out_reg   (
 .scan_in(tte_tag_out_reg_scanin[65:0]),
 .scan_out(tte_tag_out_reg_scanout[65:0]),
 .l1clk(l1clk_out),
 .din(rd_tte_tag_b[65:0]),
 .dout(tlb_tte_tag_b[65:0]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_tlb_tl_64x59_cust_inv_macro__stack_66c__width_66 tlb_tte_tag_inv   (
 .din(tlb_tte_tag_b[65:0]),
 .dout(tlb_tte_tag[65:0])
);					

n2_tlb_tl_64x59_cust_inv_macro__width_1 rd_tte_u_bit_b_inv  (
 .din(rd_tte_u_bit),
 .dout(rd_tte_u_bit_b)
);

n2_tlb_tl_64x59_cust_msff_ctl_macro__width_1 tte_u_bit_out_reg  (
 .scan_in(tte_u_bit_out_reg_scanin),
 .scan_out(tte_u_bit_out_reg_scanout),
 .l1clk(l1clk_out),
 .din(rd_tte_u_bit_b),
 .dout(tlb_tte_u_bit_b),
  .siclk(siclk),
  .soclk(soclk)
);

n2_tlb_tl_64x59_cust_inv_macro__width_1 tlb_tte_u_bit_inv  (
 .din(tlb_tte_u_bit_b),
 .dout(tlb_tte_u_bit)
);

///////////////////////////////////////////////////////////////
// Tag compare logic
///////////////////////////////////////////////////////////////

n2_tlb_tl_64x59_cust_cmp_macro__width_32 way0_cmp  (
	.din0	({cache_ptag_w0[39:11],cache_set_vld[0],1'b0          , 1'b0}),
	.din1	({pa_1[39:11],         1'b1,            1'b0          , 1'b0}),
	.dout	(cache_way_hit_in[0])
);
n2_tlb_tl_64x59_cust_cmp_macro__width_32 way1_cmp  (
	.din0	({cache_ptag_w1[39:11],cache_set_vld[1],1'b0          , 1'b0}),
	.din1	({pa_1[39:11],         1'b1,            1'b0          , 1'b0}),
	.dout	(cache_way_hit_in[1])
);
n2_tlb_tl_64x59_cust_cmp_macro__width_32 way2_cmp  (
	.din0	({cache_ptag_w2[39:11],cache_set_vld[2],1'b0          , 1'b0}),
	.din1	({pa_1[39:11],         1'b1,            1'b0          , 1'b0}),
	.dout	(cache_way_hit_in[2])
);
n2_tlb_tl_64x59_cust_cmp_macro__width_32 way3_cmp  (
	.din0	({cache_ptag_w3[39:11],cache_set_vld[3],1'b0          , 1'b0}),
	.din1	({pa_1[39:11],         1'b1,            1'b0          , 1'b0}),
	.dout	(cache_way_hit_in[3])
);
n2_tlb_tl_64x59_cust_cmp_macro__width_32 way4_cmp  (
	.din0	({cache_ptag_w4[39:11],cache_set_vld[4],1'b0          , 1'b0}),
	.din1	({pa_1[39:11],         1'b1,            1'b0          , 1'b0}),
	.dout	(cache_way_hit_in[4])
);
n2_tlb_tl_64x59_cust_cmp_macro__width_32 way5_cmp  (
	.din0	({cache_ptag_w5[39:11],cache_set_vld[5],1'b0          , 1'b0}),
	.din1	({pa_1[39:11],         1'b1,            1'b0          , 1'b0}),
	.dout	(cache_way_hit_in[5])
);
n2_tlb_tl_64x59_cust_cmp_macro__width_32 way6_cmp  (
	.din0	({cache_ptag_w6[39:11],cache_set_vld[6],1'b0          , 1'b0}),
	.din1	({pa_1[39:11],         1'b1,            1'b0          , 1'b0}),
	.dout	(cache_way_hit_in[6])
);
n2_tlb_tl_64x59_cust_cmp_macro__width_32 way7_cmp  (
	.din0	({cache_ptag_w7[39:11],cache_set_vld[7],1'b0          , 1'b0}),
	.din1	({pa_1[39:11],         1'b1,            1'b0          , 1'b0}),
	.dout	(cache_way_hit_in[7])
);

n2_tlb_tl_64x59_cust_inv_macro__width_8 cache_way_hit_in_b_inv  (
 .din(cache_way_hit_in[7:0]),
 .dout(cache_way_hit_in_b[7:0])
);

n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_8 cache_way_hit_reg   (
 .scan_in(cache_way_hit_reg_scanin[7:0]),
 .scan_out(cache_way_hit_reg_scanout[7:0]),
 .l1clk(l1clk_out),
 .din(cache_way_hit_in_b[7:0]),
 .dout(cache_way_hit_b[7:0]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_tlb_tl_64x59_cust_inv_macro__width_8 cache_way_hit_inv  (
 .din(cache_way_hit_b[7:0]),
 .dout(cache_way_hit[7:0])
);

n2_tlb_tl_64x59_cust_mux_macro__mux_aonpe__ports_8__width_1 cache_hit_or    (
	.din0	(cache_way_hit[0]),
	.din1	(cache_way_hit[1]),
	.din2	(cache_way_hit[2]),
	.din3	(cache_way_hit[3]),
	.din4	(cache_way_hit[4]),
	.din5	(cache_way_hit[5]),
	.din6	(cache_way_hit[6]),
	.din7	(cache_way_hit[7]),
	.sel0	(tlb_cam_mhit_b),
	.sel1	(tlb_cam_mhit_b),
	.sel2	(tlb_cam_mhit_b),
	.sel3	(tlb_cam_mhit_b),
	.sel4	(tlb_cam_mhit_b),
	.sel5	(tlb_cam_mhit_b),
	.sel6	(tlb_cam_mhit_b),
	.sel7	(tlb_cam_mhit_b),
	.dout	(cache_hit)	
);

///////////////////////////////////////////////////////////////
// Parity checks for data
///////////////////////////////////////////////////////////////

n2_tlb_tl_64x59_cust_prty_macro__width_32 dprty0  (
	.din	(tlb_tte_data[31:0]),
	.dout	(data_parity_0)
);
n2_tlb_tl_64x59_cust_prty_macro__width_8 dprty1  (
	.din	({2'b00,tlb_tte_data[36:32],data_parity_0}),
	.dout	(tlb_tte_data_parity)
);



// Flops for circuit use

n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_4 mm_debug_reg   (
 .scan_in(mm_debug_reg_scanin[3:0]),
 .scan_out(mm_debug_reg_scanout[3:0]),
 .l1clk(l1clk_in),
 .din(mm_debug[3:0]),
 .dout(mm_debug[3:0]),
  .siclk(siclk),
  .soclk(soclk)
);

assign tag_read_mux_control = mm_debug[3];


supply0 vss; // <- port for ground
supply1 vdd; // <- port for power 
// Fullscan hookups begin
assign tte_data_reg_scanin	    [0] = scan_in			     ;
assign tte_data_reg_scanin	 [37:1] = tte_data_reg_scanout	      [36:0];

assign vaddr_reg_scanin		    [0] = tte_data_reg_scanout		 [37];
assign vaddr_reg_scanin		    [1] = vaddr_reg_scanout  		 [0];

assign rw_index_reg_scanin	    [5] = vaddr_reg_scanout  		 [1];
assign rw_index_reg_scanin	    [4] = rw_index_reg_scanout 	 [5];
assign rw_index_reg_scanin	    [3] = rw_index_reg_scanout 	 [4];
assign rw_index_reg_scanin	    [0] = rw_index_reg_scanout 	 [3];
assign rw_index_reg_scanin	    [1] = rw_index_reg_scanout 	 [0];
assign rw_index_reg_scanin	    [2] = rw_index_reg_scanout 	 [1];


assign rw_index_vld_reg_scanin	         = rw_index_reg_scanout 	 [2];

assign cam_ctl_lat_scanin	    [6] = rw_index_vld_reg_scanout 	     ;
assign cam_ctl_lat_scanin	    [5] = cam_ctl_lat_scanout	 	 [6];
assign cam_ctl_lat_scanin	    [58] = cam_ctl_lat_scanout	 	 [5];
assign cam_ctl_lat_scanin	 [60:59] = cam_ctl_lat_scanout	      [59:58];
assign cam_ctl_lat_scanin	    [37] = cam_ctl_lat_scanout	 	 [60];
assign cam_ctl_lat_scanin	 [56:38] = cam_ctl_lat_scanout	      [55:37];

assign page_size_mask_reg_scanin    [0] = cam_ctl_lat_scanout	         [56];

assign cam_ctl_lat_scanin           [21] = page_size_mask_reg_scanout    [0];
assign cam_ctl_lat_scanin	 [26:22] = cam_ctl_lat_scanout	      [25:21];

assign page_size_mask_reg_scanin    [1] = cam_ctl_lat_scanout	         [26];

assign cam_ctl_lat_scanin           [27] = page_size_mask_reg_scanout    [1];
assign cam_ctl_lat_scanin	 [29:28] = cam_ctl_lat_scanout	      [28:27];
assign cam_ctl_lat_scanin	    [31] = cam_ctl_lat_scanout	         [29];
assign cam_ctl_lat_scanin	 [33:32] = cam_ctl_lat_scanout	      [32:31];

assign page_size_mask_reg_scanin    [2] = cam_ctl_lat_scanout	         [33];

assign cam_ctl_lat_scanin           [34] = page_size_mask_reg_scanout    [2];
assign cam_ctl_lat_scanin	 [36:35] = cam_ctl_lat_scanout	      [35:34];
assign cam_ctl_lat_scanin	    [57] = cam_ctl_lat_scanout	 	 [36];
assign cam_ctl_lat_scanin	    [3] = cam_ctl_lat_scanout	 	 [57];
assign cam_ctl_lat_scanin	    [4] = cam_ctl_lat_scanout	 	 [3];
assign cam_ctl_lat_scanin	    [61] = cam_ctl_lat_scanout	 	 [4];
assign cam_ctl_lat_scanin	 [73:62] = cam_ctl_lat_scanout	      [72:61];
assign cam_ctl_lat_scanin	    [8] = cam_ctl_lat_scanout	 	 [73];
assign cam_ctl_lat_scanin	 [20:9] = cam_ctl_lat_scanout	      [19:8];

assign mm_debug_reg_scanin	    [3] = cam_ctl_lat_scanout	 	 [20];
assign mm_debug_reg_scanin	 [2:0] = mm_debug_reg_scanout	      [3:1];

assign cam_ctl_lat_scanin	    [7] = mm_debug_reg_scanout	 	 [0];

assign disable_clear_ubit_reg_scanin     = cam_ctl_lat_scanout	 	 [7];

assign cam_ctl_lat_scanin	    [30] = disable_clear_ubit_reg_scanout    ;
assign cam_ctl_lat_scanin	    [0] = cam_ctl_lat_scanout	 	 [30];
assign cam_ctl_lat_scanin	    [2] = cam_ctl_lat_scanout	 	 [0];
assign cam_ctl_lat_scanin	    [1] = cam_ctl_lat_scanout	 	 [2];

assign tlb_bypass_reg_scanin	         = cam_ctl_lat_scanout	 	 [1];

assign tlb_cam_hit_reg_scanin	    [2] = tlb_bypass_reg_scanout 	     ;
assign tlb_cam_hit_reg_scanin	    [0] = tlb_cam_hit_reg_scanout 	 [2];

assign tte_tag_out_reg_scanin	    [22] = tlb_cam_hit_reg_scanout 	 [0];

assign tte_u_bit_out_reg_scanin 	 = tte_tag_out_reg_scanout       [22];

assign tte_tag_out_reg_scanin	    [12] = tte_u_bit_out_reg_scanout 	     ;
assign tte_tag_out_reg_scanin	 [11:0] = tte_tag_out_reg_scanout    [12:1];
assign tte_tag_out_reg_scanin	    [65] = tte_tag_out_reg_scanout 	 [0];
assign tte_tag_out_reg_scanin	 [64:53] = tte_tag_out_reg_scanout    [65:54];
assign tte_tag_out_reg_scanin	    [49] = tte_tag_out_reg_scanout 	 [53];
assign tte_tag_out_reg_scanin       [28] = tte_tag_out_reg_scanout	 [49];
assign tte_tag_out_reg_scanin    [27:23] = tte_tag_out_reg_scanout    [28:24];
assign tte_tag_out_reg_scanin       [21] = tte_tag_out_reg_scanout       [23];
assign tte_tag_out_reg_scanin    [20:13] = tte_tag_out_reg_scanout    [21:14];
assign tte_tag_out_reg_scanin       [48] = tte_tag_out_reg_scanout       [13];
assign tte_tag_out_reg_scanin    [47:29] = tte_tag_out_reg_scanout    [48:30];
assign tte_tag_out_reg_scanin       [52] = tte_tag_out_reg_scanout       [29];
assign tte_tag_out_reg_scanin    [51:50] = tte_tag_out_reg_scanout    [52:51];

assign tte_data_out_reg_scanin      [0] = tte_tag_out_reg_scanout       [50];
assign tte_data_out_reg_scanin   [37:1] = tte_data_out_reg_scanout   [36:0];

assign cache_way_hit_reg_scanin     [0] = tte_data_out_reg_scanout      [37];
assign cache_way_hit_reg_scanin  [7:1] = cache_way_hit_reg_scanout  [6:0];

assign pa_reg_scanin                [0] = cache_way_hit_reg_scanout     [7];
assign pa_reg_scanin             [26:1] = pa_reg_scanout             [25:0];

assign tlb_cam_hit_reg_scanin       [1] = pa_reg_scanout                [26];

assign scan_out                          = tlb_cam_hit_reg_scanout       [1];
// Fullscan hookups end

`ifndef FPGA
// synopsys translate_on
`endif

endmodule






// any PARAMS parms go into naming of macro

module n2_tlb_tl_64x59_cust_l1clkhdr_ctl_macro (
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
//   macro for cl_mc1_sram_msff_mo_{16,8,4}x flops
//
//





module n2_tlb_tl_64x59_cust_sram_msff_mo_macro__fs_1__width_74 (
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
input [73:0] d;
  input [73:0] scan_in;
input l1clk;
input and_clk;
input siclk;
input soclk;
output [73:0] mq;
output [73:0] mq_l;
  output [73:0] scan_out;
output [73:0] q;
output [73:0] q_l;






new_dlata #(74)  d0_0 (
.d(d[73:0]),
.si(scan_in[73:0]),
.so(scan_out[73:0]),
.l1clk(l1clk),
.and_clk(and_clk),
.siclk(siclk),
.soclk(soclk),
.q(q[73:0]),
.q_l(q_l[73:0]),
.mq(mq[73:0]),
.mq_l(mq_l[73:0])
);










//place::generic_place($width,$stack,$left);

endmodule





//
//   invert macro
//
//





module n2_tlb_tl_64x59_cust_inv_macro__width_1 (
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





module n2_tlb_tl_64x59_cust_and_macro__ports_2__width_1 (
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

module n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_3 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [2:0] fdin;

  input [2:0] din;
  input l1clk;
  input [2:0] scan_in;


  input siclk;
  input soclk;

  output [2:0] dout;
  output [2:0] scan_out;
assign fdin[2:0] = din[2:0];






dff #(3)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[2:0]),
.si(scan_in[2:0]),
.so(scan_out[2:0]),
.q(dout[2:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_tlb_tl_64x59_cust_msff_ctl_macro__width_1 (
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

module n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_2 (
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

module n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_38 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [37:0] fdin;

  input [37:0] din;
  input l1clk;
  input [37:0] scan_in;


  input siclk;
  input soclk;

  output [37:0] dout;
  output [37:0] scan_out;
assign fdin[37:0] = din[37:0];






dff #(38)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[37:0]),
.si(scan_in[37:0]),
.so(scan_out[37:0]),
.q(dout[37:0])
);












endmodule









// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_tlb_tl_64x59_cust_mux_macro__mux_aope__ports_2__width_6 (
  din0, 
  din1, 
  sel0, 
  dout);
wire psel0;
wire psel1;

  input [5:0] din0;
  input [5:0] din1;
  input sel0;
  output [5:0] dout;





cl_dp1_penc2_8x  c0_0 (
 .sel0(sel0),
 .psel0(psel0),
 .psel1(psel1)
);

mux2s #(6)  d0_0 (
  .sel0(psel0),
  .sel1(psel1),
  .in0(din0[5:0]),
  .in1(din1[5:0]),
.dout(dout[5:0])
);









  



endmodule






// any PARAMS parms go into naming of macro

module n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_6 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [5:0] fdin;

  input [5:0] din;
  input l1clk;
  input [5:0] scan_in;


  input siclk;
  input soclk;

  output [5:0] dout;
  output [5:0] scan_out;
assign fdin[5:0] = din[5:0];






dff #(6)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[5:0]),
.si(scan_in[5:0]),
.so(scan_out[5:0]),
.q(dout[5:0])
);












endmodule










module n2_tlb_tl_64x59_array (
  l1clk, 
  disable_clear_ubit, 
  tlb_bypass, 
  tlb_wr_flopped, 
  tlb_rd_flopped, 
  rw_index, 
  tlb_cam, 
  tlb_cam_flopped, 
  demap, 
  demap_context, 
  demap_all, 
  demap_real, 
  tte_tag, 
  tte_tag_flopped, 
  tte_ubit, 
  tte_page_size_mask, 
  tte_data, 
  va, 
  tag_read_mux_control, 
  pa, 
  tlb_cam_hit, 
  context0_hit, 
  multiple_match, 
  rd_tte_data, 
  rd_tte_tag, 
  rd_tte_u_bit, 
  tlb_replacement_index) ;
wire [63:0] ram_wwl;
wire [63:0] ram_rwl;
wire [63:0] valid;
wire [63:0] used;


`define ENTRIES		64
`define INDEX		5

input		l1clk;
input		disable_clear_ubit;

input		tlb_bypass;
input		tlb_wr_flopped;
input		tlb_rd_flopped;
input	[`INDEX:0] rw_index;
input		tlb_cam;
input		tlb_cam_flopped;
input		demap;
input		demap_context;
input		demap_all;
input		demap_real;

input	[65:0]	tte_tag;
input	[65:0]	tte_tag_flopped;
input		tte_ubit;
input	[2:0]	tte_page_size_mask;
input	[37:0]	tte_data;
input	[12:11]	va;		// Incoming VA

input 		tag_read_mux_control;

output	[39:11]	pa;
output		tlb_cam_hit;
output		context0_hit;
output		multiple_match;
output	[37:0]	rd_tte_data;
output	[65:0]	rd_tte_tag;
output		rd_tte_u_bit;
output	[`INDEX:0] tlb_replacement_index;





`define VA_39 40
`define VA_28 29
`define VA_27 28
`define VA_22 23
`define VA_21 21
`define VA_16 16
`define VA_15 15 
`define VA_13 13




n2_tlb_tl_64x59_cam		cam(
  .l1clk(l1clk),
  .tlb_bypass(tlb_bypass),
  .tlb_wr_flopped(tlb_wr_flopped),
  .tlb_rd_flopped(tlb_rd_flopped),
  .rw_index(rw_index[5:0]),
  .tlb_cam(tlb_cam),
  .tlb_cam_flopped(tlb_cam_flopped),
  .demap(demap),
  .demap_context(demap_context),
  .demap_all(demap_all),
  .demap_real(demap_real),
  .tte_tag(tte_tag[65:0]),
  .tte_tag_flopped(tte_tag_flopped[65:0]),
  .tte_page_size_mask(tte_page_size_mask[2:0]),
  .tag_read_mux_control(tag_read_mux_control),
  .tlb_cam_hit(tlb_cam_hit),
  .context0_hit(context0_hit),
  .rd_tte_tag(rd_tte_tag[65:0]),
  .ram_wwl(ram_wwl[63:0]),
  .ram_rwl(ram_rwl[63:0]),
  .valid(valid[63:0]));

n2_tlb_tl_64x59_ram		ram(
	.va		({tte_tag_flopped[`VA_39:`VA_28],
			  tte_tag_flopped[`VA_27:`VA_22],
			  tte_tag_flopped[`VA_21:`VA_16],
			  tte_tag_flopped[`VA_15:`VA_13],
			  va[12:11]}),
  .l1clk(l1clk),
  .tlb_bypass(tlb_bypass),
  .tlb_cam_flopped(tlb_cam_flopped),
  .ram_wwl(ram_wwl[63:0]),
  .ram_rwl(ram_rwl[63:0]),
  .tte_data(tte_data[37:0]),
  .pa(pa[39:11]),
  .rd_tte_data(rd_tte_data[37:0])
);

n2_tlb_tl_64x59_multihit	multihit (
	.tlb_cam_mhit			(multiple_match		),
  .ram_rwl(ram_rwl[63:0]),
  .tlb_bypass(tlb_bypass)
);

n2_tlb_tl_64x59_ubit		ubit(
  .l1clk(l1clk),
  .disable_clear_ubit(disable_clear_ubit),
  .tlb_bypass(tlb_bypass),
  .ram_rwl(ram_rwl[63:0]),
  .ram_wwl(ram_wwl[63:0]),
  .tte_ubit(tte_ubit),
  .tlb_wr_flopped(tlb_wr_flopped),
  .tlb_rd_flopped(tlb_rd_flopped),
  .tlb_cam_flopped(tlb_cam_flopped),
  .used(used[63:0]),
  .rd_tte_u_bit(rd_tte_u_bit));

n2_tlb_tl_64x59_repl_index	repl_index(
  .l1clk(l1clk),
  .used(used[63:0]),
  .valid(valid[63:0]),
  .tlb_replacement_index(tlb_replacement_index[5:0]));


supply0 vss; // <- port for ground
supply1 vdd; // <- port for power 
endmodule


`ifndef FPGA
module n2_tlb_tl_64x59_cam (
  l1clk, 
  tlb_bypass, 
  tlb_wr_flopped, 
  tlb_rd_flopped, 
  rw_index, 
  tlb_cam, 
  tlb_cam_flopped, 
  demap, 
  demap_context, 
  demap_all, 
  demap_real, 
  tte_tag, 
  tte_tag_flopped, 
  tte_page_size_mask, 
  tag_read_mux_control, 
  tlb_cam_hit, 
  context0_hit, 
  rd_tte_tag, 
  ram_wwl, 
  ram_rwl, 
  valid) ;
wire [6:0] rw_index_to_decode;
wire [127:0] decoded_index;
wire [127:64] decoded_index_unused;


`define ENTRIES		64
`define INDEX		5



input		l1clk;

input		tlb_bypass;
input		tlb_wr_flopped;
input		tlb_rd_flopped;
input	[`INDEX:0] rw_index;
input		tlb_cam;
input		tlb_cam_flopped;
input		demap;
input		demap_context;
input		demap_all;
input		demap_real;

input	[65:0]	tte_tag;
input	[65:0]	tte_tag_flopped;
input	[2:0]	tte_page_size_mask;

input 		tag_read_mux_control;



output		tlb_cam_hit;
output		context0_hit;
output	[65:0]	rd_tte_tag;
output	[`ENTRIES-1:0] ram_wwl;
output	[`ENTRIES-1:0] ram_rwl;
output	[`ENTRIES-1:0] valid;



`define CNTX1_HI 65
`define CNTX1_LO 53
`define PID_HI   52
`define PID_LO   50
`define REAL_BIT 49
`define VA_47    48
`define VA_28    29
`define VA_27    28
`define VA_22    23
`define TTE_VALID 22 
`define VA_21    21
`define VA_16    16
`define VA_15    15 
`define VA_13    13
`define CNTX0_HI 12
`define CNTX0_LO  0



//----------------------------------------------------------------------
// Declarations
//----------------------------------------------------------------------

// local signals

reg 	[12:0] 	context_a	[`ENTRIES-1:0];  // Contexts a and b are
reg 	[12:0] 	context_a_	[`ENTRIES-1:0];  // to be equal at all times
reg 	[12:0] 	context_b	[`ENTRIES-1:0];  // This is NOT context 0 and 1
reg 	[12:0] 	context_b_	[`ENTRIES-1:0];  // This is NOT primary/secondary
reg        	r_bit		[`ENTRIES-1:0];
reg        	r_bit_		[`ENTRIES-1:0];
reg     [47:28] va_47_28	[`ENTRIES-1:0];
reg     [47:28] va_47_28_	[`ENTRIES-1:0];
reg     [27:22] va_27_22	[`ENTRIES-1:0];
reg     [27:22] va_27_22_	[`ENTRIES-1:0];
reg     [21:16] va_21_16	[`ENTRIES-1:0];
reg     [21:16] va_21_16_	[`ENTRIES-1:0];
reg     [15:13] va_15_13	[`ENTRIES-1:0];
reg     [15:13] va_15_13_	[`ENTRIES-1:0];
reg	[2:0]	pid		[`ENTRIES-1:0];
reg	[2:0]	pid_		[`ENTRIES-1:0];
reg 	[`ENTRIES-1:0]	valid;
reg 	[`ENTRIES-1:0]	match_for_sat;
reg 			tlb_cam_hit;
reg 			context0_hit;

integer n;
reg [31:0] n_reg;

reg [`ENTRIES-1:0] va_47_28_match ;
reg [`ENTRIES-1:0] va_27_22_match ;
reg [`ENTRIES-1:0] va_21_16_match ;
reg [`ENTRIES-1:0] va_15_13_match ;
reg [`ENTRIES-1:0] pid_match      ;
reg [`ENTRIES-1:0] real_match     ;
reg [`ENTRIES-1:0] context0_match ;
reg [`ENTRIES-1:0] context1_match ;
reg [`ENTRIES-1:0] context_match  ;
reg [`ENTRIES-1:0] match          ;
reg [`ENTRIES-1:0] ram_wl         ;
reg [65:0] rd_tte_tag;
reg [12:0] a_xnor_tag;
reg [12:0] b_xnor_tag;

reg 	   demap_posedge_l1clk;



`ifndef NOINITMEM
///////////////////////////////////////
// Initialize the arrays.            //
///////////////////////////////////////
initial begin
	for (n = 0; n < `ENTRIES; n = n+1) begin
		context_a	[n] = {13 {1'b0}};
		context_a_	[n] = {13 {1'b1}};
		context_b	[n] = {13 {1'b0}};
		context_b_	[n] = {13 {1'b1}};
		r_bit		[n] = { 1 {1'b0}};
		r_bit_		[n] = { 1 {1'b1}};
		va_47_28	[n] = {20 {1'b0}};
		va_47_28_	[n] = {20 {1'b1}};
		va_27_22	[n] = { 6 {1'b0}};
		va_27_22_	[n] = { 6 {1'b1}};
		va_21_16	[n] = { 6 {1'b0}};
		va_21_16_	[n] = { 6 {1'b1}};
		va_15_13	[n] = { 3 {1'b0}};
		va_15_13_	[n] = { 3 {1'b1}};
		pid		[n] = { 3 {1'b0}};
		pid_		[n] = { 3 {1'b1}};
		valid		[n] = { 1 {1'b0}};
	end // for (n = 0; n < `ENTRIES; n = n+1)
end
`endif



///////////////////////////////////////////////////////////////
// CAM, read
///////////////////////////////////////////////////////////////
always @(posedge l1clk) begin

	demap_posedge_l1clk = demap;
	
	match[`ENTRIES-1:0] = {`ENTRIES {1'b0}};

	if (tlb_cam | demap) begin
		for (n = 0; n < `ENTRIES; n = n + 1) begin
			// Have to represent dual match line architecture...
			// LSB 2 bits of context must both match AND MSB 11 bits must not mismatch
			a_xnor_tag[12:0] =       (context_a	[n] &  tte_tag[`CNTX1_HI:`CNTX1_LO]) |
						 (context_a_	[n] & ~tte_tag[`CNTX1_HI:`CNTX1_LO]) ;
			b_xnor_tag[12:0] =       (context_b	[n] &  tte_tag[`CNTX0_HI:`CNTX0_LO]) |
						 (context_b_	[n] & ~tte_tag[`CNTX0_HI:`CNTX0_LO]) ;
			context1_match[n] = demap_all | demap_real | 
					    (& a_xnor_tag[1:0]) & 
					    (~(| {context_a	[n] & ~tte_tag[`CNTX1_HI:`CNTX1_LO] & 13'h1ffc,
						  context_a_	[n] &  tte_tag[`CNTX1_HI:`CNTX1_LO] & 13'h1ffc}));
			context0_match[n] = demap_all | demap_real |
					    (& b_xnor_tag[1:0]) & 
					    (~(| {context_b	[n] & ~tte_tag[`CNTX0_HI:`CNTX0_LO] & 13'h1ffc,
						  context_b_	[n] &  tte_tag[`CNTX0_HI:`CNTX0_LO] & 13'h1ffc}));
			pid_match[n]      = (~(| {pid		[n] & ~tte_tag[`PID_HI	:`PID_LO  ],
						  pid_		[n] &  tte_tag[`PID_HI	:`PID_LO  ]}));
			real_match[n]     = demap_all | 
					    (~(| {r_bit		[n] & ~tte_tag[`REAL_BIT	  ],
						  r_bit_	[n] &  tte_tag[`REAL_BIT	  ]}));
			va_47_28_match[n] = demap_all | demap_real | demap_context |  
					    (~(| {va_47_28	[n] & ~tte_tag[`VA_47	:`VA_28   ],
						  va_47_28_	[n] &  tte_tag[`VA_47	:`VA_28   ]}));
			va_27_22_match[n] = demap_all | demap_real | demap_context |  
					    (~(| {va_27_22	[n] & ~tte_tag[`VA_27	:`VA_22   ],
						  va_27_22_	[n] &  tte_tag[`VA_27	:`VA_22   ]}));
			va_21_16_match[n] = demap_all | demap_real | demap_context |  
					    (~(| {va_21_16	[n] & ~tte_tag[`VA_21	:`VA_16   ],
						  va_21_16_	[n] &  tte_tag[`VA_21	:`VA_16   ]}));
			va_15_13_match[n] = demap_all | demap_real | demap_context |  
					    (~(| {va_15_13	[n] & ~tte_tag[`VA_15	:`VA_13   ],
						  va_15_13_	[n] &  tte_tag[`VA_15	:`VA_13   ]}));

			context_match[n]  = context0_match[n] | context1_match[n];
			
			match[n] = va_47_28_match[n] & va_27_22_match[n] & va_21_16_match[n] & 
				   va_15_13_match[n] & pid_match[n] & real_match[n] & context_match[n] &
				   valid[n];

		end // for (n = 0; n < `ENTRIES; n = n + 1)
		
		
	end // if (tlb_cam | demap)
	

		
	ram_wl[`ENTRIES-1:0] <= match[`ENTRIES-1:0];
	
end // always @ (posedge l1clk)



///////////////////////////////////////////////////////////////
// Demap, Write, Read
///////////////////////////////////////////////////////////////
always @(negedge l1clk) begin

	// Demap
	if (demap) begin	
		for (n = 0; n < `ENTRIES; n = n + 1) begin
			if (match[n]) begin
				valid[n] <= 1'b0;
			end
		end
	end // if (demap)	

	// Write
	if (tlb_wr_flopped) begin

		for (n = 0; n < `ENTRIES; n = n + 1) begin
			if (ram_wwl[n]) begin
				context_a	[n] <=( tte_tag_flopped[`CNTX1_HI:`CNTX1_LO] & {13 {~tte_tag_flopped[`REAL_BIT]}}) | {11'h00, {2 {tte_tag_flopped[`REAL_BIT]}}};
				context_a_	[n] <=(~tte_tag_flopped[`CNTX1_HI:`CNTX1_LO] & {13 {~tte_tag_flopped[`REAL_BIT]}}) | {11'h00, {2 {tte_tag_flopped[`REAL_BIT]}}};
				pid		[n] <=  tte_tag_flopped[`PID_HI  :`PID_LO  ];
				pid_		[n] <= ~tte_tag_flopped[`PID_HI  :`PID_LO  ];
				r_bit		[n] <=  tte_tag_flopped[`REAL_BIT          ];
				r_bit_		[n] <= ~tte_tag_flopped[`REAL_BIT          ];
				va_47_28	[n] <=  tte_tag_flopped[`VA_47   :`VA_28   ];
				va_47_28_	[n] <= ~tte_tag_flopped[`VA_47   :`VA_28   ];
				va_27_22	[n] <=  tte_tag_flopped[`VA_27   :`VA_22   ] & { 6 {~tte_page_size_mask[2]}};
				va_27_22_	[n] <= ~tte_tag_flopped[`VA_27   :`VA_22   ] & { 6 {~tte_page_size_mask[2]}};
				va_21_16	[n] <=  tte_tag_flopped[`VA_21   :`VA_16   ] & { 6 {~tte_page_size_mask[1]}};
				va_21_16_	[n] <= ~tte_tag_flopped[`VA_21   :`VA_16   ] & { 6 {~tte_page_size_mask[1]}};
				va_15_13	[n] <=  tte_tag_flopped[`VA_15   :`VA_13   ] & { 3 {~tte_page_size_mask[0]}};
				va_15_13_	[n] <= ~tte_tag_flopped[`VA_15   :`VA_13   ] & { 3 {~tte_page_size_mask[0]}};
				context_b	[n] <=( tte_tag_flopped[`CNTX0_HI:`CNTX0_LO] & {13 {~tte_tag_flopped[`REAL_BIT]}}) | {11'h00, {2 {tte_tag_flopped[`REAL_BIT]}}};
				context_b_	[n] <=(~tte_tag_flopped[`CNTX0_HI:`CNTX0_LO] & {13 {~tte_tag_flopped[`REAL_BIT]}}) | {11'h00, {2 {tte_tag_flopped[`REAL_BIT]}}};
				valid 		[n] <=  tte_tag_flopped[`TTE_VALID         ];

				
				
					
			end // if (ram_wwl[n])
		end // for (n = 0; n < `ENTRIES; n = n + 1)
		
	end // if (tlb_wr_flopped)

	// Read	
	if (tlb_rd_flopped) begin
		if (tag_read_mux_control) begin
			rd_tte_tag[`CNTX1_HI:`CNTX1_LO] <= context_a_	[rw_index[`INDEX:0]];
			rd_tte_tag[`PID_HI  :`PID_LO  ] <= pid_		[rw_index[`INDEX:0]];
			rd_tte_tag[`REAL_BIT          ] <= r_bit_	[rw_index[`INDEX:0]];
			rd_tte_tag[`VA_47   :`VA_28   ] <= va_47_28_	[rw_index[`INDEX:0]];
			rd_tte_tag[`VA_27   :`VA_22   ] <= va_27_22_	[rw_index[`INDEX:0]];
			rd_tte_tag[`VA_21   :`VA_16   ] <= va_21_16_	[rw_index[`INDEX:0]];
			rd_tte_tag[`VA_15   :`VA_13   ] <= va_15_13_	[rw_index[`INDEX:0]];
			rd_tte_tag[`CNTX0_HI:`CNTX0_LO] <= context_b_	[rw_index[`INDEX:0]];
		end // if (tag_read_mux_control)
		else begin
			rd_tte_tag[`CNTX1_HI:`CNTX1_LO] <= context_a	[rw_index[`INDEX:0]];
			rd_tte_tag[`PID_HI  :`PID_LO  ] <= pid		[rw_index[`INDEX:0]];
			rd_tte_tag[`REAL_BIT          ] <= r_bit	[rw_index[`INDEX:0]];
			rd_tte_tag[`VA_47   :`VA_28   ] <= va_47_28	[rw_index[`INDEX:0]];
			rd_tte_tag[`VA_27   :`VA_22   ] <= va_27_22	[rw_index[`INDEX:0]];
			rd_tte_tag[`VA_21   :`VA_16   ] <= va_21_16	[rw_index[`INDEX:0]];
			rd_tte_tag[`VA_15   :`VA_13   ] <= va_15_13	[rw_index[`INDEX:0]];
			rd_tte_tag[`CNTX0_HI:`CNTX0_LO] <= context_b	[rw_index[`INDEX:0]];
		end // else: !if(tag_read_mux_control)
		rd_tte_tag[`TTE_VALID         ] <= valid	[rw_index[`INDEX:0]];
	end // if (tlb_rd
	else begin
	        rd_tte_tag[65:0] <= {66 {1'b0}} ;
	end // else: !if(tlb_rd)

end // always @ (negedge l1clk)



///////////////////////////////////////////////////////////////
// Output assignments
///////////////////////////////////////////////////////////////
// Have to hold them to next clock edge

// Read and write address decode
assign rw_index_to_decode[6:0] =
	{1'b0,
//	{rw_index[6],
	rw_index[5:0]};

assign decoded_index[127:0] = 
	{(rw_index_to_decode[6:0] == 7'h7f),
	 (rw_index_to_decode[6:0] == 7'h7e),
	 (rw_index_to_decode[6:0] == 7'h7d),
	 (rw_index_to_decode[6:0] == 7'h7c),
	 (rw_index_to_decode[6:0] == 7'h7b),
	 (rw_index_to_decode[6:0] == 7'h7a),
	 (rw_index_to_decode[6:0] == 7'h79),
	 (rw_index_to_decode[6:0] == 7'h78),
	 (rw_index_to_decode[6:0] == 7'h77),
	 (rw_index_to_decode[6:0] == 7'h76),
	 (rw_index_to_decode[6:0] == 7'h75),
	 (rw_index_to_decode[6:0] == 7'h74),
	 (rw_index_to_decode[6:0] == 7'h73),
	 (rw_index_to_decode[6:0] == 7'h72),
	 (rw_index_to_decode[6:0] == 7'h71),
	 (rw_index_to_decode[6:0] == 7'h70),
	 (rw_index_to_decode[6:0] == 7'h6f),
	 (rw_index_to_decode[6:0] == 7'h6e),
	 (rw_index_to_decode[6:0] == 7'h6d),
	 (rw_index_to_decode[6:0] == 7'h6c),
	 (rw_index_to_decode[6:0] == 7'h6b),
	 (rw_index_to_decode[6:0] == 7'h6a),
	 (rw_index_to_decode[6:0] == 7'h69),
	 (rw_index_to_decode[6:0] == 7'h68),
	 (rw_index_to_decode[6:0] == 7'h67),
	 (rw_index_to_decode[6:0] == 7'h66),
	 (rw_index_to_decode[6:0] == 7'h65),
	 (rw_index_to_decode[6:0] == 7'h64),
	 (rw_index_to_decode[6:0] == 7'h63),
	 (rw_index_to_decode[6:0] == 7'h62),
	 (rw_index_to_decode[6:0] == 7'h61),
	 (rw_index_to_decode[6:0] == 7'h60),
	 (rw_index_to_decode[6:0] == 7'h5f),
	 (rw_index_to_decode[6:0] == 7'h5e),
	 (rw_index_to_decode[6:0] == 7'h5d),
	 (rw_index_to_decode[6:0] == 7'h5c),
	 (rw_index_to_decode[6:0] == 7'h5b),
	 (rw_index_to_decode[6:0] == 7'h5a),
	 (rw_index_to_decode[6:0] == 7'h59),
	 (rw_index_to_decode[6:0] == 7'h58),
	 (rw_index_to_decode[6:0] == 7'h57),
	 (rw_index_to_decode[6:0] == 7'h56),
	 (rw_index_to_decode[6:0] == 7'h55),
	 (rw_index_to_decode[6:0] == 7'h54),
	 (rw_index_to_decode[6:0] == 7'h53),
	 (rw_index_to_decode[6:0] == 7'h52),
	 (rw_index_to_decode[6:0] == 7'h51),
	 (rw_index_to_decode[6:0] == 7'h50),
	 (rw_index_to_decode[6:0] == 7'h4f),
	 (rw_index_to_decode[6:0] == 7'h4e),
	 (rw_index_to_decode[6:0] == 7'h4d),
	 (rw_index_to_decode[6:0] == 7'h4c),
	 (rw_index_to_decode[6:0] == 7'h4b),
	 (rw_index_to_decode[6:0] == 7'h4a),
	 (rw_index_to_decode[6:0] == 7'h49),
	 (rw_index_to_decode[6:0] == 7'h48),
	 (rw_index_to_decode[6:0] == 7'h47),
	 (rw_index_to_decode[6:0] == 7'h46),
	 (rw_index_to_decode[6:0] == 7'h45),
	 (rw_index_to_decode[6:0] == 7'h44),
	 (rw_index_to_decode[6:0] == 7'h43),
	 (rw_index_to_decode[6:0] == 7'h42),
	 (rw_index_to_decode[6:0] == 7'h41),
	 (rw_index_to_decode[6:0] == 7'h40),
	 (rw_index_to_decode[6:0] == 7'h3f),
	 (rw_index_to_decode[6:0] == 7'h3e),
	 (rw_index_to_decode[6:0] == 7'h3d),
	 (rw_index_to_decode[6:0] == 7'h3c),
	 (rw_index_to_decode[6:0] == 7'h3b),
	 (rw_index_to_decode[6:0] == 7'h3a),
	 (rw_index_to_decode[6:0] == 7'h39),
	 (rw_index_to_decode[6:0] == 7'h38),
	 (rw_index_to_decode[6:0] == 7'h37),
	 (rw_index_to_decode[6:0] == 7'h36),
	 (rw_index_to_decode[6:0] == 7'h35),
	 (rw_index_to_decode[6:0] == 7'h34),
	 (rw_index_to_decode[6:0] == 7'h33),
	 (rw_index_to_decode[6:0] == 7'h32),
	 (rw_index_to_decode[6:0] == 7'h31),
	 (rw_index_to_decode[6:0] == 7'h30),
	 (rw_index_to_decode[6:0] == 7'h2f),
	 (rw_index_to_decode[6:0] == 7'h2e),
	 (rw_index_to_decode[6:0] == 7'h2d),
	 (rw_index_to_decode[6:0] == 7'h2c),
	 (rw_index_to_decode[6:0] == 7'h2b),
	 (rw_index_to_decode[6:0] == 7'h2a),
	 (rw_index_to_decode[6:0] == 7'h29),
	 (rw_index_to_decode[6:0] == 7'h28),
	 (rw_index_to_decode[6:0] == 7'h27),
	 (rw_index_to_decode[6:0] == 7'h26),
	 (rw_index_to_decode[6:0] == 7'h25),
	 (rw_index_to_decode[6:0] == 7'h24),
	 (rw_index_to_decode[6:0] == 7'h23),
	 (rw_index_to_decode[6:0] == 7'h22),
	 (rw_index_to_decode[6:0] == 7'h21),
	 (rw_index_to_decode[6:0] == 7'h20),
	 (rw_index_to_decode[6:0] == 7'h1f),
	 (rw_index_to_decode[6:0] == 7'h1e),
	 (rw_index_to_decode[6:0] == 7'h1d),
	 (rw_index_to_decode[6:0] == 7'h1c),
	 (rw_index_to_decode[6:0] == 7'h1b),
	 (rw_index_to_decode[6:0] == 7'h1a),
	 (rw_index_to_decode[6:0] == 7'h19),
	 (rw_index_to_decode[6:0] == 7'h18),
	 (rw_index_to_decode[6:0] == 7'h17),
	 (rw_index_to_decode[6:0] == 7'h16),
	 (rw_index_to_decode[6:0] == 7'h15),
	 (rw_index_to_decode[6:0] == 7'h14),
	 (rw_index_to_decode[6:0] == 7'h13),
	 (rw_index_to_decode[6:0] == 7'h12),
	 (rw_index_to_decode[6:0] == 7'h11),
	 (rw_index_to_decode[6:0] == 7'h10),
	 (rw_index_to_decode[6:0] == 7'h0f),
	 (rw_index_to_decode[6:0] == 7'h0e),
	 (rw_index_to_decode[6:0] == 7'h0d),
	 (rw_index_to_decode[6:0] == 7'h0c),
	 (rw_index_to_decode[6:0] == 7'h0b),
	 (rw_index_to_decode[6:0] == 7'h0a),
	 (rw_index_to_decode[6:0] == 7'h09),
	 (rw_index_to_decode[6:0] == 7'h08),
	 (rw_index_to_decode[6:0] == 7'h07),
	 (rw_index_to_decode[6:0] == 7'h06),
	 (rw_index_to_decode[6:0] == 7'h05),
	 (rw_index_to_decode[6:0] == 7'h04),
	 (rw_index_to_decode[6:0] == 7'h03),
	 (rw_index_to_decode[6:0] == 7'h02),
	 (rw_index_to_decode[6:0] == 7'h01),
	 (rw_index_to_decode[6:0] == 7'h00)};

assign decoded_index_unused[127:64] = decoded_index[127:64];

always @(negedge l1clk) begin
	match_for_sat[`ENTRIES-1:0] <= match[`ENTRIES-1:0]; // For MMU SAT
	tlb_cam_hit <= (| match[`ENTRIES-1:0]) | tlb_bypass | ~tlb_cam;
	context0_hit <= (|(match[`ENTRIES-1:0] & context0_match[`ENTRIES-1:0])) & ~demap_posedge_l1clk;
end // always @ (negedge l1clk)

assign ram_wwl[`ENTRIES-1:0] = 
       decoded_index[`ENTRIES-1:0] & {`ENTRIES {tlb_wr_flopped}};

assign ram_rwl[`ENTRIES-1:0] = 
       (decoded_index[`ENTRIES-1:0] & {`ENTRIES {tlb_rd_flopped }}) |
       (ram_wl       [`ENTRIES-1:0] & {`ENTRIES {tlb_cam_flopped}});





supply0 vss; // <- port for ground
supply1 vdd; // <- port for power 
endmodule
`endif // `ifndef FPGA

`ifdef FPGA
module n2_tlb_tl_64x59_cam(l1clk, tlb_bypass, tlb_wr_flopped, tlb_rd_flopped, 
	rw_index, tlb_cam, tlb_cam_flopped, demap, demap_context, demap_all, 
	demap_real, tte_tag, tte_tag_flopped, tte_page_size_mask, 
	tag_read_mux_control, tlb_cam_hit, context0_hit, rd_tte_tag, ram_wwl, 
	ram_rwl, valid);

	input			l1clk;
	input			tlb_bypass;
	input			tlb_wr_flopped;
	input			tlb_rd_flopped;
	input	[5:0]		rw_index;
	input			tlb_cam;
	input			tlb_cam_flopped;
	input			demap;
	input			demap_context;
	input			demap_all;
	input			demap_real;
	input	[65:0]		tte_tag;
	input	[65:0]		tte_tag_flopped;
	input	[2:0]		tte_page_size_mask;
	input			tag_read_mux_control;
	output			tlb_cam_hit;
	output			context0_hit;
	output	[65:0]		rd_tte_tag;
	output	[(64 - 1):0]	ram_wwl;
	output	[(64 - 1):0]	ram_rwl;
	output	[(64 - 1):0]	valid;

	wire	[6:0]		rw_index_to_decode;
	wire	[127:0]		decoded_index;
	wire	[127:64]	decoded_index_unused;

	reg	[12:0]		context_a[(64 - 1):0];
	reg	[12:0]		context_a_[(64 - 1):0];
	reg	[12:0]		context_b[(64 - 1):0];
	reg	[12:0]		context_b_[(64 - 1):0];
	reg			r_bit[(64 - 1):0];
	reg			r_bit_[(64 - 1):0];
	reg	[47:28]		va_47_28[(64 - 1):0];
	reg	[47:28]		va_47_28_[(64 - 1):0];
	reg	[27:22]		va_27_22[(64 - 1):0];
	reg	[27:22]		va_27_22_[(64 - 1):0];
	reg	[21:16]		va_21_16[(64 - 1):0];
	reg	[21:16]		va_21_16_[(64 - 1):0];
	reg	[15:13]		va_15_13[(64 - 1):0];
	reg	[15:13]		va_15_13_[(64 - 1):0];
	reg	[2:0]		pid[(64 - 1):0];
	reg	[2:0]		pid_[(64 - 1):0];
	reg	[(64 - 1):0]	match_for_sat;
	reg			tlb_cam_hit;
	reg			context0_hit;
	integer			n;
	reg	[31:0]		n_reg;
	reg	[(64 - 1):0]	va_47_28_match;
	reg	[(64 - 1):0]	va_27_22_match;
	reg	[(64 - 1):0]	va_21_16_match;
	reg	[(64 - 1):0]	va_15_13_match;
	reg	[(64 - 1):0]	pid_match;
	reg	[(64 - 1):0]	real_match;
	reg	[(64 - 1):0]	context0_match;
	reg	[(64 - 1):0]	context1_match;
	reg	[(64 - 1):0]	context_match;
	reg	[(64 - 1):0]	match;
	reg	[(64 - 1):0]	ram_wl;
	reg	[65:0]		rd_tte_tag;
	reg	[(64 - 1):0]	valid;
	reg	[12:0]		a_xnor_tag;
	reg	[12:0]		b_xnor_tag;
	reg			demap_posedge_l1clk;
	supply0			vss;
	supply1			vdd;

	assign rw_index_to_decode[6:0] = {1'b0, rw_index[5:0]};
	assign decoded_index[127:0] = {(rw_index_to_decode[6:0] == 7'b1111111), 
		(rw_index_to_decode[6:0] == 7'h7e), (rw_index_to_decode[6:0] ==
		7'h7d), (rw_index_to_decode[6:0] == 7'h7c), 
		(rw_index_to_decode[6:0] == 7'h7b), (rw_index_to_decode[6:0] ==
		7'h7a), (rw_index_to_decode[6:0] == 7'h79), 
		(rw_index_to_decode[6:0] == 7'h78), (rw_index_to_decode[6:0] ==
		7'h77), (rw_index_to_decode[6:0] == 7'h76), 
		(rw_index_to_decode[6:0] == 7'h75), (rw_index_to_decode[6:0] ==
		7'h74), (rw_index_to_decode[6:0] == 7'h73), 
		(rw_index_to_decode[6:0] == 7'h72), (rw_index_to_decode[6:0] ==
		7'h71), (rw_index_to_decode[6:0] == 7'h70), 
		(rw_index_to_decode[6:0] == 7'h6f), (rw_index_to_decode[6:0] ==
		7'h6e), (rw_index_to_decode[6:0] == 7'h6d), 
		(rw_index_to_decode[6:0] == 7'h6c), (rw_index_to_decode[6:0] ==
		7'h6b), (rw_index_to_decode[6:0] == 7'h6a), 
		(rw_index_to_decode[6:0] == 7'h69), (rw_index_to_decode[6:0] ==
		7'h68), (rw_index_to_decode[6:0] == 7'h67), 
		(rw_index_to_decode[6:0] == 7'h66), (rw_index_to_decode[6:0] ==
		7'h65), (rw_index_to_decode[6:0] == 7'h64), 
		(rw_index_to_decode[6:0] == 7'h63), (rw_index_to_decode[6:0] ==
		7'h62), (rw_index_to_decode[6:0] == 7'h61), 
		(rw_index_to_decode[6:0] == 7'h60), (rw_index_to_decode[6:0] ==
		7'h5f), (rw_index_to_decode[6:0] == 7'h5e), 
		(rw_index_to_decode[6:0] == 7'h5d), (rw_index_to_decode[6:0] ==
		7'h5c), (rw_index_to_decode[6:0] == 7'h5b), 
		(rw_index_to_decode[6:0] == 7'h5a), (rw_index_to_decode[6:0] ==
		7'h59), (rw_index_to_decode[6:0] == 7'h58), 
		(rw_index_to_decode[6:0] == 7'h57), (rw_index_to_decode[6:0] ==
		7'h56), (rw_index_to_decode[6:0] == 7'h55), 
		(rw_index_to_decode[6:0] == 7'h54), (rw_index_to_decode[6:0] ==
		7'h53), (rw_index_to_decode[6:0] == 7'h52), 
		(rw_index_to_decode[6:0] == 7'h51), (rw_index_to_decode[6:0] ==
		7'h50), (rw_index_to_decode[6:0] == 7'h4f), 
		(rw_index_to_decode[6:0] == 7'h4e), (rw_index_to_decode[6:0] ==
		7'h4d), (rw_index_to_decode[6:0] == 7'h4c), 
		(rw_index_to_decode[6:0] == 7'h4b), (rw_index_to_decode[6:0] ==
		7'h4a), (rw_index_to_decode[6:0] == 7'h49), 
		(rw_index_to_decode[6:0] == 7'h48), (rw_index_to_decode[6:0] ==
		7'h47), (rw_index_to_decode[6:0] == 7'h46), 
		(rw_index_to_decode[6:0] == 7'h45), (rw_index_to_decode[6:0] ==
		7'h44), (rw_index_to_decode[6:0] == 7'h43), 
		(rw_index_to_decode[6:0] == 7'h42), (rw_index_to_decode[6:0] ==
		7'h41), (rw_index_to_decode[6:0] == 7'h40), 
		(rw_index_to_decode[6:0] == 7'b0111111), 
		(rw_index_to_decode[6:0] == 7'h3e), (rw_index_to_decode[6:0] ==
		7'h3d), (rw_index_to_decode[6:0] == 7'h3c), 
		(rw_index_to_decode[6:0] == 7'h3b), (rw_index_to_decode[6:0] ==
		7'h3a), (rw_index_to_decode[6:0] == 7'h39), 
		(rw_index_to_decode[6:0] == 7'h38), (rw_index_to_decode[6:0] ==
		7'h37), (rw_index_to_decode[6:0] == 7'h36), 
		(rw_index_to_decode[6:0] == 7'h35), (rw_index_to_decode[6:0] ==
		7'h34), (rw_index_to_decode[6:0] == 7'h33), 
		(rw_index_to_decode[6:0] == 7'h32), (rw_index_to_decode[6:0] ==
		7'h31), (rw_index_to_decode[6:0] == 7'h30), 
		(rw_index_to_decode[6:0] == 7'h2f), (rw_index_to_decode[6:0] ==
		7'h2e), (rw_index_to_decode[6:0] == 7'h2d), 
		(rw_index_to_decode[6:0] == 7'h2c), (rw_index_to_decode[6:0] ==
		7'h2b), (rw_index_to_decode[6:0] == 7'h2a), 
		(rw_index_to_decode[6:0] == 7'h29), (rw_index_to_decode[6:0] ==
		7'h28), (rw_index_to_decode[6:0] == 7'h27), 
		(rw_index_to_decode[6:0] == 7'h26), (rw_index_to_decode[6:0] ==
		7'h25), (rw_index_to_decode[6:0] == 7'h24), 
		(rw_index_to_decode[6:0] == 7'h23), (rw_index_to_decode[6:0] ==
		7'h22), (rw_index_to_decode[6:0] == 7'h21), 
		(rw_index_to_decode[6:0] == 7'h20), (rw_index_to_decode[6:0] ==
		7'h1f), (rw_index_to_decode[6:0] == 7'h1e), 
		(rw_index_to_decode[6:0] == 7'h1d), (rw_index_to_decode[6:0] ==
		7'h1c), (rw_index_to_decode[6:0] == 7'h1b), 
		(rw_index_to_decode[6:0] == 7'h1a), (rw_index_to_decode[6:0] ==
		7'h19), (rw_index_to_decode[6:0] == 7'h18), 
		(rw_index_to_decode[6:0] == 7'h17), (rw_index_to_decode[6:0] ==
		7'h16), (rw_index_to_decode[6:0] == 7'h15), 
		(rw_index_to_decode[6:0] == 7'h14), (rw_index_to_decode[6:0] ==
		7'h13), (rw_index_to_decode[6:0] == 7'h12), 
		(rw_index_to_decode[6:0] == 7'h11), (rw_index_to_decode[6:0] ==
		7'h10), (rw_index_to_decode[6:0] == 7'h0f), 
		(rw_index_to_decode[6:0] == 7'h0e), (rw_index_to_decode[6:0] ==
		7'h0d), (rw_index_to_decode[6:0] == 7'h0c), 
		(rw_index_to_decode[6:0] == 7'h0b), (rw_index_to_decode[6:0] ==
		7'h0a), (rw_index_to_decode[6:0] == 7'h09), 
		(rw_index_to_decode[6:0] == 7'h08), (rw_index_to_decode[6:0] ==
		7'h07), (rw_index_to_decode[6:0] == 7'h06), 
		(rw_index_to_decode[6:0] == 7'h05), (rw_index_to_decode[6:0] ==
		7'h04), (rw_index_to_decode[6:0] == 7'h03), 
		(rw_index_to_decode[6:0] == 7'b0000010), 
		(rw_index_to_decode[6:0] == 7'b1), (rw_index_to_decode[6:0] ==
		7'b0)};
	assign decoded_index_unused[127:64] = decoded_index[127:64];
	assign ram_wwl[(64 - 1):0] = (decoded_index[(64 - 1):0] & {64 {
		tlb_wr_flopped}});
	assign ram_rwl[(64 - 1):0] = ((decoded_index[(64 - 1):0] & {64 {
		tlb_rd_flopped}}) | (ram_wl[(64 - 1):0] & {64 {tlb_cam_flopped}}
		));

	initial begin
	  for (n = 0; (n < 64); n = (n + 1)) begin
	    context_a[n] = {13 {1'b0}};
	    context_a_[n] = {13 {1'b1}};
	    context_b[n] = {13 {1'b0}};
	    context_b_[n] = {13 {1'b1}};
	    r_bit[n] = {1 {1'b0}};
	    r_bit_[n] = {1 {1'b1}};
	    va_47_28[n] = {20 {1'b0}};
	    va_47_28_[n] = {20 {1'b1}};
	    va_27_22[n] = {6 {1'b0}};
	    va_27_22_[n] = {6 {1'b1}};
	    va_21_16[n] = {6 {1'b0}};
	    va_21_16_[n] = {6 {1'b1}};
	    va_15_13[n] = {3 {1'b0}};
	    va_15_13_[n] = {3 {1'b1}};
	    pid[n] = {3 {1'b0}};
	    pid_[n] = {3 {1'b1}};
	    valid[n] = {1 {1'b0}};
	  end
	end
	always @(posedge l1clk) begin
	  demap_posedge_l1clk = demap;
	  match[(64 - 1):0] = {64 {1'b0}};
	  if (tlb_cam | demap) begin
	    for (n = 0; (n < 64); n = (n + 1)) begin
	      a_xnor_tag[12:0] = ((context_a[n] & tte_tag[65:53]) | (
		      context_a_[n] & (~tte_tag[65:53])));
	      b_xnor_tag[12:0] = ((context_b[n] & tte_tag[12:0]) | (
		      context_b_[n] & (~tte_tag[12:0])));
	      context1_match[n] = ((demap_all | demap_real) | ((&a_xnor_tag[1:0]
		      ) & (~(|{((context_a[n] & (~tte_tag[65:53])) & 13'h1ffc), 
		      ((context_a_[n] & tte_tag[65:53]) & 13'h1ffc)}))));
	      context0_match[n] = ((demap_all | demap_real) | ((&b_xnor_tag[1:0]
		      ) & (~(|{((context_b[n] & (~tte_tag[12:0])) & 13'h1ffc), 
		      ((context_b_[n] & tte_tag[12:0]) & 13'h1ffc)}))));
	      pid_match[n] = (~(|{(pid[n] & (~tte_tag[52:50])), (pid_[n] &
		      tte_tag[52:50])}));
	      real_match[n] = (demap_all | (~(|{(r_bit[n] & (~tte_tag[49])), 
		      (r_bit_[n] & tte_tag[49])})));
	      va_47_28_match[n] = (((demap_all | demap_real) | demap_context) | 
		      (~(|{(va_47_28[n] & (~tte_tag[48:29])), (va_47_28_[n] &
		      tte_tag[48:29])})));
	      va_27_22_match[n] = (((demap_all | demap_real) | demap_context) | 
		      (~(|{(va_27_22[n] & (~tte_tag[28:23])), (va_27_22_[n] &
		      tte_tag[28:23])})));
	      va_21_16_match[n] = (((demap_all | demap_real) | demap_context) | 
		      (~(|{(va_21_16[n] & (~tte_tag[21:16])), (va_21_16_[n] &
		      tte_tag[21:16])})));
	      va_15_13_match[n] = (((demap_all | demap_real) | demap_context) | 
		      (~(|{(va_15_13[n] & (~tte_tag[15:13])), (va_15_13_[n] &
		      tte_tag[15:13])})));
	      context_match[n] = (context0_match[n] | context1_match[n]);
	      match[n] = (((((((va_47_28_match[n] & va_27_22_match[n]) & 
		      va_21_16_match[n]) & va_15_13_match[n]) & pid_match[n]) & 
		      real_match[n]) & context_match[n]) & valid[n]);
	    end
	  end
	  ram_wl[(64 - 1):0] <= match[(64 - 1):0];
	end
	always @(negedge l1clk) begin
	  if (demap) begin
	    for (n = 0; (n < 64); n = (n + 1)) begin
	      if (match[n]) begin
		valid[n] <= 1'b0;
	      end
	    end
	  end
	  if (tlb_wr_flopped) begin
	    for (n = 0; (n < 64); n = (n + 1)) begin
	      if (ram_wwl[n]) begin
		context_a[n] <= ((tte_tag_flopped[65:53] & {13 {
			(~tte_tag_flopped[49])}}) | {11'b0, {2
			{tte_tag_flopped[49]}}});
		context_a_[n] <= (((~tte_tag_flopped[65:53]) & {13 {
			(~tte_tag_flopped[49])}}) | {11'b0, {2
			{tte_tag_flopped[49]}}});
		pid[n] <= tte_tag_flopped[52:50];
		pid_[n] <= (~tte_tag_flopped[52:50]);
		r_bit[n] <= tte_tag_flopped[49];
		r_bit_[n] <= (~tte_tag_flopped[49]);
		va_47_28[n] <= tte_tag_flopped[48:29];
		va_47_28_[n] <= (~tte_tag_flopped[48:29]);
		va_27_22[n] <= (tte_tag_flopped[28:23] & {6 {
			(~tte_page_size_mask[2])}});
		va_27_22_[n] <= ((~tte_tag_flopped[28:23]) & {6 {
			(~tte_page_size_mask[2])}});
		va_21_16[n] <= (tte_tag_flopped[21:16] & {6 {
			(~tte_page_size_mask[1])}});
		va_21_16_[n] <= ((~tte_tag_flopped[21:16]) & {6 {
			(~tte_page_size_mask[1])}});
		va_15_13[n] <= (tte_tag_flopped[15:13] & {3 {
			(~tte_page_size_mask[0])}});
		va_15_13_[n] <= ((~tte_tag_flopped[15:13]) & {3 {
			(~tte_page_size_mask[0])}});
		context_b[n] <= ((tte_tag_flopped[12:0] & {13 {
			(~tte_tag_flopped[49])}}) | {11'b0, {2
			{tte_tag_flopped[49]}}});
		context_b_[n] <= (((~tte_tag_flopped[12:0]) & {13 {
			(~tte_tag_flopped[49])}}) | {11'b0, {2
			{tte_tag_flopped[49]}}});
		valid[n] <= tte_tag_flopped[22];
	      end
	    end
	  end
	  if (tlb_rd_flopped) begin
	    if (tag_read_mux_control) begin
	      rd_tte_tag[65:53] <= context_a_[rw_index[5:0]];
	      rd_tte_tag[52:50] <= pid_[rw_index[5:0]];
	      rd_tte_tag[49] <= r_bit_[rw_index[5:0]];
	      rd_tte_tag[48:29] <= va_47_28_[rw_index[5:0]];
	      rd_tte_tag[28:23] <= va_27_22_[rw_index[5:0]];
	      rd_tte_tag[21:16] <= va_21_16_[rw_index[5:0]];
	      rd_tte_tag[15:13] <= va_15_13_[rw_index[5:0]];
	      rd_tte_tag[12:0] <= context_b_[rw_index[5:0]];
	    end
	    else
	      begin
		rd_tte_tag[65:53] <= context_a[rw_index[5:0]];
		rd_tte_tag[52:50] <= pid[rw_index[5:0]];
		rd_tte_tag[49] <= r_bit[rw_index[5:0]];
		rd_tte_tag[48:29] <= va_47_28[rw_index[5:0]];
		rd_tte_tag[28:23] <= va_27_22[rw_index[5:0]];
		rd_tte_tag[21:16] <= va_21_16[rw_index[5:0]];
		rd_tte_tag[15:13] <= va_15_13[rw_index[5:0]];
		rd_tte_tag[12:0] <= context_b[rw_index[5:0]];
	      end
	    rd_tte_tag[22] <= valid[rw_index[5:0]];
	  end
	  else
	    begin
	      rd_tte_tag[65:0] <= {66 {1'b0}};
	    end
	end
	always @(negedge l1clk) begin
	  match_for_sat[(64 - 1):0] <= match[(64 - 1):0];
	  tlb_cam_hit <= (((|match[(64 - 1):0]) | tlb_bypass) | (~tlb_cam));
	  context0_hit <= ((|(match[(64 - 1):0] & context0_match[(64 - 1):0])) &
		  (~demap_posedge_l1clk));
	end
endmodule

`endif // `ifdef FPGA


`ifndef FPGA
module n2_tlb_tl_64x59_ram (
  l1clk, 
  tlb_bypass, 
  tlb_cam_flopped, 
  ram_wwl, 
  ram_rwl, 
  tte_data, 
  va, 
  pa, 
  rd_tte_data) ;
wire any_wwl;
wire any_rwl;
wire [37:0] prd_data;
wire [39:13] tte_pa;


`define ENTRIES		64
`define INDEX		5



input		l1clk;

input		tlb_bypass;
input 		tlb_cam_flopped;
input	[`ENTRIES-1:0] ram_wwl;
input	[`ENTRIES-1:0] ram_rwl;

input	[37:0]	tte_data;
input	[39:11]	va;		// Incoming VA



output	[39:11]	pa;
output	[37:0]	rd_tte_data;



`define DATA_PARITY         36
`define DATA_PA_39_28_HI    35
`define DATA_PA_39_28_LO    24
`define DATA_PA_27_22_HI    23
`define DATA_PA_27_22_LO    18
`define DATA_VA_27_22_V     17 
`define DATA_PA_21_16_HI    16
`define DATA_PA_21_16_LO    11
`define DATA_VA_21_16_V     10 
`define DATA_PA_15_13_HI     9
`define DATA_PA_15_13_LO     7
`define DATA_VA_15_13_V      6 
`define DATA_NFO             5 
`define DATA_IE              4 
`define DATA_CP              3 
`define DATA_X               2 
`define DATA_P               1 
`define DATA_W               0 

assign any_wwl =
	| ram_wwl[`ENTRIES-1:0];

assign any_rwl =
	| ram_rwl[`ENTRIES-1:0];



	    
	    
	    
	    
	    
	    
	    
	    
	    

	    
	    
	    
	    
	    
	    
	    
	    
	    








//----------------------------------------------------------------------
// Declarations
//----------------------------------------------------------------------

reg [37:0]  tlb_data_[`ENTRIES-1:0] ;		// this models the data array
						// data stored negative active

integer n;

`ifndef NOINITMEM
///////////////////////////////////////
// Initialize the arrays.            //
///////////////////////////////////////
initial begin
	for (n = 0; n < `ENTRIES; n = n + 1) begin
		tlb_data_[n] = {38 {1'b1}};
	end
	`ifdef ENABLE_DUMPMEM
	if ($test$plusargs("DUMPMEM_DTLB")) begin
		$fsdbDumpMem(tlb_data_, 0, `ENTRIES);
	end
	`endif
end
`endif





///////////////////////////////////////////////////////////////
// Write                                                     // 
///////////////////////////////////////////////////////////////
always @(negedge l1clk) begin

	for (n = 0; n < `ENTRIES; n = n + 1) begin
		if (ram_wwl[n]) begin
			// data stored negative active
			tlb_data_[n] <= ~tte_data[37:0];
			
			
			
			
			n = `ENTRIES;
			
		end // if (ram_wl[n])
	end // for (n = 0; n < `ENTRIES; n = n + 1)
	
end // always @ (ram_wl[`ENTRIES-1:0])



///////////////////////////////////////////////////////////////
// Read                                                      // 
///////////////////////////////////////////////////////////////

// ram_rwl is now second half cycle signal... so no need to latch
// Only force outputs to X if read and write at same time
// Model multiple hit read accurately:
//    Whenever stored_data==0 is read from a bit by any of wordline,
//    dout is 0.
// Invert data since stored_data is negative active
assign prd_data[37:0] =
        ((~tlb_data_[0] & {38 {ram_rwl[0]}}) |
         (~tlb_data_[1] & {38 {ram_rwl[1]}}) |
         (~tlb_data_[2] & {38 {ram_rwl[2]}}) |
         (~tlb_data_[3] & {38 {ram_rwl[3]}}) |
         (~tlb_data_[4] & {38 {ram_rwl[4]}}) |
         (~tlb_data_[5] & {38 {ram_rwl[5]}}) |
         (~tlb_data_[6] & {38 {ram_rwl[6]}}) |
         (~tlb_data_[7] & {38 {ram_rwl[7]}}) |
         (~tlb_data_[8] & {38 {ram_rwl[8]}}) |
         (~tlb_data_[9] & {38 {ram_rwl[9]}}) |
         (~tlb_data_[10] & {38 {ram_rwl[10]}}) |
         (~tlb_data_[11] & {38 {ram_rwl[11]}}) |
         (~tlb_data_[12] & {38 {ram_rwl[12]}}) |
         (~tlb_data_[13] & {38 {ram_rwl[13]}}) |
         (~tlb_data_[14] & {38 {ram_rwl[14]}}) |
         (~tlb_data_[15] & {38 {ram_rwl[15]}}) |
         (~tlb_data_[16] & {38 {ram_rwl[16]}}) |
         (~tlb_data_[17] & {38 {ram_rwl[17]}}) |
         (~tlb_data_[18] & {38 {ram_rwl[18]}}) |
         (~tlb_data_[19] & {38 {ram_rwl[19]}}) |
         (~tlb_data_[20] & {38 {ram_rwl[20]}}) |
         (~tlb_data_[21] & {38 {ram_rwl[21]}}) |
         (~tlb_data_[22] & {38 {ram_rwl[22]}}) |
         (~tlb_data_[23] & {38 {ram_rwl[23]}}) |
         (~tlb_data_[24] & {38 {ram_rwl[24]}}) |
         (~tlb_data_[25] & {38 {ram_rwl[25]}}) |
         (~tlb_data_[26] & {38 {ram_rwl[26]}}) |
         (~tlb_data_[27] & {38 {ram_rwl[27]}}) |
         (~tlb_data_[28] & {38 {ram_rwl[28]}}) |
         (~tlb_data_[29] & {38 {ram_rwl[29]}}) |
         (~tlb_data_[30] & {38 {ram_rwl[30]}}) |
         (~tlb_data_[31] & {38 {ram_rwl[31]}}) |
         (~tlb_data_[32] & {38 {ram_rwl[32]}}) |
         (~tlb_data_[33] & {38 {ram_rwl[33]}}) |
         (~tlb_data_[34] & {38 {ram_rwl[34]}}) |
         (~tlb_data_[35] & {38 {ram_rwl[35]}}) |
         (~tlb_data_[36] & {38 {ram_rwl[36]}}) |
         (~tlb_data_[37] & {38 {ram_rwl[37]}}) |
         (~tlb_data_[38] & {38 {ram_rwl[38]}}) |
         (~tlb_data_[39] & {38 {ram_rwl[39]}}) |
         (~tlb_data_[40] & {38 {ram_rwl[40]}}) |
         (~tlb_data_[41] & {38 {ram_rwl[41]}}) |
         (~tlb_data_[42] & {38 {ram_rwl[42]}}) |
         (~tlb_data_[43] & {38 {ram_rwl[43]}}) |
         (~tlb_data_[44] & {38 {ram_rwl[44]}}) |
         (~tlb_data_[45] & {38 {ram_rwl[45]}}) |
         (~tlb_data_[46] & {38 {ram_rwl[46]}}) |
         (~tlb_data_[47] & {38 {ram_rwl[47]}}) |
         (~tlb_data_[48] & {38 {ram_rwl[48]}}) |
         (~tlb_data_[49] & {38 {ram_rwl[49]}}) |
         (~tlb_data_[50] & {38 {ram_rwl[50]}}) |
         (~tlb_data_[51] & {38 {ram_rwl[51]}}) |
         (~tlb_data_[52] & {38 {ram_rwl[52]}}) |
         (~tlb_data_[53] & {38 {ram_rwl[53]}}) |
         (~tlb_data_[54] & {38 {ram_rwl[54]}}) |
         (~tlb_data_[55] & {38 {ram_rwl[55]}}) |
         (~tlb_data_[56] & {38 {ram_rwl[56]}}) |
         (~tlb_data_[57] & {38 {ram_rwl[57]}}) |
         (~tlb_data_[58] & {38 {ram_rwl[58]}}) |
         (~tlb_data_[59] & {38 {ram_rwl[59]}}) |
         (~tlb_data_[60] & {38 {ram_rwl[60]}}) |
         (~tlb_data_[61] & {38 {ram_rwl[61]}}) |
         (~tlb_data_[62] & {38 {ram_rwl[62]}}) |
         (~tlb_data_[63] & {38 {ram_rwl[63]}}) );
			   
assign rd_tte_data[37:0] =
	({38 {any_rwl & ~any_wwl       }} & prd_data[37:0]) |
	({38 {any_rwl &  any_wwl & 1'bx}}                 ) ;


      


///////////////////////////////////////////////////////////////
// Construct the physical page number                        //
///////////////////////////////////////////////////////////////
assign tte_pa[39:13] = {rd_tte_data[`DATA_PA_39_28_HI:`DATA_PA_39_28_LO],
                        rd_tte_data[`DATA_PA_27_22_HI:`DATA_PA_27_22_LO],
                        rd_tte_data[`DATA_PA_21_16_HI:`DATA_PA_21_16_LO], 
                        rd_tte_data[`DATA_PA_15_13_HI:`DATA_PA_15_13_LO]};

assign pa[12:11] = va[12:11];

assign pa[15:13] = 
       (~rd_tte_data[`DATA_VA_15_13_V] & tlb_cam_flopped & ~tlb_bypass) ? 
	       tte_pa[15:13] : va[15:13] ;
assign pa[21:16] = 
       (~rd_tte_data[`DATA_VA_21_16_V] & tlb_cam_flopped & ~tlb_bypass) ? 
	       tte_pa[21:16] : va[21:16] ;
assign pa[27:22] = 
       (~rd_tte_data[`DATA_VA_27_22_V] & tlb_cam_flopped & ~tlb_bypass) ? 
	       tte_pa[27:22] : va[27:22] ;
assign pa[39:28] = 
       (tlb_cam_flopped & ~tlb_bypass) ? 
	       tte_pa[39:28] : va[39:28];




supply0 vss; // <- port for ground
supply1 vdd; // <- port for power 

endmodule
`endif // `ifndef FPGA

`ifdef FPGA
module n2_tlb_tl_64x59_ram(l1clk, tlb_bypass, tlb_cam_flopped, ram_wwl, ram_rwl,
	tte_data, va, pa, rd_tte_data);

	input			l1clk;
	input			tlb_bypass;
	input			tlb_cam_flopped;
	input	[(64 - 1):0]	ram_wwl;
	input	[(64 - 1):0]	ram_rwl;
	input	[37:0]		tte_data;
	input	[39:11]		va;
	output	[39:11]		pa;
	output	[37:0]		rd_tte_data;

	wire			any_wwl;
	wire			any_rwl;
	wire	[37:0]		prd_data;
	wire	[39:13]		tte_pa;

	reg	[37:0]		tlb_data_[(64 - 1):0];
	integer			n;
	integer			done;
	supply0			vss;
	supply1			vdd;

	assign any_wwl = (|ram_wwl[(64 - 1):0]);
	assign any_rwl = (|ram_rwl[(64 - 1):0]);
	assign prd_data[37:0] = ((((((((((((((((((((((((((((((((((((((((((((((((
		(((((((((((((((((~tlb_data_[0]) & {38 {ram_rwl[0]}}) | ((~
		tlb_data_[1]) & {38 {ram_rwl[1]}})) | ((~tlb_data_[2]) & {38 {
		ram_rwl[2]}})) | ((~tlb_data_[3]) & {38 {ram_rwl[3]}})) | ((~
		tlb_data_[4]) & {38 {ram_rwl[4]}})) | ((~tlb_data_[5]) & {38 {
		ram_rwl[5]}})) | ((~tlb_data_[6]) & {38 {ram_rwl[6]}})) | ((~
		tlb_data_[7]) & {38 {ram_rwl[7]}})) | ((~tlb_data_[8]) & {38 {
		ram_rwl[8]}})) | ((~tlb_data_[9]) & {38 {ram_rwl[9]}})) | ((~
		tlb_data_[10]) & {38 {ram_rwl[10]}})) | ((~tlb_data_[11]) & {38 
		{ram_rwl[11]}})) | ((~tlb_data_[12]) & {38 {ram_rwl[12]}})) | ((
		~tlb_data_[13]) & {38 {ram_rwl[13]}})) | ((~tlb_data_[14]) & {38
		{ram_rwl[14]}})) | ((~tlb_data_[15]) & {38 {ram_rwl[15]}})) | ((
		~tlb_data_[16]) & {38 {ram_rwl[16]}})) | ((~tlb_data_[17]) & {38
		{ram_rwl[17]}})) | ((~tlb_data_[18]) & {38 {ram_rwl[18]}})) | ((
		~tlb_data_[19]) & {38 {ram_rwl[19]}})) | ((~tlb_data_[20]) & {38
		{ram_rwl[20]}})) | ((~tlb_data_[21]) & {38 {ram_rwl[21]}})) | ((
		~tlb_data_[22]) & {38 {ram_rwl[22]}})) | ((~tlb_data_[23]) & {38
		{ram_rwl[23]}})) | ((~tlb_data_[24]) & {38 {ram_rwl[24]}})) | ((
		~tlb_data_[25]) & {38 {ram_rwl[25]}})) | ((~tlb_data_[26]) & {38
		{ram_rwl[26]}})) | ((~tlb_data_[27]) & {38 {ram_rwl[27]}})) | ((
		~tlb_data_[28]) & {38 {ram_rwl[28]}})) | ((~tlb_data_[29]) & {38
		{ram_rwl[29]}})) | ((~tlb_data_[30]) & {38 {ram_rwl[30]}})) | ((
		~tlb_data_[31]) & {38 {ram_rwl[31]}})) | ((~tlb_data_[32]) & {38
		{ram_rwl[32]}})) | ((~tlb_data_[33]) & {38 {ram_rwl[33]}})) | ((
		~tlb_data_[34]) & {38 {ram_rwl[34]}})) | ((~tlb_data_[35]) & {38
		{ram_rwl[35]}})) | ((~tlb_data_[36]) & {38 {ram_rwl[36]}})) | ((
		~tlb_data_[37]) & {38 {ram_rwl[37]}})) | ((~tlb_data_[38]) & {38
		{ram_rwl[38]}})) | ((~tlb_data_[39]) & {38 {ram_rwl[39]}})) | ((
		~tlb_data_[40]) & {38 {ram_rwl[40]}})) | ((~tlb_data_[41]) & {38
		{ram_rwl[41]}})) | ((~tlb_data_[42]) & {38 {ram_rwl[42]}})) | ((
		~tlb_data_[43]) & {38 {ram_rwl[43]}})) | ((~tlb_data_[44]) & {38
		{ram_rwl[44]}})) | ((~tlb_data_[45]) & {38 {ram_rwl[45]}})) | ((
		~tlb_data_[46]) & {38 {ram_rwl[46]}})) | ((~tlb_data_[47]) & {38
		{ram_rwl[47]}})) | ((~tlb_data_[48]) & {38 {ram_rwl[48]}})) | ((
		~tlb_data_[49]) & {38 {ram_rwl[49]}})) | ((~tlb_data_[50]) & {38
		{ram_rwl[50]}})) | ((~tlb_data_[51]) & {38 {ram_rwl[51]}})) | ((
		~tlb_data_[52]) & {38 {ram_rwl[52]}})) | ((~tlb_data_[53]) & {38
		{ram_rwl[53]}})) | ((~tlb_data_[54]) & {38 {ram_rwl[54]}})) | ((
		~tlb_data_[55]) & {38 {ram_rwl[55]}})) | ((~tlb_data_[56]) & {38
		{ram_rwl[56]}})) | ((~tlb_data_[57]) & {38 {ram_rwl[57]}})) | ((
		~tlb_data_[58]) & {38 {ram_rwl[58]}})) | ((~tlb_data_[59]) & {38
		{ram_rwl[59]}})) | ((~tlb_data_[60]) & {38 {ram_rwl[60]}})) | ((
		~tlb_data_[61]) & {38 {ram_rwl[61]}})) | ((~tlb_data_[62]) & {38
		{ram_rwl[62]}})) | ((~tlb_data_[63]) & {38 {ram_rwl[63]}}));
	assign rd_tte_data[37:0] = (({38 {(any_rwl & (~any_wwl))}} & 
		prd_data[37:0]) | {38 {((any_rwl & any_wwl) & 1'bx)}});
	assign tte_pa[39:13] = {rd_tte_data[35:24], rd_tte_data[23:18], 
		rd_tte_data[16:11], rd_tte_data[9:7]};
	assign pa[12:11] = va[12:11];
	assign pa[15:13] = ((((~rd_tte_data[6]) & tlb_cam_flopped) & (~
		tlb_bypass)) ? tte_pa[15:13] : va[15:13]);
	assign pa[21:16] = ((((~rd_tte_data[10]) & tlb_cam_flopped) & (~
		tlb_bypass)) ? tte_pa[21:16] : va[21:16]);
	assign pa[27:22] = ((((~rd_tte_data[17]) & tlb_cam_flopped) & (~
		tlb_bypass)) ? tte_pa[27:22] : va[27:22]);
	assign pa[39:28] = ((tlb_cam_flopped & (~tlb_bypass)) ? tte_pa[39:28] : 
		va[39:28]);

	initial begin
	  for (n = 0; (n < 64); n = (n + 1)) begin
	    tlb_data_[n] = {38 {1'b1}};
	  end
	end
	always @(negedge l1clk) begin
	  done = 0;
	  for (n = 0; (n < 64); n = (n + 1)) begin
	    if (ram_wwl[n] && (!done)) begin
	      tlb_data_[n] <= (~tte_data[37:0]);
	      done = 1;
	    end
	  end
	end
endmodule

`endif // `ifdef FPGA


module n2_tlb_tl_64x59_multihit (
  ram_rwl, 
  tlb_bypass, 
  tlb_cam_mhit) ;
wire [7:0] sum;
wire multiple_match;
wire unused;


`define ENTRIES		64
//`define INDEX		5


input	[`ENTRIES-1:0] ram_rwl;
input		tlb_bypass;



output		tlb_cam_mhit;





assign sum[7:0] = 
	{{7 {1'b0}}, ram_rwl[0]} +
	{{7 {1'b0}}, ram_rwl[1]} +
	{{7 {1'b0}}, ram_rwl[2]} +
	{{7 {1'b0}}, ram_rwl[3]} +
	{{7 {1'b0}}, ram_rwl[4]} +
	{{7 {1'b0}}, ram_rwl[5]} +
	{{7 {1'b0}}, ram_rwl[6]} +
	{{7 {1'b0}}, ram_rwl[7]} +
	{{7 {1'b0}}, ram_rwl[8]} +
	{{7 {1'b0}}, ram_rwl[9]} +
	{{7 {1'b0}}, ram_rwl[10]} +
	{{7 {1'b0}}, ram_rwl[11]} +
	{{7 {1'b0}}, ram_rwl[12]} +
	{{7 {1'b0}}, ram_rwl[13]} +
	{{7 {1'b0}}, ram_rwl[14]} +
	{{7 {1'b0}}, ram_rwl[15]} +
	{{7 {1'b0}}, ram_rwl[16]} +
	{{7 {1'b0}}, ram_rwl[17]} +
	{{7 {1'b0}}, ram_rwl[18]} +
	{{7 {1'b0}}, ram_rwl[19]} +
	{{7 {1'b0}}, ram_rwl[20]} +
	{{7 {1'b0}}, ram_rwl[21]} +
	{{7 {1'b0}}, ram_rwl[22]} +
	{{7 {1'b0}}, ram_rwl[23]} +
	{{7 {1'b0}}, ram_rwl[24]} +
	{{7 {1'b0}}, ram_rwl[25]} +
	{{7 {1'b0}}, ram_rwl[26]} +
	{{7 {1'b0}}, ram_rwl[27]} +
	{{7 {1'b0}}, ram_rwl[28]} +
	{{7 {1'b0}}, ram_rwl[29]} +
	{{7 {1'b0}}, ram_rwl[30]} +
	{{7 {1'b0}}, ram_rwl[31]} +
	{{7 {1'b0}}, ram_rwl[32]} +
	{{7 {1'b0}}, ram_rwl[33]} +
	{{7 {1'b0}}, ram_rwl[34]} +
	{{7 {1'b0}}, ram_rwl[35]} +
	{{7 {1'b0}}, ram_rwl[36]} +
	{{7 {1'b0}}, ram_rwl[37]} +
	{{7 {1'b0}}, ram_rwl[38]} +
	{{7 {1'b0}}, ram_rwl[39]} +
	{{7 {1'b0}}, ram_rwl[40]} +
	{{7 {1'b0}}, ram_rwl[41]} +
	{{7 {1'b0}}, ram_rwl[42]} +
	{{7 {1'b0}}, ram_rwl[43]} +
	{{7 {1'b0}}, ram_rwl[44]} +
	{{7 {1'b0}}, ram_rwl[45]} +
	{{7 {1'b0}}, ram_rwl[46]} +
	{{7 {1'b0}}, ram_rwl[47]} +
	{{7 {1'b0}}, ram_rwl[48]} +
	{{7 {1'b0}}, ram_rwl[49]} +
	{{7 {1'b0}}, ram_rwl[50]} +
	{{7 {1'b0}}, ram_rwl[51]} +
	{{7 {1'b0}}, ram_rwl[52]} +
	{{7 {1'b0}}, ram_rwl[53]} +
	{{7 {1'b0}}, ram_rwl[54]} +
	{{7 {1'b0}}, ram_rwl[55]} +
	{{7 {1'b0}}, ram_rwl[56]} +
	{{7 {1'b0}}, ram_rwl[57]} +
	{{7 {1'b0}}, ram_rwl[58]} +
	{{7 {1'b0}}, ram_rwl[59]} +
	{{7 {1'b0}}, ram_rwl[60]} +
	{{7 {1'b0}}, ram_rwl[61]} +
	{{7 {1'b0}}, ram_rwl[62]} +
	{{7 {1'b0}}, ram_rwl[63]} ;
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//


assign multiple_match = 
	(| sum[7:1]) & ~tlb_bypass;

assign unused = sum[0];

assign tlb_cam_mhit = 
       multiple_match;


supply0 vss; // <- port for ground
supply1 vdd; // <- port for power 
endmodule


`ifndef FPGA
module n2_tlb_tl_64x59_ubit (
  l1clk, 
  disable_clear_ubit, 
  tlb_bypass, 
  ram_rwl, 
  ram_wwl, 
  tte_ubit, 
  tlb_wr_flopped, 
  tlb_rd_flopped, 
  tlb_cam_flopped, 
  used, 
  rd_tte_u_bit) ;
wire all_entries_used;


`define ENTRIES		64



input		l1clk;
input		disable_clear_ubit;

input		tlb_bypass;
input	[`ENTRIES-1:0] ram_rwl;
input	[`ENTRIES-1:0] ram_wwl;
input		tte_ubit;

input		tlb_wr_flopped;
input		tlb_rd_flopped;
input		tlb_cam_flopped;



output	[`ENTRIES-1:0] used;
output 		   rd_tte_u_bit;



//----------------------------------------------------------------------
// Declarations
//----------------------------------------------------------------------
reg [`ENTRIES-1:0] used;

integer 	   n;

reg 		   rd_tte_u_bit_in;


`ifndef NOINITMEM
///////////////////////////////////////
// Initialize the arrays.            //
///////////////////////////////////////
initial begin
	used[`ENTRIES-1:0]  = {`ENTRIES {1'b0}} ;
end
`endif



assign all_entries_used  = 
       (& used[`ENTRIES-1:0]) & ~disable_clear_ubit;


always @(negedge l1clk) begin
	// Maintain the used bits
	if (all_entries_used) begin
		used[`ENTRIES-1:0] <= {`ENTRIES {1'b0}};
	end

	if (~all_entries_used & ((~tlb_bypass & tlb_cam_flopped) | tlb_wr_flopped)) begin
		for (n = 0; n < `ENTRIES; n = n + 1) begin
			if (ram_rwl[n]) begin
				used[n] <= 1'b1;
			end
			if (ram_wwl[n]) begin
				used[n] <= tte_ubit;
			end
		end
	end // if (~all_entries_used & ((~tlb_bypass & tlb_cam_flopped) | tlb_wr_flopped))

	
end // always @ (negedge l1clk)




///////////////////////////////////////////////////////////////
// Read U bit
///////////////////////////////////////////////////////////////


always @(ram_rwl[`ENTRIES-1:0] or used[`ENTRIES-1:0] or tlb_rd_flopped) begin

	rd_tte_u_bit_in = {1'b0};

	if (tlb_rd_flopped & (| ram_rwl[`ENTRIES-1:0])) begin	 
		for (n = 0; n < `ENTRIES; n = n + 1) begin
			if (ram_rwl[n]) begin
				rd_tte_u_bit_in = used[n];
				
				
				n = `ENTRIES;
				
			end // if (ram_wl[n])
		end // for (n = 0; n < `ENTRIES; n = n + 1)
	end // if (tlb_rd_flopped & (| ram_rwl[`ENTRIES-1:0]))
	else if (~tlb_rd_flopped & (| ram_rwl[`ENTRIES-1:0])) begin
		rd_tte_u_bit_in = {1'bx};
	end
	
end

assign rd_tte_u_bit = 
       rd_tte_u_bit_in;


supply0 vss; // <- port for ground
supply1 vdd; // <- port for power 
endmodule
`endif // `ifndef FPGA

`ifdef FPGA
module n2_tlb_tl_64x59_ubit(l1clk, disable_clear_ubit, tlb_bypass, ram_rwl, 
	ram_wwl, tte_ubit, tlb_wr_flopped, tlb_rd_flopped, tlb_cam_flopped, 
	used, rd_tte_u_bit);

	input			l1clk;
	input			disable_clear_ubit;
	input			tlb_bypass;
	input	[(64 - 1):0]	ram_rwl;
	input	[(64 - 1):0]	ram_wwl;
	input			tte_ubit;
	input			tlb_wr_flopped;
	input			tlb_rd_flopped;
	input			tlb_cam_flopped;
	output	[(64 - 1):0]	used;
	output			rd_tte_u_bit;

	wire			all_entries_used;
	reg	[(64 - 1):0]	used;
	integer			n;
	integer			done;
	reg			rd_tte_u_bit_in;
	supply0			vss;
	supply1			vdd;

	assign all_entries_used = ((&used[(64 - 1):0]) & (~disable_clear_ubit));
	assign rd_tte_u_bit = rd_tte_u_bit_in;

	initial begin
	  used[(64 - 1):0] = {64 {1'b0}};
	end
	always @(negedge l1clk) begin
	  if (all_entries_used) begin
	    used[(64 - 1):0] <= {64 {1'b0}};
	  end
	  if ((~all_entries_used) & (((~tlb_bypass) & tlb_cam_flopped) | 
		  tlb_wr_flopped)) begin
	    for (n = 0; (n < 64); n = (n + 1)) begin
	      if (ram_rwl[n]) begin
		used[n] <= 1'b1;
	      end
	      if (ram_wwl[n]) begin
		used[n] <= tte_ubit;
	      end
	    end
	  end
	end
	always @(ram_rwl[(64 - 1):0] or used[(64 - 1):0] or tlb_rd_flopped) 
		begin
	  rd_tte_u_bit_in = {1'b0};
	  if (tlb_rd_flopped & (|ram_rwl[(64 - 1):0])) begin
	    done = 0;
	    for (n = 0; (n < 64); n = (n + 1)) begin
	      if (ram_rwl[n] && (!done)) begin
		rd_tte_u_bit_in = used[n];
		done = 1;
	      end
	    end
	  end
	end
endmodule

`endif // `ifdef FPGA



module n2_tlb_tl_64x59_repl_index (
  l1clk, 
  used, 
  valid, 
  tlb_replacement_index) ;
wire [63:0] nu_or_nv;
wire [63:0] used_and_valid;
wire [1:0] enc4_00;
wire sel4_00_b;
wire [1:0] enc4_01;
wire sel4_01_b;
wire [1:0] enc4_02;
wire sel4_02_b;
wire [1:0] enc4_03;
wire sel4_03_b;
wire [1:0] enc4_04;
wire sel4_04_b;
wire [1:0] enc4_05;
wire sel4_05_b;
wire [1:0] enc4_06;
wire sel4_06_b;
wire [1:0] enc4_07;
wire sel4_07_b;
wire [1:0] enc4_08;
wire sel4_08_b;
wire [1:0] enc4_09;
wire sel4_09_b;
wire [1:0] enc4_10;
wire sel4_10_b;
wire [1:0] enc4_11;
wire sel4_11_b;
wire [1:0] enc4_12;
wire sel4_12_b;
wire [1:0] enc4_13;
wire sel4_13_b;
wire [1:0] enc4_14;
wire sel4_14_b;
wire [1:0] enc4_15;
wire sel4_15_b;
wire [2:0] enc8_00;
wire sel8_00_b;
wire [2:0] enc8_01;
wire sel8_01_b;
wire [2:0] enc8_02;
wire sel8_02_b;
wire [2:0] enc8_03;
wire sel8_03_b;
wire [2:0] enc8_04;
wire sel8_04_b;
wire [2:0] enc8_05;
wire sel8_05_b;
wire [2:0] enc8_06;
wire sel8_06_b;
wire [2:0] enc8_07;
wire sel8_07_b;
wire [3:0] enc16_0;
wire sel16_0_b;
wire [3:0] enc16_1;
wire sel16_1_b;
wire [3:0] enc16_2;
wire sel16_2_b;
wire [3:0] enc16_3;
wire sel16_3_b;
wire unused;
wire [3:0] enc16_l_0;
wire [3:0] enc16_l_1;
wire [3:0] enc16_l_2;
wire [3:0] enc16_l_3;
wire sel16_l_0_b;
wire sel16_l_1_b;
wire sel16_l_2_b;
wire sel16_l_3_b_unused;
wire [4:0] enc32_0;
wire sel32_0_b;
wire [4:0] enc32_1;
wire [5:0] enc64_0;


`define ENTRIES		64
`define INDEX		5


input		l1clk;

input	[`ENTRIES-1:0] used;
input	[`ENTRIES-1:0] valid;


output	[`INDEX:0] tlb_replacement_index;



assign nu_or_nv[`ENTRIES-1:0] =
       ~valid[`ENTRIES-1:0] | ~used[`ENTRIES-1:0];

assign used_and_valid[`ENTRIES-1:0] =
       ~nu_or_nv[`ENTRIES-1:0];


// 4 bit priority encoders
assign enc4_00[1] = used_and_valid[0] &   used_and_valid[1];
assign enc4_00[0] = used_and_valid[0] & (~used_and_valid[1] | used_and_valid[2]);
assign sel4_00_b  = &used_and_valid[3:0];

assign enc4_01[1] = used_and_valid[4] &   used_and_valid[5];
assign enc4_01[0] = used_and_valid[4] & (~used_and_valid[5] | used_and_valid[6]);
assign sel4_01_b  = &used_and_valid[7:4];

assign enc4_02[1] = used_and_valid[8] &   used_and_valid[9];
assign enc4_02[0] = used_and_valid[8] & (~used_and_valid[9] | used_and_valid[10]);
assign sel4_02_b  = &used_and_valid[11:8];

assign enc4_03[1] = used_and_valid[12] &   used_and_valid[13];
assign enc4_03[0] = used_and_valid[12] & (~used_and_valid[13] | used_and_valid[14]);
assign sel4_03_b  = &used_and_valid[15:12];

assign enc4_04[1] = used_and_valid[16] &   used_and_valid[17];
assign enc4_04[0] = used_and_valid[16] & (~used_and_valid[17] | used_and_valid[18]);
assign sel4_04_b  = &used_and_valid[19:16];

assign enc4_05[1] = used_and_valid[20] &   used_and_valid[21];
assign enc4_05[0] = used_and_valid[20] & (~used_and_valid[21] | used_and_valid[22]);
assign sel4_05_b  = &used_and_valid[23:20];

assign enc4_06[1] = used_and_valid[24] &   used_and_valid[25];
assign enc4_06[0] = used_and_valid[24] & (~used_and_valid[25] | used_and_valid[26]);
assign sel4_06_b  = &used_and_valid[27:24];

assign enc4_07[1] = used_and_valid[28] &   used_and_valid[29];
assign enc4_07[0] = used_and_valid[28] & (~used_and_valid[29] | used_and_valid[30]);
assign sel4_07_b  = &used_and_valid[31:28];

assign enc4_08[1] = used_and_valid[32] &   used_and_valid[33];
assign enc4_08[0] = used_and_valid[32] & (~used_and_valid[33] | used_and_valid[34]);
assign sel4_08_b  = &used_and_valid[35:32];

assign enc4_09[1] = used_and_valid[36] &   used_and_valid[37];
assign enc4_09[0] = used_and_valid[36] & (~used_and_valid[37] | used_and_valid[38]);
assign sel4_09_b  = &used_and_valid[39:36];

assign enc4_10[1] = used_and_valid[40] &   used_and_valid[41];
assign enc4_10[0] = used_and_valid[40] & (~used_and_valid[41] | used_and_valid[42]);
assign sel4_10_b  = &used_and_valid[43:40];

assign enc4_11[1] = used_and_valid[44] &   used_and_valid[45];
assign enc4_11[0] = used_and_valid[44] & (~used_and_valid[45] | used_and_valid[46]);
assign sel4_11_b  = &used_and_valid[47:44];

assign enc4_12[1] = used_and_valid[48] &   used_and_valid[49];
assign enc4_12[0] = used_and_valid[48] & (~used_and_valid[49] | used_and_valid[50]);
assign sel4_12_b  = &used_and_valid[51:48];

assign enc4_13[1] = used_and_valid[52] &   used_and_valid[53];
assign enc4_13[0] = used_and_valid[52] & (~used_and_valid[53] | used_and_valid[54]);
assign sel4_13_b  = &used_and_valid[55:52];

assign enc4_14[1] = used_and_valid[56] &   used_and_valid[57];
assign enc4_14[0] = used_and_valid[56] & (~used_and_valid[57] | used_and_valid[58]);
assign sel4_14_b  = &used_and_valid[59:56];

assign enc4_15[1] = used_and_valid[60] &   used_and_valid[61];
assign enc4_15[0] = used_and_valid[60] & (~used_and_valid[61] | used_and_valid[62]);
assign sel4_15_b  = &used_and_valid[63:60];


// Now generate 8 bit group encodings
assign enc8_00[2]   = sel4_00_b;
assign enc8_00[1:0] = (enc4_00[1:0] & {2 {~sel4_00_b}}) | (enc4_01[1:0] & {2 {sel4_00_b}});
assign sel8_00_b    = sel4_00_b & sel4_01_b;

assign enc8_01[2]   = sel4_02_b;
assign enc8_01[1:0] = (enc4_02[1:0] & {2 {~sel4_02_b}}) | (enc4_03[1:0] & {2 {sel4_02_b}});
assign sel8_01_b    = sel4_02_b & sel4_03_b;

assign enc8_02[2]   = sel4_04_b;
assign enc8_02[1:0] = (enc4_04[1:0] & {2 {~sel4_04_b}}) | (enc4_05[1:0] & {2 {sel4_04_b}});
assign sel8_02_b    = sel4_04_b & sel4_05_b;

assign enc8_03[2]   = sel4_06_b;
assign enc8_03[1:0] = (enc4_06[1:0] & {2 {~sel4_06_b}}) | (enc4_07[1:0] & {2 {sel4_06_b}});
assign sel8_03_b    = sel4_06_b & sel4_07_b;

assign enc8_04[2]   = sel4_08_b;
assign enc8_04[1:0] = (enc4_08[1:0] & {2 {~sel4_08_b}}) | (enc4_09[1:0] & {2 {sel4_08_b}});
assign sel8_04_b    = sel4_08_b & sel4_09_b;

assign enc8_05[2]   = sel4_10_b;
assign enc8_05[1:0] = (enc4_10[1:0] & {2 {~sel4_10_b}}) | (enc4_11[1:0] & {2 {sel4_10_b}});
assign sel8_05_b    = sel4_10_b & sel4_11_b;

assign enc8_06[2]   = sel4_12_b;
assign enc8_06[1:0] = (enc4_12[1:0] & {2 {~sel4_12_b}}) | (enc4_13[1:0] & {2 {sel4_12_b}});
assign sel8_06_b    = sel4_12_b & sel4_13_b;

assign enc8_07[2]   = sel4_14_b;
assign enc8_07[1:0] = (enc4_14[1:0] & {2 {~sel4_14_b}}) | (enc4_15[1:0] & {2 {sel4_14_b}});
assign sel8_07_b    = sel4_14_b & sel4_15_b;


// Now generate 16 bit group encodings
assign enc16_0[3]   = sel8_00_b;
assign enc16_0[2:0] = (enc8_00[2:0] & {3 {~sel8_00_b}}) | (enc8_01[2:0] & {3 {sel8_00_b}});
assign sel16_0_b    = sel8_00_b & sel8_01_b;

assign enc16_1[3]   = sel8_02_b;
assign enc16_1[2:0] = (enc8_02[2:0] & {3 {~sel8_02_b}}) | (enc8_03[2:0] & {3 {sel8_02_b}});
assign sel16_1_b    = sel8_02_b & sel8_03_b;

assign enc16_2[3]   = sel8_04_b;
assign enc16_2[2:0] = (enc8_04[2:0] & {3 {~sel8_04_b}}) | (enc8_05[2:0] & {3 {sel8_04_b}});
assign sel16_2_b    = sel8_04_b & sel8_05_b;

assign enc16_3[3]   = sel8_06_b;
assign enc16_3[2:0] = (enc8_06[2:0] & {3 {~sel8_06_b}}) | (enc8_07[2:0] & {3 {sel8_06_b}});
assign sel16_3_b    = sel8_06_b & sel8_07_b;


// Now flop (nonscan)

n2_tlb_tl_64x59_cust_msff_ctl_macro__width_20 enc16_lat  (
 .scan_in	(1'b0),
 .scan_out	(unused),
 .l1clk		(l1clk),
 .siclk		(1'b0),				 
 .soclk		(1'b0),				 
 .din		({enc16_0[3:0],
		  enc16_1[3:0],
		  enc16_2[3:0],
		  enc16_3[3:0],
		  sel16_0_b,
		  sel16_1_b,
		  sel16_2_b,
		  sel16_3_b}),
 .dout		({enc16_l_0[3:0],
		  enc16_l_1[3:0],
		  enc16_l_2[3:0],
		  enc16_l_3[3:0],
		  sel16_l_0_b,
		  sel16_l_1_b,
		  sel16_l_2_b,
		  sel16_l_3_b_unused})
);



// Now generate 32 bit group encodings
assign enc32_0[4]   = sel16_l_0_b;
assign enc32_0[3:0] = (enc16_l_0[3:0] & {4 {~sel16_l_0_b}}) | (enc16_l_1[3:0] & {4 {sel16_l_0_b}});
assign sel32_0_b    = sel16_l_0_b & sel16_l_1_b;

assign enc32_1[4]   = sel16_l_2_b;
assign enc32_1[3:0] = (enc16_l_2[3:0] & {4 {~sel16_l_2_b}}) | (enc16_l_3[3:0] & {4 {sel16_l_2_b}});



// Now generate 64 bit group encodings
assign enc64_0[5]   = sel32_0_b;
assign enc64_0[4:0] = (enc32_0[4:0] & {5 {~sel32_0_b}}) | (enc32_1[4:0] & {5 {sel32_0_b}});


assign tlb_replacement_index[5:0] = enc64_0[5:0];


supply0 vss; // <- port for ground
supply1 vdd; // <- port for power 
endmodule






// any PARAMS parms go into naming of macro

module n2_tlb_tl_64x59_cust_msff_ctl_macro__width_20 (
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

module n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_27 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [26:0] fdin;

  input [26:0] din;
  input l1clk;
  input [26:0] scan_in;


  input siclk;
  input soclk;

  output [26:0] dout;
  output [26:0] scan_out;
assign fdin[26:0] = din[26:0];






dff #(27)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[26:0]),
.si(scan_in[26:0]),
.so(scan_out[26:0]),
.q(dout[26:0])
);












endmodule









//
//   invert macro
//
//





module n2_tlb_tl_64x59_cust_inv_macro__stack_66c__width_66 (
  din, 
  dout);
  input [65:0] din;
  output [65:0] dout;






inv #(66)  d0_0 (
.in(din[65:0]),
.out(dout[65:0])
);









endmodule









// any PARAMS parms go into naming of macro

module n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_66 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [65:0] fdin;

  input [65:0] din;
  input l1clk;
  input [65:0] scan_in;


  input siclk;
  input soclk;

  output [65:0] dout;
  output [65:0] scan_out;
assign fdin[65:0] = din[65:0];






dff #(66)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[65:0]),
.si(scan_in[65:0]),
.so(scan_out[65:0]),
.q(dout[65:0])
);












endmodule









//
//   comparator macro (output is 1 if both inputs are equal; 0 otherwise)
//
//





module n2_tlb_tl_64x59_cust_cmp_macro__width_32 (
  din0, 
  din1, 
  dout);
  input [31:0] din0;
  input [31:0] din1;
  output dout;






cmp #(32)  m0_0 (
.in0(din0[31:0]),
.in1(din1[31:0]),
.out(dout)
);










endmodule





//
//   invert macro
//
//





module n2_tlb_tl_64x59_cust_inv_macro__width_8 (
  din, 
  dout);
  input [7:0] din;
  output [7:0] dout;






inv #(8)  d0_0 (
.in(din[7:0]),
.out(dout[7:0])
);









endmodule









// any PARAMS parms go into naming of macro

module n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_8 (
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









// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_tlb_tl_64x59_cust_mux_macro__mux_aonpe__ports_8__width_1 (
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

  input [0:0] din0;
  input sel0;
  input [0:0] din1;
  input sel1;
  input [0:0] din2;
  input sel2;
  input [0:0] din3;
  input sel3;
  input [0:0] din4;
  input sel4;
  input [0:0] din5;
  input sel5;
  input [0:0] din6;
  input sel6;
  input [0:0] din7;
  input sel7;
  output [0:0] dout;





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
mux8s #(1)  d0_0 (
  .sel0(buffout0),
  .sel1(buffout1),
  .sel2(buffout2),
  .sel3(buffout3),
  .sel4(buffout4),
  .sel5(buffout5),
  .sel6(buffout6),
  .sel7(buffout7),
  .in0(din0[0:0]),
  .in1(din1[0:0]),
  .in2(din2[0:0]),
  .in3(din3[0:0]),
  .in4(din4[0:0]),
  .in5(din5[0:0]),
  .in6(din6[0:0]),
  .in7(din7[0:0]),
.dout(dout[0:0])
);









  



endmodule


//
//   parity macro (even parity)
//
//





module n2_tlb_tl_64x59_cust_prty_macro__width_32 (
  din, 
  dout);
  input [31:0] din;
  output dout;







prty #(32)  m0_0 (
.in(din[31:0]),
.out(dout)
);










endmodule





//
//   parity macro (even parity)
//
//





module n2_tlb_tl_64x59_cust_prty_macro__width_8 (
  din, 
  dout);
  input [7:0] din;
  output dout;







prty #(8)  m0_0 (
.in(din[7:0]),
.out(dout)
);










endmodule









// any PARAMS parms go into naming of macro

module n2_tlb_tl_64x59_cust_msff_ctl_macro__fs_1__width_4 (
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








