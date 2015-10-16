// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: n2_dca_sp_9kb_cust.v
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
`ifndef FPGA
module n2_dca_sp_9kb_cust (
  dcache_rd_addr_e, 
  dcache_alt_addr_e, 
  dcache_alt_addr_sel_e, 
  dcache_rvld_e, 
  dcache_wvld_e, 
  dcache_clk_en_e, 
  dcache_wclk_en_e, 
  dcache_rclk_en_m, 
  dcache_wdata_e, 
  dcache_wr_way_e, 
  dcache_byte_wr_en_e, 
  dcache_alt_rsel_way_m, 
  dcache_rsel_way_b, 
  dcache_alt_way_sel_m, 
  lsu_l2fill_or_byp_data_m, 
  dcache_bypass_e_, 
  dcache_rdata_b, 
  dcache_rparity_b, 
  dcache_perr_w0_b, 
  dcache_perr_w1_b, 
  dcache_perr_w2_b, 
  dcache_perr_w3_b, 
  dcache_rdata_msb_w0_b, 
  dcache_rdata_msb_w1_b, 
  dcache_rdata_msb_w2_b, 
  dcache_rdata_msb_w3_b, 
  l2clk, 
  scan_in, 
  tcu_pce_ov, 
  tcu_aclk, 
  tcu_bclk, 
  tcu_array_wr_inhibit, 
  tcu_scan_en, 
  tcu_se_scancollar_in, 
  tcu_se_scancollar_out, 
  scan_out, 
  fuse_dca_repair_value, 
  fuse_dca_repair_en, 
  fuse_dca_rid, 
  fuse_dca_wen, 
  fuse_red_reset, 
  dca_fuse_repair_value, 
  dca_fuse_repair_en, 
  vnw_ary);
wire l1clk_in;
wire l1clk_in_pm;
wire l1clk_out_pm;
wire l1clk_out;
wire l1clk_free;
wire l1clk_free_wpm;
wire l1clk_red;
wire [10:3] dcache_rwaddr_e;
wire [7:0] lat_addr_scanin;
wire [7:0] lat_addr_scanout;
wire [10:3] dcache_rwaddr_eb;
wire [10:3] dcache_rwaddr_l_unused;
wire [3:0] wr_way_dec_e;
wire [6:0] lat_ctl_eb_scanin;
wire [6:0] lat_ctl_eb_scanout;
wire dcache_rvld_top_eb;
wire dcache_rvld_bot_eb;
wire dcache_wvld_eb;
wire [3:0] wr_way_dec_eb;
wire [6:0] lat_ctl_unused;
wire [2:0] dff_ctl_m_0_scanin;
wire [2:0] dff_ctl_m_0_scanout;
wire dcache_rvld_m;
wire dcache_wvld_m;
wire dcache_bypass_m_;
wire [15:0] dff_ctl_m_1_scanin;
wire [15:0] dff_ctl_m_1_scanout;
wire [15:0] byte_wr_en_eb;
wire [15:0] dff_ctl_l_unused;
wire [4:0] dff_ctl_b_scanin;
wire [4:0] dff_ctl_b_scanout;
wire dcache_alt_way_sel_b;
wire [3:0] dcache_alt_rsel_way_b;
wire [143:0] dff_wdata_m_scanin;
wire [143:0] dff_wdata_m_scanout;
wire [15:0] dcache_wparity_m;
wire [127:0] dcache_wdata_m;
wire [5:0] fuse_dca_repair_value_ff;
wire [1:0] fuse_dca_repair_en_ff;
wire [1:0] fuse_dca_rid_ff;
wire fuse_dca_wen_ff;
wire fuse_red_reset_ff;
wire [5:0] dca_fuse_repair_value_pre;
wire [1:0] dca_fuse_repair_en_pre;
wire [63:0] dcache_rdata_w0_m;
wire [63:0] rdata_w0_m;
wire [63:0] rdata_w1_m;
wire [63:0] dcache_rdata_w1_m;
wire [63:0] rdata_w2_m;
wire [63:0] dcache_rdata_w2_m;
wire [63:0] rdata_w3_m;
wire [63:0] dcache_rdata_w3_m;
wire [7:0] dff_msb_w0_scanin;
wire [7:0] dff_msb_w0_scanout;
wire [7:0] dff_msb_w1_scanin;
wire [7:0] dff_msb_w1_scanout;
wire [7:0] dff_msb_w2_scanin;
wire [7:0] dff_msb_w2_scanout;
wire [7:0] dff_msb_w3_scanin;
wire [7:0] dff_msb_w3_scanout;
wire [63:0] dff_rdata_w0_m_scanin;
wire [63:0] dff_rdata_w0_m_scanout;
wire [63:0] rdata_w0_b;
wire [7:0] dff_rparity_w0_m_scanin;
wire [7:0] dff_rparity_w0_m_scanout;
wire [7:0] rparity_w0_m;
wire [7:0] rparity_w0_b;
wire [63:0] dff_rdata_w1_m_scanin;
wire [63:0] dff_rdata_w1_m_scanout;
wire [63:0] rdata_w1_b;
wire [7:0] dff_rparity_w1_m_scanin;
wire [7:0] dff_rparity_w1_m_scanout;
wire [7:0] rparity_w1_m;
wire [7:0] rparity_w1_b;
wire [63:0] dff_rdata_w2_m_scanin;
wire [63:0] dff_rdata_w2_m_scanout;
wire [63:0] rdata_w2_b;
wire [7:0] dff_rparity_w2_m_scanin;
wire [7:0] dff_rparity_w2_m_scanout;
wire [7:0] rparity_w2_m;
wire [7:0] rparity_w2_b;
wire [63:0] dff_rdata_w3_m_scanin;
wire [63:0] dff_rdata_w3_m_scanout;
wire [63:0] rdata_w3_b;
wire [7:0] dff_rparity_w3_m_scanin;
wire [7:0] dff_rparity_w3_m_scanout;
wire [7:0] rparity_w3_m;
wire [7:0] rparity_w3_b;
wire [3:0] dcache_rd_sel_way_b;
wire w0_p0_0;
wire w0_p0_1;
wire w0_p0_2;
wire [7:0] w0_parity_m;
wire w0_p1_0;
wire w0_p1_1;
wire w0_p1_2;
wire w0_p2_0;
wire w0_p2_1;
wire w0_p2_2;
wire w0_p3_0;
wire w0_p3_1;
wire w0_p3_2;
wire w0_p4_0;
wire w0_p4_1;
wire w0_p4_2;
wire w0_p5_0;
wire w0_p5_1;
wire w0_p5_2;
wire w0_p6_0;
wire w0_p6_1;
wire w0_p6_2;
wire w0_p7_0;
wire w0_p7_1;
wire w0_p7_2;
wire w1_p0_0;
wire w1_p0_1;
wire w1_p0_2;
wire [7:0] w1_parity_m;
wire w1_p1_0;
wire w1_p1_1;
wire w1_p1_2;
wire w1_p2_0;
wire w1_p2_1;
wire w1_p2_2;
wire w1_p3_0;
wire w1_p3_1;
wire w1_p3_2;
wire w1_p4_0;
wire w1_p4_1;
wire w1_p4_2;
wire w1_p5_0;
wire w1_p5_1;
wire w1_p5_2;
wire w1_p6_0;
wire w1_p6_1;
wire w1_p6_2;
wire w1_p7_0;
wire w1_p7_1;
wire w1_p7_2;
wire w2_p0_0;
wire w2_p0_1;
wire w2_p0_2;
wire [7:0] w2_parity_m;
wire w2_p1_0;
wire w2_p1_1;
wire w2_p1_2;
wire w2_p2_0;
wire w2_p2_1;
wire w2_p2_2;
wire w2_p3_0;
wire w2_p3_1;
wire w2_p3_2;
wire w2_p4_0;
wire w2_p4_1;
wire w2_p4_2;
wire w2_p5_0;
wire w2_p5_1;
wire w2_p5_2;
wire w2_p6_0;
wire w2_p6_1;
wire w2_p6_2;
wire w2_p7_0;
wire w2_p7_1;
wire w2_p7_2;
wire w3_p0_0;
wire w3_p0_1;
wire w3_p0_2;
wire [7:0] w3_parity_m;
wire w3_p1_0;
wire w3_p1_1;
wire w3_p1_2;
wire w3_p2_0;
wire w3_p2_1;
wire w3_p2_2;
wire w3_p3_0;
wire w3_p3_1;
wire w3_p3_2;
wire w3_p4_0;
wire w3_p4_1;
wire w3_p4_2;
wire w3_p5_0;
wire w3_p5_1;
wire w3_p5_2;
wire w3_p6_0;
wire w3_p6_1;
wire w3_p6_2;
wire w3_p7_0;
wire w3_p7_1;
wire w3_p7_2;
wire [7:0] dff_byte_perr_w0_scanin;
wire [7:0] dff_byte_perr_w0_scanout;
wire [7:0] w0_parity_b;
wire [7:0] dff_byte_perr_w1_scanin;
wire [7:0] dff_byte_perr_w1_scanout;
wire [7:0] w1_parity_b;
wire [7:0] dff_byte_perr_w2_scanin;
wire [7:0] dff_byte_perr_w2_scanout;
wire [7:0] w2_parity_b;
wire [7:0] dff_byte_perr_w3_scanin;
wire [7:0] dff_byte_perr_w3_scanout;
wire [7:0] w3_parity_b;
wire w0_parity_err_b;
wire w1_parity_err_b;
wire w2_parity_err_b;
wire w3_parity_err_b;
wire [11:0] dff_red_in_scanin;
wire [11:0] dff_red_in_scanout;
wire [7:0] dff_red_out_scanin;
wire [7:0] dff_red_out_scanout;
 

input [10:3]    dcache_rd_addr_e;     // read cache index [10:4] + bit [3] offset
input [10:3]    dcache_alt_addr_e;    // write/bist/diagnostic read cache index + offset 
input           dcache_alt_addr_sel_e;

input           dcache_rvld_e;        // read accesses d$.
input           dcache_wvld_e;        // valid write setup to m-stage.
// 0in bits_on -var {dcache_rvld_e,dcache_wvld_e} -max 1 -message "Attempt to read AND write dcache on same cycle"
input           dcache_clk_en_e;      // array clock enable
input           dcache_wclk_en_e;     // write data/byte_wr_en flops clock enable
input           dcache_rclk_en_m;     // read flops clock enable
   
input [143:0]   dcache_wdata_e;       // write data - 16Bx8 + 8b parity.
input [1:0]     dcache_wr_way_e;     // replacement way for load miss/store (encoded).
input [15:0]    dcache_byte_wr_en_e;  // 16b byte wr enable for stores.

input [3:0]     dcache_alt_rsel_way_m;// bist/diagnostic read way select
input [3:0]     dcache_rsel_way_b;    // load way select, connect to cache_way_hit
input           dcache_alt_way_sel_m;
       
input [63:0]	lsu_l2fill_or_byp_data_m;
input       	dcache_bypass_e_;
   
output  [63:0]  dcache_rdata_b;
output  [7:0]   dcache_rparity_b;
   
output  	dcache_perr_w0_b; 
output  	dcache_perr_w1_b; 
output  	dcache_perr_w2_b; 
output  	dcache_perr_w3_b; 

output [7:0] dcache_rdata_msb_w0_b;
output [7:0] dcache_rdata_msb_w1_b;
output [7:0] dcache_rdata_msb_w2_b;
output [7:0] dcache_rdata_msb_w3_b;
   
input		l2clk;
input		scan_in;
input		tcu_pce_ov;
input		tcu_aclk;
input		tcu_bclk;
input		tcu_array_wr_inhibit;
input		tcu_scan_en;
input		tcu_se_scancollar_in;
input		tcu_se_scancollar_out;
output          scan_out;

input	[5:0]	fuse_dca_repair_value;
input	[1:0]	fuse_dca_repair_en;
input	[1:0]	fuse_dca_rid;
input		fuse_dca_wen;
input		fuse_red_reset;
output	[5:0]	dca_fuse_repair_value;
output	[1:0]	dca_fuse_repair_en;

input		vnw_ary;

// synopsys translate_off

// 0in bits_on -var {~dcache_clk_en_e,dcache_wvld_e} -max 1 -message "Attempt to write with clk_en disabled"
// 0in bits_on -var {~dcache_clk_en_e,dcache_rvld_e} -max 1 -message "Attempt to read with clk_en disabled"
// 0in bits_on -var {~dcache_wclk_en_e,dcache_wvld_e} -max 1 -message "Attempt to write with wclk_en disabled"
// 0in bits_on -var {~dcache_rclk_en_m,dcache_rvld_m} -max 1 -message "Attempt to read with rclk_en disabled"
// 0in bits_on -var {~dcache_bypass_e_,dcache_rvld_e} -max 1 -message "Read and bypass both active"

wire pce_ov = tcu_pce_ov;
wire stop   = 1'b0;
wire siclk  = tcu_aclk ;
wire soclk  = tcu_bclk;

//================================================
// Clock headers
//================================================
n2_dca_sp_9kb_cust_l1clkhdr_ctl_macro l1ch_in (
        .l2clk	(l2clk), 
        .l1en 	(1'b1), 
	.pce_ov	(1'b1),
	.se	(tcu_se_scancollar_in),
        .l1clk	(l1clk_in),
  .stop(stop)
);

n2_dca_sp_9kb_cust_l1clkhdr_ctl_macro l1ch_in_pm (
        .l2clk	(l2clk), 
        .l1en 	(dcache_wclk_en_e), 
	.se	(tcu_se_scancollar_in),
        .l1clk	(l1clk_in_pm),
  .pce_ov(pce_ov),
  .stop(stop)
);

n2_dca_sp_9kb_cust_l1clkhdr_ctl_macro l1ch_out_pm (
        .l2clk	(l2clk), 
        .l1en 	(dcache_rclk_en_m), 
	.se	(tcu_se_scancollar_out),
        .l1clk	(l1clk_out_pm),
  .pce_ov(pce_ov),
  .stop(stop)
);

n2_dca_sp_9kb_cust_l1clkhdr_ctl_macro l1ch_out (
        .l2clk	(l2clk), 
        .l1en 	(1'b1), 
	.pce_ov	(1'b1),
	.se	(tcu_se_scancollar_out),
        .l1clk	(l1clk_out),
  .stop(stop)
);

n2_dca_sp_9kb_cust_l1clkhdr_ctl_macro l1ch_free (
        .l2clk	(l2clk), 
        .l1en 	(dcache_clk_en_e), 
	.se	(tcu_scan_en),
        .l1clk	(l1clk_free),
  .pce_ov(pce_ov),
  .stop(stop)
);

n2_dca_sp_9kb_cust_l1clkhdr_ctl_macro l1ch_free_wpm (
        .l2clk	(l2clk), 
        .l1en 	(dcache_wclk_en_e), 
	.se	(tcu_scan_en),
        .l1clk	(l1clk_free_wpm),
  .pce_ov(pce_ov),
  .stop(stop)
);

n2_dca_sp_9kb_cust_l1clkhdr_ctl_macro l1ch_red (
        .l2clk	(l2clk), 
        .l1en 	(1'b1), 
	.pce_ov	(1'b1),
	.se	(1'b0),
        .l1clk	(l1clk_red),
  .stop(stop)
);

//=========================================================================================
//  Input flops
//=========================================================================================

// BIST Rd used fill address port.
n2_dca_sp_9kb_cust_mux_macro__mux_aope__ports_2__width_8 mx_addr_e    (
	.din0	(dcache_alt_addr_e[10:3]),
	.din1	(dcache_rd_addr_e[10:3]),
	.sel0	(dcache_alt_addr_sel_e),
	.dout	(dcache_rwaddr_e[10:3])
);
   
n2_dca_sp_9kb_cust_tisram_msff_macro__fs_1__width_8 lat_addr   (
        .scan_in(lat_addr_scanin[7:0]),
        .scan_out(lat_addr_scanout[7:0]),
        .l1clk		(l1clk_in),
	.d		(dcache_rwaddr_e[10:3]),
	.latout		(dcache_rwaddr_eb[10:3]),
	.latout_l	(dcache_rwaddr_l_unused[10:3]),
  .siclk(siclk),
  .soclk(soclk)
);

// This is just a 2:4 decoder
n2_dca_sp_9kb_cust_mux_macro__mux_aodec__ports_4__width_4 wr_way_decode    (
	.din0	(4'b0001),
	.din1	(4'b0010),
	.din2	(4'b0100),
	.din3	(4'b1000),
	.sel	(dcache_wr_way_e[1:0]),
	.dout	(wr_way_dec_e[3:0])
);

n2_dca_sp_9kb_cust_tisram_msff_macro__fs_1__width_7 lat_ctl_eb   (
        .scan_in(lat_ctl_eb_scanin[6:0]),
        .scan_out(lat_ctl_eb_scanout[6:0]),
        .l1clk		(l1clk_in),
	.d		({dcache_rvld_e,     dcache_rvld_e,     dcache_wvld_e, wr_way_dec_e[3:0]}),
	.latout		({dcache_rvld_top_eb,dcache_rvld_bot_eb,dcache_wvld_eb,wr_way_dec_eb[3:0]}),
	.latout_l	(lat_ctl_unused[6:0]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_3 dff_ctl_m_0  (
     .scan_in(dff_ctl_m_0_scanin[2:0]),
     .scan_out(dff_ctl_m_0_scanout[2:0]),
	.l1clk	(l1clk_in),
	.din	({dcache_rvld_e,dcache_wvld_e,dcache_bypass_e_}),
	.dout	({dcache_rvld_m,dcache_wvld_m,dcache_bypass_m_}),
  .siclk(siclk),
  .soclk(soclk)
);

n2_dca_sp_9kb_cust_tisram_msff_macro__fs_1__width_16 dff_ctl_m_1   (
	.scan_in(dff_ctl_m_1_scanin[15:0]),
	.scan_out(dff_ctl_m_1_scanout[15:0]),
	.l1clk		(l1clk_in_pm),
	.d		(dcache_byte_wr_en_e[15:0]),
	.latout		(byte_wr_en_eb[15:0]),
	.latout_l	(dff_ctl_l_unused[15:0]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_5 dff_ctl_b  (
     .scan_in(dff_ctl_b_scanin[4:0]),
     .scan_out(dff_ctl_b_scanout[4:0]),
	.l1clk	(l1clk_in),
	.din	({dcache_alt_way_sel_m,dcache_alt_rsel_way_m[3:0]}),
	.dout	({dcache_alt_way_sel_b,dcache_alt_rsel_way_b[3:0]}),
  .siclk(siclk),
  .soclk(soclk)
);
n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_144 dff_wdata_m  (
     .scan_in(dff_wdata_m_scanin[143:0]),
     .scan_out(dff_wdata_m_scanout[143:0]),
	.l1clk	(l1clk_in_pm),
	.din	(dcache_wdata_e[143:0]),
        .dout	({dcache_wparity_m[15],dcache_wdata_m[127:120],
		  dcache_wparity_m[14],dcache_wdata_m[119:112],
		  dcache_wparity_m[13],dcache_wdata_m[111:104],
		  dcache_wparity_m[12],dcache_wdata_m[103:96],
		  dcache_wparity_m[11],dcache_wdata_m[95:88],
		  dcache_wparity_m[10],dcache_wdata_m[87:80],
		  dcache_wparity_m[9],dcache_wdata_m[79:72],
		  dcache_wparity_m[8],dcache_wdata_m[71:64],
		  dcache_wparity_m[7],dcache_wdata_m[63:56],
		  dcache_wparity_m[6],dcache_wdata_m[55:48],
		  dcache_wparity_m[5],dcache_wdata_m[47:40],
		  dcache_wparity_m[4],dcache_wdata_m[39:32],
		  dcache_wparity_m[3],dcache_wdata_m[31:24],
		  dcache_wparity_m[2],dcache_wdata_m[23:16],
		  dcache_wparity_m[1],dcache_wdata_m[15:8],
		  dcache_wparity_m[0],dcache_wdata_m[7:0] }),
  .siclk(siclk),
  .soclk(soclk)
);











n2_dca_sp_9kb_array array (
	.l1clk			(l1clk_free),
	.l1clk_wr		(l1clk_free_wpm),
	.addr_b			(dcache_rwaddr_eb[10:3]),
	.rd_en_top_b		(dcache_rvld_top_eb),
	.rd_en_bot_b		(dcache_rvld_bot_eb),
	.rd_en_a		(dcache_rvld_m),
	.wr_en_b		(dcache_wvld_eb),
	.wr_en_a		(dcache_wvld_m),
	.wr_inh_b		(tcu_array_wr_inhibit),
	.byte_wr_en_b		(byte_wr_en_eb[15:0]),
	.wr_waysel_b		(wr_way_dec_eb[3:0]),
	.fuse_dca_repair_value	(fuse_dca_repair_value_ff[5:0]),
	.fuse_dca_repair_en	(fuse_dca_repair_en_ff[1:0]),
	.fuse_dca_rid		(fuse_dca_rid_ff[1:0]),
	.fuse_dca_wen		(fuse_dca_wen_ff),
	.fuse_red_reset		(fuse_red_reset_ff),
	.dca_fuse_repair_value	(dca_fuse_repair_value_pre[5:0]),
	.dca_fuse_repair_en	(dca_fuse_repair_en_pre[1:0]),
  .l1clk_red(l1clk_red),
  .dcache_wdata_m(dcache_wdata_m[127:0]),
  .dcache_wparity_m(dcache_wparity_m[15:0]),
  .dcache_rdata_w0_m(dcache_rdata_w0_m[63:0]),
  .rparity_w0_m(rparity_w0_m[7:0]),
  .dcache_rdata_w1_m(dcache_rdata_w1_m[63:0]),
  .rparity_w1_m(rparity_w1_m[7:0]),
  .dcache_rdata_w2_m(dcache_rdata_w2_m[63:0]),
  .rparity_w2_m(rparity_w2_m[7:0]),
  .dcache_rdata_w3_m(dcache_rdata_w3_m[63:0]),
  .rparity_w3_m(rparity_w3_m[7:0]),
  .vnw_ary(vnw_ary)
);


   
// mux fill/bypass data into way0 here so that it's not in the critical B stage path
n2_dca_sp_9kb_cust_mux_macro__mux_aope__ports_2__width_64 mx_way0_data    (
	.din0	(dcache_rdata_w0_m[63:0]),
	.din1	(lsu_l2fill_or_byp_data_m[63:0]),
	.sel0	(dcache_bypass_m_),
	.dout	(rdata_w0_m[63:0])
);
assign rdata_w1_m[63:0] = dcache_rdata_w1_m[63:0];
assign rdata_w2_m[63:0] = dcache_rdata_w2_m[63:0];
assign rdata_w3_m[63:0] = dcache_rdata_w3_m[63:0];

//=========================================================================================
//  Output flops
//=========================================================================================

n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_8 dff_msb_w0  (
     .scan_in(dff_msb_w0_scanin[7:0]),
     .scan_out(dff_msb_w0_scanout[7:0]),
	.l1clk	(l1clk_out_pm),
	.din	({dcache_rdata_w0_m[63],dcache_rdata_w0_m[55],dcache_rdata_w0_m[47],dcache_rdata_w0_m[39],
		  dcache_rdata_w0_m[31],dcache_rdata_w0_m[23],dcache_rdata_w0_m[15],dcache_rdata_w0_m[7]}),
	.dout	(dcache_rdata_msb_w0_b[7:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_8 dff_msb_w1  (
     .scan_in(dff_msb_w1_scanin[7:0]),
     .scan_out(dff_msb_w1_scanout[7:0]),
	.l1clk	(l1clk_out_pm),
	.din	({dcache_rdata_w1_m[63],dcache_rdata_w1_m[55],dcache_rdata_w1_m[47],dcache_rdata_w1_m[39],
		  dcache_rdata_w1_m[31],dcache_rdata_w1_m[23],dcache_rdata_w1_m[15],dcache_rdata_w1_m[7]}),
	.dout	(dcache_rdata_msb_w1_b[7:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_8 dff_msb_w2  (
     .scan_in(dff_msb_w2_scanin[7:0]),
     .scan_out(dff_msb_w2_scanout[7:0]),
	.l1clk	(l1clk_out_pm),
	.din	({dcache_rdata_w2_m[63],dcache_rdata_w2_m[55],dcache_rdata_w2_m[47],dcache_rdata_w2_m[39],
		  dcache_rdata_w2_m[31],dcache_rdata_w2_m[23],dcache_rdata_w2_m[15],dcache_rdata_w2_m[7]}),
	.dout	(dcache_rdata_msb_w2_b[7:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_8 dff_msb_w3  (
     .scan_in(dff_msb_w3_scanin[7:0]),
     .scan_out(dff_msb_w3_scanout[7:0]),
	.l1clk	(l1clk_out_pm),
	.din	({dcache_rdata_w3_m[63],dcache_rdata_w3_m[55],dcache_rdata_w3_m[47],dcache_rdata_w3_m[39],
		  dcache_rdata_w3_m[31],dcache_rdata_w3_m[23],dcache_rdata_w3_m[15],dcache_rdata_w3_m[7]}),
	.dout	(dcache_rdata_msb_w3_b[7:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_64 dff_rdata_w0_m  (
     .scan_in(dff_rdata_w0_m_scanin[63:0]),
     .scan_out(dff_rdata_w0_m_scanout[63:0]),
	.l1clk	(l1clk_out_pm),
	.din	(rdata_w0_m[63:0]),
	.dout	(rdata_w0_b[63:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_8 dff_rparity_w0_m  (
     .scan_in(dff_rparity_w0_m_scanin[7:0]),
     .scan_out(dff_rparity_w0_m_scanout[7:0]),
	.l1clk	(l1clk_out_pm),
	.din	(rparity_w0_m[7:0]),
	.dout	(rparity_w0_b[7:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_64 dff_rdata_w1_m  (
     .scan_in(dff_rdata_w1_m_scanin[63:0]),
     .scan_out(dff_rdata_w1_m_scanout[63:0]),
	.l1clk	(l1clk_out_pm),
	.din	(rdata_w1_m[63:0]),
	.dout	(rdata_w1_b[63:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_8 dff_rparity_w1_m  (
     .scan_in(dff_rparity_w1_m_scanin[7:0]),
     .scan_out(dff_rparity_w1_m_scanout[7:0]),
	.l1clk	(l1clk_out_pm),
	.din	(rparity_w1_m[7:0]),
	.dout	(rparity_w1_b[7:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_64 dff_rdata_w2_m  (
     .scan_in(dff_rdata_w2_m_scanin[63:0]),
     .scan_out(dff_rdata_w2_m_scanout[63:0]),
	.l1clk	(l1clk_out_pm),
	.din	(rdata_w2_m[63:0]),
	.dout	(rdata_w2_b[63:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_8 dff_rparity_w2_m  (
     .scan_in(dff_rparity_w2_m_scanin[7:0]),
     .scan_out(dff_rparity_w2_m_scanout[7:0]),
	.l1clk	(l1clk_out_pm),
	.din	(rparity_w2_m[7:0]),
	.dout	(rparity_w2_b[7:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_64 dff_rdata_w3_m  (
     .scan_in(dff_rdata_w3_m_scanin[63:0]),
     .scan_out(dff_rdata_w3_m_scanout[63:0]),
	.l1clk	(l1clk_out_pm),
	.din	(rdata_w3_m[63:0]),
	.dout	(rdata_w3_b[63:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_8 dff_rparity_w3_m  (
     .scan_in(dff_rparity_w3_m_scanin[7:0]),
     .scan_out(dff_rparity_w3_m_scanout[7:0]),
	.l1clk	(l1clk_out_pm),
	.din	(rparity_w3_m[7:0]),
	.dout	(rparity_w3_b[7:0]),
  .siclk(siclk),
  .soclk(soclk)
);

//=========================================================================================
//  Way select
//=========================================================================================

n2_dca_sp_9kb_cust_mux_macro__mux_aope__ports_2__width_4 mx_sel_way    (
	.din0	(dcache_alt_rsel_way_b[3:0]),
	.din1	(dcache_rsel_way_b[3:0]),
	.sel0	(dcache_alt_way_sel_b),
	.dout	(dcache_rd_sel_way_b[3:0])
);
   
n2_dca_sp_9kb_cust_mux_macro__mux_aonpe__ports_4__width_64 mx_rdata_b    (
	.din0	(rdata_w0_b[63:0]),
	.din1	(rdata_w1_b[63:0]),
	.din2	(rdata_w2_b[63:0]),
	.din3	(rdata_w3_b[63:0]),
	.sel0	(dcache_rd_sel_way_b[0]),
	.sel1	(dcache_rd_sel_way_b[1]),
	.sel2	(dcache_rd_sel_way_b[2]),
	.sel3	(dcache_rd_sel_way_b[3]),
	.dout	(dcache_rdata_b[63:0])
);

n2_dca_sp_9kb_cust_mux_macro__mux_aonpe__ports_4__width_8 mx_rparity_b    (
	.din0	(rparity_w0_b[7:0]),
	.din1	(rparity_w1_b[7:0]),
	.din2	(rparity_w2_b[7:0]),
	.din3	(rparity_w3_b[7:0]),
	.sel0	(dcache_rd_sel_way_b[0]),
	.sel1	(dcache_rd_sel_way_b[1]),
	.sel2	(dcache_rd_sel_way_b[2]),
	.sel3	(dcache_rd_sel_way_b[3]),
	.dout	(dcache_rparity_b[7:0])
);

//=========================================================================================
// Parity check. Parity for each byte is calculated in M.  The result of all bytes is
// flopped and OR'ed in B. 
//=========================================================================================

// ***** Way 0 *****
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w0_par0   (
	.din0({dcache_rdata_w0_m[0],dcache_rdata_w0_m[3],dcache_rdata_w0_m[6], w0_p0_0}),
	.din1({dcache_rdata_w0_m[1],dcache_rdata_w0_m[4],dcache_rdata_w0_m[7], w0_p0_1}),
	.din2({dcache_rdata_w0_m[2],dcache_rdata_w0_m[5],rparity_w0_m[0],w0_p0_2}),
	.dout({w0_p0_0,w0_p0_1,w0_p0_2,w0_parity_m[0]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w0_par1   (
	.din0({dcache_rdata_w0_m[8],dcache_rdata_w0_m[11],dcache_rdata_w0_m[14], w0_p1_0}),
	.din1({dcache_rdata_w0_m[9],dcache_rdata_w0_m[12],dcache_rdata_w0_m[15], w0_p1_1}),
	.din2({dcache_rdata_w0_m[10],dcache_rdata_w0_m[13],rparity_w0_m[1],w0_p1_2}),
	.dout({w0_p1_0,w0_p1_1,w0_p1_2,w0_parity_m[1]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w0_par2   (
	.din0({dcache_rdata_w0_m[16],dcache_rdata_w0_m[19],dcache_rdata_w0_m[22], w0_p2_0}),
	.din1({dcache_rdata_w0_m[17],dcache_rdata_w0_m[20],dcache_rdata_w0_m[23], w0_p2_1}),
	.din2({dcache_rdata_w0_m[18],dcache_rdata_w0_m[21],rparity_w0_m[2],w0_p2_2}),
	.dout({w0_p2_0,w0_p2_1,w0_p2_2,w0_parity_m[2]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w0_par3   (
	.din0({dcache_rdata_w0_m[24],dcache_rdata_w0_m[27],dcache_rdata_w0_m[30], w0_p3_0}),
	.din1({dcache_rdata_w0_m[25],dcache_rdata_w0_m[28],dcache_rdata_w0_m[31], w0_p3_1}),
	.din2({dcache_rdata_w0_m[26],dcache_rdata_w0_m[29],rparity_w0_m[3],w0_p3_2}),
	.dout({w0_p3_0,w0_p3_1,w0_p3_2,w0_parity_m[3]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w0_par4   (
	.din0({dcache_rdata_w0_m[32],dcache_rdata_w0_m[35],dcache_rdata_w0_m[38], w0_p4_0}),
	.din1({dcache_rdata_w0_m[33],dcache_rdata_w0_m[36],dcache_rdata_w0_m[39], w0_p4_1}),
	.din2({dcache_rdata_w0_m[34],dcache_rdata_w0_m[37],rparity_w0_m[4],w0_p4_2}),
	.dout({w0_p4_0,w0_p4_1,w0_p4_2,w0_parity_m[4]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w0_par5   (
	.din0({dcache_rdata_w0_m[40],dcache_rdata_w0_m[43],dcache_rdata_w0_m[46], w0_p5_0}),
	.din1({dcache_rdata_w0_m[41],dcache_rdata_w0_m[44],dcache_rdata_w0_m[47], w0_p5_1}),
	.din2({dcache_rdata_w0_m[42],dcache_rdata_w0_m[45],rparity_w0_m[5],w0_p5_2}),
	.dout({w0_p5_0,w0_p5_1,w0_p5_2,w0_parity_m[5]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w0_par6   (
	.din0({dcache_rdata_w0_m[48],dcache_rdata_w0_m[51],dcache_rdata_w0_m[54], w0_p6_0}),
	.din1({dcache_rdata_w0_m[49],dcache_rdata_w0_m[52],dcache_rdata_w0_m[55], w0_p6_1}),
	.din2({dcache_rdata_w0_m[50],dcache_rdata_w0_m[53],rparity_w0_m[6],w0_p6_2}),
	.dout({w0_p6_0,w0_p6_1,w0_p6_2,w0_parity_m[6]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w0_par7   (
	.din0({dcache_rdata_w0_m[56],dcache_rdata_w0_m[59],dcache_rdata_w0_m[62], w0_p7_0}),
	.din1({dcache_rdata_w0_m[57],dcache_rdata_w0_m[60],dcache_rdata_w0_m[63], w0_p7_1}),
	.din2({dcache_rdata_w0_m[58],dcache_rdata_w0_m[61],rparity_w0_m[7],w0_p7_2}),
	.dout({w0_p7_0,w0_p7_1,w0_p7_2,w0_parity_m[7]})
);
   
// ***** Way 1 *****
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w1_par0   (
	.din0({dcache_rdata_w1_m[0],dcache_rdata_w1_m[3],dcache_rdata_w1_m[6], w1_p0_0}),
	.din1({dcache_rdata_w1_m[1],dcache_rdata_w1_m[4],dcache_rdata_w1_m[7], w1_p0_1}),
	.din2({dcache_rdata_w1_m[2],dcache_rdata_w1_m[5],rparity_w1_m[0],w1_p0_2}),
	.dout({w1_p0_0,w1_p0_1,w1_p0_2,w1_parity_m[0]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w1_par1   (
	.din0({dcache_rdata_w1_m[8],dcache_rdata_w1_m[11],dcache_rdata_w1_m[14], w1_p1_0}),
	.din1({dcache_rdata_w1_m[9],dcache_rdata_w1_m[12],dcache_rdata_w1_m[15], w1_p1_1}),
	.din2({dcache_rdata_w1_m[10],dcache_rdata_w1_m[13],rparity_w1_m[1],w1_p1_2}),
	.dout({w1_p1_0,w1_p1_1,w1_p1_2,w1_parity_m[1]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w1_par2   (
	.din0({dcache_rdata_w1_m[16],dcache_rdata_w1_m[19],dcache_rdata_w1_m[22], w1_p2_0}),
	.din1({dcache_rdata_w1_m[17],dcache_rdata_w1_m[20],dcache_rdata_w1_m[23], w1_p2_1}),
	.din2({dcache_rdata_w1_m[18],dcache_rdata_w1_m[21],rparity_w1_m[2],w1_p2_2}),
	.dout({w1_p2_0,w1_p2_1,w1_p2_2,w1_parity_m[2]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w1_par3   (
	.din0({dcache_rdata_w1_m[24],dcache_rdata_w1_m[27],dcache_rdata_w1_m[30], w1_p3_0}),
	.din1({dcache_rdata_w1_m[25],dcache_rdata_w1_m[28],dcache_rdata_w1_m[31], w1_p3_1}),
	.din2({dcache_rdata_w1_m[26],dcache_rdata_w1_m[29],rparity_w1_m[3],w1_p3_2}),
	.dout({w1_p3_0,w1_p3_1,w1_p3_2,w1_parity_m[3]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w1_par4   (
	.din0({dcache_rdata_w1_m[32],dcache_rdata_w1_m[35],dcache_rdata_w1_m[38], w1_p4_0}),
	.din1({dcache_rdata_w1_m[33],dcache_rdata_w1_m[36],dcache_rdata_w1_m[39], w1_p4_1}),
	.din2({dcache_rdata_w1_m[34],dcache_rdata_w1_m[37],rparity_w1_m[4],w1_p4_2}),
	.dout({w1_p4_0,w1_p4_1,w1_p4_2,w1_parity_m[4]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w1_par5   (
	.din0({dcache_rdata_w1_m[40],dcache_rdata_w1_m[43],dcache_rdata_w1_m[46], w1_p5_0}),
	.din1({dcache_rdata_w1_m[41],dcache_rdata_w1_m[44],dcache_rdata_w1_m[47], w1_p5_1}),
	.din2({dcache_rdata_w1_m[42],dcache_rdata_w1_m[45],rparity_w1_m[5],w1_p5_2}),
	.dout({w1_p5_0,w1_p5_1,w1_p5_2,w1_parity_m[5]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w1_par6   (
	.din0({dcache_rdata_w1_m[48],dcache_rdata_w1_m[51],dcache_rdata_w1_m[54], w1_p6_0}),
	.din1({dcache_rdata_w1_m[49],dcache_rdata_w1_m[52],dcache_rdata_w1_m[55], w1_p6_1}),
	.din2({dcache_rdata_w1_m[50],dcache_rdata_w1_m[53],rparity_w1_m[6],w1_p6_2}),
	.dout({w1_p6_0,w1_p6_1,w1_p6_2,w1_parity_m[6]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w1_par7   (
	.din0({dcache_rdata_w1_m[56],dcache_rdata_w1_m[59],dcache_rdata_w1_m[62], w1_p7_0}),
	.din1({dcache_rdata_w1_m[57],dcache_rdata_w1_m[60],dcache_rdata_w1_m[63], w1_p7_1}),
	.din2({dcache_rdata_w1_m[58],dcache_rdata_w1_m[61],rparity_w1_m[7],w1_p7_2}),
	.dout({w1_p7_0,w1_p7_1,w1_p7_2,w1_parity_m[7]})
);
   
// ***** Way 2 *****
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w2_par0   (
	.din0({dcache_rdata_w2_m[0],dcache_rdata_w2_m[3],dcache_rdata_w2_m[6], w2_p0_0}),
	.din1({dcache_rdata_w2_m[1],dcache_rdata_w2_m[4],dcache_rdata_w2_m[7], w2_p0_1}),
	.din2({dcache_rdata_w2_m[2],dcache_rdata_w2_m[5],rparity_w2_m[0],w2_p0_2}),
	.dout({w2_p0_0,w2_p0_1,w2_p0_2,w2_parity_m[0]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w2_par1   (
	.din0({dcache_rdata_w2_m[8],dcache_rdata_w2_m[11],dcache_rdata_w2_m[14], w2_p1_0}),
	.din1({dcache_rdata_w2_m[9],dcache_rdata_w2_m[12],dcache_rdata_w2_m[15], w2_p1_1}),
	.din2({dcache_rdata_w2_m[10],dcache_rdata_w2_m[13],rparity_w2_m[1],w2_p1_2}),
	.dout({w2_p1_0,w2_p1_1,w2_p1_2,w2_parity_m[1]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w2_par2   (
	.din0({dcache_rdata_w2_m[16],dcache_rdata_w2_m[19],dcache_rdata_w2_m[22], w2_p2_0}),
	.din1({dcache_rdata_w2_m[17],dcache_rdata_w2_m[20],dcache_rdata_w2_m[23], w2_p2_1}),
	.din2({dcache_rdata_w2_m[18],dcache_rdata_w2_m[21],rparity_w2_m[2],w2_p2_2}),
	.dout({w2_p2_0,w2_p2_1,w2_p2_2,w2_parity_m[2]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w2_par3   (
	.din0({dcache_rdata_w2_m[24],dcache_rdata_w2_m[27],dcache_rdata_w2_m[30], w2_p3_0}),
	.din1({dcache_rdata_w2_m[25],dcache_rdata_w2_m[28],dcache_rdata_w2_m[31], w2_p3_1}),
	.din2({dcache_rdata_w2_m[26],dcache_rdata_w2_m[29],rparity_w2_m[3],w2_p3_2}),
	.dout({w2_p3_0,w2_p3_1,w2_p3_2,w2_parity_m[3]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w2_par4   (
	.din0({dcache_rdata_w2_m[32],dcache_rdata_w2_m[35],dcache_rdata_w2_m[38], w2_p4_0}),
	.din1({dcache_rdata_w2_m[33],dcache_rdata_w2_m[36],dcache_rdata_w2_m[39], w2_p4_1}),
	.din2({dcache_rdata_w2_m[34],dcache_rdata_w2_m[37],rparity_w2_m[4],w2_p4_2}),
	.dout({w2_p4_0,w2_p4_1,w2_p4_2,w2_parity_m[4]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w2_par5   (
	.din0({dcache_rdata_w2_m[40],dcache_rdata_w2_m[43],dcache_rdata_w2_m[46], w2_p5_0}),
	.din1({dcache_rdata_w2_m[41],dcache_rdata_w2_m[44],dcache_rdata_w2_m[47], w2_p5_1}),
	.din2({dcache_rdata_w2_m[42],dcache_rdata_w2_m[45],rparity_w2_m[5],w2_p5_2}),
	.dout({w2_p5_0,w2_p5_1,w2_p5_2,w2_parity_m[5]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w2_par6   (
	.din0({dcache_rdata_w2_m[48],dcache_rdata_w2_m[51],dcache_rdata_w2_m[54], w2_p6_0}),
	.din1({dcache_rdata_w2_m[49],dcache_rdata_w2_m[52],dcache_rdata_w2_m[55], w2_p6_1}),
	.din2({dcache_rdata_w2_m[50],dcache_rdata_w2_m[53],rparity_w2_m[6],w2_p6_2}),
	.dout({w2_p6_0,w2_p6_1,w2_p6_2,w2_parity_m[6]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w2_par7   (
	.din0({dcache_rdata_w2_m[56],dcache_rdata_w2_m[59],dcache_rdata_w2_m[62], w2_p7_0}),
	.din1({dcache_rdata_w2_m[57],dcache_rdata_w2_m[60],dcache_rdata_w2_m[63], w2_p7_1}),
	.din2({dcache_rdata_w2_m[58],dcache_rdata_w2_m[61],rparity_w2_m[7],w2_p7_2}),
	.dout({w2_p7_0,w2_p7_1,w2_p7_2,w2_parity_m[7]})
);
   
// ***** Way 3 *****
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w3_par0   (
	.din0({dcache_rdata_w3_m[0],dcache_rdata_w3_m[3],dcache_rdata_w3_m[6], w3_p0_0}),
	.din1({dcache_rdata_w3_m[1],dcache_rdata_w3_m[4],dcache_rdata_w3_m[7], w3_p0_1}),
	.din2({dcache_rdata_w3_m[2],dcache_rdata_w3_m[5],rparity_w3_m[0],w3_p0_2}),
	.dout({w3_p0_0,w3_p0_1,w3_p0_2,w3_parity_m[0]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w3_par1   (
	.din0({dcache_rdata_w3_m[8],dcache_rdata_w3_m[11],dcache_rdata_w3_m[14], w3_p1_0}),
	.din1({dcache_rdata_w3_m[9],dcache_rdata_w3_m[12],dcache_rdata_w3_m[15], w3_p1_1}),
	.din2({dcache_rdata_w3_m[10],dcache_rdata_w3_m[13],rparity_w3_m[1],w3_p1_2}),
	.dout({w3_p1_0,w3_p1_1,w3_p1_2,w3_parity_m[1]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w3_par2   (
	.din0({dcache_rdata_w3_m[16],dcache_rdata_w3_m[19],dcache_rdata_w3_m[22], w3_p2_0}),
	.din1({dcache_rdata_w3_m[17],dcache_rdata_w3_m[20],dcache_rdata_w3_m[23], w3_p2_1}),
	.din2({dcache_rdata_w3_m[18],dcache_rdata_w3_m[21],rparity_w3_m[2],w3_p2_2}),
	.dout({w3_p2_0,w3_p2_1,w3_p2_2,w3_parity_m[2]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w3_par3   (
	.din0({dcache_rdata_w3_m[24],dcache_rdata_w3_m[27],dcache_rdata_w3_m[30], w3_p3_0}),
	.din1({dcache_rdata_w3_m[25],dcache_rdata_w3_m[28],dcache_rdata_w3_m[31], w3_p3_1}),
	.din2({dcache_rdata_w3_m[26],dcache_rdata_w3_m[29],rparity_w3_m[3],w3_p3_2}),
	.dout({w3_p3_0,w3_p3_1,w3_p3_2,w3_parity_m[3]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w3_par4   (
	.din0({dcache_rdata_w3_m[32],dcache_rdata_w3_m[35],dcache_rdata_w3_m[38], w3_p4_0}),
	.din1({dcache_rdata_w3_m[33],dcache_rdata_w3_m[36],dcache_rdata_w3_m[39], w3_p4_1}),
	.din2({dcache_rdata_w3_m[34],dcache_rdata_w3_m[37],rparity_w3_m[4],w3_p4_2}),
	.dout({w3_p4_0,w3_p4_1,w3_p4_2,w3_parity_m[4]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w3_par5   (
	.din0({dcache_rdata_w3_m[40],dcache_rdata_w3_m[43],dcache_rdata_w3_m[46], w3_p5_0}),
	.din1({dcache_rdata_w3_m[41],dcache_rdata_w3_m[44],dcache_rdata_w3_m[47], w3_p5_1}),
	.din2({dcache_rdata_w3_m[42],dcache_rdata_w3_m[45],rparity_w3_m[5],w3_p5_2}),
	.dout({w3_p5_0,w3_p5_1,w3_p5_2,w3_parity_m[5]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w3_par6   (
	.din0({dcache_rdata_w3_m[48],dcache_rdata_w3_m[51],dcache_rdata_w3_m[54], w3_p6_0}),
	.din1({dcache_rdata_w3_m[49],dcache_rdata_w3_m[52],dcache_rdata_w3_m[55], w3_p6_1}),
	.din2({dcache_rdata_w3_m[50],dcache_rdata_w3_m[53],rparity_w3_m[6],w3_p6_2}),
	.dout({w3_p6_0,w3_p6_1,w3_p6_2,w3_parity_m[6]})
);
n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 w3_par7   (
	.din0({dcache_rdata_w3_m[56],dcache_rdata_w3_m[59],dcache_rdata_w3_m[62], w3_p7_0}),
	.din1({dcache_rdata_w3_m[57],dcache_rdata_w3_m[60],dcache_rdata_w3_m[63], w3_p7_1}),
	.din2({dcache_rdata_w3_m[58],dcache_rdata_w3_m[61],rparity_w3_m[7],w3_p7_2}),
	.dout({w3_p7_0,w3_p7_1,w3_p7_2,w3_parity_m[7]})
);

n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_8 dff_byte_perr_w0  (
     .scan_in(dff_byte_perr_w0_scanin[7:0]),
     .scan_out(dff_byte_perr_w0_scanout[7:0]),
	.l1clk	(l1clk_out_pm),
	.din	(w0_parity_m[7:0]),
	.dout	(w0_parity_b[7:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_8 dff_byte_perr_w1  (
     .scan_in(dff_byte_perr_w1_scanin[7:0]),
     .scan_out(dff_byte_perr_w1_scanout[7:0]),
	.l1clk	(l1clk_out_pm),
	.din	(w1_parity_m[7:0]),
	.dout	(w1_parity_b[7:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_8 dff_byte_perr_w2  (
     .scan_in(dff_byte_perr_w2_scanin[7:0]),
     .scan_out(dff_byte_perr_w2_scanout[7:0]),
	.l1clk	(l1clk_out_pm),
	.din	(w2_parity_m[7:0]),
	.dout	(w2_parity_b[7:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_8 dff_byte_perr_w3  (
     .scan_in(dff_byte_perr_w3_scanin[7:0]),
     .scan_out(dff_byte_perr_w3_scanout[7:0]),
	.l1clk	(l1clk_out_pm),
	.din	(w3_parity_m[7:0]),
	.dout	(w3_parity_b[7:0]),
  .siclk(siclk),
  .soclk(soclk)
);

// Funcionally this is just an OR gate.
n2_dca_sp_9kb_cust_mux_macro__mux_aonpe__ports_8__width_1 parity_w0    (
	.din0(1'b1), .din1(1'b1), .din2(1'b1), .din3(1'b1), .din4(1'b1), .din5(1'b1), .din6(1'b1), .din7(1'b1),
	.sel0(w0_parity_b[0]), .sel1(w0_parity_b[1]), .sel2(w0_parity_b[2]), .sel3(w0_parity_b[3]),
	.sel4(w0_parity_b[4]), .sel5(w0_parity_b[5]), .sel6(w0_parity_b[6]), .sel7(w0_parity_b[7]),
	.dout(w0_parity_err_b)
);
// Funcionally this is just an OR gate.
n2_dca_sp_9kb_cust_mux_macro__mux_aonpe__ports_8__width_1 parity_w1    (
	.din0(1'b1), .din1(1'b1), .din2(1'b1), .din3(1'b1), .din4(1'b1), .din5(1'b1), .din6(1'b1), .din7(1'b1),
	.sel0(w1_parity_b[0]), .sel1(w1_parity_b[1]), .sel2(w1_parity_b[2]), .sel3(w1_parity_b[3]),
	.sel4(w1_parity_b[4]), .sel5(w1_parity_b[5]), .sel6(w1_parity_b[6]), .sel7(w1_parity_b[7]),
	.dout(w1_parity_err_b)
);
// Funcionally this is just an OR gate.
n2_dca_sp_9kb_cust_mux_macro__mux_aonpe__ports_8__width_1 parity_w2    (
	.din0(1'b1), .din1(1'b1), .din2(1'b1), .din3(1'b1), .din4(1'b1), .din5(1'b1), .din6(1'b1), .din7(1'b1),
	.sel0(w2_parity_b[0]), .sel1(w2_parity_b[1]), .sel2(w2_parity_b[2]), .sel3(w2_parity_b[3]),
	.sel4(w2_parity_b[4]), .sel5(w2_parity_b[5]), .sel6(w2_parity_b[6]), .sel7(w2_parity_b[7]),
	.dout(w2_parity_err_b)
);
// Funcionally this is just an OR gate.
n2_dca_sp_9kb_cust_mux_macro__mux_aonpe__ports_8__width_1 parity_w3    (
	.din0(1'b1), .din1(1'b1), .din2(1'b1), .din3(1'b1), .din4(1'b1), .din5(1'b1), .din6(1'b1), .din7(1'b1),
	.sel0(w3_parity_b[0]), .sel1(w3_parity_b[1]), .sel2(w3_parity_b[2]), .sel3(w3_parity_b[3]),
	.sel4(w3_parity_b[4]), .sel5(w3_parity_b[5]), .sel6(w3_parity_b[6]), .sel7(w3_parity_b[7]),
	.dout(w3_parity_err_b)
);
   
assign dcache_perr_w0_b = w0_parity_err_b;
assign dcache_perr_w1_b = w1_parity_err_b;
assign dcache_perr_w2_b = w2_parity_err_b;
assign dcache_perr_w3_b = w3_parity_err_b;

//=========================================================================================
//  Redundancy flops
//=========================================================================================

n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_12 dff_red_in  (
     .scan_in(dff_red_in_scanin[11:0]),
     .scan_out(dff_red_in_scanout[11:0]),
	.l1clk	(l1clk_in),
	.din	({fuse_dca_repair_value[5:0],   fuse_dca_repair_en[1:0],
		  fuse_dca_rid[1:0],   fuse_dca_wen,   fuse_red_reset}),
	.dout	({fuse_dca_repair_value_ff[5:0],fuse_dca_repair_en_ff[1:0],
		  fuse_dca_rid_ff[1:0],fuse_dca_wen_ff,fuse_red_reset_ff}),
  .siclk(siclk),
  .soclk(soclk)
);

n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_8 dff_red_out  (
     .scan_in(dff_red_out_scanin[7:0]),
     .scan_out(dff_red_out_scanout[7:0]),
	.l1clk	(l1clk_out),
	.din	({dca_fuse_repair_value_pre[5:0],dca_fuse_repair_en_pre[1:0]}),
	.dout	({dca_fuse_repair_value[5:0],    dca_fuse_repair_en[1:0]}),
  .siclk(siclk),
  .soclk(soclk)
);


supply0 vss;
supply1 vdd;

// scanorder start
// dff_byte_perr_w0_scanin[7]
// dff_byte_perr_w1_scanin[7]
// dff_byte_perr_w1_scanin[6]
// dff_byte_perr_w0_scanin[6]
// dff_byte_perr_w0_scanin[5]
// dff_byte_perr_w1_scanin[5]
// dff_byte_perr_w1_scanin[4]
// dff_byte_perr_w0_scanin[4]
// dff_wdata_m_scanin[143]
// dff_wdata_m_scanin[71]
// dff_rparity_w3_m_scanin[7]
// dff_rparity_w2_m_scanin[7]
// dff_rparity_w1_m_scanin[7]
// dff_rparity_w0_m_scanin[7]
// dff_wdata_m_scanin[134]
// dff_wdata_m_scanin[62]
// dff_rparity_w3_m_scanin[6]
// dff_rparity_w2_m_scanin[6]
// dff_rparity_w1_m_scanin[6]
// dff_rparity_w0_m_scanin[6]
// dff_wdata_m_scanin[142]
// dff_wdata_m_scanin[70]
// dff_rdata_w3_m_scanin[63]
// dff_rdata_w2_m_scanin[63]
// dff_rdata_w1_m_scanin[63]
// dff_rdata_w0_m_scanin[63]
// dff_wdata_m_scanin[133]
// dff_wdata_m_scanin[61]
// dff_rdata_w3_m_scanin[55]
// dff_rdata_w2_m_scanin[55]
// dff_rdata_w1_m_scanin[55]
// dff_rdata_w0_m_scanin[55]
// dff_wdata_m_scanin[141]
// dff_wdata_m_scanin[69]
// dff_rdata_w3_m_scanin[62]
// dff_rdata_w2_m_scanin[62]
// dff_rdata_w1_m_scanin[62]
// dff_rdata_w0_m_scanin[62]
// dff_wdata_m_scanin[132]
// dff_wdata_m_scanin[60]
// dff_rdata_w3_m_scanin[54]
// dff_rdata_w2_m_scanin[54]
// dff_rdata_w1_m_scanin[54]
// dff_rdata_w0_m_scanin[54]
// dff_wdata_m_scanin[140]
// dff_wdata_m_scanin[68]
// dff_rdata_w3_m_scanin[61]
// dff_rdata_w2_m_scanin[61]
// dff_rdata_w1_m_scanin[61]
// dff_rdata_w0_m_scanin[61]
// dff_wdata_m_scanin[131]
// dff_wdata_m_scanin[59]
// dff_rdata_w3_m_scanin[53]
// dff_rdata_w2_m_scanin[53]
// dff_rdata_w1_m_scanin[53]
// dff_rdata_w0_m_scanin[53]
// dff_wdata_m_scanin[139]
// dff_wdata_m_scanin[67]
// dff_rdata_w3_m_scanin[60]
// dff_rdata_w2_m_scanin[60]
// dff_rdata_w1_m_scanin[60]
// dff_rdata_w0_m_scanin[60]
// dff_wdata_m_scanin[130]
// dff_wdata_m_scanin[58]
// dff_rdata_w3_m_scanin[52]
// dff_rdata_w2_m_scanin[52]
// dff_rdata_w1_m_scanin[52]
// dff_rdata_w0_m_scanin[52]
// dff_wdata_m_scanin[138]
// dff_wdata_m_scanin[66]
// dff_rdata_w3_m_scanin[59]
// dff_rdata_w2_m_scanin[59]
// dff_rdata_w1_m_scanin[59]
// dff_rdata_w0_m_scanin[59]
// dff_wdata_m_scanin[129]
// dff_wdata_m_scanin[57]
// dff_rdata_w3_m_scanin[51]
// dff_rdata_w2_m_scanin[51]
// dff_rdata_w1_m_scanin[51]
// dff_rdata_w0_m_scanin[51]
// dff_wdata_m_scanin[137]
// dff_wdata_m_scanin[65]
// dff_rdata_w3_m_scanin[58]
// dff_rdata_w2_m_scanin[58]
// dff_rdata_w1_m_scanin[58]
// dff_rdata_w0_m_scanin[58]
// dff_wdata_m_scanin[128]
// dff_wdata_m_scanin[56]
// dff_rdata_w3_m_scanin[50]
// dff_rdata_w2_m_scanin[50]
// dff_rdata_w1_m_scanin[50]
// dff_rdata_w0_m_scanin[50]
// dff_wdata_m_scanin[136]
// dff_wdata_m_scanin[64]
// dff_rdata_w3_m_scanin[57]
// dff_rdata_w2_m_scanin[57]
// dff_rdata_w1_m_scanin[57]
// dff_rdata_w0_m_scanin[57]
// dff_wdata_m_scanin[127]
// dff_wdata_m_scanin[55]
// dff_rdata_w3_m_scanin[49]
// dff_rdata_w2_m_scanin[49]
// dff_rdata_w1_m_scanin[49]
// dff_rdata_w0_m_scanin[49]
// dff_wdata_m_scanin[135]
// dff_wdata_m_scanin[63]
// dff_rdata_w3_m_scanin[56]
// dff_rdata_w2_m_scanin[56]
// dff_rdata_w1_m_scanin[56]
// dff_rdata_w0_m_scanin[56]
// dff_wdata_m_scanin[126]
// dff_wdata_m_scanin[54]
// dff_rdata_w3_m_scanin[48]
// dff_rdata_w2_m_scanin[48]
// dff_rdata_w1_m_scanin[48]
// dff_rdata_w0_m_scanin[48]
// dff_wdata_m_scanin[125]
// dff_wdata_m_scanin[53]
// dff_rparity_w3_m_scanin[5]
// dff_rparity_w2_m_scanin[5]
// dff_rparity_w1_m_scanin[5]
// dff_rparity_w0_m_scanin[5]
// dff_wdata_m_scanin[116]
// dff_wdata_m_scanin[44]
// dff_rparity_w3_m_scanin[4]
// dff_rparity_w2_m_scanin[4]
// dff_rparity_w1_m_scanin[4]
// dff_rparity_w0_m_scanin[4]
// dff_wdata_m_scanin[124]
// dff_wdata_m_scanin[52]
// dff_rdata_w3_m_scanin[47]
// dff_rdata_w2_m_scanin[47]
// dff_rdata_w1_m_scanin[47]
// dff_rdata_w0_m_scanin[47]
// dff_wdata_m_scanin[115]
// dff_wdata_m_scanin[43]
// dff_rdata_w3_m_scanin[39]
// dff_rdata_w2_m_scanin[39]
// dff_rdata_w1_m_scanin[39]
// dff_rdata_w0_m_scanin[39]
// dff_wdata_m_scanin[123]
// dff_wdata_m_scanin[51]
// dff_rdata_w3_m_scanin[46]
// dff_rdata_w2_m_scanin[46]
// dff_rdata_w1_m_scanin[46]
// dff_rdata_w0_m_scanin[46]
// dff_wdata_m_scanin[114]
// dff_wdata_m_scanin[42]
// dff_rdata_w3_m_scanin[38]
// dff_rdata_w2_m_scanin[38]
// dff_rdata_w1_m_scanin[38]
// dff_rdata_w0_m_scanin[38]
// dff_wdata_m_scanin[122]
// dff_wdata_m_scanin[50]
// dff_rdata_w3_m_scanin[45]
// dff_rdata_w2_m_scanin[45]
// dff_rdata_w1_m_scanin[45]
// dff_rdata_w0_m_scanin[45]
// dff_wdata_m_scanin[113]
// dff_wdata_m_scanin[41]
// dff_rdata_w3_m_scanin[37]
// dff_rdata_w2_m_scanin[37]
// dff_rdata_w1_m_scanin[37]
// dff_rdata_w0_m_scanin[37]
// dff_wdata_m_scanin[121]
// dff_wdata_m_scanin[49]
// dff_rdata_w3_m_scanin[44]
// dff_rdata_w2_m_scanin[44]
// dff_rdata_w1_m_scanin[44]
// dff_rdata_w0_m_scanin[44]
// dff_wdata_m_scanin[112]
// dff_wdata_m_scanin[40]
// dff_rdata_w3_m_scanin[36]
// dff_rdata_w2_m_scanin[36]
// dff_rdata_w1_m_scanin[36]
// dff_rdata_w0_m_scanin[36]
// dff_wdata_m_scanin[120]
// dff_wdata_m_scanin[48]
// dff_rdata_w3_m_scanin[43]
// dff_rdata_w2_m_scanin[43]
// dff_rdata_w1_m_scanin[43]
// dff_rdata_w0_m_scanin[43]
// dff_wdata_m_scanin[111]
// dff_wdata_m_scanin[39]
// dff_rdata_w3_m_scanin[35]
// dff_rdata_w2_m_scanin[35]
// dff_rdata_w1_m_scanin[35]
// dff_rdata_w0_m_scanin[35]
// dff_wdata_m_scanin[119]
// dff_wdata_m_scanin[47]
// dff_rdata_w3_m_scanin[42]
// dff_rdata_w2_m_scanin[42]
// dff_rdata_w1_m_scanin[42]
// dff_rdata_w0_m_scanin[42]
// dff_wdata_m_scanin[110]
// dff_wdata_m_scanin[38]
// dff_rdata_w3_m_scanin[34]
// dff_rdata_w2_m_scanin[34]
// dff_rdata_w1_m_scanin[34]
// dff_rdata_w0_m_scanin[34]
// dff_wdata_m_scanin[118]
// dff_wdata_m_scanin[46]
// dff_rdata_w3_m_scanin[41]
// dff_rdata_w2_m_scanin[41]
// dff_rdata_w1_m_scanin[41]
// dff_rdata_w0_m_scanin[41]
// dff_wdata_m_scanin[109]
// dff_wdata_m_scanin[37]
// dff_rdata_w3_m_scanin[33]
// dff_rdata_w2_m_scanin[33]
// dff_rdata_w1_m_scanin[33]
// dff_rdata_w0_m_scanin[33]
// dff_wdata_m_scanin[117]
// dff_wdata_m_scanin[45]
// dff_rdata_w3_m_scanin[40]
// dff_rdata_w2_m_scanin[40]
// dff_rdata_w1_m_scanin[40]
// dff_rdata_w0_m_scanin[40]
// dff_wdata_m_scanin[108]
// dff_wdata_m_scanin[36]
// dff_rdata_w3_m_scanin[32]
// dff_rdata_w2_m_scanin[32]
// dff_rdata_w1_m_scanin[32]
// dff_rdata_w0_m_scanin[32]
// dff_ctl_m_1_scanin[15]
// dff_ctl_m_1_scanin[7]
// dff_ctl_m_1_scanin[14]
// dff_ctl_m_1_scanin[6]
// dff_ctl_m_1_scanin[13]
// dff_ctl_m_1_scanin[5]
// dff_ctl_m_1_scanin[12]
// dff_ctl_m_1_scanin[4]
// dff_byte_perr_w2_scanin[7]
// dff_byte_perr_w3_scanin[7]
// dff_byte_perr_w3_scanin[6]
// dff_byte_perr_w2_scanin[6]
// dff_byte_perr_w2_scanin[5]
// dff_byte_perr_w3_scanin[5]
// dff_byte_perr_w3_scanin[4]
// dff_byte_perr_w2_scanin[4]
// dff_ctl_m_0_scanin[0]
// dff_ctl_b_scanin[4]
// dff_ctl_b_scanin[0]
// dff_ctl_b_scanin[1]
// dff_ctl_b_scanin[2]
// dff_ctl_b_scanin[3]
// lat_ctl_eb_scanin[6]
// lat_ctl_eb_scanin[1]
// lat_ctl_eb_scanin[0]
// lat_ctl_eb_scanin[2]
// lat_ctl_eb_scanin[3]
// lat_addr_scanin[1]
// lat_addr_scanin[0]
// lat_addr_scanin[7]
// lat_addr_scanin[6]
// lat_addr_scanin[5]
// lat_addr_scanin[4]
// lat_addr_scanin[3]
// lat_addr_scanin[2]
// lat_ctl_eb_scanin[4]
// dff_ctl_m_0_scanin[1]
// dff_ctl_m_0_scanin[2]
// lat_ctl_eb_scanin[5]
// dff_byte_perr_w0_scanin[0]
// dff_byte_perr_w1_scanin[0]
// dff_byte_perr_w1_scanin[1]
// dff_byte_perr_w0_scanin[1]
// dff_byte_perr_w0_scanin[2]
// dff_byte_perr_w1_scanin[2]
// dff_byte_perr_w1_scanin[3]
// dff_byte_perr_w0_scanin[3]
// dff_wdata_m_scanin[80]
// dff_wdata_m_scanin[8]
// dff_rparity_w3_m_scanin[0]
// dff_rparity_w2_m_scanin[0]
// dff_rparity_w1_m_scanin[0]
// dff_rparity_w0_m_scanin[0]
// dff_wdata_m_scanin[89]
// dff_wdata_m_scanin[17]
// dff_rparity_w3_m_scanin[1]
// dff_rparity_w2_m_scanin[1]
// dff_rparity_w1_m_scanin[1]
// dff_rparity_w0_m_scanin[1]
// dff_wdata_m_scanin[72]
// dff_wdata_m_scanin[0]
// dff_rdata_w3_m_scanin[0]
// dff_rdata_w2_m_scanin[0]
// dff_rdata_w1_m_scanin[0]
// dff_rdata_w0_m_scanin[0]
// dff_wdata_m_scanin[81]
// dff_wdata_m_scanin[9]
// dff_rdata_w3_m_scanin[8]
// dff_rdata_w2_m_scanin[8]
// dff_rdata_w1_m_scanin[8]
// dff_rdata_w0_m_scanin[8]
// dff_wdata_m_scanin[73]
// dff_wdata_m_scanin[1]
// dff_rdata_w3_m_scanin[1]
// dff_rdata_w2_m_scanin[1]
// dff_rdata_w1_m_scanin[1]
// dff_rdata_w0_m_scanin[1]
// dff_wdata_m_scanin[82]
// dff_wdata_m_scanin[10]
// dff_rdata_w3_m_scanin[9]
// dff_rdata_w2_m_scanin[9]
// dff_rdata_w1_m_scanin[9]
// dff_rdata_w0_m_scanin[9]
// dff_wdata_m_scanin[74]
// dff_wdata_m_scanin[2]
// dff_rdata_w3_m_scanin[2]
// dff_rdata_w2_m_scanin[2]
// dff_rdata_w1_m_scanin[2]
// dff_rdata_w0_m_scanin[2]
// dff_wdata_m_scanin[83]
// dff_wdata_m_scanin[11]
// dff_rdata_w3_m_scanin[10]
// dff_rdata_w2_m_scanin[10]
// dff_rdata_w1_m_scanin[10]
// dff_rdata_w0_m_scanin[10]
// dff_wdata_m_scanin[75]
// dff_wdata_m_scanin[3]
// dff_rdata_w3_m_scanin[3]
// dff_rdata_w2_m_scanin[3]
// dff_rdata_w1_m_scanin[3]
// dff_rdata_w0_m_scanin[3]
// dff_wdata_m_scanin[84]
// dff_wdata_m_scanin[12]
// dff_rdata_w3_m_scanin[11]
// dff_rdata_w2_m_scanin[11]
// dff_rdata_w1_m_scanin[11]
// dff_rdata_w0_m_scanin[11]
// dff_wdata_m_scanin[76]
// dff_wdata_m_scanin[4]
// dff_rdata_w3_m_scanin[4]
// dff_rdata_w2_m_scanin[4]
// dff_rdata_w1_m_scanin[4]
// dff_rdata_w0_m_scanin[4]
// dff_wdata_m_scanin[85]
// dff_wdata_m_scanin[13]
// dff_rdata_w3_m_scanin[12]
// dff_rdata_w2_m_scanin[12]
// dff_rdata_w1_m_scanin[12]
// dff_rdata_w0_m_scanin[12]
// dff_wdata_m_scanin[77]
// dff_wdata_m_scanin[5]
// dff_rdata_w3_m_scanin[5]
// dff_rdata_w2_m_scanin[5]
// dff_rdata_w1_m_scanin[5]
// dff_rdata_w0_m_scanin[5]
// dff_wdata_m_scanin[86]
// dff_wdata_m_scanin[14]
// dff_rdata_w3_m_scanin[13]
// dff_rdata_w2_m_scanin[13]
// dff_rdata_w1_m_scanin[13]
// dff_rdata_w0_m_scanin[13]
// dff_wdata_m_scanin[78]
// dff_wdata_m_scanin[6]
// dff_rdata_w3_m_scanin[6]
// dff_rdata_w2_m_scanin[6]
// dff_rdata_w1_m_scanin[6]
// dff_rdata_w0_m_scanin[6]
// dff_wdata_m_scanin[87]
// dff_wdata_m_scanin[15]
// dff_rdata_w3_m_scanin[14]
// dff_rdata_w2_m_scanin[14]
// dff_rdata_w1_m_scanin[14]
// dff_rdata_w0_m_scanin[14]
// dff_wdata_m_scanin[79]
// dff_wdata_m_scanin[7]
// dff_rdata_w3_m_scanin[7]
// dff_rdata_w2_m_scanin[7]
// dff_rdata_w1_m_scanin[7]
// dff_rdata_w0_m_scanin[7]
// dff_wdata_m_scanin[88]
// dff_wdata_m_scanin[16]
// dff_rdata_w3_m_scanin[15]
// dff_rdata_w2_m_scanin[15]
// dff_rdata_w1_m_scanin[15]
// dff_rdata_w0_m_scanin[15]
// dff_wdata_m_scanin[98]
// dff_wdata_m_scanin[26]
// dff_rparity_w3_m_scanin[2]
// dff_rparity_w2_m_scanin[2]
// dff_rparity_w1_m_scanin[2]
// dff_rparity_w0_m_scanin[2]
// dff_wdata_m_scanin[107]
// dff_wdata_m_scanin[35]
// dff_rparity_w3_m_scanin[3]
// dff_rparity_w2_m_scanin[3]
// dff_rparity_w1_m_scanin[3]
// dff_rparity_w0_m_scanin[3]
// dff_wdata_m_scanin[90]
// dff_wdata_m_scanin[18]
// dff_rdata_w3_m_scanin[16]
// dff_rdata_w2_m_scanin[16]
// dff_rdata_w1_m_scanin[16]
// dff_rdata_w0_m_scanin[16]
// dff_wdata_m_scanin[99]
// dff_wdata_m_scanin[27]
// dff_rdata_w3_m_scanin[24]
// dff_rdata_w2_m_scanin[24]
// dff_rdata_w1_m_scanin[24]
// dff_rdata_w0_m_scanin[24]
// dff_wdata_m_scanin[91]
// dff_wdata_m_scanin[19]
// dff_rdata_w3_m_scanin[17]
// dff_rdata_w2_m_scanin[17]
// dff_rdata_w1_m_scanin[17]
// dff_rdata_w0_m_scanin[17]
// dff_wdata_m_scanin[100]
// dff_wdata_m_scanin[28]
// dff_rdata_w3_m_scanin[25]
// dff_rdata_w2_m_scanin[25]
// dff_rdata_w1_m_scanin[25]
// dff_rdata_w0_m_scanin[25]
// dff_wdata_m_scanin[92]
// dff_wdata_m_scanin[20]
// dff_rdata_w3_m_scanin[18]
// dff_rdata_w2_m_scanin[18]
// dff_rdata_w1_m_scanin[18]
// dff_rdata_w0_m_scanin[18]
// dff_wdata_m_scanin[101]
// dff_wdata_m_scanin[29]
// dff_rdata_w3_m_scanin[26]
// dff_rdata_w2_m_scanin[26]
// dff_rdata_w1_m_scanin[26]
// dff_rdata_w0_m_scanin[26]
// dff_wdata_m_scanin[93]
// dff_wdata_m_scanin[21]
// dff_rdata_w3_m_scanin[19]
// dff_rdata_w2_m_scanin[19]
// dff_rdata_w1_m_scanin[19]
// dff_rdata_w0_m_scanin[19]
// dff_wdata_m_scanin[102]
// dff_wdata_m_scanin[30]
// dff_rdata_w3_m_scanin[27]
// dff_rdata_w2_m_scanin[27]
// dff_rdata_w1_m_scanin[27]
// dff_rdata_w0_m_scanin[27]
// dff_wdata_m_scanin[94]
// dff_wdata_m_scanin[22]
// dff_rdata_w3_m_scanin[20]
// dff_rdata_w2_m_scanin[20]
// dff_rdata_w1_m_scanin[20]
// dff_rdata_w0_m_scanin[20]
// dff_wdata_m_scanin[103]
// dff_wdata_m_scanin[31]
// dff_rdata_w3_m_scanin[28]
// dff_rdata_w2_m_scanin[28]
// dff_rdata_w1_m_scanin[28]
// dff_rdata_w0_m_scanin[28]
// dff_wdata_m_scanin[95]
// dff_wdata_m_scanin[23]
// dff_rdata_w3_m_scanin[21]
// dff_rdata_w2_m_scanin[21]
// dff_rdata_w1_m_scanin[21]
// dff_rdata_w0_m_scanin[21]
// dff_wdata_m_scanin[104]
// dff_wdata_m_scanin[32]
// dff_rdata_w3_m_scanin[29]
// dff_rdata_w2_m_scanin[29]
// dff_rdata_w1_m_scanin[29]
// dff_rdata_w0_m_scanin[29]
// dff_wdata_m_scanin[96]
// dff_wdata_m_scanin[24]
// dff_rdata_w3_m_scanin[22]
// dff_rdata_w2_m_scanin[22]
// dff_rdata_w1_m_scanin[22]
// dff_rdata_w0_m_scanin[22]
// dff_wdata_m_scanin[105]
// dff_wdata_m_scanin[33]
// dff_rdata_w3_m_scanin[30]
// dff_rdata_w2_m_scanin[30]
// dff_rdata_w1_m_scanin[30]
// dff_rdata_w0_m_scanin[30]
// dff_wdata_m_scanin[97]
// dff_wdata_m_scanin[25]
// dff_rdata_w3_m_scanin[23]
// dff_rdata_w2_m_scanin[23]
// dff_rdata_w1_m_scanin[23]
// dff_rdata_w0_m_scanin[23]
// dff_wdata_m_scanin[106]
// dff_wdata_m_scanin[34]
// dff_rdata_w3_m_scanin[31]
// dff_rdata_w2_m_scanin[31]
// dff_rdata_w1_m_scanin[31]
// dff_rdata_w0_m_scanin[31]
// dff_ctl_m_1_scanin[8]
// dff_ctl_m_1_scanin[0]
// dff_ctl_m_1_scanin[9]
// dff_ctl_m_1_scanin[1]
// dff_ctl_m_1_scanin[10]
// dff_ctl_m_1_scanin[2]
// dff_ctl_m_1_scanin[11]
// dff_ctl_m_1_scanin[3]
// dff_byte_perr_w2_scanin[0]
// dff_byte_perr_w3_scanin[0]
// dff_byte_perr_w3_scanin[1]
// dff_byte_perr_w2_scanin[1]
// dff_byte_perr_w2_scanin[2]
// dff_byte_perr_w3_scanin[2]
// dff_byte_perr_w3_scanin[3]
// dff_byte_perr_w2_scanin[3]
// dff_msb_w3_scanin[7]
// dff_msb_w2_scanin[7]
// dff_msb_w1_scanin[7]
// dff_msb_w0_scanin[7]
// dff_msb_w3_scanin[6]
// dff_msb_w2_scanin[6]
// dff_msb_w1_scanin[6]
// dff_msb_w0_scanin[6]
// dff_msb_w3_scanin[5]
// dff_msb_w2_scanin[5]
// dff_msb_w1_scanin[5]
// dff_msb_w0_scanin[5]
// dff_msb_w3_scanin[4]
// dff_msb_w2_scanin[4]
// dff_msb_w1_scanin[4]
// dff_msb_w0_scanin[4]
// dff_msb_w3_scanin[0]
// dff_msb_w2_scanin[0]
// dff_msb_w1_scanin[0]
// dff_msb_w0_scanin[0]
// dff_msb_w3_scanin[1]
// dff_msb_w2_scanin[1]
// dff_msb_w1_scanin[1]
// dff_msb_w0_scanin[1]
// dff_msb_w3_scanin[2]
// dff_msb_w2_scanin[2]
// dff_msb_w1_scanin[2]
// dff_msb_w0_scanin[2]
// dff_msb_w3_scanin[3]
// dff_msb_w2_scanin[3]
// dff_msb_w1_scanin[3]
// dff_msb_w0_scanin[3]
// dff_red_out_scanin[2]
// dff_red_out_scanin[3]
// dff_red_out_scanin[4]
// dff_red_out_scanin[5]
// dff_red_out_scanin[6]
// dff_red_out_scanin[7]
// dff_red_out_scanin[0]
// dff_red_out_scanin[1]
// dff_red_in_scanin[2]
// dff_red_in_scanin[3]
// dff_red_in_scanin[1]
// dff_red_in_scanin[0]
// dff_red_in_scanin[6]
// dff_red_in_scanin[7]
// dff_red_in_scanin[8]
// dff_red_in_scanin[9]
// dff_red_in_scanin[10]
// dff_red_in_scanin[11]
// dff_red_in_scanin[4]
// dff_red_in_scanin[5]
// scanorder end
// fixscan start
assign dff_byte_perr_w0_scanin[7]=scan_in;
assign dff_byte_perr_w1_scanin[7]=dff_byte_perr_w0_scanout[7];
assign dff_byte_perr_w1_scanin[6]=dff_byte_perr_w1_scanout[7];
assign dff_byte_perr_w0_scanin[6]=dff_byte_perr_w1_scanout[6];
assign dff_byte_perr_w0_scanin[5]=dff_byte_perr_w0_scanout[6];
assign dff_byte_perr_w1_scanin[5]=dff_byte_perr_w0_scanout[5];
assign dff_byte_perr_w1_scanin[4]=dff_byte_perr_w1_scanout[5];
assign dff_byte_perr_w0_scanin[4]=dff_byte_perr_w1_scanout[4];
assign dff_wdata_m_scanin[143]=dff_byte_perr_w0_scanout[4];
assign dff_wdata_m_scanin[71]=dff_wdata_m_scanout[143];
assign dff_rparity_w3_m_scanin[7]=dff_wdata_m_scanout[71];
assign dff_rparity_w2_m_scanin[7]=dff_rparity_w3_m_scanout[7];
assign dff_rparity_w1_m_scanin[7]=dff_rparity_w2_m_scanout[7];
assign dff_rparity_w0_m_scanin[7]=dff_rparity_w1_m_scanout[7];
assign dff_wdata_m_scanin[134]=dff_rparity_w0_m_scanout[7];
assign dff_wdata_m_scanin[62]=dff_wdata_m_scanout[134];
assign dff_rparity_w3_m_scanin[6]=dff_wdata_m_scanout[62];
assign dff_rparity_w2_m_scanin[6]=dff_rparity_w3_m_scanout[6];
assign dff_rparity_w1_m_scanin[6]=dff_rparity_w2_m_scanout[6];
assign dff_rparity_w0_m_scanin[6]=dff_rparity_w1_m_scanout[6];
assign dff_wdata_m_scanin[142]=dff_rparity_w0_m_scanout[6];
assign dff_wdata_m_scanin[70]=dff_wdata_m_scanout[142];
assign dff_rdata_w3_m_scanin[63]=dff_wdata_m_scanout[70];
assign dff_rdata_w2_m_scanin[63]=dff_rdata_w3_m_scanout[63];
assign dff_rdata_w1_m_scanin[63]=dff_rdata_w2_m_scanout[63];
assign dff_rdata_w0_m_scanin[63]=dff_rdata_w1_m_scanout[63];
assign dff_wdata_m_scanin[133]=dff_rdata_w0_m_scanout[63];
assign dff_wdata_m_scanin[61]=dff_wdata_m_scanout[133];
assign dff_rdata_w3_m_scanin[55]=dff_wdata_m_scanout[61];
assign dff_rdata_w2_m_scanin[55]=dff_rdata_w3_m_scanout[55];
assign dff_rdata_w1_m_scanin[55]=dff_rdata_w2_m_scanout[55];
assign dff_rdata_w0_m_scanin[55]=dff_rdata_w1_m_scanout[55];
assign dff_wdata_m_scanin[141]=dff_rdata_w0_m_scanout[55];
assign dff_wdata_m_scanin[69]=dff_wdata_m_scanout[141];
assign dff_rdata_w3_m_scanin[62]=dff_wdata_m_scanout[69];
assign dff_rdata_w2_m_scanin[62]=dff_rdata_w3_m_scanout[62];
assign dff_rdata_w1_m_scanin[62]=dff_rdata_w2_m_scanout[62];
assign dff_rdata_w0_m_scanin[62]=dff_rdata_w1_m_scanout[62];
assign dff_wdata_m_scanin[132]=dff_rdata_w0_m_scanout[62];
assign dff_wdata_m_scanin[60]=dff_wdata_m_scanout[132];
assign dff_rdata_w3_m_scanin[54]=dff_wdata_m_scanout[60];
assign dff_rdata_w2_m_scanin[54]=dff_rdata_w3_m_scanout[54];
assign dff_rdata_w1_m_scanin[54]=dff_rdata_w2_m_scanout[54];
assign dff_rdata_w0_m_scanin[54]=dff_rdata_w1_m_scanout[54];
assign dff_wdata_m_scanin[140]=dff_rdata_w0_m_scanout[54];
assign dff_wdata_m_scanin[68]=dff_wdata_m_scanout[140];
assign dff_rdata_w3_m_scanin[61]=dff_wdata_m_scanout[68];
assign dff_rdata_w2_m_scanin[61]=dff_rdata_w3_m_scanout[61];
assign dff_rdata_w1_m_scanin[61]=dff_rdata_w2_m_scanout[61];
assign dff_rdata_w0_m_scanin[61]=dff_rdata_w1_m_scanout[61];
assign dff_wdata_m_scanin[131]=dff_rdata_w0_m_scanout[61];
assign dff_wdata_m_scanin[59]=dff_wdata_m_scanout[131];
assign dff_rdata_w3_m_scanin[53]=dff_wdata_m_scanout[59];
assign dff_rdata_w2_m_scanin[53]=dff_rdata_w3_m_scanout[53];
assign dff_rdata_w1_m_scanin[53]=dff_rdata_w2_m_scanout[53];
assign dff_rdata_w0_m_scanin[53]=dff_rdata_w1_m_scanout[53];
assign dff_wdata_m_scanin[139]=dff_rdata_w0_m_scanout[53];
assign dff_wdata_m_scanin[67]=dff_wdata_m_scanout[139];
assign dff_rdata_w3_m_scanin[60]=dff_wdata_m_scanout[67];
assign dff_rdata_w2_m_scanin[60]=dff_rdata_w3_m_scanout[60];
assign dff_rdata_w1_m_scanin[60]=dff_rdata_w2_m_scanout[60];
assign dff_rdata_w0_m_scanin[60]=dff_rdata_w1_m_scanout[60];
assign dff_wdata_m_scanin[130]=dff_rdata_w0_m_scanout[60];
assign dff_wdata_m_scanin[58]=dff_wdata_m_scanout[130];
assign dff_rdata_w3_m_scanin[52]=dff_wdata_m_scanout[58];
assign dff_rdata_w2_m_scanin[52]=dff_rdata_w3_m_scanout[52];
assign dff_rdata_w1_m_scanin[52]=dff_rdata_w2_m_scanout[52];
assign dff_rdata_w0_m_scanin[52]=dff_rdata_w1_m_scanout[52];
assign dff_wdata_m_scanin[138]=dff_rdata_w0_m_scanout[52];
assign dff_wdata_m_scanin[66]=dff_wdata_m_scanout[138];
assign dff_rdata_w3_m_scanin[59]=dff_wdata_m_scanout[66];
assign dff_rdata_w2_m_scanin[59]=dff_rdata_w3_m_scanout[59];
assign dff_rdata_w1_m_scanin[59]=dff_rdata_w2_m_scanout[59];
assign dff_rdata_w0_m_scanin[59]=dff_rdata_w1_m_scanout[59];
assign dff_wdata_m_scanin[129]=dff_rdata_w0_m_scanout[59];
assign dff_wdata_m_scanin[57]=dff_wdata_m_scanout[129];
assign dff_rdata_w3_m_scanin[51]=dff_wdata_m_scanout[57];
assign dff_rdata_w2_m_scanin[51]=dff_rdata_w3_m_scanout[51];
assign dff_rdata_w1_m_scanin[51]=dff_rdata_w2_m_scanout[51];
assign dff_rdata_w0_m_scanin[51]=dff_rdata_w1_m_scanout[51];
assign dff_wdata_m_scanin[137]=dff_rdata_w0_m_scanout[51];
assign dff_wdata_m_scanin[65]=dff_wdata_m_scanout[137];
assign dff_rdata_w3_m_scanin[58]=dff_wdata_m_scanout[65];
assign dff_rdata_w2_m_scanin[58]=dff_rdata_w3_m_scanout[58];
assign dff_rdata_w1_m_scanin[58]=dff_rdata_w2_m_scanout[58];
assign dff_rdata_w0_m_scanin[58]=dff_rdata_w1_m_scanout[58];
assign dff_wdata_m_scanin[128]=dff_rdata_w0_m_scanout[58];
assign dff_wdata_m_scanin[56]=dff_wdata_m_scanout[128];
assign dff_rdata_w3_m_scanin[50]=dff_wdata_m_scanout[56];
assign dff_rdata_w2_m_scanin[50]=dff_rdata_w3_m_scanout[50];
assign dff_rdata_w1_m_scanin[50]=dff_rdata_w2_m_scanout[50];
assign dff_rdata_w0_m_scanin[50]=dff_rdata_w1_m_scanout[50];
assign dff_wdata_m_scanin[136]=dff_rdata_w0_m_scanout[50];
assign dff_wdata_m_scanin[64]=dff_wdata_m_scanout[136];
assign dff_rdata_w3_m_scanin[57]=dff_wdata_m_scanout[64];
assign dff_rdata_w2_m_scanin[57]=dff_rdata_w3_m_scanout[57];
assign dff_rdata_w1_m_scanin[57]=dff_rdata_w2_m_scanout[57];
assign dff_rdata_w0_m_scanin[57]=dff_rdata_w1_m_scanout[57];
assign dff_wdata_m_scanin[127]=dff_rdata_w0_m_scanout[57];
assign dff_wdata_m_scanin[55]=dff_wdata_m_scanout[127];
assign dff_rdata_w3_m_scanin[49]=dff_wdata_m_scanout[55];
assign dff_rdata_w2_m_scanin[49]=dff_rdata_w3_m_scanout[49];
assign dff_rdata_w1_m_scanin[49]=dff_rdata_w2_m_scanout[49];
assign dff_rdata_w0_m_scanin[49]=dff_rdata_w1_m_scanout[49];
assign dff_wdata_m_scanin[135]=dff_rdata_w0_m_scanout[49];
assign dff_wdata_m_scanin[63]=dff_wdata_m_scanout[135];
assign dff_rdata_w3_m_scanin[56]=dff_wdata_m_scanout[63];
assign dff_rdata_w2_m_scanin[56]=dff_rdata_w3_m_scanout[56];
assign dff_rdata_w1_m_scanin[56]=dff_rdata_w2_m_scanout[56];
assign dff_rdata_w0_m_scanin[56]=dff_rdata_w1_m_scanout[56];
assign dff_wdata_m_scanin[126]=dff_rdata_w0_m_scanout[56];
assign dff_wdata_m_scanin[54]=dff_wdata_m_scanout[126];
assign dff_rdata_w3_m_scanin[48]=dff_wdata_m_scanout[54];
assign dff_rdata_w2_m_scanin[48]=dff_rdata_w3_m_scanout[48];
assign dff_rdata_w1_m_scanin[48]=dff_rdata_w2_m_scanout[48];
assign dff_rdata_w0_m_scanin[48]=dff_rdata_w1_m_scanout[48];
assign dff_wdata_m_scanin[125]=dff_rdata_w0_m_scanout[48];
assign dff_wdata_m_scanin[53]=dff_wdata_m_scanout[125];
assign dff_rparity_w3_m_scanin[5]=dff_wdata_m_scanout[53];
assign dff_rparity_w2_m_scanin[5]=dff_rparity_w3_m_scanout[5];
assign dff_rparity_w1_m_scanin[5]=dff_rparity_w2_m_scanout[5];
assign dff_rparity_w0_m_scanin[5]=dff_rparity_w1_m_scanout[5];
assign dff_wdata_m_scanin[116]=dff_rparity_w0_m_scanout[5];
assign dff_wdata_m_scanin[44]=dff_wdata_m_scanout[116];
assign dff_rparity_w3_m_scanin[4]=dff_wdata_m_scanout[44];
assign dff_rparity_w2_m_scanin[4]=dff_rparity_w3_m_scanout[4];
assign dff_rparity_w1_m_scanin[4]=dff_rparity_w2_m_scanout[4];
assign dff_rparity_w0_m_scanin[4]=dff_rparity_w1_m_scanout[4];
assign dff_wdata_m_scanin[124]=dff_rparity_w0_m_scanout[4];
assign dff_wdata_m_scanin[52]=dff_wdata_m_scanout[124];
assign dff_rdata_w3_m_scanin[47]=dff_wdata_m_scanout[52];
assign dff_rdata_w2_m_scanin[47]=dff_rdata_w3_m_scanout[47];
assign dff_rdata_w1_m_scanin[47]=dff_rdata_w2_m_scanout[47];
assign dff_rdata_w0_m_scanin[47]=dff_rdata_w1_m_scanout[47];
assign dff_wdata_m_scanin[115]=dff_rdata_w0_m_scanout[47];
assign dff_wdata_m_scanin[43]=dff_wdata_m_scanout[115];
assign dff_rdata_w3_m_scanin[39]=dff_wdata_m_scanout[43];
assign dff_rdata_w2_m_scanin[39]=dff_rdata_w3_m_scanout[39];
assign dff_rdata_w1_m_scanin[39]=dff_rdata_w2_m_scanout[39];
assign dff_rdata_w0_m_scanin[39]=dff_rdata_w1_m_scanout[39];
assign dff_wdata_m_scanin[123]=dff_rdata_w0_m_scanout[39];
assign dff_wdata_m_scanin[51]=dff_wdata_m_scanout[123];
assign dff_rdata_w3_m_scanin[46]=dff_wdata_m_scanout[51];
assign dff_rdata_w2_m_scanin[46]=dff_rdata_w3_m_scanout[46];
assign dff_rdata_w1_m_scanin[46]=dff_rdata_w2_m_scanout[46];
assign dff_rdata_w0_m_scanin[46]=dff_rdata_w1_m_scanout[46];
assign dff_wdata_m_scanin[114]=dff_rdata_w0_m_scanout[46];
assign dff_wdata_m_scanin[42]=dff_wdata_m_scanout[114];
assign dff_rdata_w3_m_scanin[38]=dff_wdata_m_scanout[42];
assign dff_rdata_w2_m_scanin[38]=dff_rdata_w3_m_scanout[38];
assign dff_rdata_w1_m_scanin[38]=dff_rdata_w2_m_scanout[38];
assign dff_rdata_w0_m_scanin[38]=dff_rdata_w1_m_scanout[38];
assign dff_wdata_m_scanin[122]=dff_rdata_w0_m_scanout[38];
assign dff_wdata_m_scanin[50]=dff_wdata_m_scanout[122];
assign dff_rdata_w3_m_scanin[45]=dff_wdata_m_scanout[50];
assign dff_rdata_w2_m_scanin[45]=dff_rdata_w3_m_scanout[45];
assign dff_rdata_w1_m_scanin[45]=dff_rdata_w2_m_scanout[45];
assign dff_rdata_w0_m_scanin[45]=dff_rdata_w1_m_scanout[45];
assign dff_wdata_m_scanin[113]=dff_rdata_w0_m_scanout[45];
assign dff_wdata_m_scanin[41]=dff_wdata_m_scanout[113];
assign dff_rdata_w3_m_scanin[37]=dff_wdata_m_scanout[41];
assign dff_rdata_w2_m_scanin[37]=dff_rdata_w3_m_scanout[37];
assign dff_rdata_w1_m_scanin[37]=dff_rdata_w2_m_scanout[37];
assign dff_rdata_w0_m_scanin[37]=dff_rdata_w1_m_scanout[37];
assign dff_wdata_m_scanin[121]=dff_rdata_w0_m_scanout[37];
assign dff_wdata_m_scanin[49]=dff_wdata_m_scanout[121];
assign dff_rdata_w3_m_scanin[44]=dff_wdata_m_scanout[49];
assign dff_rdata_w2_m_scanin[44]=dff_rdata_w3_m_scanout[44];
assign dff_rdata_w1_m_scanin[44]=dff_rdata_w2_m_scanout[44];
assign dff_rdata_w0_m_scanin[44]=dff_rdata_w1_m_scanout[44];
assign dff_wdata_m_scanin[112]=dff_rdata_w0_m_scanout[44];
assign dff_wdata_m_scanin[40]=dff_wdata_m_scanout[112];
assign dff_rdata_w3_m_scanin[36]=dff_wdata_m_scanout[40];
assign dff_rdata_w2_m_scanin[36]=dff_rdata_w3_m_scanout[36];
assign dff_rdata_w1_m_scanin[36]=dff_rdata_w2_m_scanout[36];
assign dff_rdata_w0_m_scanin[36]=dff_rdata_w1_m_scanout[36];
assign dff_wdata_m_scanin[120]=dff_rdata_w0_m_scanout[36];
assign dff_wdata_m_scanin[48]=dff_wdata_m_scanout[120];
assign dff_rdata_w3_m_scanin[43]=dff_wdata_m_scanout[48];
assign dff_rdata_w2_m_scanin[43]=dff_rdata_w3_m_scanout[43];
assign dff_rdata_w1_m_scanin[43]=dff_rdata_w2_m_scanout[43];
assign dff_rdata_w0_m_scanin[43]=dff_rdata_w1_m_scanout[43];
assign dff_wdata_m_scanin[111]=dff_rdata_w0_m_scanout[43];
assign dff_wdata_m_scanin[39]=dff_wdata_m_scanout[111];
assign dff_rdata_w3_m_scanin[35]=dff_wdata_m_scanout[39];
assign dff_rdata_w2_m_scanin[35]=dff_rdata_w3_m_scanout[35];
assign dff_rdata_w1_m_scanin[35]=dff_rdata_w2_m_scanout[35];
assign dff_rdata_w0_m_scanin[35]=dff_rdata_w1_m_scanout[35];
assign dff_wdata_m_scanin[119]=dff_rdata_w0_m_scanout[35];
assign dff_wdata_m_scanin[47]=dff_wdata_m_scanout[119];
assign dff_rdata_w3_m_scanin[42]=dff_wdata_m_scanout[47];
assign dff_rdata_w2_m_scanin[42]=dff_rdata_w3_m_scanout[42];
assign dff_rdata_w1_m_scanin[42]=dff_rdata_w2_m_scanout[42];
assign dff_rdata_w0_m_scanin[42]=dff_rdata_w1_m_scanout[42];
assign dff_wdata_m_scanin[110]=dff_rdata_w0_m_scanout[42];
assign dff_wdata_m_scanin[38]=dff_wdata_m_scanout[110];
assign dff_rdata_w3_m_scanin[34]=dff_wdata_m_scanout[38];
assign dff_rdata_w2_m_scanin[34]=dff_rdata_w3_m_scanout[34];
assign dff_rdata_w1_m_scanin[34]=dff_rdata_w2_m_scanout[34];
assign dff_rdata_w0_m_scanin[34]=dff_rdata_w1_m_scanout[34];
assign dff_wdata_m_scanin[118]=dff_rdata_w0_m_scanout[34];
assign dff_wdata_m_scanin[46]=dff_wdata_m_scanout[118];
assign dff_rdata_w3_m_scanin[41]=dff_wdata_m_scanout[46];
assign dff_rdata_w2_m_scanin[41]=dff_rdata_w3_m_scanout[41];
assign dff_rdata_w1_m_scanin[41]=dff_rdata_w2_m_scanout[41];
assign dff_rdata_w0_m_scanin[41]=dff_rdata_w1_m_scanout[41];
assign dff_wdata_m_scanin[109]=dff_rdata_w0_m_scanout[41];
assign dff_wdata_m_scanin[37]=dff_wdata_m_scanout[109];
assign dff_rdata_w3_m_scanin[33]=dff_wdata_m_scanout[37];
assign dff_rdata_w2_m_scanin[33]=dff_rdata_w3_m_scanout[33];
assign dff_rdata_w1_m_scanin[33]=dff_rdata_w2_m_scanout[33];
assign dff_rdata_w0_m_scanin[33]=dff_rdata_w1_m_scanout[33];
assign dff_wdata_m_scanin[117]=dff_rdata_w0_m_scanout[33];
assign dff_wdata_m_scanin[45]=dff_wdata_m_scanout[117];
assign dff_rdata_w3_m_scanin[40]=dff_wdata_m_scanout[45];
assign dff_rdata_w2_m_scanin[40]=dff_rdata_w3_m_scanout[40];
assign dff_rdata_w1_m_scanin[40]=dff_rdata_w2_m_scanout[40];
assign dff_rdata_w0_m_scanin[40]=dff_rdata_w1_m_scanout[40];
assign dff_wdata_m_scanin[108]=dff_rdata_w0_m_scanout[40];
assign dff_wdata_m_scanin[36]=dff_wdata_m_scanout[108];
assign dff_rdata_w3_m_scanin[32]=dff_wdata_m_scanout[36];
assign dff_rdata_w2_m_scanin[32]=dff_rdata_w3_m_scanout[32];
assign dff_rdata_w1_m_scanin[32]=dff_rdata_w2_m_scanout[32];
assign dff_rdata_w0_m_scanin[32]=dff_rdata_w1_m_scanout[32];
assign dff_ctl_m_1_scanin[15]=dff_rdata_w0_m_scanout[32];
assign dff_ctl_m_1_scanin[7]=dff_ctl_m_1_scanout[15];
assign dff_ctl_m_1_scanin[14]=dff_ctl_m_1_scanout[7];
assign dff_ctl_m_1_scanin[6]=dff_ctl_m_1_scanout[14];
assign dff_ctl_m_1_scanin[13]=dff_ctl_m_1_scanout[6];
assign dff_ctl_m_1_scanin[5]=dff_ctl_m_1_scanout[13];
assign dff_ctl_m_1_scanin[12]=dff_ctl_m_1_scanout[5];
assign dff_ctl_m_1_scanin[4]=dff_ctl_m_1_scanout[12];
assign dff_byte_perr_w2_scanin[7]=dff_ctl_m_1_scanout[4];
assign dff_byte_perr_w3_scanin[7]=dff_byte_perr_w2_scanout[7];
assign dff_byte_perr_w3_scanin[6]=dff_byte_perr_w3_scanout[7];
assign dff_byte_perr_w2_scanin[6]=dff_byte_perr_w3_scanout[6];
assign dff_byte_perr_w2_scanin[5]=dff_byte_perr_w2_scanout[6];
assign dff_byte_perr_w3_scanin[5]=dff_byte_perr_w2_scanout[5];
assign dff_byte_perr_w3_scanin[4]=dff_byte_perr_w3_scanout[5];
assign dff_byte_perr_w2_scanin[4]=dff_byte_perr_w3_scanout[4];
assign dff_ctl_m_0_scanin[0]=dff_byte_perr_w2_scanout[4];
assign dff_ctl_b_scanin[4]=dff_ctl_m_0_scanout[0];
assign dff_ctl_b_scanin[0]=dff_ctl_b_scanout[4];
assign dff_ctl_b_scanin[1]=dff_ctl_b_scanout[0];
assign dff_ctl_b_scanin[2]=dff_ctl_b_scanout[1];
assign dff_ctl_b_scanin[3]=dff_ctl_b_scanout[2];
assign lat_ctl_eb_scanin[6]=dff_ctl_b_scanout[3];
assign lat_ctl_eb_scanin[1]=lat_ctl_eb_scanout[6];
assign lat_ctl_eb_scanin[0]=lat_ctl_eb_scanout[1];
assign lat_ctl_eb_scanin[2]=lat_ctl_eb_scanout[0];
assign lat_ctl_eb_scanin[3]=lat_ctl_eb_scanout[2];
assign lat_addr_scanin[1]=lat_ctl_eb_scanout[3];
assign lat_addr_scanin[0]=lat_addr_scanout[1];
assign lat_addr_scanin[7]=lat_addr_scanout[0];
assign lat_addr_scanin[6]=lat_addr_scanout[7];
assign lat_addr_scanin[5]=lat_addr_scanout[6];
assign lat_addr_scanin[4]=lat_addr_scanout[5];
assign lat_addr_scanin[3]=lat_addr_scanout[4];
assign lat_addr_scanin[2]=lat_addr_scanout[3];
assign lat_ctl_eb_scanin[4]=lat_addr_scanout[2];
assign dff_ctl_m_0_scanin[1]=lat_ctl_eb_scanout[4];
assign dff_ctl_m_0_scanin[2]=dff_ctl_m_0_scanout[1];
assign lat_ctl_eb_scanin[5]=dff_ctl_m_0_scanout[2];
assign dff_byte_perr_w0_scanin[0]=lat_ctl_eb_scanout[5];
assign dff_byte_perr_w1_scanin[0]=dff_byte_perr_w0_scanout[0];
assign dff_byte_perr_w1_scanin[1]=dff_byte_perr_w1_scanout[0];
assign dff_byte_perr_w0_scanin[1]=dff_byte_perr_w1_scanout[1];
assign dff_byte_perr_w0_scanin[2]=dff_byte_perr_w0_scanout[1];
assign dff_byte_perr_w1_scanin[2]=dff_byte_perr_w0_scanout[2];
assign dff_byte_perr_w1_scanin[3]=dff_byte_perr_w1_scanout[2];
assign dff_byte_perr_w0_scanin[3]=dff_byte_perr_w1_scanout[3];
assign dff_wdata_m_scanin[80]=dff_byte_perr_w0_scanout[3];
assign dff_wdata_m_scanin[8]=dff_wdata_m_scanout[80];
assign dff_rparity_w3_m_scanin[0]=dff_wdata_m_scanout[8];
assign dff_rparity_w2_m_scanin[0]=dff_rparity_w3_m_scanout[0];
assign dff_rparity_w1_m_scanin[0]=dff_rparity_w2_m_scanout[0];
assign dff_rparity_w0_m_scanin[0]=dff_rparity_w1_m_scanout[0];
assign dff_wdata_m_scanin[89]=dff_rparity_w0_m_scanout[0];
assign dff_wdata_m_scanin[17]=dff_wdata_m_scanout[89];
assign dff_rparity_w3_m_scanin[1]=dff_wdata_m_scanout[17];
assign dff_rparity_w2_m_scanin[1]=dff_rparity_w3_m_scanout[1];
assign dff_rparity_w1_m_scanin[1]=dff_rparity_w2_m_scanout[1];
assign dff_rparity_w0_m_scanin[1]=dff_rparity_w1_m_scanout[1];
assign dff_wdata_m_scanin[72]=dff_rparity_w0_m_scanout[1];
assign dff_wdata_m_scanin[0]=dff_wdata_m_scanout[72];
assign dff_rdata_w3_m_scanin[0]=dff_wdata_m_scanout[0];
assign dff_rdata_w2_m_scanin[0]=dff_rdata_w3_m_scanout[0];
assign dff_rdata_w1_m_scanin[0]=dff_rdata_w2_m_scanout[0];
assign dff_rdata_w0_m_scanin[0]=dff_rdata_w1_m_scanout[0];
assign dff_wdata_m_scanin[81]=dff_rdata_w0_m_scanout[0];
assign dff_wdata_m_scanin[9]=dff_wdata_m_scanout[81];
assign dff_rdata_w3_m_scanin[8]=dff_wdata_m_scanout[9];
assign dff_rdata_w2_m_scanin[8]=dff_rdata_w3_m_scanout[8];
assign dff_rdata_w1_m_scanin[8]=dff_rdata_w2_m_scanout[8];
assign dff_rdata_w0_m_scanin[8]=dff_rdata_w1_m_scanout[8];
assign dff_wdata_m_scanin[73]=dff_rdata_w0_m_scanout[8];
assign dff_wdata_m_scanin[1]=dff_wdata_m_scanout[73];
assign dff_rdata_w3_m_scanin[1]=dff_wdata_m_scanout[1];
assign dff_rdata_w2_m_scanin[1]=dff_rdata_w3_m_scanout[1];
assign dff_rdata_w1_m_scanin[1]=dff_rdata_w2_m_scanout[1];
assign dff_rdata_w0_m_scanin[1]=dff_rdata_w1_m_scanout[1];
assign dff_wdata_m_scanin[82]=dff_rdata_w0_m_scanout[1];
assign dff_wdata_m_scanin[10]=dff_wdata_m_scanout[82];
assign dff_rdata_w3_m_scanin[9]=dff_wdata_m_scanout[10];
assign dff_rdata_w2_m_scanin[9]=dff_rdata_w3_m_scanout[9];
assign dff_rdata_w1_m_scanin[9]=dff_rdata_w2_m_scanout[9];
assign dff_rdata_w0_m_scanin[9]=dff_rdata_w1_m_scanout[9];
assign dff_wdata_m_scanin[74]=dff_rdata_w0_m_scanout[9];
assign dff_wdata_m_scanin[2]=dff_wdata_m_scanout[74];
assign dff_rdata_w3_m_scanin[2]=dff_wdata_m_scanout[2];
assign dff_rdata_w2_m_scanin[2]=dff_rdata_w3_m_scanout[2];
assign dff_rdata_w1_m_scanin[2]=dff_rdata_w2_m_scanout[2];
assign dff_rdata_w0_m_scanin[2]=dff_rdata_w1_m_scanout[2];
assign dff_wdata_m_scanin[83]=dff_rdata_w0_m_scanout[2];
assign dff_wdata_m_scanin[11]=dff_wdata_m_scanout[83];
assign dff_rdata_w3_m_scanin[10]=dff_wdata_m_scanout[11];
assign dff_rdata_w2_m_scanin[10]=dff_rdata_w3_m_scanout[10];
assign dff_rdata_w1_m_scanin[10]=dff_rdata_w2_m_scanout[10];
assign dff_rdata_w0_m_scanin[10]=dff_rdata_w1_m_scanout[10];
assign dff_wdata_m_scanin[75]=dff_rdata_w0_m_scanout[10];
assign dff_wdata_m_scanin[3]=dff_wdata_m_scanout[75];
assign dff_rdata_w3_m_scanin[3]=dff_wdata_m_scanout[3];
assign dff_rdata_w2_m_scanin[3]=dff_rdata_w3_m_scanout[3];
assign dff_rdata_w1_m_scanin[3]=dff_rdata_w2_m_scanout[3];
assign dff_rdata_w0_m_scanin[3]=dff_rdata_w1_m_scanout[3];
assign dff_wdata_m_scanin[84]=dff_rdata_w0_m_scanout[3];
assign dff_wdata_m_scanin[12]=dff_wdata_m_scanout[84];
assign dff_rdata_w3_m_scanin[11]=dff_wdata_m_scanout[12];
assign dff_rdata_w2_m_scanin[11]=dff_rdata_w3_m_scanout[11];
assign dff_rdata_w1_m_scanin[11]=dff_rdata_w2_m_scanout[11];
assign dff_rdata_w0_m_scanin[11]=dff_rdata_w1_m_scanout[11];
assign dff_wdata_m_scanin[76]=dff_rdata_w0_m_scanout[11];
assign dff_wdata_m_scanin[4]=dff_wdata_m_scanout[76];
assign dff_rdata_w3_m_scanin[4]=dff_wdata_m_scanout[4];
assign dff_rdata_w2_m_scanin[4]=dff_rdata_w3_m_scanout[4];
assign dff_rdata_w1_m_scanin[4]=dff_rdata_w2_m_scanout[4];
assign dff_rdata_w0_m_scanin[4]=dff_rdata_w1_m_scanout[4];
assign dff_wdata_m_scanin[85]=dff_rdata_w0_m_scanout[4];
assign dff_wdata_m_scanin[13]=dff_wdata_m_scanout[85];
assign dff_rdata_w3_m_scanin[12]=dff_wdata_m_scanout[13];
assign dff_rdata_w2_m_scanin[12]=dff_rdata_w3_m_scanout[12];
assign dff_rdata_w1_m_scanin[12]=dff_rdata_w2_m_scanout[12];
assign dff_rdata_w0_m_scanin[12]=dff_rdata_w1_m_scanout[12];
assign dff_wdata_m_scanin[77]=dff_rdata_w0_m_scanout[12];
assign dff_wdata_m_scanin[5]=dff_wdata_m_scanout[77];
assign dff_rdata_w3_m_scanin[5]=dff_wdata_m_scanout[5];
assign dff_rdata_w2_m_scanin[5]=dff_rdata_w3_m_scanout[5];
assign dff_rdata_w1_m_scanin[5]=dff_rdata_w2_m_scanout[5];
assign dff_rdata_w0_m_scanin[5]=dff_rdata_w1_m_scanout[5];
assign dff_wdata_m_scanin[86]=dff_rdata_w0_m_scanout[5];
assign dff_wdata_m_scanin[14]=dff_wdata_m_scanout[86];
assign dff_rdata_w3_m_scanin[13]=dff_wdata_m_scanout[14];
assign dff_rdata_w2_m_scanin[13]=dff_rdata_w3_m_scanout[13];
assign dff_rdata_w1_m_scanin[13]=dff_rdata_w2_m_scanout[13];
assign dff_rdata_w0_m_scanin[13]=dff_rdata_w1_m_scanout[13];
assign dff_wdata_m_scanin[78]=dff_rdata_w0_m_scanout[13];
assign dff_wdata_m_scanin[6]=dff_wdata_m_scanout[78];
assign dff_rdata_w3_m_scanin[6]=dff_wdata_m_scanout[6];
assign dff_rdata_w2_m_scanin[6]=dff_rdata_w3_m_scanout[6];
assign dff_rdata_w1_m_scanin[6]=dff_rdata_w2_m_scanout[6];
assign dff_rdata_w0_m_scanin[6]=dff_rdata_w1_m_scanout[6];
assign dff_wdata_m_scanin[87]=dff_rdata_w0_m_scanout[6];
assign dff_wdata_m_scanin[15]=dff_wdata_m_scanout[87];
assign dff_rdata_w3_m_scanin[14]=dff_wdata_m_scanout[15];
assign dff_rdata_w2_m_scanin[14]=dff_rdata_w3_m_scanout[14];
assign dff_rdata_w1_m_scanin[14]=dff_rdata_w2_m_scanout[14];
assign dff_rdata_w0_m_scanin[14]=dff_rdata_w1_m_scanout[14];
assign dff_wdata_m_scanin[79]=dff_rdata_w0_m_scanout[14];
assign dff_wdata_m_scanin[7]=dff_wdata_m_scanout[79];
assign dff_rdata_w3_m_scanin[7]=dff_wdata_m_scanout[7];
assign dff_rdata_w2_m_scanin[7]=dff_rdata_w3_m_scanout[7];
assign dff_rdata_w1_m_scanin[7]=dff_rdata_w2_m_scanout[7];
assign dff_rdata_w0_m_scanin[7]=dff_rdata_w1_m_scanout[7];
assign dff_wdata_m_scanin[88]=dff_rdata_w0_m_scanout[7];
assign dff_wdata_m_scanin[16]=dff_wdata_m_scanout[88];
assign dff_rdata_w3_m_scanin[15]=dff_wdata_m_scanout[16];
assign dff_rdata_w2_m_scanin[15]=dff_rdata_w3_m_scanout[15];
assign dff_rdata_w1_m_scanin[15]=dff_rdata_w2_m_scanout[15];
assign dff_rdata_w0_m_scanin[15]=dff_rdata_w1_m_scanout[15];
assign dff_wdata_m_scanin[98]=dff_rdata_w0_m_scanout[15];
assign dff_wdata_m_scanin[26]=dff_wdata_m_scanout[98];
assign dff_rparity_w3_m_scanin[2]=dff_wdata_m_scanout[26];
assign dff_rparity_w2_m_scanin[2]=dff_rparity_w3_m_scanout[2];
assign dff_rparity_w1_m_scanin[2]=dff_rparity_w2_m_scanout[2];
assign dff_rparity_w0_m_scanin[2]=dff_rparity_w1_m_scanout[2];
assign dff_wdata_m_scanin[107]=dff_rparity_w0_m_scanout[2];
assign dff_wdata_m_scanin[35]=dff_wdata_m_scanout[107];
assign dff_rparity_w3_m_scanin[3]=dff_wdata_m_scanout[35];
assign dff_rparity_w2_m_scanin[3]=dff_rparity_w3_m_scanout[3];
assign dff_rparity_w1_m_scanin[3]=dff_rparity_w2_m_scanout[3];
assign dff_rparity_w0_m_scanin[3]=dff_rparity_w1_m_scanout[3];
assign dff_wdata_m_scanin[90]=dff_rparity_w0_m_scanout[3];
assign dff_wdata_m_scanin[18]=dff_wdata_m_scanout[90];
assign dff_rdata_w3_m_scanin[16]=dff_wdata_m_scanout[18];
assign dff_rdata_w2_m_scanin[16]=dff_rdata_w3_m_scanout[16];
assign dff_rdata_w1_m_scanin[16]=dff_rdata_w2_m_scanout[16];
assign dff_rdata_w0_m_scanin[16]=dff_rdata_w1_m_scanout[16];
assign dff_wdata_m_scanin[99]=dff_rdata_w0_m_scanout[16];
assign dff_wdata_m_scanin[27]=dff_wdata_m_scanout[99];
assign dff_rdata_w3_m_scanin[24]=dff_wdata_m_scanout[27];
assign dff_rdata_w2_m_scanin[24]=dff_rdata_w3_m_scanout[24];
assign dff_rdata_w1_m_scanin[24]=dff_rdata_w2_m_scanout[24];
assign dff_rdata_w0_m_scanin[24]=dff_rdata_w1_m_scanout[24];
assign dff_wdata_m_scanin[91]=dff_rdata_w0_m_scanout[24];
assign dff_wdata_m_scanin[19]=dff_wdata_m_scanout[91];
assign dff_rdata_w3_m_scanin[17]=dff_wdata_m_scanout[19];
assign dff_rdata_w2_m_scanin[17]=dff_rdata_w3_m_scanout[17];
assign dff_rdata_w1_m_scanin[17]=dff_rdata_w2_m_scanout[17];
assign dff_rdata_w0_m_scanin[17]=dff_rdata_w1_m_scanout[17];
assign dff_wdata_m_scanin[100]=dff_rdata_w0_m_scanout[17];
assign dff_wdata_m_scanin[28]=dff_wdata_m_scanout[100];
assign dff_rdata_w3_m_scanin[25]=dff_wdata_m_scanout[28];
assign dff_rdata_w2_m_scanin[25]=dff_rdata_w3_m_scanout[25];
assign dff_rdata_w1_m_scanin[25]=dff_rdata_w2_m_scanout[25];
assign dff_rdata_w0_m_scanin[25]=dff_rdata_w1_m_scanout[25];
assign dff_wdata_m_scanin[92]=dff_rdata_w0_m_scanout[25];
assign dff_wdata_m_scanin[20]=dff_wdata_m_scanout[92];
assign dff_rdata_w3_m_scanin[18]=dff_wdata_m_scanout[20];
assign dff_rdata_w2_m_scanin[18]=dff_rdata_w3_m_scanout[18];
assign dff_rdata_w1_m_scanin[18]=dff_rdata_w2_m_scanout[18];
assign dff_rdata_w0_m_scanin[18]=dff_rdata_w1_m_scanout[18];
assign dff_wdata_m_scanin[101]=dff_rdata_w0_m_scanout[18];
assign dff_wdata_m_scanin[29]=dff_wdata_m_scanout[101];
assign dff_rdata_w3_m_scanin[26]=dff_wdata_m_scanout[29];
assign dff_rdata_w2_m_scanin[26]=dff_rdata_w3_m_scanout[26];
assign dff_rdata_w1_m_scanin[26]=dff_rdata_w2_m_scanout[26];
assign dff_rdata_w0_m_scanin[26]=dff_rdata_w1_m_scanout[26];
assign dff_wdata_m_scanin[93]=dff_rdata_w0_m_scanout[26];
assign dff_wdata_m_scanin[21]=dff_wdata_m_scanout[93];
assign dff_rdata_w3_m_scanin[19]=dff_wdata_m_scanout[21];
assign dff_rdata_w2_m_scanin[19]=dff_rdata_w3_m_scanout[19];
assign dff_rdata_w1_m_scanin[19]=dff_rdata_w2_m_scanout[19];
assign dff_rdata_w0_m_scanin[19]=dff_rdata_w1_m_scanout[19];
assign dff_wdata_m_scanin[102]=dff_rdata_w0_m_scanout[19];
assign dff_wdata_m_scanin[30]=dff_wdata_m_scanout[102];
assign dff_rdata_w3_m_scanin[27]=dff_wdata_m_scanout[30];
assign dff_rdata_w2_m_scanin[27]=dff_rdata_w3_m_scanout[27];
assign dff_rdata_w1_m_scanin[27]=dff_rdata_w2_m_scanout[27];
assign dff_rdata_w0_m_scanin[27]=dff_rdata_w1_m_scanout[27];
assign dff_wdata_m_scanin[94]=dff_rdata_w0_m_scanout[27];
assign dff_wdata_m_scanin[22]=dff_wdata_m_scanout[94];
assign dff_rdata_w3_m_scanin[20]=dff_wdata_m_scanout[22];
assign dff_rdata_w2_m_scanin[20]=dff_rdata_w3_m_scanout[20];
assign dff_rdata_w1_m_scanin[20]=dff_rdata_w2_m_scanout[20];
assign dff_rdata_w0_m_scanin[20]=dff_rdata_w1_m_scanout[20];
assign dff_wdata_m_scanin[103]=dff_rdata_w0_m_scanout[20];
assign dff_wdata_m_scanin[31]=dff_wdata_m_scanout[103];
assign dff_rdata_w3_m_scanin[28]=dff_wdata_m_scanout[31];
assign dff_rdata_w2_m_scanin[28]=dff_rdata_w3_m_scanout[28];
assign dff_rdata_w1_m_scanin[28]=dff_rdata_w2_m_scanout[28];
assign dff_rdata_w0_m_scanin[28]=dff_rdata_w1_m_scanout[28];
assign dff_wdata_m_scanin[95]=dff_rdata_w0_m_scanout[28];
assign dff_wdata_m_scanin[23]=dff_wdata_m_scanout[95];
assign dff_rdata_w3_m_scanin[21]=dff_wdata_m_scanout[23];
assign dff_rdata_w2_m_scanin[21]=dff_rdata_w3_m_scanout[21];
assign dff_rdata_w1_m_scanin[21]=dff_rdata_w2_m_scanout[21];
assign dff_rdata_w0_m_scanin[21]=dff_rdata_w1_m_scanout[21];
assign dff_wdata_m_scanin[104]=dff_rdata_w0_m_scanout[21];
assign dff_wdata_m_scanin[32]=dff_wdata_m_scanout[104];
assign dff_rdata_w3_m_scanin[29]=dff_wdata_m_scanout[32];
assign dff_rdata_w2_m_scanin[29]=dff_rdata_w3_m_scanout[29];
assign dff_rdata_w1_m_scanin[29]=dff_rdata_w2_m_scanout[29];
assign dff_rdata_w0_m_scanin[29]=dff_rdata_w1_m_scanout[29];
assign dff_wdata_m_scanin[96]=dff_rdata_w0_m_scanout[29];
assign dff_wdata_m_scanin[24]=dff_wdata_m_scanout[96];
assign dff_rdata_w3_m_scanin[22]=dff_wdata_m_scanout[24];
assign dff_rdata_w2_m_scanin[22]=dff_rdata_w3_m_scanout[22];
assign dff_rdata_w1_m_scanin[22]=dff_rdata_w2_m_scanout[22];
assign dff_rdata_w0_m_scanin[22]=dff_rdata_w1_m_scanout[22];
assign dff_wdata_m_scanin[105]=dff_rdata_w0_m_scanout[22];
assign dff_wdata_m_scanin[33]=dff_wdata_m_scanout[105];
assign dff_rdata_w3_m_scanin[30]=dff_wdata_m_scanout[33];
assign dff_rdata_w2_m_scanin[30]=dff_rdata_w3_m_scanout[30];
assign dff_rdata_w1_m_scanin[30]=dff_rdata_w2_m_scanout[30];
assign dff_rdata_w0_m_scanin[30]=dff_rdata_w1_m_scanout[30];
assign dff_wdata_m_scanin[97]=dff_rdata_w0_m_scanout[30];
assign dff_wdata_m_scanin[25]=dff_wdata_m_scanout[97];
assign dff_rdata_w3_m_scanin[23]=dff_wdata_m_scanout[25];
assign dff_rdata_w2_m_scanin[23]=dff_rdata_w3_m_scanout[23];
assign dff_rdata_w1_m_scanin[23]=dff_rdata_w2_m_scanout[23];
assign dff_rdata_w0_m_scanin[23]=dff_rdata_w1_m_scanout[23];
assign dff_wdata_m_scanin[106]=dff_rdata_w0_m_scanout[23];
assign dff_wdata_m_scanin[34]=dff_wdata_m_scanout[106];
assign dff_rdata_w3_m_scanin[31]=dff_wdata_m_scanout[34];
assign dff_rdata_w2_m_scanin[31]=dff_rdata_w3_m_scanout[31];
assign dff_rdata_w1_m_scanin[31]=dff_rdata_w2_m_scanout[31];
assign dff_rdata_w0_m_scanin[31]=dff_rdata_w1_m_scanout[31];
assign dff_ctl_m_1_scanin[8]=dff_rdata_w0_m_scanout[31];
assign dff_ctl_m_1_scanin[0]=dff_ctl_m_1_scanout[8];
assign dff_ctl_m_1_scanin[9]=dff_ctl_m_1_scanout[0];
assign dff_ctl_m_1_scanin[1]=dff_ctl_m_1_scanout[9];
assign dff_ctl_m_1_scanin[10]=dff_ctl_m_1_scanout[1];
assign dff_ctl_m_1_scanin[2]=dff_ctl_m_1_scanout[10];
assign dff_ctl_m_1_scanin[11]=dff_ctl_m_1_scanout[2];
assign dff_ctl_m_1_scanin[3]=dff_ctl_m_1_scanout[11];
assign dff_byte_perr_w2_scanin[0]=dff_ctl_m_1_scanout[3];
assign dff_byte_perr_w3_scanin[0]=dff_byte_perr_w2_scanout[0];
assign dff_byte_perr_w3_scanin[1]=dff_byte_perr_w3_scanout[0];
assign dff_byte_perr_w2_scanin[1]=dff_byte_perr_w3_scanout[1];
assign dff_byte_perr_w2_scanin[2]=dff_byte_perr_w2_scanout[1];
assign dff_byte_perr_w3_scanin[2]=dff_byte_perr_w2_scanout[2];
assign dff_byte_perr_w3_scanin[3]=dff_byte_perr_w3_scanout[2];
assign dff_byte_perr_w2_scanin[3]=dff_byte_perr_w3_scanout[3];
assign dff_msb_w3_scanin[7]=dff_byte_perr_w2_scanout[3];
assign dff_msb_w2_scanin[7]=dff_msb_w3_scanout[7];
assign dff_msb_w1_scanin[7]=dff_msb_w2_scanout[7];
assign dff_msb_w0_scanin[7]=dff_msb_w1_scanout[7];
assign dff_msb_w3_scanin[6]=dff_msb_w0_scanout[7];
assign dff_msb_w2_scanin[6]=dff_msb_w3_scanout[6];
assign dff_msb_w1_scanin[6]=dff_msb_w2_scanout[6];
assign dff_msb_w0_scanin[6]=dff_msb_w1_scanout[6];
assign dff_msb_w3_scanin[5]=dff_msb_w0_scanout[6];
assign dff_msb_w2_scanin[5]=dff_msb_w3_scanout[5];
assign dff_msb_w1_scanin[5]=dff_msb_w2_scanout[5];
assign dff_msb_w0_scanin[5]=dff_msb_w1_scanout[5];
assign dff_msb_w3_scanin[4]=dff_msb_w0_scanout[5];
assign dff_msb_w2_scanin[4]=dff_msb_w3_scanout[4];
assign dff_msb_w1_scanin[4]=dff_msb_w2_scanout[4];
assign dff_msb_w0_scanin[4]=dff_msb_w1_scanout[4];
assign dff_msb_w3_scanin[0]=dff_msb_w0_scanout[4];
assign dff_msb_w2_scanin[0]=dff_msb_w3_scanout[0];
assign dff_msb_w1_scanin[0]=dff_msb_w2_scanout[0];
assign dff_msb_w0_scanin[0]=dff_msb_w1_scanout[0];
assign dff_msb_w3_scanin[1]=dff_msb_w0_scanout[0];
assign dff_msb_w2_scanin[1]=dff_msb_w3_scanout[1];
assign dff_msb_w1_scanin[1]=dff_msb_w2_scanout[1];
assign dff_msb_w0_scanin[1]=dff_msb_w1_scanout[1];
assign dff_msb_w3_scanin[2]=dff_msb_w0_scanout[1];
assign dff_msb_w2_scanin[2]=dff_msb_w3_scanout[2];
assign dff_msb_w1_scanin[2]=dff_msb_w2_scanout[2];
assign dff_msb_w0_scanin[2]=dff_msb_w1_scanout[2];
assign dff_msb_w3_scanin[3]=dff_msb_w0_scanout[2];
assign dff_msb_w2_scanin[3]=dff_msb_w3_scanout[3];
assign dff_msb_w1_scanin[3]=dff_msb_w2_scanout[3];
assign dff_msb_w0_scanin[3]=dff_msb_w1_scanout[3];
assign dff_red_out_scanin[2]=dff_msb_w0_scanout[3];
assign dff_red_out_scanin[3]=dff_red_out_scanout[2];
assign dff_red_out_scanin[4]=dff_red_out_scanout[3];
assign dff_red_out_scanin[5]=dff_red_out_scanout[4];
assign dff_red_out_scanin[6]=dff_red_out_scanout[5];
assign dff_red_out_scanin[7]=dff_red_out_scanout[6];
assign dff_red_out_scanin[0]=dff_red_out_scanout[7];
assign dff_red_out_scanin[1]=dff_red_out_scanout[0];
assign dff_red_in_scanin[2]=dff_red_out_scanout[1];
assign dff_red_in_scanin[3]=dff_red_in_scanout[2];
assign dff_red_in_scanin[1]=dff_red_in_scanout[3];
assign dff_red_in_scanin[0]=dff_red_in_scanout[1];
assign dff_red_in_scanin[6]=dff_red_in_scanout[0];
assign dff_red_in_scanin[7]=dff_red_in_scanout[6];
assign dff_red_in_scanin[8]=dff_red_in_scanout[7];
assign dff_red_in_scanin[9]=dff_red_in_scanout[8];
assign dff_red_in_scanin[10]=dff_red_in_scanout[9];
assign dff_red_in_scanin[11]=dff_red_in_scanout[10];
assign dff_red_in_scanin[4]=dff_red_in_scanout[11];
assign dff_red_in_scanin[5]=dff_red_in_scanout[4];
assign scan_out=dff_red_in_scanout[5];
// fixscan end

// synopsys translate_on

endmodule








// any PARAMS parms go into naming of macro

module n2_dca_sp_9kb_cust_l1clkhdr_ctl_macro (
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









// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_dca_sp_9kb_cust_mux_macro__mux_aope__ports_2__width_8 (
  din0, 
  din1, 
  sel0, 
  dout);
wire psel0;
wire psel1;

  input [7:0] din0;
  input [7:0] din1;
  input sel0;
  output [7:0] dout;





cl_dp1_penc2_8x  c0_0 (
 .sel0(sel0),
 .psel0(psel0),
 .psel1(psel1)
);

mux2s #(8)  d0_0 (
  .sel0(psel0),
  .sel1(psel1),
  .in0(din0[7:0]),
  .in1(din1[7:0]),
.dout(dout[7:0])
);









  



endmodule


//
//   macro for cl_mc1_tisram_msff_{16,8}x flops
//
//





module n2_dca_sp_9kb_cust_tisram_msff_macro__fs_1__width_8 (
  d, 
  scan_in, 
  l1clk, 
  siclk, 
  soclk, 
  scan_out, 
  latout, 
  latout_l);
input [7:0] d;
  input [7:0] scan_in;
input l1clk;
input siclk;
input soclk;
  output [7:0] scan_out;
output [7:0] latout;
output [7:0] latout_l;






tisram_msff #(8)  d0_0 (
.d(d[7:0]),
.si(scan_in[7:0]),
.so(scan_out[7:0]),
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.latout(latout[7:0]),
.latout_l(latout_l[7:0])
);












//place::generic_place($width,$stack,$left);

endmodule





// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_dca_sp_9kb_cust_mux_macro__mux_aodec__ports_4__width_4 (
  din0, 
  din1, 
  din2, 
  din3, 
  sel, 
  dout);
wire psel0;
wire psel1;
wire psel2;
wire psel3;

  input [3:0] din0;
  input [3:0] din1;
  input [3:0] din2;
  input [3:0] din3;
  input [1:0] sel;
  output [3:0] dout;





cl_dp1_pdec4_8x  c0_0 (
  .test(1'b1),
 .sel0(sel[0]),
 .sel1(sel[1]),
 .psel0(psel0),
 .psel1(psel1),
 .psel2(psel2),
 .psel3(psel3)
);

mux4s #(4)  d0_0 (
  .sel0(psel0),
  .sel1(psel1),
  .sel2(psel2),
  .sel3(psel3),
  .in0(din0[3:0]),
  .in1(din1[3:0]),
  .in2(din2[3:0]),
  .in3(din3[3:0]),
.dout(dout[3:0])
);









  



endmodule


//
//   macro for cl_mc1_tisram_msff_{16,8}x flops
//
//





module n2_dca_sp_9kb_cust_tisram_msff_macro__fs_1__width_7 (
  d, 
  scan_in, 
  l1clk, 
  siclk, 
  soclk, 
  scan_out, 
  latout, 
  latout_l);
input [6:0] d;
  input [6:0] scan_in;
input l1clk;
input siclk;
input soclk;
  output [6:0] scan_out;
output [6:0] latout;
output [6:0] latout_l;






tisram_msff #(7)  d0_0 (
.d(d[6:0]),
.si(scan_in[6:0]),
.so(scan_out[6:0]),
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.latout(latout[6:0]),
.latout_l(latout_l[6:0])
);












//place::generic_place($width,$stack,$left);

endmodule









// any PARAMS parms go into naming of macro

module n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_3 (
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









//
//   macro for cl_mc1_tisram_msff_{16,8}x flops
//
//





module n2_dca_sp_9kb_cust_tisram_msff_macro__fs_1__width_16 (
  d, 
  scan_in, 
  l1clk, 
  siclk, 
  soclk, 
  scan_out, 
  latout, 
  latout_l);
input [15:0] d;
  input [15:0] scan_in;
input l1clk;
input siclk;
input soclk;
  output [15:0] scan_out;
output [15:0] latout;
output [15:0] latout_l;






tisram_msff #(16)  d0_0 (
.d(d[15:0]),
.si(scan_in[15:0]),
.so(scan_out[15:0]),
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.latout(latout[15:0]),
.latout_l(latout_l[15:0])
);












//place::generic_place($width,$stack,$left);

endmodule









// any PARAMS parms go into naming of macro

module n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_5 (
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

module n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_144 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [143:0] fdin;

  input [143:0] din;
  input l1clk;
  input [143:0] scan_in;


  input siclk;
  input soclk;

  output [143:0] dout;
  output [143:0] scan_out;
assign fdin[143:0] = din[143:0];






dff #(144)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[143:0]),
.si(scan_in[143:0]),
.so(scan_out[143:0]),
.q(dout[143:0])
);












endmodule








module n2_dca_sp_9kb_array (
  l1clk, 
  l1clk_wr, 
  l1clk_red, 
  rd_en_top_b, 
  rd_en_bot_b, 
  rd_en_a, 
  wr_en_a, 
  wr_en_b, 
  wr_inh_b, 
  addr_b, 
  byte_wr_en_b, 
  wr_waysel_b, 
  dcache_wdata_m, 
  dcache_wparity_m, 
  dcache_rdata_w0_m, 
  rparity_w0_m, 
  dcache_rdata_w1_m, 
  rparity_w1_m, 
  dcache_rdata_w2_m, 
  rparity_w2_m, 
  dcache_rdata_w3_m, 
  rparity_w3_m, 
  fuse_dca_repair_value, 
  fuse_dca_repair_en, 
  fuse_dca_rid, 
  fuse_dca_wen, 
  fuse_red_reset, 
  dca_fuse_repair_value, 
  dca_fuse_repair_en, 
  vnw_ary);
wire fuse_red_reset_qual;
wire fuse_dca_wen_qual;
wire [3:0] red_id;
wire [3:0] red_reg_clk_;
wire [5:0] red_data;
wire [1:0] red_enable;
wire [8:0] w0_byte7_l_unused;
wire [8:0] w0_byte6_l_unused;
wire [8:0] w0_byte5_l_unused;
wire [8:0] w0_byte4_l_unused;
wire [8:0] w0_byte3_l_unused;
wire [8:0] w0_byte2_l_unused;
wire [8:0] w0_byte1_l_unused;
wire [8:0] w0_byte0_l_unused;
wire [8:0] w1_byte7_l_unused;
wire [8:0] w1_byte6_l_unused;
wire [8:0] w1_byte5_l_unused;
wire [8:0] w1_byte4_l_unused;
wire [8:0] w1_byte3_l_unused;
wire [8:0] w1_byte2_l_unused;
wire [8:0] w1_byte1_l_unused;
wire [8:0] w1_byte0_l_unused;
wire [8:0] w2_byte7_l_unused;
wire [8:0] w2_byte6_l_unused;
wire [8:0] w2_byte5_l_unused;
wire [8:0] w2_byte4_l_unused;
wire [8:0] w2_byte3_l_unused;
wire [8:0] w2_byte2_l_unused;
wire [8:0] w2_byte1_l_unused;
wire [8:0] w2_byte0_l_unused;
wire [8:0] w3_byte7_l_unused;
wire [8:0] w3_byte6_l_unused;
wire [8:0] w3_byte5_l_unused;
wire [8:0] w3_byte4_l_unused;
wire [8:0] w3_byte3_l_unused;
wire [8:0] w3_byte2_l_unused;
wire [8:0] w3_byte1_l_unused;
wire [8:0] w3_byte0_l_unused;
       

input                   l1clk;          // l1clk from l1clk_header
input			l1clk_wr;
input			l1clk_red;
input                   rd_en_top_b;    // e_cycle b_phase signal
input                   rd_en_bot_b;    // e_cycle b_phase signal
input                   rd_en_a;        // m_cycle a_phase signal
input                   wr_en_a;        // m_cycle a_phase signal
input                   wr_en_b;        // e_cycle b_phase signal
input                   wr_inh_b;       // e_cycle b_phase signal
input   [10:3]          addr_b;         // e_cycle b_phase signal
input   [15:0]          byte_wr_en_b;   // e_cycle b_phase signal
input   [3:0]           wr_waysel_b;    // e_cycle b_phase signal

input	[127:0]		dcache_wdata_m;
input	[15:0]		dcache_wparity_m;

output	[63:0]		dcache_rdata_w0_m;
output	[7:0]		rparity_w0_m;
output	[63:0]		dcache_rdata_w1_m;
output	[7:0]		rparity_w1_m;
output	[63:0]		dcache_rdata_w2_m;
output	[7:0]		rparity_w2_m;
output	[63:0]		dcache_rdata_w3_m;
output	[7:0]		rparity_w3_m;

input	[5:0]	fuse_dca_repair_value;
input	[1:0]	fuse_dca_repair_en;
input	[1:0]	fuse_dca_rid;
input		fuse_dca_wen;
input		fuse_red_reset;
output	[5:0]	dca_fuse_repair_value;
output	[1:0]	dca_fuse_repair_en;

input		vnw_ary;

///////////////////////////////////////////
// Redundancy register logic
///////////////////////////////////////////

// Clock and data enables

assign fuse_red_reset_qual = fuse_red_reset & ~wr_inh_b;
assign fuse_dca_wen_qual = fuse_dca_wen & ~wr_inh_b;

assign red_id[0] = ~fuse_dca_rid[1] & ~fuse_dca_rid[0];
assign red_id[1] = ~fuse_dca_rid[1] &  fuse_dca_rid[0];
assign red_id[2] =  fuse_dca_rid[1] & ~fuse_dca_rid[0];
assign red_id[3] =  fuse_dca_rid[1] &  fuse_dca_rid[0];

assign red_reg_clk_[0] = ~(~l1clk_red & ((red_id[0] & fuse_dca_wen_qual) | fuse_red_reset_qual));
assign red_reg_clk_[1] = ~(~l1clk_red & ((red_id[1] & fuse_dca_wen_qual) | fuse_red_reset_qual));
assign red_reg_clk_[2] = ~(~l1clk_red & ((red_id[2] & fuse_dca_wen_qual) | fuse_red_reset_qual));
assign red_reg_clk_[3] = ~(~l1clk_red & ((red_id[3] & fuse_dca_wen_qual) | fuse_red_reset_qual));

assign red_data[5:0] = fuse_dca_repair_value[5:0] & {6{~fuse_red_reset_qual}};
assign red_enable[1:0] = fuse_dca_repair_en[1:0] & {2{~fuse_red_reset_qual}};

// 4 set of 8 registers.
// register is a simple b_latch. active when clk is low.

reg	[5:0]	red_reg_d_bl;
reg	[5:0]	red_reg_d_br;
reg	[5:0]	red_reg_d_tl;
reg	[5:0]	red_reg_d_tr;
reg	[1:0]	red_reg_en_bl;
reg	[1:0]	red_reg_en_br;
reg	[1:0]	red_reg_en_tl;
reg	[1:0]	red_reg_en_tr;

`ifndef NOINITMEM
// Initialize the arrays.
initial begin
  red_reg_d_bl[5:0] = 6'd0;
  red_reg_en_bl[1:0] = 2'd0;
  red_reg_d_br[5:0] = 6'd0;
  red_reg_en_br[1:0] = 2'd0;
  red_reg_d_tl[5:0] = 6'd0;
  red_reg_en_tl[1:0] = 2'd0;
  red_reg_d_tr[5:0] = 6'd0;
  red_reg_en_tr[1:0] = 2'd0;
end
`endif

always @(red_reg_clk_ or red_data or red_enable) begin
  if (~red_reg_clk_[0]) begin
    red_reg_d_bl[5:0]  = red_data[5:0];
    red_reg_en_bl[1:0] = red_enable[1:0];
  end
  if (~red_reg_clk_[1]) begin
    red_reg_d_br[5:0]  = red_data[5:0];
    red_reg_en_br[1:0] = red_enable[1:0];
  end
  if (~red_reg_clk_[2]) begin
    red_reg_d_tl[5:0]  = red_data[5:0];
    red_reg_en_tl[1:0] = red_enable[1:0];
  end
  if (~red_reg_clk_[3]) begin
    red_reg_d_tr[5:0]  = red_data[5:0];
    red_reg_en_tr[1:0] = red_enable[1:0];
  end
end

// output muxing
assign dca_fuse_repair_value[5:0] = (red_reg_d_tr[5:0] & {6{red_id[3]}}) |
                                    (red_reg_d_tl[5:0] & {6{red_id[2]}}) |
                                    (red_reg_d_br[5:0] & {6{red_id[1]}}) |
                                    (red_reg_d_bl[5:0] & {6{red_id[0]}});

assign dca_fuse_repair_en[1:0] = (red_reg_en_tr[1:0] & {2{red_id[3]}}) |
                                 (red_reg_en_tl[1:0] & {2{red_id[2]}}) |
                                 (red_reg_en_br[1:0] & {2{red_id[1]}}) |
                                 (red_reg_en_bl[1:0] & {2{red_id[0]}}) ;

// The two subarrays

n2_dca_sp_9kb_bank way01 (
	.red_data_l	(red_reg_d_tl[5:0]),
	.red_enable_l	(red_reg_en_tl[1:0]),
	.red_data_r	(red_reg_d_tr[5:0]),
	.red_enable_r	(red_reg_en_tr[1:0]),
	.rd_en_b	(rd_en_top_b),
	.wr_waysel_b	(wr_waysel_b[1:0]),
	.wrd_byte15_a	({dcache_wparity_m[15],dcache_wdata_m[127:120]}),
	.wrd_byte14_a	({dcache_wparity_m[14],dcache_wdata_m[119:112]}),
	.wrd_byte13_a	({dcache_wparity_m[13],dcache_wdata_m[111:104]}),
	.wrd_byte12_a	({dcache_wparity_m[12],dcache_wdata_m[103:96]}),
	.wrd_byte11_a	({dcache_wparity_m[11],dcache_wdata_m[95:88]}),
	.wrd_byte10_a	({dcache_wparity_m[10],dcache_wdata_m[87:80]}),
	.wrd_byte9_a	({dcache_wparity_m[9],dcache_wdata_m[79:72]}),
	.wrd_byte8_a	({dcache_wparity_m[8],dcache_wdata_m[71:64]}),
	.wrd_byte7_a	({dcache_wparity_m[7],dcache_wdata_m[63:56]}),
	.wrd_byte6_a	({dcache_wparity_m[6],dcache_wdata_m[55:48]}),
	.wrd_byte5_a	({dcache_wparity_m[5],dcache_wdata_m[47:40]}),
	.wrd_byte4_a	({dcache_wparity_m[4],dcache_wdata_m[39:32]}),
	.wrd_byte3_a	({dcache_wparity_m[3],dcache_wdata_m[31:24]}),
	.wrd_byte2_a	({dcache_wparity_m[2],dcache_wdata_m[23:16]}),
	.wrd_byte1_a	({dcache_wparity_m[1],dcache_wdata_m[15:8]}),
	.wrd_byte0_a	({dcache_wparity_m[0],dcache_wdata_m[7:0]}),
	.w0_byte7_h	({rparity_w0_m[7],dcache_rdata_w0_m[63:56]}),
	.w0_byte6_h	({rparity_w0_m[6],dcache_rdata_w0_m[55:48]}),
	.w0_byte5_h	({rparity_w0_m[5],dcache_rdata_w0_m[47:40]}),
	.w0_byte4_h	({rparity_w0_m[4],dcache_rdata_w0_m[39:32]}),
	.w0_byte3_h	({rparity_w0_m[3],dcache_rdata_w0_m[31:24]}),
	.w0_byte2_h	({rparity_w0_m[2],dcache_rdata_w0_m[23:16]}),
	.w0_byte1_h	({rparity_w0_m[1],dcache_rdata_w0_m[15:8]}),
	.w0_byte0_h	({rparity_w0_m[0],dcache_rdata_w0_m[7:0]}),
	.w1_byte7_h	({rparity_w1_m[7],dcache_rdata_w1_m[63:56]}),
	.w1_byte6_h	({rparity_w1_m[6],dcache_rdata_w1_m[55:48]}),
	.w1_byte5_h	({rparity_w1_m[5],dcache_rdata_w1_m[47:40]}),
	.w1_byte4_h	({rparity_w1_m[4],dcache_rdata_w1_m[39:32]}),
	.w1_byte3_h	({rparity_w1_m[3],dcache_rdata_w1_m[31:24]}),
	.w1_byte2_h	({rparity_w1_m[2],dcache_rdata_w1_m[23:16]}),
	.w1_byte1_h	({rparity_w1_m[1],dcache_rdata_w1_m[15:8]}),
	.w1_byte0_h	({rparity_w1_m[0],dcache_rdata_w1_m[7:0]}),
	.w0_byte7_l	(w0_byte7_l_unused[8:0]),
	.w0_byte6_l	(w0_byte6_l_unused[8:0]),
	.w0_byte5_l	(w0_byte5_l_unused[8:0]),
	.w0_byte4_l	(w0_byte4_l_unused[8:0]),
	.w0_byte3_l	(w0_byte3_l_unused[8:0]),
	.w0_byte2_l	(w0_byte2_l_unused[8:0]),
	.w0_byte1_l	(w0_byte1_l_unused[8:0]),
	.w0_byte0_l	(w0_byte0_l_unused[8:0]),
	.w1_byte7_l	(w1_byte7_l_unused[8:0]),
	.w1_byte6_l	(w1_byte6_l_unused[8:0]),
	.w1_byte5_l	(w1_byte5_l_unused[8:0]),
	.w1_byte4_l	(w1_byte4_l_unused[8:0]),
	.w1_byte3_l	(w1_byte3_l_unused[8:0]),
	.w1_byte2_l	(w1_byte2_l_unused[8:0]),
	.w1_byte1_l	(w1_byte1_l_unused[8:0]),
	.w1_byte0_l	(w1_byte0_l_unused[8:0]),
  .l1clk(l1clk),
  .l1clk_wr(l1clk_wr),
  .rd_en_a(rd_en_a),
  .wr_en_a(wr_en_a),
  .wr_en_b(wr_en_b),
  .wr_inh_b(wr_inh_b),
  .addr_b(addr_b[10:3]),
  .byte_wr_en_b(byte_wr_en_b[15:0]),
  .vnw_ary(vnw_ary)
);

n2_dca_sp_9kb_bank way23 (
	.red_data_l	(red_reg_d_bl[5:0]),
	.red_enable_l	(red_reg_en_bl[1:0]),
	.red_data_r	(red_reg_d_br[5:0]),
	.red_enable_r	(red_reg_en_br[1:0]),
	.rd_en_b	(rd_en_bot_b),
	.wr_waysel_b	(wr_waysel_b[3:2]),
	.wrd_byte15_a	({dcache_wparity_m[15],dcache_wdata_m[127:120]}),
	.wrd_byte14_a	({dcache_wparity_m[14],dcache_wdata_m[119:112]}),
	.wrd_byte13_a	({dcache_wparity_m[13],dcache_wdata_m[111:104]}),
	.wrd_byte12_a	({dcache_wparity_m[12],dcache_wdata_m[103:96]}),
	.wrd_byte11_a	({dcache_wparity_m[11],dcache_wdata_m[95:88]}),
	.wrd_byte10_a	({dcache_wparity_m[10],dcache_wdata_m[87:80]}),
	.wrd_byte9_a	({dcache_wparity_m[9],dcache_wdata_m[79:72]}),
	.wrd_byte8_a	({dcache_wparity_m[8],dcache_wdata_m[71:64]}),
	.wrd_byte7_a	({dcache_wparity_m[7],dcache_wdata_m[63:56]}),
	.wrd_byte6_a	({dcache_wparity_m[6],dcache_wdata_m[55:48]}),
	.wrd_byte5_a	({dcache_wparity_m[5],dcache_wdata_m[47:40]}),
	.wrd_byte4_a	({dcache_wparity_m[4],dcache_wdata_m[39:32]}),
	.wrd_byte3_a	({dcache_wparity_m[3],dcache_wdata_m[31:24]}),
	.wrd_byte2_a	({dcache_wparity_m[2],dcache_wdata_m[23:16]}),
	.wrd_byte1_a	({dcache_wparity_m[1],dcache_wdata_m[15:8]}),
	.wrd_byte0_a	({dcache_wparity_m[0],dcache_wdata_m[7:0]}),
	.w0_byte7_h	({rparity_w2_m[7],dcache_rdata_w2_m[63:56]}),
	.w0_byte6_h	({rparity_w2_m[6],dcache_rdata_w2_m[55:48]}),
	.w0_byte5_h	({rparity_w2_m[5],dcache_rdata_w2_m[47:40]}),
	.w0_byte4_h	({rparity_w2_m[4],dcache_rdata_w2_m[39:32]}),
	.w0_byte3_h	({rparity_w2_m[3],dcache_rdata_w2_m[31:24]}),
	.w0_byte2_h	({rparity_w2_m[2],dcache_rdata_w2_m[23:16]}),
	.w0_byte1_h	({rparity_w2_m[1],dcache_rdata_w2_m[15:8]}),
	.w0_byte0_h	({rparity_w2_m[0],dcache_rdata_w2_m[7:0]}),
	.w1_byte7_h	({rparity_w3_m[7],dcache_rdata_w3_m[63:56]}),
	.w1_byte6_h	({rparity_w3_m[6],dcache_rdata_w3_m[55:48]}),
	.w1_byte5_h	({rparity_w3_m[5],dcache_rdata_w3_m[47:40]}),
	.w1_byte4_h	({rparity_w3_m[4],dcache_rdata_w3_m[39:32]}),
	.w1_byte3_h	({rparity_w3_m[3],dcache_rdata_w3_m[31:24]}),
	.w1_byte2_h	({rparity_w3_m[2],dcache_rdata_w3_m[23:16]}),
	.w1_byte1_h	({rparity_w3_m[1],dcache_rdata_w3_m[15:8]}),
	.w1_byte0_h	({rparity_w3_m[0],dcache_rdata_w3_m[7:0]}),
	.w0_byte7_l	(w2_byte7_l_unused[8:0]),
	.w0_byte6_l	(w2_byte6_l_unused[8:0]),
	.w0_byte5_l	(w2_byte5_l_unused[8:0]),
	.w0_byte4_l	(w2_byte4_l_unused[8:0]),
	.w0_byte3_l	(w2_byte3_l_unused[8:0]),
	.w0_byte2_l	(w2_byte2_l_unused[8:0]),
	.w0_byte1_l	(w2_byte1_l_unused[8:0]),
	.w0_byte0_l	(w2_byte0_l_unused[8:0]),
	.w1_byte7_l	(w3_byte7_l_unused[8:0]),
	.w1_byte6_l	(w3_byte6_l_unused[8:0]),
	.w1_byte5_l	(w3_byte5_l_unused[8:0]),
	.w1_byte4_l	(w3_byte4_l_unused[8:0]),
	.w1_byte3_l	(w3_byte3_l_unused[8:0]),
	.w1_byte2_l	(w3_byte2_l_unused[8:0]),
	.w1_byte1_l	(w3_byte1_l_unused[8:0]),
	.w1_byte0_l	(w3_byte0_l_unused[8:0]),
  .l1clk(l1clk),
  .l1clk_wr(l1clk_wr),
  .rd_en_a(rd_en_a),
  .wr_en_a(wr_en_a),
  .wr_en_b(wr_en_b),
  .wr_inh_b(wr_inh_b),
  .addr_b(addr_b[10:3]),
  .byte_wr_en_b(byte_wr_en_b[15:0]),
  .vnw_ary(vnw_ary)
);


supply0 vss;
supply1 vdd;
endmodule



module n2_dca_sp_9kb_bank (
  l1clk, 
  l1clk_wr, 
  rd_en_b, 
  rd_en_a, 
  wr_en_a, 
  wr_en_b, 
  wr_inh_b, 
  addr_b, 
  byte_wr_en_b, 
  wr_waysel_b, 
  red_data_l, 
  red_data_r, 
  red_enable_l, 
  red_enable_r, 
  vnw_ary, 
  wrd_byte15_a, 
  wrd_byte14_a, 
  wrd_byte13_a, 
  wrd_byte12_a, 
  wrd_byte11_a, 
  wrd_byte10_a, 
  wrd_byte9_a, 
  wrd_byte8_a, 
  wrd_byte7_a, 
  wrd_byte6_a, 
  wrd_byte5_a, 
  wrd_byte4_a, 
  wrd_byte3_a, 
  wrd_byte2_a, 
  wrd_byte1_a, 
  wrd_byte0_a, 
  w1_byte7_h, 
  w1_byte6_h, 
  w1_byte5_h, 
  w1_byte4_h, 
  w1_byte3_h, 
  w1_byte2_h, 
  w1_byte1_h, 
  w1_byte0_h, 
  w1_byte7_l, 
  w1_byte6_l, 
  w1_byte5_l, 
  w1_byte4_l, 
  w1_byte3_l, 
  w1_byte2_l, 
  w1_byte1_l, 
  w1_byte0_l, 
  w0_byte7_h, 
  w0_byte6_h, 
  w0_byte5_h, 
  w0_byte4_h, 
  w0_byte3_h, 
  w0_byte2_h, 
  w0_byte1_h, 
  w0_byte0_h, 
  w0_byte7_l, 
  w0_byte6_l, 
  w0_byte5_l, 
  w0_byte4_l, 
  w0_byte3_l, 
  w0_byte2_l, 
  w0_byte1_l, 
  w0_byte0_l);       

`define WIDTH 288
`define ENTRIES 128

// way0 and way1 are interleaved physically across 2 subbanks
//        [288,277,..................,145,144] -- xdec -- [143,142,.............,1,0]
//          H   L   H   L       H   L   H   L  -- xdec --  L   H   L   H      L H L H      
// way1 = [288,287,284,283,...,151,150,147,146 -- xdec -- 141,140,137,136,...,5,4,1,0
// way0 = [286,285,282,281,...,149,148,145,144 -- xdec -- 143,142,139,138,...,7,6,3,2

input                   l1clk;          // l1clk from l1clk_header
input                   l1clk_wr;       // l1clk from l1clk_header
input                   rd_en_b;        // e_cycle b_phase signal
input                   rd_en_a;        // m_cycle a_phase signal
input                   wr_en_a;        // m_cycle a_phase signal
input                   wr_en_b;        // e_cycle b_phase signal
input                   wr_inh_b;       // e_cycle b_phase signal
input   [10:3]          addr_b;         // e_cycle b_phase signal
input   [15:0]          byte_wr_en_b;   // e_cycle b_phase signal
input   [1:0]           wr_waysel_b;    // e_cycle b_phase signal

input	[5:0]		red_data_l;
input	[5:0]		red_data_r;
input	[1:0]		red_enable_l;
input	[1:0]		red_enable_r;

input			vnw_ary;

input   [8:0]           wrd_byte15_a;   // m_cycle a_phase signal
input   [8:0]           wrd_byte14_a;
input   [8:0]           wrd_byte13_a;
input   [8:0]           wrd_byte12_a;
input   [8:0]           wrd_byte11_a;
input   [8:0]           wrd_byte10_a;
input   [8:0]           wrd_byte9_a;
input   [8:0]           wrd_byte8_a;
input   [8:0]           wrd_byte7_a;
input   [8:0]           wrd_byte6_a;
input   [8:0]           wrd_byte5_a;
input   [8:0]           wrd_byte4_a;
input   [8:0]           wrd_byte3_a;
input   [8:0]           wrd_byte2_a;
input   [8:0]           wrd_byte1_a;
input   [8:0]           wrd_byte0_a;

output  [8:0]           w1_byte7_h;     // m_cycle b_phase clock-like signal    
output  [8:0]           w1_byte6_h;
output  [8:0]           w1_byte5_h;
output  [8:0]           w1_byte4_h;
output  [8:0]           w1_byte3_h;
output  [8:0]           w1_byte2_h;
output  [8:0]           w1_byte1_h;
output  [8:0]           w1_byte0_h;
output  [8:0]           w1_byte7_l;
output  [8:0]           w1_byte6_l;
output  [8:0]           w1_byte5_l;
output  [8:0]           w1_byte4_l;
output  [8:0]           w1_byte3_l;
output  [8:0]           w1_byte2_l;
output  [8:0]           w1_byte1_l;
output  [8:0]           w1_byte0_l;

output  [8:0]           w0_byte7_h;     // m_cycle b_phase clock-like signal    
output  [8:0]           w0_byte6_h;
output  [8:0]           w0_byte5_h;
output  [8:0]           w0_byte4_h;
output  [8:0]           w0_byte3_h;
output  [8:0]           w0_byte2_h;
output  [8:0]           w0_byte1_h;
output  [8:0]           w0_byte0_h;
output  [8:0]           w0_byte7_l;
output  [8:0]           w0_byte6_l;
output  [8:0]           w0_byte5_l;
output  [8:0]           w0_byte4_l;
output  [8:0]           w0_byte3_l;
output  [8:0]           w0_byte2_l;
output  [8:0]           w0_byte1_l;
output  [8:0]           w0_byte0_l;







reg	[71:0]		w0_sao_h;
reg	[71:0]		w0_sao_l;
reg	[71:0]		w1_sao_h;
reg	[71:0]		w1_sao_l;




n2_dca_sp_9kb_subbank left (
	.byte_wr_en_b 	({byte_wr_en_b[15],byte_wr_en_b[7],byte_wr_en_b[14],byte_wr_en_b[6],
			  byte_wr_en_b[13],byte_wr_en_b[5],byte_wr_en_b[12],byte_wr_en_b[4]}),
	.wr_data_a	({wrd_byte15_a[8], wrd_byte7_a[8], wrd_byte14_a[8], wrd_byte6_a[8], 
			  wrd_byte15_a[7], wrd_byte7_a[7], wrd_byte14_a[7], wrd_byte6_a[7],
			  wrd_byte15_a[6], wrd_byte7_a[6], wrd_byte14_a[6], wrd_byte6_a[6],
			  wrd_byte15_a[5], wrd_byte7_a[5], wrd_byte14_a[5], wrd_byte6_a[5],
			  wrd_byte15_a[4], wrd_byte7_a[4], wrd_byte14_a[4], wrd_byte6_a[4],
			  wrd_byte15_a[3], wrd_byte7_a[3], wrd_byte14_a[3], wrd_byte6_a[3],
			  wrd_byte15_a[2], wrd_byte7_a[2], wrd_byte14_a[2], wrd_byte6_a[2],
			  wrd_byte15_a[1], wrd_byte7_a[1], wrd_byte14_a[1], wrd_byte6_a[1],
			  wrd_byte15_a[0], wrd_byte7_a[0], wrd_byte14_a[0], wrd_byte6_a[0],
			  wrd_byte13_a[8], wrd_byte5_a[8], wrd_byte12_a[8], wrd_byte4_a[8], 
			  wrd_byte13_a[7], wrd_byte5_a[7], wrd_byte12_a[7], wrd_byte4_a[7],
			  wrd_byte13_a[6], wrd_byte5_a[6], wrd_byte12_a[6], wrd_byte4_a[6],
			  wrd_byte13_a[5], wrd_byte5_a[5], wrd_byte12_a[5], wrd_byte4_a[5],
			  wrd_byte13_a[4], wrd_byte5_a[4], wrd_byte12_a[4], wrd_byte4_a[4],
			  wrd_byte13_a[3], wrd_byte5_a[3], wrd_byte12_a[3], wrd_byte4_a[3],
			  wrd_byte13_a[2], wrd_byte5_a[2], wrd_byte12_a[2], wrd_byte4_a[2],
			  wrd_byte13_a[1], wrd_byte5_a[1], wrd_byte12_a[1], wrd_byte4_a[1],
			  wrd_byte13_a[0], wrd_byte5_a[0], wrd_byte12_a[0], wrd_byte4_a[0]}),
	.red_data	(red_data_l[5:0]),
	.red_en		(red_enable_l[1:0]),
	.w0_rdata_h	({w0_byte7_h[8],w0_byte6_h[8],w0_byte7_h[7],w0_byte6_h[7],
			  w0_byte7_h[6],w0_byte6_h[6],w0_byte7_h[5],w0_byte6_h[5],
			  w0_byte7_h[4],w0_byte6_h[4],w0_byte7_h[3],w0_byte6_h[3],
			  w0_byte7_h[2],w0_byte6_h[2],w0_byte7_h[1],w0_byte6_h[1],
			  w0_byte7_h[0],w0_byte6_h[0],w0_byte5_h[8],w0_byte4_h[8],
	 		  w0_byte5_h[7],w0_byte4_h[7],w0_byte5_h[6],w0_byte4_h[6],
	 		  w0_byte5_h[5],w0_byte4_h[5],w0_byte5_h[4],w0_byte4_h[4],
	 		  w0_byte5_h[3],w0_byte4_h[3],w0_byte5_h[2],w0_byte4_h[2],
	 		  w0_byte5_h[1],w0_byte4_h[1],w0_byte5_h[0],w0_byte4_h[0]}),
	.w0_rdata_l	({w0_byte7_l[8],w0_byte6_l[8],w0_byte7_l[7],w0_byte6_l[7],
			  w0_byte7_l[6],w0_byte6_l[6],w0_byte7_l[5],w0_byte6_l[5],
			  w0_byte7_l[4],w0_byte6_l[4],w0_byte7_l[3],w0_byte6_l[3],
			  w0_byte7_l[2],w0_byte6_l[2],w0_byte7_l[1],w0_byte6_l[1],
			  w0_byte7_l[0],w0_byte6_l[0],w0_byte5_l[8],w0_byte4_l[8],
	 		  w0_byte5_l[7],w0_byte4_l[7],w0_byte5_l[6],w0_byte4_l[6],
	 		  w0_byte5_l[5],w0_byte4_l[5],w0_byte5_l[4],w0_byte4_l[4],
	 		  w0_byte5_l[3],w0_byte4_l[3],w0_byte5_l[2],w0_byte4_l[2],
	 		  w0_byte5_l[1],w0_byte4_l[1],w0_byte5_l[0],w0_byte4_l[0]}),
	.w1_rdata_h	({w1_byte7_h[8],w1_byte6_h[8],w1_byte7_h[7],w1_byte6_h[7],
			  w1_byte7_h[6],w1_byte6_h[6],w1_byte7_h[5],w1_byte6_h[5],
			  w1_byte7_h[4],w1_byte6_h[4],w1_byte7_h[3],w1_byte6_h[3],
			  w1_byte7_h[2],w1_byte6_h[2],w1_byte7_h[1],w1_byte6_h[1],
			  w1_byte7_h[0],w1_byte6_h[0],w1_byte5_h[8],w1_byte4_h[8],
	 		  w1_byte5_h[7],w1_byte4_h[7],w1_byte5_h[6],w1_byte4_h[6],
	 		  w1_byte5_h[5],w1_byte4_h[5],w1_byte5_h[4],w1_byte4_h[4],
	 		  w1_byte5_h[3],w1_byte4_h[3],w1_byte5_h[2],w1_byte4_h[2],
	 		  w1_byte5_h[1],w1_byte4_h[1],w1_byte5_h[0],w1_byte4_h[0]}),
	.w1_rdata_l	({w1_byte7_l[8],w1_byte6_l[8],w1_byte7_l[7],w1_byte6_l[7],
			  w1_byte7_l[6],w1_byte6_l[6],w1_byte7_l[5],w1_byte6_l[5],
			  w1_byte7_l[4],w1_byte6_l[4],w1_byte7_l[3],w1_byte6_l[3],
			  w1_byte7_l[2],w1_byte6_l[2],w1_byte7_l[1],w1_byte6_l[1],
			  w1_byte7_l[0],w1_byte6_l[0],w1_byte5_l[8],w1_byte4_l[8],
	 		  w1_byte5_l[7],w1_byte4_l[7],w1_byte5_l[6],w1_byte4_l[6],
	 		  w1_byte5_l[5],w1_byte4_l[5],w1_byte5_l[4],w1_byte4_l[4],
	 		  w1_byte5_l[3],w1_byte4_l[3],w1_byte5_l[2],w1_byte4_l[2],
	 		  w1_byte5_l[1],w1_byte4_l[1],w1_byte5_l[0],w1_byte4_l[0]}),
  .l1clk(l1clk),
  .l1clk_wr(l1clk_wr),
  .rd_en_b(rd_en_b),
  .rd_en_a(rd_en_a),
  .wr_en_a(wr_en_a),
  .wr_en_b(wr_en_b),
  .wr_inh_b(wr_inh_b),
  .addr_b(addr_b[10:3]),
  .wr_waysel_b(wr_waysel_b[1:0]),
  .vnw_ary(vnw_ary)
);

// The right subbank is a mirrored copy of the left (redundant columns on the left),
// so all I/O's must be reverse ordered.

n2_dca_sp_9kb_subbank right (
	.byte_wr_en_b 	({byte_wr_en_b[8],byte_wr_en_b[0],byte_wr_en_b[9],byte_wr_en_b[1],
			  byte_wr_en_b[10],byte_wr_en_b[2],byte_wr_en_b[11],byte_wr_en_b[3]}),
	.wr_data_a	({wrd_byte8_a[8], wrd_byte0_a[8], wrd_byte9_a[8], wrd_byte1_a[8], 
			  wrd_byte8_a[0], wrd_byte0_a[0], wrd_byte9_a[0], wrd_byte1_a[0],
			  wrd_byte8_a[1], wrd_byte0_a[1], wrd_byte9_a[1], wrd_byte1_a[1],
			  wrd_byte8_a[2], wrd_byte0_a[2], wrd_byte9_a[2], wrd_byte1_a[2],
			  wrd_byte8_a[3], wrd_byte0_a[3], wrd_byte9_a[3], wrd_byte1_a[3],
			  wrd_byte8_a[4], wrd_byte0_a[4], wrd_byte9_a[4], wrd_byte1_a[4],
			  wrd_byte8_a[5], wrd_byte0_a[5], wrd_byte9_a[5], wrd_byte1_a[5],
			  wrd_byte8_a[6], wrd_byte0_a[6], wrd_byte9_a[6], wrd_byte1_a[6],
			  wrd_byte8_a[7], wrd_byte0_a[7], wrd_byte9_a[7], wrd_byte1_a[7],
			  wrd_byte10_a[8], wrd_byte2_a[8], wrd_byte11_a[8], wrd_byte3_a[8], 
			  wrd_byte10_a[0], wrd_byte2_a[0], wrd_byte11_a[0], wrd_byte3_a[0],
			  wrd_byte10_a[1], wrd_byte2_a[1], wrd_byte11_a[1], wrd_byte3_a[1],
			  wrd_byte10_a[2], wrd_byte2_a[2], wrd_byte11_a[2], wrd_byte3_a[2],
			  wrd_byte10_a[3], wrd_byte2_a[3], wrd_byte11_a[3], wrd_byte3_a[3],
			  wrd_byte10_a[4], wrd_byte2_a[4], wrd_byte11_a[4], wrd_byte3_a[4],
			  wrd_byte10_a[5], wrd_byte2_a[5], wrd_byte11_a[5], wrd_byte3_a[5],
			  wrd_byte10_a[6], wrd_byte2_a[6], wrd_byte11_a[6], wrd_byte3_a[6],
			  wrd_byte10_a[7], wrd_byte2_a[7], wrd_byte11_a[7], wrd_byte3_a[7]}),
	.red_data	(red_data_r[5:0]),
	.red_en		(red_enable_r[1:0]),
	.w0_rdata_h	({w0_byte0_h[8],w0_byte1_h[8],w0_byte0_h[0],w0_byte1_h[0],
			  w0_byte0_h[1],w0_byte1_h[1],w0_byte0_h[2],w0_byte1_h[2],
			  w0_byte0_h[3],w0_byte1_h[3],w0_byte0_h[4],w0_byte1_h[4],
			  w0_byte0_h[5],w0_byte1_h[5],w0_byte0_h[6],w0_byte1_h[6],
			  w0_byte0_h[7],w0_byte1_h[7],w0_byte2_h[8],w0_byte3_h[8],
			  w0_byte2_h[0],w0_byte3_h[0],w0_byte2_h[1],w0_byte3_h[1],
			  w0_byte2_h[2],w0_byte3_h[2],w0_byte2_h[3],w0_byte3_h[3],
			  w0_byte2_h[4],w0_byte3_h[4],w0_byte2_h[5],w0_byte3_h[5],
			  w0_byte2_h[6],w0_byte3_h[6],w0_byte2_h[7],w0_byte3_h[7]}),
	.w0_rdata_l	({w0_byte0_l[8],w0_byte1_l[8],w0_byte0_l[0],w0_byte1_l[0],
			  w0_byte0_l[1],w0_byte1_l[1],w0_byte0_l[2],w0_byte1_l[2],
			  w0_byte0_l[3],w0_byte1_l[3],w0_byte0_l[4],w0_byte1_l[4],
			  w0_byte0_l[5],w0_byte1_l[5],w0_byte0_l[6],w0_byte1_l[6],
			  w0_byte0_l[7],w0_byte1_l[7],w0_byte2_l[8],w0_byte3_l[8],
			  w0_byte2_l[0],w0_byte3_l[0],w0_byte2_l[1],w0_byte3_l[1],
			  w0_byte2_l[2],w0_byte3_l[2],w0_byte2_l[3],w0_byte3_l[3],
			  w0_byte2_l[4],w0_byte3_l[4],w0_byte2_l[5],w0_byte3_l[5],
			  w0_byte2_l[6],w0_byte3_l[6],w0_byte2_l[7],w0_byte3_l[7]}),
	.w1_rdata_h	({w1_byte0_h[8],w1_byte1_h[8],w1_byte0_h[0],w1_byte1_h[0],
			  w1_byte0_h[1],w1_byte1_h[1],w1_byte0_h[2],w1_byte1_h[2],
			  w1_byte0_h[3],w1_byte1_h[3],w1_byte0_h[4],w1_byte1_h[4],
			  w1_byte0_h[5],w1_byte1_h[5],w1_byte0_h[6],w1_byte1_h[6],
			  w1_byte0_h[7],w1_byte1_h[7],w1_byte2_h[8],w1_byte3_h[8],
			  w1_byte2_h[0],w1_byte3_h[0],w1_byte2_h[1],w1_byte3_h[1],
			  w1_byte2_h[2],w1_byte3_h[2],w1_byte2_h[3],w1_byte3_h[3],
			  w1_byte2_h[4],w1_byte3_h[4],w1_byte2_h[5],w1_byte3_h[5],
			  w1_byte2_h[6],w1_byte3_h[6],w1_byte2_h[7],w1_byte3_h[7]}),
	.w1_rdata_l	({w1_byte0_l[8],w1_byte1_l[8],w1_byte0_l[0],w1_byte1_l[0],
			  w1_byte0_l[1],w1_byte1_l[1],w1_byte0_l[2],w1_byte1_l[2],
			  w1_byte0_l[3],w1_byte1_l[3],w1_byte0_l[4],w1_byte1_l[4],
			  w1_byte0_l[5],w1_byte1_l[5],w1_byte0_l[6],w1_byte1_l[6],
			  w1_byte0_l[7],w1_byte1_l[7],w1_byte2_l[8],w1_byte3_l[8],
			  w1_byte2_l[0],w1_byte3_l[0],w1_byte2_l[1],w1_byte3_l[1],
			  w1_byte2_l[2],w1_byte3_l[2],w1_byte2_l[3],w1_byte3_l[3],
			  w1_byte2_l[4],w1_byte3_l[4],w1_byte2_l[5],w1_byte3_l[5],
			  w1_byte2_l[6],w1_byte3_l[6],w1_byte2_l[7],w1_byte3_l[7]}),
  .l1clk(l1clk),
  .l1clk_wr(l1clk_wr),
  .rd_en_b(rd_en_b),
  .rd_en_a(rd_en_a),
  .wr_en_a(wr_en_a),
  .wr_en_b(wr_en_b),
  .wr_inh_b(wr_inh_b),
  .addr_b(addr_b[10:3]),
  .wr_waysel_b(wr_waysel_b[1:0]),
  .vnw_ary(vnw_ary)
);




                       



























supply0 vss;
supply1 vdd;
endmodule




module n2_dca_sp_9kb_subbank (
  l1clk, 
  l1clk_wr, 
  rd_en_b, 
  rd_en_a, 
  wr_en_a, 
  wr_en_b, 
  wr_inh_b, 
  addr_b, 
  byte_wr_en_b, 
  wr_waysel_b, 
  wr_data_a, 
  red_data, 
  red_en, 
  vnw_ary, 
  w0_rdata_h, 
  w0_rdata_l, 
  w1_rdata_h, 
  w1_rdata_l);
wire red_shift_en;
wire [143:0] data_in;
wire [143:0] byte_mask;
wire w0_wcs;
wire w1_wcs;
wire [143:0] way_mask;
wire [143:0] local_dout;
wire rcs_l;
wire [35:0] w0_dout;
wire [35:0] w1_dout;
       

`define ENTRIES 128

// way0 and way1 are interleaved physically across 2 subbanks
//        [288,277,..................,145,144] -- xdec -- [143,142,.............,1,0]
//          H   L   H   L       H   L   H   L  -- xdec --  L   H   L   H      L H L H      
// way1 = [288,287,284,283,...,151,150,147,146 -- xdec -- 141,140,137,136,...,5,4,1,0
// way0 = [286,285,282,281,...,149,148,145,144 -- xdec -- 143,142,139,138,...,7,6,3,2

input		l1clk;          // l1clk from l1clk_header
input		l1clk_wr;       // l1clk from l1clk_header
input		rd_en_b;        // e_cycle b_phase signal
input		rd_en_a;        // m_cycle a_phase signal
input		wr_en_a;        // m_cycle a_phase signal
input		wr_en_b;        // e_cycle b_phase signal
input		wr_inh_b;       // e_cycle b_phase signal
input   [10:3]	addr_b;         // e_cycle b_phase signal
input   [7:0]	byte_wr_en_b;   // e_cycle b_phase signal
input   [1:0]	wr_waysel_b;    // e_cycle b_phase signal

input   [71:0]	wr_data_a;   // m_cycle a_phase signal

input	[5:0]	red_data;
input	[1:0]	red_en;

input		vnw_ary;

output  [35:0]	w0_rdata_h;     // m_cycle b_phase clock-like signal    
output  [35:0]	w0_rdata_l;     // m_cycle b_phase clock-like signal    
output  [35:0]	w1_rdata_h;     // m_cycle b_phase clock-like signal    
output  [35:0]	w1_rdata_l;     // m_cycle b_phase clock-like signal    

// synopsys translate_off

reg     [147:0]	mem[`ENTRIES-1:0];
reg     [143:0]	dout;
reg	[35:0]	w0_sao_h;
reg	[35:0]	w0_sao_l;
reg	[35:0]	w1_sao_h;
reg	[35:0]	w1_sao_l;

wire	[147:0]	wr_data;
wire	[143:0]	din;
wire	[147:0]	temp;


assign red_shift_en = red_en[1] & red_en[0];

//////////////////////////////////
// Initialize to zeros
`ifndef NOINITMEM
integer i;
initial begin
  for (i=0;i<128;i=i+1) begin
  mem[i] =  148'd0;
  end
end
`endif

/////////////////////////////
// wrdata input mapping 
////////////////////////////

assign data_in[143:0] = {
	wr_data_a[71],wr_data_a[70],wr_data_a[71],wr_data_a[70],
	wr_data_a[69],wr_data_a[68],wr_data_a[69],wr_data_a[68],
	wr_data_a[67],wr_data_a[66],wr_data_a[67],wr_data_a[66],
	wr_data_a[65],wr_data_a[64],wr_data_a[65],wr_data_a[64],
	wr_data_a[63],wr_data_a[62],wr_data_a[63],wr_data_a[62],
	wr_data_a[61],wr_data_a[60],wr_data_a[61],wr_data_a[60],
	wr_data_a[59],wr_data_a[58],wr_data_a[59],wr_data_a[58],
	wr_data_a[57],wr_data_a[56],wr_data_a[57],wr_data_a[56],
	wr_data_a[55],wr_data_a[54],wr_data_a[55],wr_data_a[54],
	wr_data_a[53],wr_data_a[52],wr_data_a[53],wr_data_a[52],
	wr_data_a[51],wr_data_a[50],wr_data_a[51],wr_data_a[50],
	wr_data_a[49],wr_data_a[48],wr_data_a[49],wr_data_a[48],
	wr_data_a[47],wr_data_a[46],wr_data_a[47],wr_data_a[46],
	wr_data_a[45],wr_data_a[44],wr_data_a[45],wr_data_a[44],
	wr_data_a[43],wr_data_a[42],wr_data_a[43],wr_data_a[42],
	wr_data_a[41],wr_data_a[40],wr_data_a[41],wr_data_a[40],
	wr_data_a[39],wr_data_a[38],wr_data_a[39],wr_data_a[38],
	wr_data_a[37],wr_data_a[36],wr_data_a[37],wr_data_a[36],
	wr_data_a[35],wr_data_a[34],wr_data_a[35],wr_data_a[34],
	wr_data_a[33],wr_data_a[32],wr_data_a[33],wr_data_a[32],
	wr_data_a[31],wr_data_a[30],wr_data_a[31],wr_data_a[30],
	wr_data_a[29],wr_data_a[28],wr_data_a[29],wr_data_a[28],
	wr_data_a[27],wr_data_a[26],wr_data_a[27],wr_data_a[26],
	wr_data_a[25],wr_data_a[24],wr_data_a[25],wr_data_a[24],
	wr_data_a[23],wr_data_a[22],wr_data_a[23],wr_data_a[22],
	wr_data_a[21],wr_data_a[20],wr_data_a[21],wr_data_a[20],
	wr_data_a[19],wr_data_a[18],wr_data_a[19],wr_data_a[18],
	wr_data_a[17],wr_data_a[16],wr_data_a[17],wr_data_a[16],
	wr_data_a[15],wr_data_a[14],wr_data_a[15],wr_data_a[14],
	wr_data_a[13],wr_data_a[12],wr_data_a[13],wr_data_a[12],
	wr_data_a[11],wr_data_a[10],wr_data_a[11],wr_data_a[10],
	wr_data_a[9],wr_data_a[8],wr_data_a[9],wr_data_a[8],
	wr_data_a[7],wr_data_a[6],wr_data_a[7],wr_data_a[6],
	wr_data_a[5],wr_data_a[4],wr_data_a[5],wr_data_a[4],
	wr_data_a[3],wr_data_a[2],wr_data_a[3],wr_data_a[2],
	wr_data_a[1],wr_data_a[0],wr_data_a[1],wr_data_a[0]};

////////////////////////////////
// Encode mask for byte enables
////////////////////////////////
assign byte_mask[143:0] = {
	{9{byte_wr_en_b[7],byte_wr_en_b[6],byte_wr_en_b[7],byte_wr_en_b[6],
 	   byte_wr_en_b[5],byte_wr_en_b[4],byte_wr_en_b[5],byte_wr_en_b[4]}},
	{9{byte_wr_en_b[3],byte_wr_en_b[2],byte_wr_en_b[3],byte_wr_en_b[2],
	   byte_wr_en_b[1],byte_wr_en_b[0],byte_wr_en_b[1],byte_wr_en_b[0]}}};

////////////////////////////////
// Encode mask for way enables
////////////////////////////////
assign w0_wcs = wr_waysel_b[0] & wr_en_b & ~wr_inh_b & ~rd_en_b ;   // way0 write 
assign w1_wcs = wr_waysel_b[1] & wr_en_b & ~wr_inh_b & ~rd_en_b ;   // way1 write

assign way_mask[143:0] = { {36{ {2{w1_wcs}},{2{w0_wcs}} }} };


assign din[143:0] = ( (byte_mask[143:0] & way_mask[143:0]) & data_in[143:0]) |
                    (~(byte_mask[143:0] & way_mask[143:0]) & local_dout[143:0]);

//////////////////////////
// Redundancy write shifter
//////////////////////////

assign wr_data[  3:  0] = din[  3:  0];
assign wr_data[  7:  4] = (red_shift_en && (red_data >= 6'd0 )) ? din[  7:  4] : din[  3:  0];
assign wr_data[ 11:  8] = (red_shift_en && (red_data >= 6'd1 )) ? din[ 11:  8] : din[  7:  4];
assign wr_data[ 15: 12] = (red_shift_en && (red_data >= 6'd2 )) ? din[ 15: 12] : din[ 11:  8];
assign wr_data[ 19: 16] = (red_shift_en && (red_data >= 6'd3 )) ? din[ 19: 16] : din[ 15: 12];
assign wr_data[ 23: 20] = (red_shift_en && (red_data >= 6'd4 )) ? din[ 23: 20] : din[ 19: 16];
assign wr_data[ 27: 24] = (red_shift_en && (red_data >= 6'd5 )) ? din[ 27: 24] : din[ 23: 20];
assign wr_data[ 31: 28] = (red_shift_en && (red_data >= 6'd6 )) ? din[ 31: 28] : din[ 27: 24];
assign wr_data[ 35: 32] = (red_shift_en && (red_data >= 6'd7 )) ? din[ 35: 32] : din[ 31: 28];
assign wr_data[ 39: 36] = (red_shift_en && (red_data >= 6'd8 )) ? din[ 39: 36] : din[ 35: 32];
assign wr_data[ 43: 40] = (red_shift_en && (red_data >= 6'd9 )) ? din[ 43: 40] : din[ 39: 36];
assign wr_data[ 47: 44] = (red_shift_en && (red_data >= 6'd10)) ? din[ 47: 44] : din[ 43: 40];
assign wr_data[ 51: 48] = (red_shift_en && (red_data >= 6'd11)) ? din[ 51: 48] : din[ 47: 44];
assign wr_data[ 55: 52] = (red_shift_en && (red_data >= 6'd12)) ? din[ 55: 52] : din[ 51: 48];
assign wr_data[ 59: 56] = (red_shift_en && (red_data >= 6'd13)) ? din[ 59: 56] : din[ 55: 52];
assign wr_data[ 63: 60] = (red_shift_en && (red_data >= 6'd14)) ? din[ 63: 60] : din[ 59: 56];
assign wr_data[ 67: 64] = (red_shift_en && (red_data >= 6'd15)) ? din[ 67: 64] : din[ 63: 60];
assign wr_data[ 71: 68] = (red_shift_en && (red_data >= 6'd16)) ? din[ 71: 68] : din[ 67: 64];
assign wr_data[ 75: 72] = (red_shift_en && (red_data >= 6'd17)) ? din[ 75: 72] : din[ 71: 68];
assign wr_data[ 79: 76] = (red_shift_en && (red_data >= 6'd18)) ? din[ 79: 76] : din[ 75: 72];
assign wr_data[ 83: 80] = (red_shift_en && (red_data >= 6'd19)) ? din[ 83: 80] : din[ 79: 76];
assign wr_data[ 87: 84] = (red_shift_en && (red_data >= 6'd20)) ? din[ 87: 84] : din[ 83: 80];
assign wr_data[ 91: 88] = (red_shift_en && (red_data >= 6'd21)) ? din[ 91: 88] : din[ 87: 84];
assign wr_data[ 95: 92] = (red_shift_en && (red_data >= 6'd22)) ? din[ 95: 92] : din[ 91: 88];
assign wr_data[ 99: 96] = (red_shift_en && (red_data >= 6'd23)) ? din[ 99: 96] : din[ 95: 92];
assign wr_data[103:100] = (red_shift_en && (red_data >= 6'd24)) ? din[103:100] : din[ 99: 96];
assign wr_data[107:104] = (red_shift_en && (red_data >= 6'd25)) ? din[107:104] : din[103:100];
assign wr_data[111:108] = (red_shift_en && (red_data >= 6'd26)) ? din[111:108] : din[107:104];
assign wr_data[115:112] = (red_shift_en && (red_data >= 6'd27)) ? din[115:112] : din[111:108];
assign wr_data[119:116] = (red_shift_en && (red_data >= 6'd28)) ? din[119:116] : din[115:112];
assign wr_data[123:120] = (red_shift_en && (red_data >= 6'd29)) ? din[123:120] : din[119:116];
assign wr_data[127:124] = (red_shift_en && (red_data >= 6'd30)) ? din[127:124] : din[123:120];
assign wr_data[131:128] = (red_shift_en && (red_data >= 6'd31)) ? din[131:128] : din[127:124];
assign wr_data[135:132] = (red_shift_en && (red_data >= 6'd32)) ? din[135:132] : din[131:128];
assign wr_data[139:136] = (red_shift_en && (red_data >= 6'd33)) ? din[139:136] : din[135:132];
assign wr_data[143:140] = (red_shift_en && (red_data >= 6'd34)) ? din[143:140] : din[139:136];
assign wr_data[147:144] = (red_shift_en && (red_data >= 6'd35)) ? 4'bx         : din[143:140];

//////////////////////
// Write array       
//////////////////////
assign rcs_l = rd_en_b & ~wr_en_b;              // read for both way0 & way1

always @ (negedge l1clk_wr) begin
    if ((w0_wcs | w1_wcs) & ~rcs_l & vnw_ary) begin
        mem[addr_b[10:4]] <= wr_data;


    end
end

assign temp[147:0] = mem[addr_b[10:4]];

//////////////////////////
// Redundancy read shifter
//////////////////////////

assign local_dout[  3:  0] = (red_shift_en && (red_data >= 6'd0 )) ? temp[  3:  0] : temp[  7:  4];
assign local_dout[  7:  4] = (red_shift_en && (red_data >= 6'd1 )) ? temp[  7:  4] : temp[ 11:  8];
assign local_dout[ 11:  8] = (red_shift_en && (red_data >= 6'd2 )) ? temp[ 11:  8] : temp[ 15: 12];
assign local_dout[ 15: 12] = (red_shift_en && (red_data >= 6'd3 )) ? temp[ 15: 12] : temp[ 19: 16];
assign local_dout[ 19: 16] = (red_shift_en && (red_data >= 6'd4 )) ? temp[ 19: 16] : temp[ 23: 20];
assign local_dout[ 23: 20] = (red_shift_en && (red_data >= 6'd5 )) ? temp[ 23: 20] : temp[ 27: 24];
assign local_dout[ 27: 24] = (red_shift_en && (red_data >= 6'd6 )) ? temp[ 27: 24] : temp[ 31: 28];
assign local_dout[ 31: 28] = (red_shift_en && (red_data >= 6'd7 )) ? temp[ 31: 28] : temp[ 35: 32];
assign local_dout[ 35: 32] = (red_shift_en && (red_data >= 6'd8 )) ? temp[ 35: 32] : temp[ 39: 36];
assign local_dout[ 39: 36] = (red_shift_en && (red_data >= 6'd9 )) ? temp[ 39: 36] : temp[ 43: 40];
assign local_dout[ 43: 40] = (red_shift_en && (red_data >= 6'd10)) ? temp[ 43: 40] : temp[ 47: 44];
assign local_dout[ 47: 44] = (red_shift_en && (red_data >= 6'd11)) ? temp[ 47: 44] : temp[ 51: 48];
assign local_dout[ 51: 48] = (red_shift_en && (red_data >= 6'd12)) ? temp[ 51: 48] : temp[ 55: 52];
assign local_dout[ 55: 52] = (red_shift_en && (red_data >= 6'd13)) ? temp[ 55: 52] : temp[ 59: 56];
assign local_dout[ 59: 56] = (red_shift_en && (red_data >= 6'd14)) ? temp[ 59: 56] : temp[ 63: 60];
assign local_dout[ 63: 60] = (red_shift_en && (red_data >= 6'd15)) ? temp[ 63: 60] : temp[ 67: 64];
assign local_dout[ 67: 64] = (red_shift_en && (red_data >= 6'd16)) ? temp[ 67: 64] : temp[ 71: 68];
assign local_dout[ 71: 68] = (red_shift_en && (red_data >= 6'd17)) ? temp[ 71: 68] : temp[ 75: 72];
assign local_dout[ 75: 72] = (red_shift_en && (red_data >= 6'd18)) ? temp[ 75: 72] : temp[ 79: 76];
assign local_dout[ 79: 76] = (red_shift_en && (red_data >= 6'd19)) ? temp[ 79: 76] : temp[ 83: 80];
assign local_dout[ 83: 80] = (red_shift_en && (red_data >= 6'd20)) ? temp[ 83: 80] : temp[ 87: 84];
assign local_dout[ 87: 84] = (red_shift_en && (red_data >= 6'd21)) ? temp[ 87: 84] : temp[ 91: 88];
assign local_dout[ 91: 88] = (red_shift_en && (red_data >= 6'd22)) ? temp[ 91: 88] : temp[ 95: 92];
assign local_dout[ 95: 92] = (red_shift_en && (red_data >= 6'd23)) ? temp[ 95: 92] : temp[ 99: 96];
assign local_dout[ 99: 96] = (red_shift_en && (red_data >= 6'd24)) ? temp[ 99: 96] : temp[103:100];
assign local_dout[103:100] = (red_shift_en && (red_data >= 6'd25)) ? temp[103:100] : temp[107:104];
assign local_dout[107:104] = (red_shift_en && (red_data >= 6'd26)) ? temp[107:104] : temp[111:108];
assign local_dout[111:108] = (red_shift_en && (red_data >= 6'd27)) ? temp[111:108] : temp[115:112];
assign local_dout[115:112] = (red_shift_en && (red_data >= 6'd28)) ? temp[115:112] : temp[119:116];
assign local_dout[119:116] = (red_shift_en && (red_data >= 6'd29)) ? temp[119:116] : temp[123:120];
assign local_dout[123:120] = (red_shift_en && (red_data >= 6'd30)) ? temp[123:120] : temp[127:124];
assign local_dout[127:124] = (red_shift_en && (red_data >= 6'd31)) ? temp[127:124] : temp[131:128];
assign local_dout[131:128] = (red_shift_en && (red_data >= 6'd32)) ? temp[131:128] : temp[135:132];
assign local_dout[135:132] = (red_shift_en && (red_data >= 6'd33)) ? temp[135:132] : temp[139:136];
assign local_dout[139:136] = (red_shift_en && (red_data >= 6'd34)) ? temp[139:136] : temp[143:140];
assign local_dout[143:140] = (red_shift_en && (red_data >= 6'd35)) ? temp[143:140] : temp[147:144];

//////////////////////
// Read array
//////////////////////
always @(posedge l1clk) begin
    if (rcs_l & vnw_ary) begin
        if (w0_wcs | w1_wcs | wr_inh_b)
            dout[143:0] <= 144'hx;
        else
            dout[143:0] <= local_dout[143:0];
    end
end

// Precharge
always @(negedge l1clk) begin
            dout[143:0] <= 144'h0;
end

//////////////////////////
// rd_data column mux 
//////////////////////////
assign w0_dout[35:0] = addr_b[3] ? 
{	dout[140], dout[136], dout[132], dout[128], dout[124], dout[120],
	dout[116], dout[112], dout[108], dout[104], dout[100], dout[96],
	dout[92], dout[88], dout[84], dout[80], dout[76], dout[72],
	dout[68], dout[64], dout[60], dout[56], dout[52], dout[48],
	dout[44], dout[40], dout[36], dout[32], dout[28], dout[24],
	dout[20], dout[16], dout[12], dout[8], dout[4], dout[0]} :
{	dout[141], dout[137], dout[133], dout[129], dout[125], dout[121],
	dout[117], dout[113], dout[109], dout[105], dout[101], dout[97],
	dout[93], dout[89], dout[85], dout[81], dout[77], dout[73],
	dout[69], dout[65], dout[61], dout[57], dout[53], dout[49],
	dout[45], dout[41], dout[37], dout[33], dout[29], dout[25],
	dout[21], dout[17], dout[13], dout[9], dout[5], dout[1]} ;

assign w1_dout[35:0] = addr_b[3] ? 
{	dout[142], dout[138], dout[134], dout[130], dout[126], dout[122],
	dout[118], dout[114], dout[110], dout[106], dout[102], dout[98],
	dout[94], dout[90], dout[86], dout[82], dout[78], dout[74],
	dout[70], dout[66], dout[62], dout[58], dout[54], dout[50],
	dout[46], dout[42], dout[38], dout[34], dout[30], dout[26],
	dout[22], dout[18], dout[14], dout[10], dout[6], dout[2]} :
{	dout[143], dout[139], dout[135], dout[131], dout[127], dout[123],
	dout[119], dout[115], dout[111], dout[107], dout[103], dout[99],
	dout[95], dout[91], dout[87], dout[83], dout[79], dout[75],
	dout[71], dout[67], dout[63], dout[59], dout[55], dout[51],
	dout[47], dout[43], dout[39], dout[35], dout[31], dout[27],
	dout[23], dout[19], dout[15], dout[11], dout[7], dout[3]} ;

// Need dual-rail at the outputs
always @(negedge l1clk or posedge wr_inh_b) begin
    if (wr_inh_b) begin
	w0_sao_h[35:0] <= 36'hx;
	w0_sao_l[35:0] <= 36'hx;
	w1_sao_h[35:0] <= 36'hx;
	w1_sao_l[35:0] <= 36'hx;
    end
    else begin
	w0_sao_h[35:0] <=  w0_dout[35:0] & {36{(rd_en_a & ~wr_en_a)}};
	w0_sao_l[35:0] <= ~w0_dout[35:0] & {36{(rd_en_a & ~wr_en_a)}};
	w1_sao_h[35:0] <=  w1_dout[35:0] & {36{(rd_en_a & ~wr_en_a)}};
	w1_sao_l[35:0] <= ~w1_dout[35:0] & {36{(rd_en_a & ~wr_en_a)}};
    end
end
always @(posedge l1clk or negedge rd_en_a) begin
	w0_sao_h[35:0] <= 36'h0;
	w0_sao_l[35:0] <= 36'h0;
	w1_sao_h[35:0] <= 36'h0;
	w1_sao_l[35:0] <= 36'h0;
end

//////////////////////////
// rd_data out mapping 
//////////////////////////
assign w0_rdata_h[35:0] = w0_sao_h[35:0] ;
assign w0_rdata_l[35:0] = w0_sao_l[35:0] ;
assign w1_rdata_h[35:0] = w1_sao_h[35:0] ;
assign w1_rdata_l[35:0] = w1_sao_l[35:0] ;


supply0 vss;
supply1 vdd;

// synopsys translate_on

endmodule




// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_dca_sp_9kb_cust_mux_macro__mux_aope__ports_2__width_64 (
  din0, 
  din1, 
  sel0, 
  dout);
wire psel0;
wire psel1;

  input [63:0] din0;
  input [63:0] din1;
  input sel0;
  output [63:0] dout;





cl_dp1_penc2_8x  c0_0 (
 .sel0(sel0),
 .psel0(psel0),
 .psel1(psel1)
);

mux2s #(64)  d0_0 (
  .sel0(psel0),
  .sel1(psel1),
  .in0(din0[63:0]),
  .in1(din1[63:0]),
.dout(dout[63:0])
);









  



endmodule






// any PARAMS parms go into naming of macro

module n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_8 (
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













// any PARAMS parms go into naming of macro

module n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_64 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [63:0] fdin;

  input [63:0] din;
  input l1clk;
  input [63:0] scan_in;


  input siclk;
  input soclk;

  output [63:0] dout;
  output [63:0] scan_out;
assign fdin[63:0] = din[63:0];






dff #(64)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[63:0]),
.si(scan_in[63:0]),
.so(scan_out[63:0]),
.q(dout[63:0])
);












endmodule









// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_dca_sp_9kb_cust_mux_macro__mux_aope__ports_2__width_4 (
  din0, 
  din1, 
  sel0, 
  dout);
wire psel0;
wire psel1;

  input [3:0] din0;
  input [3:0] din1;
  input sel0;
  output [3:0] dout;





cl_dp1_penc2_8x  c0_0 (
 .sel0(sel0),
 .psel0(psel0),
 .psel1(psel1)
);

mux2s #(4)  d0_0 (
  .sel0(psel0),
  .sel1(psel1),
  .in0(din0[3:0]),
  .in1(din1[3:0]),
.dout(dout[3:0])
);









  



endmodule


// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_dca_sp_9kb_cust_mux_macro__mux_aonpe__ports_4__width_64 (
  din0, 
  sel0, 
  din1, 
  sel1, 
  din2, 
  sel2, 
  din3, 
  sel3, 
  dout);
wire buffout0;
wire buffout1;
wire buffout2;
wire buffout3;

  input [63:0] din0;
  input sel0;
  input [63:0] din1;
  input sel1;
  input [63:0] din2;
  input sel2;
  input [63:0] din3;
  input sel3;
  output [63:0] dout;





cl_dp1_muxbuff4_8x  c0_0 (
 .in0(sel0),
 .in1(sel1),
 .in2(sel2),
 .in3(sel3),
 .out0(buffout0),
 .out1(buffout1),
 .out2(buffout2),
 .out3(buffout3)
);
mux4s #(64)  d0_0 (
  .sel0(buffout0),
  .sel1(buffout1),
  .sel2(buffout2),
  .sel3(buffout3),
  .in0(din0[63:0]),
  .in1(din1[63:0]),
  .in2(din2[63:0]),
  .in3(din3[63:0]),
.dout(dout[63:0])
);









  



endmodule


// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_dca_sp_9kb_cust_mux_macro__mux_aonpe__ports_4__width_8 (
  din0, 
  sel0, 
  din1, 
  sel1, 
  din2, 
  sel2, 
  din3, 
  sel3, 
  dout);
wire buffout0;
wire buffout1;
wire buffout2;
wire buffout3;

  input [7:0] din0;
  input sel0;
  input [7:0] din1;
  input sel1;
  input [7:0] din2;
  input sel2;
  input [7:0] din3;
  input sel3;
  output [7:0] dout;





cl_dp1_muxbuff4_8x  c0_0 (
 .in0(sel0),
 .in1(sel1),
 .in2(sel2),
 .in3(sel3),
 .out0(buffout0),
 .out1(buffout1),
 .out2(buffout2),
 .out3(buffout3)
);
mux4s #(8)  d0_0 (
  .sel0(buffout0),
  .sel1(buffout1),
  .sel2(buffout2),
  .sel3(buffout3),
  .in0(din0[7:0]),
  .in1(din1[7:0]),
  .in2(din2[7:0]),
  .in3(din3[7:0]),
.dout(dout[7:0])
);









  



endmodule


//
//   xor macro for ports = 2,3
//
//





module n2_dca_sp_9kb_cust_xor_macro__ports_3__width_4 (
  din0, 
  din1, 
  din2, 
  dout);
  input [3:0] din0;
  input [3:0] din1;
  input [3:0] din2;
  output [3:0] dout;





xor3 #(4)  d0_0 (
.in0(din0[3:0]),
.in1(din1[3:0]),
.in2(din2[3:0]),
.out(dout[3:0])
);








endmodule





// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module n2_dca_sp_9kb_cust_mux_macro__mux_aonpe__ports_8__width_1 (
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






// any PARAMS parms go into naming of macro

module n2_dca_sp_9kb_cust_msff_ctl_macro__fs_1__width_12 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [11:0] fdin;

  input [11:0] din;
  input l1clk;
  input [11:0] scan_in;


  input siclk;
  input soclk;

  output [11:0] dout;
  output [11:0] scan_out;
assign fdin[11:0] = din[11:0];






dff #(12)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[11:0]),
.si(scan_in[11:0]),
.so(scan_out[11:0]),
.q(dout[11:0])
);












endmodule

`endif // `ifndef FPGA

`ifdef FPGA
/* Source file "n2_dca_sp_9kb_cust_vj.v", line 1 */
// No timescale specified
module n2_dca_sp_9kb_cust(dcache_rd_addr_e, dcache_alt_addr_e, 
	dcache_alt_addr_sel_e, dcache_rvld_e, dcache_wvld_e, dcache_clk_en_e, 
	dcache_wclk_en_e, dcache_rclk_en_m, dcache_wdata_e, dcache_wr_way_e, 
	dcache_byte_wr_en_e, dcache_alt_rsel_way_m, dcache_rsel_way_b, 
	dcache_alt_way_sel_m, lsu_l2fill_or_byp_data_m, dcache_bypass_e_, 
	dcache_rdata_b, dcache_rparity_b, dcache_perr_w0_b, dcache_perr_w1_b, 
	dcache_perr_w2_b, dcache_perr_w3_b, dcache_rdata_msb_w0_b, 
	dcache_rdata_msb_w1_b, dcache_rdata_msb_w2_b, dcache_rdata_msb_w3_b, 
	l2clk, scan_in, tcu_pce_ov, tcu_aclk, tcu_bclk, tcu_array_wr_inhibit, 
	tcu_scan_en, tcu_se_scancollar_in, tcu_se_scancollar_out, scan_out, 
	fuse_dca_repair_value, fuse_dca_repair_en, fuse_dca_rid, fuse_dca_wen, 
	fuse_red_reset, dca_fuse_repair_value, dca_fuse_repair_en, vnw_ary);

	input	[10:3]		dcache_rd_addr_e;
	input	[10:3]		dcache_alt_addr_e;
	input			dcache_alt_addr_sel_e;
	input			dcache_rvld_e;
	input			dcache_wvld_e;
	input			dcache_clk_en_e;
	input			dcache_wclk_en_e;
	input			dcache_rclk_en_m;
	input	[143:0]		dcache_wdata_e;
	input	[1:0]		dcache_wr_way_e;
	input	[15:0]		dcache_byte_wr_en_e;
	input	[3:0]		dcache_alt_rsel_way_m;
	input	[3:0]		dcache_rsel_way_b;
	input			dcache_alt_way_sel_m;
	input	[63:0]		lsu_l2fill_or_byp_data_m;
	input			dcache_bypass_e_;
	output	[63:0]		dcache_rdata_b;
	output	[7:0]		dcache_rparity_b;
	output			dcache_perr_w0_b;
	output			dcache_perr_w1_b;
	output			dcache_perr_w2_b;
	output			dcache_perr_w3_b;
	output	[7:0]		dcache_rdata_msb_w0_b;
	output	[7:0]		dcache_rdata_msb_w1_b;
	output	[7:0]		dcache_rdata_msb_w2_b;
	output	[7:0]		dcache_rdata_msb_w3_b;
	input			l2clk;
	input			scan_in;
	input			tcu_pce_ov;
	input			tcu_aclk;
	input			tcu_bclk;
	input			tcu_array_wr_inhibit;
	input			tcu_scan_en;
	input			tcu_se_scancollar_in;
	input			tcu_se_scancollar_out;
	output			scan_out;
	input	[5:0]		fuse_dca_repair_value;
	input	[1:0]		fuse_dca_repair_en;
	input	[1:0]		fuse_dca_rid;
	input			fuse_dca_wen;
	input			fuse_red_reset;
	output	[5:0]		dca_fuse_repair_value;
	output	[1:0]		dca_fuse_repair_en;
	input			vnw_ary;

	wire			l1clk_in;
	wire			l1clk_in_pm;
	wire			l1clk_out_pm;
	wire			l1clk_out;
	wire			l1clk_free;
	wire			l1clk_free_wpm;
	wire			l1clk_red;
	wire	[10:3]		dcache_rwaddr_e;
	wire	[7:0]		lat_addr_scanin;
	wire	[7:0]		lat_addr_scanout;
	wire	[10:3]		dcache_rwaddr_eb;
	wire	[10:3]		dcache_rwaddr_l_unused;
	wire	[3:0]		wr_way_dec_e;
	wire	[6:0]		lat_ctl_eb_scanin;
	wire	[6:0]		lat_ctl_eb_scanout;
	wire			dcache_rvld_top_eb;
	wire			dcache_rvld_bot_eb;
	wire			dcache_wvld_eb;
	wire	[3:0]		wr_way_dec_eb;
	wire	[6:0]		lat_ctl_unused;
	wire	[2:0]		dff_ctl_m_0_scanin;
	wire	[2:0]		dff_ctl_m_0_scanout;
	wire			dcache_rvld_m;
	wire			dcache_wvld_m;
	wire			dcache_bypass_m_;
	wire	[15:0]		dff_ctl_m_1_scanin;
	wire	[15:0]		dff_ctl_m_1_scanout;
	wire	[15:0]		byte_wr_en_eb;
	wire	[15:0]		dff_ctl_l_unused;
	wire	[4:0]		dff_ctl_b_scanin;
	wire	[4:0]		dff_ctl_b_scanout;
	wire			dcache_alt_way_sel_b;
	wire	[3:0]		dcache_alt_rsel_way_b;
	wire	[143:0]		dff_wdata_m_scanin;
	wire	[143:0]		dff_wdata_m_scanout;
	wire	[15:0]		dcache_wparity_m;
	wire	[127:0]		dcache_wdata_m;
	wire	[5:0]		fuse_dca_repair_value_ff;
	wire	[1:0]		fuse_dca_repair_en_ff;
	wire	[1:0]		fuse_dca_rid_ff;
	wire			fuse_dca_wen_ff;
	wire			fuse_red_reset_ff;
	wire	[5:0]		dca_fuse_repair_value_pre;
	wire	[1:0]		dca_fuse_repair_en_pre;
	wire	[63:0]		dcache_rdata_w0_m;
	wire	[63:0]		rdata_w0_m;
	wire	[63:0]		rdata_w1_m;
	wire	[63:0]		dcache_rdata_w1_m;
	wire	[63:0]		rdata_w2_m;
	wire	[63:0]		dcache_rdata_w2_m;
	wire	[63:0]		rdata_w3_m;
	wire	[63:0]		dcache_rdata_w3_m;
	wire	[7:0]		dff_msb_w0_scanin;
	wire	[7:0]		dff_msb_w0_scanout;
	wire	[7:0]		dff_msb_w1_scanin;
	wire	[7:0]		dff_msb_w1_scanout;
	wire	[7:0]		dff_msb_w2_scanin;
	wire	[7:0]		dff_msb_w2_scanout;
	wire	[7:0]		dff_msb_w3_scanin;
	wire	[7:0]		dff_msb_w3_scanout;
	wire	[63:0]		dff_rdata_w0_m_scanin;
	wire	[63:0]		dff_rdata_w0_m_scanout;
	wire	[63:0]		rdata_w0_b;
	wire	[7:0]		dff_rparity_w0_m_scanin;
	wire	[7:0]		dff_rparity_w0_m_scanout;
	wire	[7:0]		rparity_w0_m;
	wire	[7:0]		rparity_w0_b;
	wire	[63:0]		dff_rdata_w1_m_scanin;
	wire	[63:0]		dff_rdata_w1_m_scanout;
	wire	[63:0]		rdata_w1_b;
	wire	[7:0]		dff_rparity_w1_m_scanin;
	wire	[7:0]		dff_rparity_w1_m_scanout;
	wire	[7:0]		rparity_w1_m;
	wire	[7:0]		rparity_w1_b;
	wire	[63:0]		dff_rdata_w2_m_scanin;
	wire	[63:0]		dff_rdata_w2_m_scanout;
	wire	[63:0]		rdata_w2_b;
	wire	[7:0]		dff_rparity_w2_m_scanin;
	wire	[7:0]		dff_rparity_w2_m_scanout;
	wire	[7:0]		rparity_w2_m;
	wire	[7:0]		rparity_w2_b;
	wire	[63:0]		dff_rdata_w3_m_scanin;
	wire	[63:0]		dff_rdata_w3_m_scanout;
	wire	[63:0]		rdata_w3_b;
	wire	[7:0]		dff_rparity_w3_m_scanin;
	wire	[7:0]		dff_rparity_w3_m_scanout;
	wire	[7:0]		rparity_w3_m;
	wire	[7:0]		rparity_w3_b;
	wire	[3:0]		dcache_rd_sel_way_b;
	wire			w0_p0_0;
	wire			w0_p0_1;
	wire			w0_p0_2;
	wire	[7:0]		w0_parity_m;
	wire			w0_p1_0;
	wire			w0_p1_1;
	wire			w0_p1_2;
	wire			w0_p2_0;
	wire			w0_p2_1;
	wire			w0_p2_2;
	wire			w0_p3_0;
	wire			w0_p3_1;
	wire			w0_p3_2;
	wire			w0_p4_0;
	wire			w0_p4_1;
	wire			w0_p4_2;
	wire			w0_p5_0;
	wire			w0_p5_1;
	wire			w0_p5_2;
	wire			w0_p6_0;
	wire			w0_p6_1;
	wire			w0_p6_2;
	wire			w0_p7_0;
	wire			w0_p7_1;
	wire			w0_p7_2;
	wire			w1_p0_0;
	wire			w1_p0_1;
	wire			w1_p0_2;
	wire	[7:0]		w1_parity_m;
	wire			w1_p1_0;
	wire			w1_p1_1;
	wire			w1_p1_2;
	wire			w1_p2_0;
	wire			w1_p2_1;
	wire			w1_p2_2;
	wire			w1_p3_0;
	wire			w1_p3_1;
	wire			w1_p3_2;
	wire			w1_p4_0;
	wire			w1_p4_1;
	wire			w1_p4_2;
	wire			w1_p5_0;
	wire			w1_p5_1;
	wire			w1_p5_2;
	wire			w1_p6_0;
	wire			w1_p6_1;
	wire			w1_p6_2;
	wire			w1_p7_0;
	wire			w1_p7_1;
	wire			w1_p7_2;
	wire			w2_p0_0;
	wire			w2_p0_1;
	wire			w2_p0_2;
	wire	[7:0]		w2_parity_m;
	wire			w2_p1_0;
	wire			w2_p1_1;
	wire			w2_p1_2;
	wire			w2_p2_0;
	wire			w2_p2_1;
	wire			w2_p2_2;
	wire			w2_p3_0;
	wire			w2_p3_1;
	wire			w2_p3_2;
	wire			w2_p4_0;
	wire			w2_p4_1;
	wire			w2_p4_2;
	wire			w2_p5_0;
	wire			w2_p5_1;
	wire			w2_p5_2;
	wire			w2_p6_0;
	wire			w2_p6_1;
	wire			w2_p6_2;
	wire			w2_p7_0;
	wire			w2_p7_1;
	wire			w2_p7_2;
	wire			w3_p0_0;
	wire			w3_p0_1;
	wire			w3_p0_2;
	wire	[7:0]		w3_parity_m;
	wire			w3_p1_0;
	wire			w3_p1_1;
	wire			w3_p1_2;
	wire			w3_p2_0;
	wire			w3_p2_1;
	wire			w3_p2_2;
	wire			w3_p3_0;
	wire			w3_p3_1;
	wire			w3_p3_2;
	wire			w3_p4_0;
	wire			w3_p4_1;
	wire			w3_p4_2;
	wire			w3_p5_0;
	wire			w3_p5_1;
	wire			w3_p5_2;
	wire			w3_p6_0;
	wire			w3_p6_1;
	wire			w3_p6_2;
	wire			w3_p7_0;
	wire			w3_p7_1;
	wire			w3_p7_2;
	wire	[7:0]		dff_byte_perr_w0_scanin;
	wire	[7:0]		dff_byte_perr_w0_scanout;
	wire	[7:0]		w0_parity_b;
	wire	[7:0]		dff_byte_perr_w1_scanin;
	wire	[7:0]		dff_byte_perr_w1_scanout;
	wire	[7:0]		w1_parity_b;
	wire	[7:0]		dff_byte_perr_w2_scanin;
	wire	[7:0]		dff_byte_perr_w2_scanout;
	wire	[7:0]		w2_parity_b;
	wire	[7:0]		dff_byte_perr_w3_scanin;
	wire	[7:0]		dff_byte_perr_w3_scanout;
	wire	[7:0]		w3_parity_b;
	wire			w0_parity_err_b;
	wire			w1_parity_err_b;
	wire			w2_parity_err_b;
	wire			w3_parity_err_b;
	wire	[11:0]		dff_red_in_scanin;
	wire	[11:0]		dff_red_in_scanout;
	wire	[7:0]		dff_red_out_scanin;
	wire	[7:0]		dff_red_out_scanout;
	wire			pce_ov = tcu_pce_ov;
	wire			stop = 1'b0;
	wire			siclk = tcu_aclk;
	wire			soclk = tcu_bclk;
	supply0			vss;
	supply1			vdd;

	assign rdata_w1_m[63:0] = dcache_rdata_w1_m[63:0];
	assign rdata_w2_m[63:0] = dcache_rdata_w2_m[63:0];
	assign rdata_w3_m[63:0] = dcache_rdata_w3_m[63:0];
	assign dcache_perr_w0_b = w0_parity_err_b;
	assign dcache_perr_w1_b = w1_parity_err_b;
	assign dcache_perr_w2_b = w2_parity_err_b;
	assign dcache_perr_w3_b = w3_parity_err_b;
	assign dff_byte_perr_w0_scanin[7] = scan_in;
	assign dff_byte_perr_w1_scanin[7] = dff_byte_perr_w0_scanout[7];
	assign dff_byte_perr_w1_scanin[6] = dff_byte_perr_w1_scanout[7];
	assign dff_byte_perr_w0_scanin[6] = dff_byte_perr_w1_scanout[6];
	assign dff_byte_perr_w0_scanin[5] = dff_byte_perr_w0_scanout[6];
	assign dff_byte_perr_w1_scanin[5] = dff_byte_perr_w0_scanout[5];
	assign dff_byte_perr_w1_scanin[4] = dff_byte_perr_w1_scanout[5];
	assign dff_byte_perr_w0_scanin[4] = dff_byte_perr_w1_scanout[4];
	assign dff_wdata_m_scanin[143] = dff_byte_perr_w0_scanout[4];
	assign dff_wdata_m_scanin[71] = dff_wdata_m_scanout[143];
	assign dff_rparity_w3_m_scanin[7] = dff_wdata_m_scanout[71];
	assign dff_rparity_w2_m_scanin[7] = dff_rparity_w3_m_scanout[7];
	assign dff_rparity_w1_m_scanin[7] = dff_rparity_w2_m_scanout[7];
	assign dff_rparity_w0_m_scanin[7] = dff_rparity_w1_m_scanout[7];
	assign dff_wdata_m_scanin[134] = dff_rparity_w0_m_scanout[7];
	assign dff_wdata_m_scanin[62] = dff_wdata_m_scanout[134];
	assign dff_rparity_w3_m_scanin[6] = dff_wdata_m_scanout[62];
	assign dff_rparity_w2_m_scanin[6] = dff_rparity_w3_m_scanout[6];
	assign dff_rparity_w1_m_scanin[6] = dff_rparity_w2_m_scanout[6];
	assign dff_rparity_w0_m_scanin[6] = dff_rparity_w1_m_scanout[6];
	assign dff_wdata_m_scanin[142] = dff_rparity_w0_m_scanout[6];
	assign dff_wdata_m_scanin[70] = dff_wdata_m_scanout[142];
	assign dff_rdata_w3_m_scanin[63] = dff_wdata_m_scanout[70];
	assign dff_rdata_w2_m_scanin[63] = dff_rdata_w3_m_scanout[63];
	assign dff_rdata_w1_m_scanin[63] = dff_rdata_w2_m_scanout[63];
	assign dff_rdata_w0_m_scanin[63] = dff_rdata_w1_m_scanout[63];
	assign dff_wdata_m_scanin[133] = dff_rdata_w0_m_scanout[63];
	assign dff_wdata_m_scanin[61] = dff_wdata_m_scanout[133];
	assign dff_rdata_w3_m_scanin[55] = dff_wdata_m_scanout[61];
	assign dff_rdata_w2_m_scanin[55] = dff_rdata_w3_m_scanout[55];
	assign dff_rdata_w1_m_scanin[55] = dff_rdata_w2_m_scanout[55];
	assign dff_rdata_w0_m_scanin[55] = dff_rdata_w1_m_scanout[55];
	assign dff_wdata_m_scanin[141] = dff_rdata_w0_m_scanout[55];
	assign dff_wdata_m_scanin[69] = dff_wdata_m_scanout[141];
	assign dff_rdata_w3_m_scanin[62] = dff_wdata_m_scanout[69];
	assign dff_rdata_w2_m_scanin[62] = dff_rdata_w3_m_scanout[62];
	assign dff_rdata_w1_m_scanin[62] = dff_rdata_w2_m_scanout[62];
	assign dff_rdata_w0_m_scanin[62] = dff_rdata_w1_m_scanout[62];
	assign dff_wdata_m_scanin[132] = dff_rdata_w0_m_scanout[62];
	assign dff_wdata_m_scanin[60] = dff_wdata_m_scanout[132];
	assign dff_rdata_w3_m_scanin[54] = dff_wdata_m_scanout[60];
	assign dff_rdata_w2_m_scanin[54] = dff_rdata_w3_m_scanout[54];
	assign dff_rdata_w1_m_scanin[54] = dff_rdata_w2_m_scanout[54];
	assign dff_rdata_w0_m_scanin[54] = dff_rdata_w1_m_scanout[54];
	assign dff_wdata_m_scanin[140] = dff_rdata_w0_m_scanout[54];
	assign dff_wdata_m_scanin[68] = dff_wdata_m_scanout[140];
	assign dff_rdata_w3_m_scanin[61] = dff_wdata_m_scanout[68];
	assign dff_rdata_w2_m_scanin[61] = dff_rdata_w3_m_scanout[61];
	assign dff_rdata_w1_m_scanin[61] = dff_rdata_w2_m_scanout[61];
	assign dff_rdata_w0_m_scanin[61] = dff_rdata_w1_m_scanout[61];
	assign dff_wdata_m_scanin[131] = dff_rdata_w0_m_scanout[61];
	assign dff_wdata_m_scanin[59] = dff_wdata_m_scanout[131];
	assign dff_rdata_w3_m_scanin[53] = dff_wdata_m_scanout[59];
	assign dff_rdata_w2_m_scanin[53] = dff_rdata_w3_m_scanout[53];
	assign dff_rdata_w1_m_scanin[53] = dff_rdata_w2_m_scanout[53];
	assign dff_rdata_w0_m_scanin[53] = dff_rdata_w1_m_scanout[53];
	assign dff_wdata_m_scanin[139] = dff_rdata_w0_m_scanout[53];
	assign dff_wdata_m_scanin[67] = dff_wdata_m_scanout[139];
	assign dff_rdata_w3_m_scanin[60] = dff_wdata_m_scanout[67];
	assign dff_rdata_w2_m_scanin[60] = dff_rdata_w3_m_scanout[60];
	assign dff_rdata_w1_m_scanin[60] = dff_rdata_w2_m_scanout[60];
	assign dff_rdata_w0_m_scanin[60] = dff_rdata_w1_m_scanout[60];
	assign dff_wdata_m_scanin[130] = dff_rdata_w0_m_scanout[60];
	assign dff_wdata_m_scanin[58] = dff_wdata_m_scanout[130];
	assign dff_rdata_w3_m_scanin[52] = dff_wdata_m_scanout[58];
	assign dff_rdata_w2_m_scanin[52] = dff_rdata_w3_m_scanout[52];
	assign dff_rdata_w1_m_scanin[52] = dff_rdata_w2_m_scanout[52];
	assign dff_rdata_w0_m_scanin[52] = dff_rdata_w1_m_scanout[52];
	assign dff_wdata_m_scanin[138] = dff_rdata_w0_m_scanout[52];
	assign dff_wdata_m_scanin[66] = dff_wdata_m_scanout[138];
	assign dff_rdata_w3_m_scanin[59] = dff_wdata_m_scanout[66];
	assign dff_rdata_w2_m_scanin[59] = dff_rdata_w3_m_scanout[59];
	assign dff_rdata_w1_m_scanin[59] = dff_rdata_w2_m_scanout[59];
	assign dff_rdata_w0_m_scanin[59] = dff_rdata_w1_m_scanout[59];
	assign dff_wdata_m_scanin[129] = dff_rdata_w0_m_scanout[59];
	assign dff_wdata_m_scanin[57] = dff_wdata_m_scanout[129];
	assign dff_rdata_w3_m_scanin[51] = dff_wdata_m_scanout[57];
	assign dff_rdata_w2_m_scanin[51] = dff_rdata_w3_m_scanout[51];
	assign dff_rdata_w1_m_scanin[51] = dff_rdata_w2_m_scanout[51];
	assign dff_rdata_w0_m_scanin[51] = dff_rdata_w1_m_scanout[51];
	assign dff_wdata_m_scanin[137] = dff_rdata_w0_m_scanout[51];
	assign dff_wdata_m_scanin[65] = dff_wdata_m_scanout[137];
	assign dff_rdata_w3_m_scanin[58] = dff_wdata_m_scanout[65];
	assign dff_rdata_w2_m_scanin[58] = dff_rdata_w3_m_scanout[58];
	assign dff_rdata_w1_m_scanin[58] = dff_rdata_w2_m_scanout[58];
	assign dff_rdata_w0_m_scanin[58] = dff_rdata_w1_m_scanout[58];
	assign dff_wdata_m_scanin[128] = dff_rdata_w0_m_scanout[58];
	assign dff_wdata_m_scanin[56] = dff_wdata_m_scanout[128];
	assign dff_rdata_w3_m_scanin[50] = dff_wdata_m_scanout[56];
	assign dff_rdata_w2_m_scanin[50] = dff_rdata_w3_m_scanout[50];
	assign dff_rdata_w1_m_scanin[50] = dff_rdata_w2_m_scanout[50];
	assign dff_rdata_w0_m_scanin[50] = dff_rdata_w1_m_scanout[50];
	assign dff_wdata_m_scanin[136] = dff_rdata_w0_m_scanout[50];
	assign dff_wdata_m_scanin[64] = dff_wdata_m_scanout[136];
	assign dff_rdata_w3_m_scanin[57] = dff_wdata_m_scanout[64];
	assign dff_rdata_w2_m_scanin[57] = dff_rdata_w3_m_scanout[57];
	assign dff_rdata_w1_m_scanin[57] = dff_rdata_w2_m_scanout[57];
	assign dff_rdata_w0_m_scanin[57] = dff_rdata_w1_m_scanout[57];
	assign dff_wdata_m_scanin[127] = dff_rdata_w0_m_scanout[57];
	assign dff_wdata_m_scanin[55] = dff_wdata_m_scanout[127];
	assign dff_rdata_w3_m_scanin[49] = dff_wdata_m_scanout[55];
	assign dff_rdata_w2_m_scanin[49] = dff_rdata_w3_m_scanout[49];
	assign dff_rdata_w1_m_scanin[49] = dff_rdata_w2_m_scanout[49];
	assign dff_rdata_w0_m_scanin[49] = dff_rdata_w1_m_scanout[49];
	assign dff_wdata_m_scanin[135] = dff_rdata_w0_m_scanout[49];
	assign dff_wdata_m_scanin[63] = dff_wdata_m_scanout[135];
	assign dff_rdata_w3_m_scanin[56] = dff_wdata_m_scanout[63];
	assign dff_rdata_w2_m_scanin[56] = dff_rdata_w3_m_scanout[56];
	assign dff_rdata_w1_m_scanin[56] = dff_rdata_w2_m_scanout[56];
	assign dff_rdata_w0_m_scanin[56] = dff_rdata_w1_m_scanout[56];
	assign dff_wdata_m_scanin[126] = dff_rdata_w0_m_scanout[56];
	assign dff_wdata_m_scanin[54] = dff_wdata_m_scanout[126];
	assign dff_rdata_w3_m_scanin[48] = dff_wdata_m_scanout[54];
	assign dff_rdata_w2_m_scanin[48] = dff_rdata_w3_m_scanout[48];
	assign dff_rdata_w1_m_scanin[48] = dff_rdata_w2_m_scanout[48];
	assign dff_rdata_w0_m_scanin[48] = dff_rdata_w1_m_scanout[48];
	assign dff_wdata_m_scanin[125] = dff_rdata_w0_m_scanout[48];
	assign dff_wdata_m_scanin[53] = dff_wdata_m_scanout[125];
	assign dff_rparity_w3_m_scanin[5] = dff_wdata_m_scanout[53];
	assign dff_rparity_w2_m_scanin[5] = dff_rparity_w3_m_scanout[5];
	assign dff_rparity_w1_m_scanin[5] = dff_rparity_w2_m_scanout[5];
	assign dff_rparity_w0_m_scanin[5] = dff_rparity_w1_m_scanout[5];
	assign dff_wdata_m_scanin[116] = dff_rparity_w0_m_scanout[5];
	assign dff_wdata_m_scanin[44] = dff_wdata_m_scanout[116];
	assign dff_rparity_w3_m_scanin[4] = dff_wdata_m_scanout[44];
	assign dff_rparity_w2_m_scanin[4] = dff_rparity_w3_m_scanout[4];
	assign dff_rparity_w1_m_scanin[4] = dff_rparity_w2_m_scanout[4];
	assign dff_rparity_w0_m_scanin[4] = dff_rparity_w1_m_scanout[4];
	assign dff_wdata_m_scanin[124] = dff_rparity_w0_m_scanout[4];
	assign dff_wdata_m_scanin[52] = dff_wdata_m_scanout[124];
	assign dff_rdata_w3_m_scanin[47] = dff_wdata_m_scanout[52];
	assign dff_rdata_w2_m_scanin[47] = dff_rdata_w3_m_scanout[47];
	assign dff_rdata_w1_m_scanin[47] = dff_rdata_w2_m_scanout[47];
	assign dff_rdata_w0_m_scanin[47] = dff_rdata_w1_m_scanout[47];
	assign dff_wdata_m_scanin[115] = dff_rdata_w0_m_scanout[47];
	assign dff_wdata_m_scanin[43] = dff_wdata_m_scanout[115];
	assign dff_rdata_w3_m_scanin[39] = dff_wdata_m_scanout[43];
	assign dff_rdata_w2_m_scanin[39] = dff_rdata_w3_m_scanout[39];
	assign dff_rdata_w1_m_scanin[39] = dff_rdata_w2_m_scanout[39];
	assign dff_rdata_w0_m_scanin[39] = dff_rdata_w1_m_scanout[39];
	assign dff_wdata_m_scanin[123] = dff_rdata_w0_m_scanout[39];
	assign dff_wdata_m_scanin[51] = dff_wdata_m_scanout[123];
	assign dff_rdata_w3_m_scanin[46] = dff_wdata_m_scanout[51];
	assign dff_rdata_w2_m_scanin[46] = dff_rdata_w3_m_scanout[46];
	assign dff_rdata_w1_m_scanin[46] = dff_rdata_w2_m_scanout[46];
	assign dff_rdata_w0_m_scanin[46] = dff_rdata_w1_m_scanout[46];
	assign dff_wdata_m_scanin[114] = dff_rdata_w0_m_scanout[46];
	assign dff_wdata_m_scanin[42] = dff_wdata_m_scanout[114];
	assign dff_rdata_w3_m_scanin[38] = dff_wdata_m_scanout[42];
	assign dff_rdata_w2_m_scanin[38] = dff_rdata_w3_m_scanout[38];
	assign dff_rdata_w1_m_scanin[38] = dff_rdata_w2_m_scanout[38];
	assign dff_rdata_w0_m_scanin[38] = dff_rdata_w1_m_scanout[38];
	assign dff_wdata_m_scanin[122] = dff_rdata_w0_m_scanout[38];
	assign dff_wdata_m_scanin[50] = dff_wdata_m_scanout[122];
	assign dff_rdata_w3_m_scanin[45] = dff_wdata_m_scanout[50];
	assign dff_rdata_w2_m_scanin[45] = dff_rdata_w3_m_scanout[45];
	assign dff_rdata_w1_m_scanin[45] = dff_rdata_w2_m_scanout[45];
	assign dff_rdata_w0_m_scanin[45] = dff_rdata_w1_m_scanout[45];
	assign dff_wdata_m_scanin[113] = dff_rdata_w0_m_scanout[45];
	assign dff_wdata_m_scanin[41] = dff_wdata_m_scanout[113];
	assign dff_rdata_w3_m_scanin[37] = dff_wdata_m_scanout[41];
	assign dff_rdata_w2_m_scanin[37] = dff_rdata_w3_m_scanout[37];
	assign dff_rdata_w1_m_scanin[37] = dff_rdata_w2_m_scanout[37];
	assign dff_rdata_w0_m_scanin[37] = dff_rdata_w1_m_scanout[37];
	assign dff_wdata_m_scanin[121] = dff_rdata_w0_m_scanout[37];
	assign dff_wdata_m_scanin[49] = dff_wdata_m_scanout[121];
	assign dff_rdata_w3_m_scanin[44] = dff_wdata_m_scanout[49];
	assign dff_rdata_w2_m_scanin[44] = dff_rdata_w3_m_scanout[44];
	assign dff_rdata_w1_m_scanin[44] = dff_rdata_w2_m_scanout[44];
	assign dff_rdata_w0_m_scanin[44] = dff_rdata_w1_m_scanout[44];
	assign dff_wdata_m_scanin[112] = dff_rdata_w0_m_scanout[44];
	assign dff_wdata_m_scanin[40] = dff_wdata_m_scanout[112];
	assign dff_rdata_w3_m_scanin[36] = dff_wdata_m_scanout[40];
	assign dff_rdata_w2_m_scanin[36] = dff_rdata_w3_m_scanout[36];
	assign dff_rdata_w1_m_scanin[36] = dff_rdata_w2_m_scanout[36];
	assign dff_rdata_w0_m_scanin[36] = dff_rdata_w1_m_scanout[36];
	assign dff_wdata_m_scanin[120] = dff_rdata_w0_m_scanout[36];
	assign dff_wdata_m_scanin[48] = dff_wdata_m_scanout[120];
	assign dff_rdata_w3_m_scanin[43] = dff_wdata_m_scanout[48];
	assign dff_rdata_w2_m_scanin[43] = dff_rdata_w3_m_scanout[43];
	assign dff_rdata_w1_m_scanin[43] = dff_rdata_w2_m_scanout[43];
	assign dff_rdata_w0_m_scanin[43] = dff_rdata_w1_m_scanout[43];
	assign dff_wdata_m_scanin[111] = dff_rdata_w0_m_scanout[43];
	assign dff_wdata_m_scanin[39] = dff_wdata_m_scanout[111];
	assign dff_rdata_w3_m_scanin[35] = dff_wdata_m_scanout[39];
	assign dff_rdata_w2_m_scanin[35] = dff_rdata_w3_m_scanout[35];
	assign dff_rdata_w1_m_scanin[35] = dff_rdata_w2_m_scanout[35];
	assign dff_rdata_w0_m_scanin[35] = dff_rdata_w1_m_scanout[35];
	assign dff_wdata_m_scanin[119] = dff_rdata_w0_m_scanout[35];
	assign dff_wdata_m_scanin[47] = dff_wdata_m_scanout[119];
	assign dff_rdata_w3_m_scanin[42] = dff_wdata_m_scanout[47];
	assign dff_rdata_w2_m_scanin[42] = dff_rdata_w3_m_scanout[42];
	assign dff_rdata_w1_m_scanin[42] = dff_rdata_w2_m_scanout[42];
	assign dff_rdata_w0_m_scanin[42] = dff_rdata_w1_m_scanout[42];
	assign dff_wdata_m_scanin[110] = dff_rdata_w0_m_scanout[42];
	assign dff_wdata_m_scanin[38] = dff_wdata_m_scanout[110];
	assign dff_rdata_w3_m_scanin[34] = dff_wdata_m_scanout[38];
	assign dff_rdata_w2_m_scanin[34] = dff_rdata_w3_m_scanout[34];
	assign dff_rdata_w1_m_scanin[34] = dff_rdata_w2_m_scanout[34];
	assign dff_rdata_w0_m_scanin[34] = dff_rdata_w1_m_scanout[34];
	assign dff_wdata_m_scanin[118] = dff_rdata_w0_m_scanout[34];
	assign dff_wdata_m_scanin[46] = dff_wdata_m_scanout[118];
	assign dff_rdata_w3_m_scanin[41] = dff_wdata_m_scanout[46];
	assign dff_rdata_w2_m_scanin[41] = dff_rdata_w3_m_scanout[41];
	assign dff_rdata_w1_m_scanin[41] = dff_rdata_w2_m_scanout[41];
	assign dff_rdata_w0_m_scanin[41] = dff_rdata_w1_m_scanout[41];
	assign dff_wdata_m_scanin[109] = dff_rdata_w0_m_scanout[41];
	assign dff_wdata_m_scanin[37] = dff_wdata_m_scanout[109];
	assign dff_rdata_w3_m_scanin[33] = dff_wdata_m_scanout[37];
	assign dff_rdata_w2_m_scanin[33] = dff_rdata_w3_m_scanout[33];
	assign dff_rdata_w1_m_scanin[33] = dff_rdata_w2_m_scanout[33];
	assign dff_rdata_w0_m_scanin[33] = dff_rdata_w1_m_scanout[33];
	assign dff_wdata_m_scanin[117] = dff_rdata_w0_m_scanout[33];
	assign dff_wdata_m_scanin[45] = dff_wdata_m_scanout[117];
	assign dff_rdata_w3_m_scanin[40] = dff_wdata_m_scanout[45];
	assign dff_rdata_w2_m_scanin[40] = dff_rdata_w3_m_scanout[40];
	assign dff_rdata_w1_m_scanin[40] = dff_rdata_w2_m_scanout[40];
	assign dff_rdata_w0_m_scanin[40] = dff_rdata_w1_m_scanout[40];
	assign dff_wdata_m_scanin[108] = dff_rdata_w0_m_scanout[40];
	assign dff_wdata_m_scanin[36] = dff_wdata_m_scanout[108];
	assign dff_rdata_w3_m_scanin[32] = dff_wdata_m_scanout[36];
	assign dff_rdata_w2_m_scanin[32] = dff_rdata_w3_m_scanout[32];
	assign dff_rdata_w1_m_scanin[32] = dff_rdata_w2_m_scanout[32];
	assign dff_rdata_w0_m_scanin[32] = dff_rdata_w1_m_scanout[32];
	assign dff_ctl_m_1_scanin[15] = dff_rdata_w0_m_scanout[32];
	assign dff_ctl_m_1_scanin[7] = dff_ctl_m_1_scanout[15];
	assign dff_ctl_m_1_scanin[14] = dff_ctl_m_1_scanout[7];
	assign dff_ctl_m_1_scanin[6] = dff_ctl_m_1_scanout[14];
	assign dff_ctl_m_1_scanin[13] = dff_ctl_m_1_scanout[6];
	assign dff_ctl_m_1_scanin[5] = dff_ctl_m_1_scanout[13];
	assign dff_ctl_m_1_scanin[12] = dff_ctl_m_1_scanout[5];
	assign dff_ctl_m_1_scanin[4] = dff_ctl_m_1_scanout[12];
	assign dff_byte_perr_w2_scanin[7] = dff_ctl_m_1_scanout[4];
	assign dff_byte_perr_w3_scanin[7] = dff_byte_perr_w2_scanout[7];
	assign dff_byte_perr_w3_scanin[6] = dff_byte_perr_w3_scanout[7];
	assign dff_byte_perr_w2_scanin[6] = dff_byte_perr_w3_scanout[6];
	assign dff_byte_perr_w2_scanin[5] = dff_byte_perr_w2_scanout[6];
	assign dff_byte_perr_w3_scanin[5] = dff_byte_perr_w2_scanout[5];
	assign dff_byte_perr_w3_scanin[4] = dff_byte_perr_w3_scanout[5];
	assign dff_byte_perr_w2_scanin[4] = dff_byte_perr_w3_scanout[4];
	assign dff_ctl_m_0_scanin[0] = dff_byte_perr_w2_scanout[4];
	assign dff_ctl_b_scanin[4] = dff_ctl_m_0_scanout[0];
	assign dff_ctl_b_scanin[0] = dff_ctl_b_scanout[4];
	assign dff_ctl_b_scanin[1] = dff_ctl_b_scanout[0];
	assign dff_ctl_b_scanin[2] = dff_ctl_b_scanout[1];
	assign dff_ctl_b_scanin[3] = dff_ctl_b_scanout[2];
	assign lat_ctl_eb_scanin[6] = dff_ctl_b_scanout[3];
	assign lat_ctl_eb_scanin[1] = lat_ctl_eb_scanout[6];
	assign lat_ctl_eb_scanin[0] = lat_ctl_eb_scanout[1];
	assign lat_ctl_eb_scanin[2] = lat_ctl_eb_scanout[0];
	assign lat_ctl_eb_scanin[3] = lat_ctl_eb_scanout[2];
	assign lat_addr_scanin[1] = lat_ctl_eb_scanout[3];
	assign lat_addr_scanin[0] = lat_addr_scanout[1];
	assign lat_addr_scanin[7] = lat_addr_scanout[0];
	assign lat_addr_scanin[6] = lat_addr_scanout[7];
	assign lat_addr_scanin[5] = lat_addr_scanout[6];
	assign lat_addr_scanin[4] = lat_addr_scanout[5];
	assign lat_addr_scanin[3] = lat_addr_scanout[4];
	assign lat_addr_scanin[2] = lat_addr_scanout[3];
	assign lat_ctl_eb_scanin[4] = lat_addr_scanout[2];
	assign dff_ctl_m_0_scanin[1] = lat_ctl_eb_scanout[4];
	assign dff_ctl_m_0_scanin[2] = dff_ctl_m_0_scanout[1];
	assign lat_ctl_eb_scanin[5] = dff_ctl_m_0_scanout[2];
	assign dff_byte_perr_w0_scanin[0] = lat_ctl_eb_scanout[5];
	assign dff_byte_perr_w1_scanin[0] = dff_byte_perr_w0_scanout[0];
	assign dff_byte_perr_w1_scanin[1] = dff_byte_perr_w1_scanout[0];
	assign dff_byte_perr_w0_scanin[1] = dff_byte_perr_w1_scanout[1];
	assign dff_byte_perr_w0_scanin[2] = dff_byte_perr_w0_scanout[1];
	assign dff_byte_perr_w1_scanin[2] = dff_byte_perr_w0_scanout[2];
	assign dff_byte_perr_w1_scanin[3] = dff_byte_perr_w1_scanout[2];
	assign dff_byte_perr_w0_scanin[3] = dff_byte_perr_w1_scanout[3];
	assign dff_wdata_m_scanin[80] = dff_byte_perr_w0_scanout[3];
	assign dff_wdata_m_scanin[8] = dff_wdata_m_scanout[80];
	assign dff_rparity_w3_m_scanin[0] = dff_wdata_m_scanout[8];
	assign dff_rparity_w2_m_scanin[0] = dff_rparity_w3_m_scanout[0];
	assign dff_rparity_w1_m_scanin[0] = dff_rparity_w2_m_scanout[0];
	assign dff_rparity_w0_m_scanin[0] = dff_rparity_w1_m_scanout[0];
	assign dff_wdata_m_scanin[89] = dff_rparity_w0_m_scanout[0];
	assign dff_wdata_m_scanin[17] = dff_wdata_m_scanout[89];
	assign dff_rparity_w3_m_scanin[1] = dff_wdata_m_scanout[17];
	assign dff_rparity_w2_m_scanin[1] = dff_rparity_w3_m_scanout[1];
	assign dff_rparity_w1_m_scanin[1] = dff_rparity_w2_m_scanout[1];
	assign dff_rparity_w0_m_scanin[1] = dff_rparity_w1_m_scanout[1];
	assign dff_wdata_m_scanin[72] = dff_rparity_w0_m_scanout[1];
	assign dff_wdata_m_scanin[0] = dff_wdata_m_scanout[72];
	assign dff_rdata_w3_m_scanin[0] = dff_wdata_m_scanout[0];
	assign dff_rdata_w2_m_scanin[0] = dff_rdata_w3_m_scanout[0];
	assign dff_rdata_w1_m_scanin[0] = dff_rdata_w2_m_scanout[0];
	assign dff_rdata_w0_m_scanin[0] = dff_rdata_w1_m_scanout[0];
	assign dff_wdata_m_scanin[81] = dff_rdata_w0_m_scanout[0];
	assign dff_wdata_m_scanin[9] = dff_wdata_m_scanout[81];
	assign dff_rdata_w3_m_scanin[8] = dff_wdata_m_scanout[9];
	assign dff_rdata_w2_m_scanin[8] = dff_rdata_w3_m_scanout[8];
	assign dff_rdata_w1_m_scanin[8] = dff_rdata_w2_m_scanout[8];
	assign dff_rdata_w0_m_scanin[8] = dff_rdata_w1_m_scanout[8];
	assign dff_wdata_m_scanin[73] = dff_rdata_w0_m_scanout[8];
	assign dff_wdata_m_scanin[1] = dff_wdata_m_scanout[73];
	assign dff_rdata_w3_m_scanin[1] = dff_wdata_m_scanout[1];
	assign dff_rdata_w2_m_scanin[1] = dff_rdata_w3_m_scanout[1];
	assign dff_rdata_w1_m_scanin[1] = dff_rdata_w2_m_scanout[1];
	assign dff_rdata_w0_m_scanin[1] = dff_rdata_w1_m_scanout[1];
	assign dff_wdata_m_scanin[82] = dff_rdata_w0_m_scanout[1];
	assign dff_wdata_m_scanin[10] = dff_wdata_m_scanout[82];
	assign dff_rdata_w3_m_scanin[9] = dff_wdata_m_scanout[10];
	assign dff_rdata_w2_m_scanin[9] = dff_rdata_w3_m_scanout[9];
	assign dff_rdata_w1_m_scanin[9] = dff_rdata_w2_m_scanout[9];
	assign dff_rdata_w0_m_scanin[9] = dff_rdata_w1_m_scanout[9];
	assign dff_wdata_m_scanin[74] = dff_rdata_w0_m_scanout[9];
	assign dff_wdata_m_scanin[2] = dff_wdata_m_scanout[74];
	assign dff_rdata_w3_m_scanin[2] = dff_wdata_m_scanout[2];
	assign dff_rdata_w2_m_scanin[2] = dff_rdata_w3_m_scanout[2];
	assign dff_rdata_w1_m_scanin[2] = dff_rdata_w2_m_scanout[2];
	assign dff_rdata_w0_m_scanin[2] = dff_rdata_w1_m_scanout[2];
	assign dff_wdata_m_scanin[83] = dff_rdata_w0_m_scanout[2];
	assign dff_wdata_m_scanin[11] = dff_wdata_m_scanout[83];
	assign dff_rdata_w3_m_scanin[10] = dff_wdata_m_scanout[11];
	assign dff_rdata_w2_m_scanin[10] = dff_rdata_w3_m_scanout[10];
	assign dff_rdata_w1_m_scanin[10] = dff_rdata_w2_m_scanout[10];
	assign dff_rdata_w0_m_scanin[10] = dff_rdata_w1_m_scanout[10];
	assign dff_wdata_m_scanin[75] = dff_rdata_w0_m_scanout[10];
	assign dff_wdata_m_scanin[3] = dff_wdata_m_scanout[75];
	assign dff_rdata_w3_m_scanin[3] = dff_wdata_m_scanout[3];
	assign dff_rdata_w2_m_scanin[3] = dff_rdata_w3_m_scanout[3];
	assign dff_rdata_w1_m_scanin[3] = dff_rdata_w2_m_scanout[3];
	assign dff_rdata_w0_m_scanin[3] = dff_rdata_w1_m_scanout[3];
	assign dff_wdata_m_scanin[84] = dff_rdata_w0_m_scanout[3];
	assign dff_wdata_m_scanin[12] = dff_wdata_m_scanout[84];
	assign dff_rdata_w3_m_scanin[11] = dff_wdata_m_scanout[12];
	assign dff_rdata_w2_m_scanin[11] = dff_rdata_w3_m_scanout[11];
	assign dff_rdata_w1_m_scanin[11] = dff_rdata_w2_m_scanout[11];
	assign dff_rdata_w0_m_scanin[11] = dff_rdata_w1_m_scanout[11];
	assign dff_wdata_m_scanin[76] = dff_rdata_w0_m_scanout[11];
	assign dff_wdata_m_scanin[4] = dff_wdata_m_scanout[76];
	assign dff_rdata_w3_m_scanin[4] = dff_wdata_m_scanout[4];
	assign dff_rdata_w2_m_scanin[4] = dff_rdata_w3_m_scanout[4];
	assign dff_rdata_w1_m_scanin[4] = dff_rdata_w2_m_scanout[4];
	assign dff_rdata_w0_m_scanin[4] = dff_rdata_w1_m_scanout[4];
	assign dff_wdata_m_scanin[85] = dff_rdata_w0_m_scanout[4];
	assign dff_wdata_m_scanin[13] = dff_wdata_m_scanout[85];
	assign dff_rdata_w3_m_scanin[12] = dff_wdata_m_scanout[13];
	assign dff_rdata_w2_m_scanin[12] = dff_rdata_w3_m_scanout[12];
	assign dff_rdata_w1_m_scanin[12] = dff_rdata_w2_m_scanout[12];
	assign dff_rdata_w0_m_scanin[12] = dff_rdata_w1_m_scanout[12];
	assign dff_wdata_m_scanin[77] = dff_rdata_w0_m_scanout[12];
	assign dff_wdata_m_scanin[5] = dff_wdata_m_scanout[77];
	assign dff_rdata_w3_m_scanin[5] = dff_wdata_m_scanout[5];
	assign dff_rdata_w2_m_scanin[5] = dff_rdata_w3_m_scanout[5];
	assign dff_rdata_w1_m_scanin[5] = dff_rdata_w2_m_scanout[5];
	assign dff_rdata_w0_m_scanin[5] = dff_rdata_w1_m_scanout[5];
	assign dff_wdata_m_scanin[86] = dff_rdata_w0_m_scanout[5];
	assign dff_wdata_m_scanin[14] = dff_wdata_m_scanout[86];
	assign dff_rdata_w3_m_scanin[13] = dff_wdata_m_scanout[14];
	assign dff_rdata_w2_m_scanin[13] = dff_rdata_w3_m_scanout[13];
	assign dff_rdata_w1_m_scanin[13] = dff_rdata_w2_m_scanout[13];
	assign dff_rdata_w0_m_scanin[13] = dff_rdata_w1_m_scanout[13];
	assign dff_wdata_m_scanin[78] = dff_rdata_w0_m_scanout[13];
	assign dff_wdata_m_scanin[6] = dff_wdata_m_scanout[78];
	assign dff_rdata_w3_m_scanin[6] = dff_wdata_m_scanout[6];
	assign dff_rdata_w2_m_scanin[6] = dff_rdata_w3_m_scanout[6];
	assign dff_rdata_w1_m_scanin[6] = dff_rdata_w2_m_scanout[6];
	assign dff_rdata_w0_m_scanin[6] = dff_rdata_w1_m_scanout[6];
	assign dff_wdata_m_scanin[87] = dff_rdata_w0_m_scanout[6];
	assign dff_wdata_m_scanin[15] = dff_wdata_m_scanout[87];
	assign dff_rdata_w3_m_scanin[14] = dff_wdata_m_scanout[15];
	assign dff_rdata_w2_m_scanin[14] = dff_rdata_w3_m_scanout[14];
	assign dff_rdata_w1_m_scanin[14] = dff_rdata_w2_m_scanout[14];
	assign dff_rdata_w0_m_scanin[14] = dff_rdata_w1_m_scanout[14];
	assign dff_wdata_m_scanin[79] = dff_rdata_w0_m_scanout[14];
	assign dff_wdata_m_scanin[7] = dff_wdata_m_scanout[79];
	assign dff_rdata_w3_m_scanin[7] = dff_wdata_m_scanout[7];
	assign dff_rdata_w2_m_scanin[7] = dff_rdata_w3_m_scanout[7];
	assign dff_rdata_w1_m_scanin[7] = dff_rdata_w2_m_scanout[7];
	assign dff_rdata_w0_m_scanin[7] = dff_rdata_w1_m_scanout[7];
	assign dff_wdata_m_scanin[88] = dff_rdata_w0_m_scanout[7];
	assign dff_wdata_m_scanin[16] = dff_wdata_m_scanout[88];
	assign dff_rdata_w3_m_scanin[15] = dff_wdata_m_scanout[16];
	assign dff_rdata_w2_m_scanin[15] = dff_rdata_w3_m_scanout[15];
	assign dff_rdata_w1_m_scanin[15] = dff_rdata_w2_m_scanout[15];
	assign dff_rdata_w0_m_scanin[15] = dff_rdata_w1_m_scanout[15];
	assign dff_wdata_m_scanin[98] = dff_rdata_w0_m_scanout[15];
	assign dff_wdata_m_scanin[26] = dff_wdata_m_scanout[98];
	assign dff_rparity_w3_m_scanin[2] = dff_wdata_m_scanout[26];
	assign dff_rparity_w2_m_scanin[2] = dff_rparity_w3_m_scanout[2];
	assign dff_rparity_w1_m_scanin[2] = dff_rparity_w2_m_scanout[2];
	assign dff_rparity_w0_m_scanin[2] = dff_rparity_w1_m_scanout[2];
	assign dff_wdata_m_scanin[107] = dff_rparity_w0_m_scanout[2];
	assign dff_wdata_m_scanin[35] = dff_wdata_m_scanout[107];
	assign dff_rparity_w3_m_scanin[3] = dff_wdata_m_scanout[35];
	assign dff_rparity_w2_m_scanin[3] = dff_rparity_w3_m_scanout[3];
	assign dff_rparity_w1_m_scanin[3] = dff_rparity_w2_m_scanout[3];
	assign dff_rparity_w0_m_scanin[3] = dff_rparity_w1_m_scanout[3];
	assign dff_wdata_m_scanin[90] = dff_rparity_w0_m_scanout[3];
	assign dff_wdata_m_scanin[18] = dff_wdata_m_scanout[90];
	assign dff_rdata_w3_m_scanin[16] = dff_wdata_m_scanout[18];
	assign dff_rdata_w2_m_scanin[16] = dff_rdata_w3_m_scanout[16];
	assign dff_rdata_w1_m_scanin[16] = dff_rdata_w2_m_scanout[16];
	assign dff_rdata_w0_m_scanin[16] = dff_rdata_w1_m_scanout[16];
	assign dff_wdata_m_scanin[99] = dff_rdata_w0_m_scanout[16];
	assign dff_wdata_m_scanin[27] = dff_wdata_m_scanout[99];
	assign dff_rdata_w3_m_scanin[24] = dff_wdata_m_scanout[27];
	assign dff_rdata_w2_m_scanin[24] = dff_rdata_w3_m_scanout[24];
	assign dff_rdata_w1_m_scanin[24] = dff_rdata_w2_m_scanout[24];
	assign dff_rdata_w0_m_scanin[24] = dff_rdata_w1_m_scanout[24];
	assign dff_wdata_m_scanin[91] = dff_rdata_w0_m_scanout[24];
	assign dff_wdata_m_scanin[19] = dff_wdata_m_scanout[91];
	assign dff_rdata_w3_m_scanin[17] = dff_wdata_m_scanout[19];
	assign dff_rdata_w2_m_scanin[17] = dff_rdata_w3_m_scanout[17];
	assign dff_rdata_w1_m_scanin[17] = dff_rdata_w2_m_scanout[17];
	assign dff_rdata_w0_m_scanin[17] = dff_rdata_w1_m_scanout[17];
	assign dff_wdata_m_scanin[100] = dff_rdata_w0_m_scanout[17];
	assign dff_wdata_m_scanin[28] = dff_wdata_m_scanout[100];
	assign dff_rdata_w3_m_scanin[25] = dff_wdata_m_scanout[28];
	assign dff_rdata_w2_m_scanin[25] = dff_rdata_w3_m_scanout[25];
	assign dff_rdata_w1_m_scanin[25] = dff_rdata_w2_m_scanout[25];
	assign dff_rdata_w0_m_scanin[25] = dff_rdata_w1_m_scanout[25];
	assign dff_wdata_m_scanin[92] = dff_rdata_w0_m_scanout[25];
	assign dff_wdata_m_scanin[20] = dff_wdata_m_scanout[92];
	assign dff_rdata_w3_m_scanin[18] = dff_wdata_m_scanout[20];
	assign dff_rdata_w2_m_scanin[18] = dff_rdata_w3_m_scanout[18];
	assign dff_rdata_w1_m_scanin[18] = dff_rdata_w2_m_scanout[18];
	assign dff_rdata_w0_m_scanin[18] = dff_rdata_w1_m_scanout[18];
	assign dff_wdata_m_scanin[101] = dff_rdata_w0_m_scanout[18];
	assign dff_wdata_m_scanin[29] = dff_wdata_m_scanout[101];
	assign dff_rdata_w3_m_scanin[26] = dff_wdata_m_scanout[29];
	assign dff_rdata_w2_m_scanin[26] = dff_rdata_w3_m_scanout[26];
	assign dff_rdata_w1_m_scanin[26] = dff_rdata_w2_m_scanout[26];
	assign dff_rdata_w0_m_scanin[26] = dff_rdata_w1_m_scanout[26];
	assign dff_wdata_m_scanin[93] = dff_rdata_w0_m_scanout[26];
	assign dff_wdata_m_scanin[21] = dff_wdata_m_scanout[93];
	assign dff_rdata_w3_m_scanin[19] = dff_wdata_m_scanout[21];
	assign dff_rdata_w2_m_scanin[19] = dff_rdata_w3_m_scanout[19];
	assign dff_rdata_w1_m_scanin[19] = dff_rdata_w2_m_scanout[19];
	assign dff_rdata_w0_m_scanin[19] = dff_rdata_w1_m_scanout[19];
	assign dff_wdata_m_scanin[102] = dff_rdata_w0_m_scanout[19];
	assign dff_wdata_m_scanin[30] = dff_wdata_m_scanout[102];
	assign dff_rdata_w3_m_scanin[27] = dff_wdata_m_scanout[30];
	assign dff_rdata_w2_m_scanin[27] = dff_rdata_w3_m_scanout[27];
	assign dff_rdata_w1_m_scanin[27] = dff_rdata_w2_m_scanout[27];
	assign dff_rdata_w0_m_scanin[27] = dff_rdata_w1_m_scanout[27];
	assign dff_wdata_m_scanin[94] = dff_rdata_w0_m_scanout[27];
	assign dff_wdata_m_scanin[22] = dff_wdata_m_scanout[94];
	assign dff_rdata_w3_m_scanin[20] = dff_wdata_m_scanout[22];
	assign dff_rdata_w2_m_scanin[20] = dff_rdata_w3_m_scanout[20];
	assign dff_rdata_w1_m_scanin[20] = dff_rdata_w2_m_scanout[20];
	assign dff_rdata_w0_m_scanin[20] = dff_rdata_w1_m_scanout[20];
	assign dff_wdata_m_scanin[103] = dff_rdata_w0_m_scanout[20];
	assign dff_wdata_m_scanin[31] = dff_wdata_m_scanout[103];
	assign dff_rdata_w3_m_scanin[28] = dff_wdata_m_scanout[31];
	assign dff_rdata_w2_m_scanin[28] = dff_rdata_w3_m_scanout[28];
	assign dff_rdata_w1_m_scanin[28] = dff_rdata_w2_m_scanout[28];
	assign dff_rdata_w0_m_scanin[28] = dff_rdata_w1_m_scanout[28];
	assign dff_wdata_m_scanin[95] = dff_rdata_w0_m_scanout[28];
	assign dff_wdata_m_scanin[23] = dff_wdata_m_scanout[95];
	assign dff_rdata_w3_m_scanin[21] = dff_wdata_m_scanout[23];
	assign dff_rdata_w2_m_scanin[21] = dff_rdata_w3_m_scanout[21];
	assign dff_rdata_w1_m_scanin[21] = dff_rdata_w2_m_scanout[21];
	assign dff_rdata_w0_m_scanin[21] = dff_rdata_w1_m_scanout[21];
	assign dff_wdata_m_scanin[104] = dff_rdata_w0_m_scanout[21];
	assign dff_wdata_m_scanin[32] = dff_wdata_m_scanout[104];
	assign dff_rdata_w3_m_scanin[29] = dff_wdata_m_scanout[32];
	assign dff_rdata_w2_m_scanin[29] = dff_rdata_w3_m_scanout[29];
	assign dff_rdata_w1_m_scanin[29] = dff_rdata_w2_m_scanout[29];
	assign dff_rdata_w0_m_scanin[29] = dff_rdata_w1_m_scanout[29];
	assign dff_wdata_m_scanin[96] = dff_rdata_w0_m_scanout[29];
	assign dff_wdata_m_scanin[24] = dff_wdata_m_scanout[96];
	assign dff_rdata_w3_m_scanin[22] = dff_wdata_m_scanout[24];
	assign dff_rdata_w2_m_scanin[22] = dff_rdata_w3_m_scanout[22];
	assign dff_rdata_w1_m_scanin[22] = dff_rdata_w2_m_scanout[22];
	assign dff_rdata_w0_m_scanin[22] = dff_rdata_w1_m_scanout[22];
	assign dff_wdata_m_scanin[105] = dff_rdata_w0_m_scanout[22];
	assign dff_wdata_m_scanin[33] = dff_wdata_m_scanout[105];
	assign dff_rdata_w3_m_scanin[30] = dff_wdata_m_scanout[33];
	assign dff_rdata_w2_m_scanin[30] = dff_rdata_w3_m_scanout[30];
	assign dff_rdata_w1_m_scanin[30] = dff_rdata_w2_m_scanout[30];
	assign dff_rdata_w0_m_scanin[30] = dff_rdata_w1_m_scanout[30];
	assign dff_wdata_m_scanin[97] = dff_rdata_w0_m_scanout[30];
	assign dff_wdata_m_scanin[25] = dff_wdata_m_scanout[97];
	assign dff_rdata_w3_m_scanin[23] = dff_wdata_m_scanout[25];
	assign dff_rdata_w2_m_scanin[23] = dff_rdata_w3_m_scanout[23];
	assign dff_rdata_w1_m_scanin[23] = dff_rdata_w2_m_scanout[23];
	assign dff_rdata_w0_m_scanin[23] = dff_rdata_w1_m_scanout[23];
	assign dff_wdata_m_scanin[106] = dff_rdata_w0_m_scanout[23];
	assign dff_wdata_m_scanin[34] = dff_wdata_m_scanout[106];
	assign dff_rdata_w3_m_scanin[31] = dff_wdata_m_scanout[34];
	assign dff_rdata_w2_m_scanin[31] = dff_rdata_w3_m_scanout[31];
	assign dff_rdata_w1_m_scanin[31] = dff_rdata_w2_m_scanout[31];
	assign dff_rdata_w0_m_scanin[31] = dff_rdata_w1_m_scanout[31];
	assign dff_ctl_m_1_scanin[8] = dff_rdata_w0_m_scanout[31];
	assign dff_ctl_m_1_scanin[0] = dff_ctl_m_1_scanout[8];
	assign dff_ctl_m_1_scanin[9] = dff_ctl_m_1_scanout[0];
	assign dff_ctl_m_1_scanin[1] = dff_ctl_m_1_scanout[9];
	assign dff_ctl_m_1_scanin[10] = dff_ctl_m_1_scanout[1];
	assign dff_ctl_m_1_scanin[2] = dff_ctl_m_1_scanout[10];
	assign dff_ctl_m_1_scanin[11] = dff_ctl_m_1_scanout[2];
	assign dff_ctl_m_1_scanin[3] = dff_ctl_m_1_scanout[11];
	assign dff_byte_perr_w2_scanin[0] = dff_ctl_m_1_scanout[3];
	assign dff_byte_perr_w3_scanin[0] = dff_byte_perr_w2_scanout[0];
	assign dff_byte_perr_w3_scanin[1] = dff_byte_perr_w3_scanout[0];
	assign dff_byte_perr_w2_scanin[1] = dff_byte_perr_w3_scanout[1];
	assign dff_byte_perr_w2_scanin[2] = dff_byte_perr_w2_scanout[1];
	assign dff_byte_perr_w3_scanin[2] = dff_byte_perr_w2_scanout[2];
	assign dff_byte_perr_w3_scanin[3] = dff_byte_perr_w3_scanout[2];
	assign dff_byte_perr_w2_scanin[3] = dff_byte_perr_w3_scanout[3];
	assign dff_msb_w3_scanin[7] = dff_byte_perr_w2_scanout[3];
	assign dff_msb_w2_scanin[7] = dff_msb_w3_scanout[7];
	assign dff_msb_w1_scanin[7] = dff_msb_w2_scanout[7];
	assign dff_msb_w0_scanin[7] = dff_msb_w1_scanout[7];
	assign dff_msb_w3_scanin[6] = dff_msb_w0_scanout[7];
	assign dff_msb_w2_scanin[6] = dff_msb_w3_scanout[6];
	assign dff_msb_w1_scanin[6] = dff_msb_w2_scanout[6];
	assign dff_msb_w0_scanin[6] = dff_msb_w1_scanout[6];
	assign dff_msb_w3_scanin[5] = dff_msb_w0_scanout[6];
	assign dff_msb_w2_scanin[5] = dff_msb_w3_scanout[5];
	assign dff_msb_w1_scanin[5] = dff_msb_w2_scanout[5];
	assign dff_msb_w0_scanin[5] = dff_msb_w1_scanout[5];
	assign dff_msb_w3_scanin[4] = dff_msb_w0_scanout[5];
	assign dff_msb_w2_scanin[4] = dff_msb_w3_scanout[4];
	assign dff_msb_w1_scanin[4] = dff_msb_w2_scanout[4];
	assign dff_msb_w0_scanin[4] = dff_msb_w1_scanout[4];
	assign dff_msb_w3_scanin[0] = dff_msb_w0_scanout[4];
	assign dff_msb_w2_scanin[0] = dff_msb_w3_scanout[0];
	assign dff_msb_w1_scanin[0] = dff_msb_w2_scanout[0];
	assign dff_msb_w0_scanin[0] = dff_msb_w1_scanout[0];
	assign dff_msb_w3_scanin[1] = dff_msb_w0_scanout[0];
	assign dff_msb_w2_scanin[1] = dff_msb_w3_scanout[1];
	assign dff_msb_w1_scanin[1] = dff_msb_w2_scanout[1];
	assign dff_msb_w0_scanin[1] = dff_msb_w1_scanout[1];
	assign dff_msb_w3_scanin[2] = dff_msb_w0_scanout[1];
	assign dff_msb_w2_scanin[2] = dff_msb_w3_scanout[2];
	assign dff_msb_w1_scanin[2] = dff_msb_w2_scanout[2];
	assign dff_msb_w0_scanin[2] = dff_msb_w1_scanout[2];
	assign dff_msb_w3_scanin[3] = dff_msb_w0_scanout[2];
	assign dff_msb_w2_scanin[3] = dff_msb_w3_scanout[3];
	assign dff_msb_w1_scanin[3] = dff_msb_w2_scanout[3];
	assign dff_msb_w0_scanin[3] = dff_msb_w1_scanout[3];
	assign dff_red_out_scanin[2] = dff_msb_w0_scanout[3];
	assign dff_red_out_scanin[3] = dff_red_out_scanout[2];
	assign dff_red_out_scanin[4] = dff_red_out_scanout[3];
	assign dff_red_out_scanin[5] = dff_red_out_scanout[4];
	assign dff_red_out_scanin[6] = dff_red_out_scanout[5];
	assign dff_red_out_scanin[7] = dff_red_out_scanout[6];
	assign dff_red_out_scanin[0] = dff_red_out_scanout[7];
	assign dff_red_out_scanin[1] = dff_red_out_scanout[0];
	assign dff_red_in_scanin[2] = dff_red_out_scanout[1];
	assign dff_red_in_scanin[3] = dff_red_in_scanout[2];
	assign dff_red_in_scanin[1] = dff_red_in_scanout[3];
	assign dff_red_in_scanin[0] = dff_red_in_scanout[1];
	assign dff_red_in_scanin[6] = dff_red_in_scanout[0];
	assign dff_red_in_scanin[7] = dff_red_in_scanout[6];
	assign dff_red_in_scanin[8] = dff_red_in_scanout[7];
	assign dff_red_in_scanin[9] = dff_red_in_scanout[8];
	assign dff_red_in_scanin[10] = dff_red_in_scanout[9];
	assign dff_red_in_scanin[11] = dff_red_in_scanout[10];
	assign dff_red_in_scanin[4] = dff_red_in_scanout[11];
	assign dff_red_in_scanin[5] = dff_red_in_scanout[4];
	assign scan_out = dff_red_in_scanout[5];

	l1clkhdr_ctl_macro l1ch_in(
		.l2clk				(l2clk), 
		.l1en				(1'b1), 
		.pce_ov				(1'b1), 
		.se				(tcu_se_scancollar_in), 
		.l1clk				(l1clk_in), 
		.stop				(stop));
	l1clkhdr_ctl_macro l1ch_in_pm(
		.l2clk				(l2clk), 
		.l1en				(dcache_wclk_en_e), 
		.se				(tcu_se_scancollar_in), 
		.l1clk				(l1clk_in_pm), 
		.pce_ov				(pce_ov), 
		.stop				(stop));
	l1clkhdr_ctl_macro l1ch_out_pm(
		.l2clk				(l2clk), 
		.l1en				(dcache_rclk_en_m), 
		.se				(tcu_se_scancollar_out), 
		.l1clk				(l1clk_out_pm), 
		.pce_ov				(pce_ov), 
		.stop				(stop));
	l1clkhdr_ctl_macro l1ch_out(
		.l2clk				(l2clk), 
		.l1en				(1'b1), 
		.pce_ov				(1'b1), 
		.se				(tcu_se_scancollar_out), 
		.l1clk				(l1clk_out), 
		.stop				(stop));
	l1clkhdr_ctl_macro l1ch_free(
		.l2clk				(l2clk), 
		.l1en				(dcache_clk_en_e), 
		.se				(tcu_scan_en), 
		.l1clk				(l1clk_free), 
		.pce_ov				(pce_ov), 
		.stop				(stop));
	l1clkhdr_ctl_macro l1ch_free_wpm(
		.l2clk				(l2clk), 
		.l1en				(dcache_wclk_en_e), 
		.se				(tcu_scan_en), 
		.l1clk				(l1clk_free_wpm), 
		.pce_ov				(pce_ov), 
		.stop				(stop));
	l1clkhdr_ctl_macro l1ch_red(
		.l2clk				(l2clk), 
		.l1en				(1'b1), 
		.pce_ov				(1'b1), 
		.se				(1'b0), 
		.l1clk				(l1clk_red), 
		.stop				(stop));
	mux_macro__mux_aope__ports_2__width_8 mx_addr_e(
		.din0				(dcache_alt_addr_e[10:3]), 
		.din1				(dcache_rd_addr_e[10:3]), 
		.sel0				(dcache_alt_addr_sel_e), 
		.dout				(dcache_rwaddr_e[10:3]));
	tisram_msff_macro__fs_1__width_8 lat_addr(
		.scan_in			(lat_addr_scanin[7:0]), 
		.scan_out			(lat_addr_scanout[7:0]), 
		.l1clk				(l1clk_in), 
		.d				(dcache_rwaddr_e[10:3]), 
		.latout				(dcache_rwaddr_eb[10:3]), 
		.latout_l			(dcache_rwaddr_l_unused[10:3]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	mux_macro__mux_aodec__ports_4__width_4 wr_way_decode(
		.din0				(4'b1), 
		.din1				(4'd2), 
		.din2				(4'd4), 
		.din3				(4'd8), 
		.sel				(dcache_wr_way_e[1:0]), 
		.dout				(wr_way_dec_e[3:0]));
	tisram_msff_macro__fs_1__width_7 lat_ctl_eb(
		.scan_in			(lat_ctl_eb_scanin[6:0]), 
		.scan_out			(lat_ctl_eb_scanout[6:0]), 
		.l1clk				(l1clk_in), 
		.d				({dcache_rvld_e, dcache_rvld_e,
		dcache_wvld_e, wr_way_dec_e[3:0]}), 
		.latout				({dcache_rvld_top_eb,
		dcache_rvld_bot_eb, dcache_wvld_eb, wr_way_dec_eb[3:0]}), 
		.latout_l			(lat_ctl_unused[6:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_3 dff_ctl_m_0(
		.scan_in			(dff_ctl_m_0_scanin[2:0]), 
		.scan_out			(dff_ctl_m_0_scanout[2:0]), 
		.l1clk				(l1clk_in), 
		.din				({dcache_rvld_e, dcache_wvld_e,
		dcache_bypass_e_}), 
		.dout				({dcache_rvld_m, dcache_wvld_m,
		dcache_bypass_m_}), 
		.siclk				(siclk), 
		.soclk				(soclk));
	tisram_msff_macro__fs_1__width_16 dff_ctl_m_1(
		.scan_in			(dff_ctl_m_1_scanin[15:0]), 
		.scan_out			(dff_ctl_m_1_scanout[15:0]), 
		.l1clk				(l1clk_in_pm), 
		.d				(dcache_byte_wr_en_e[15:0]), 
		.latout				(byte_wr_en_eb[15:0]), 
		.latout_l			(dff_ctl_l_unused[15:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_5 dff_ctl_b(
		.scan_in			(dff_ctl_b_scanin[4:0]), 
		.scan_out			(dff_ctl_b_scanout[4:0]), 
		.l1clk				(l1clk_in), 
		.din				({dcache_alt_way_sel_m,
		dcache_alt_rsel_way_m[3:0]}), 
		.dout				({dcache_alt_way_sel_b,
		dcache_alt_rsel_way_b[3:0]}), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_144 dff_wdata_m(
		.scan_in			(dff_wdata_m_scanin[143:0]), 
		.scan_out			(dff_wdata_m_scanout[143:0]), 
		.l1clk				(l1clk_in_pm), 
		.din				(dcache_wdata_e[143:0]), 
		.dout				({dcache_wparity_m[15],
		dcache_wdata_m[127:120], dcache_wparity_m[14],
		dcache_wdata_m[119:112], dcache_wparity_m[13],
		dcache_wdata_m[111:104], dcache_wparity_m[12],
		dcache_wdata_m[103:96], dcache_wparity_m[11],
		dcache_wdata_m[95:88], dcache_wparity_m[10],
		dcache_wdata_m[87:80], dcache_wparity_m[9],
		dcache_wdata_m[79:72], dcache_wparity_m[8],
		dcache_wdata_m[71:64], dcache_wparity_m[7],
		dcache_wdata_m[63:56], dcache_wparity_m[6],
		dcache_wdata_m[55:48], dcache_wparity_m[5],
		dcache_wdata_m[47:40], dcache_wparity_m[4],
		dcache_wdata_m[39:32], dcache_wparity_m[3],
		dcache_wdata_m[31:24], dcache_wparity_m[2],
		dcache_wdata_m[23:16], dcache_wparity_m[1],
		dcache_wdata_m[15:8], dcache_wparity_m[0],
		dcache_wdata_m[7:0]}), 
		.siclk				(siclk), 
		.soclk				(soclk));
	n2_dca_sp_9kb_array array(
		.l1clk				(l1clk_free), 
		.l1clk_wr			(l1clk_free_wpm), 
		.addr_b				(dcache_rwaddr_eb[10:3]), 
		.rd_en_top_b			(dcache_rvld_top_eb), 
		.rd_en_bot_b			(dcache_rvld_bot_eb), 
		.rd_en_a			(dcache_rvld_m), 
		.wr_en_b			(dcache_wvld_eb), 
		.wr_en_a			(dcache_wvld_m), 
		.wr_inh_b			(tcu_array_wr_inhibit), 
		.byte_wr_en_b			(byte_wr_en_eb[15:0]), 
		.wr_waysel_b			(wr_way_dec_eb[3:0]), 
		.fuse_dca_repair_value		(fuse_dca_repair_value_ff[5:0]),
		.fuse_dca_repair_en		(fuse_dca_repair_en_ff[1:0]), 
		.fuse_dca_rid			(fuse_dca_rid_ff[1:0]), 
		.fuse_dca_wen			(fuse_dca_wen_ff), 
		.fuse_red_reset			(fuse_red_reset_ff), 
		.dca_fuse_repair_value		
		(dca_fuse_repair_value_pre[5:0]), 
		.dca_fuse_repair_en		(dca_fuse_repair_en_pre[1:0]), 
		.l1clk_red			(l1clk_red), 
		.dcache_wdata_m			(dcache_wdata_m[127:0]), 
		.dcache_wparity_m		(dcache_wparity_m[15:0]), 
		.dcache_rdata_w0_m		(dcache_rdata_w0_m[63:0]), 
		.rparity_w0_m			(rparity_w0_m[7:0]), 
		.dcache_rdata_w1_m		(dcache_rdata_w1_m[63:0]), 
		.rparity_w1_m			(rparity_w1_m[7:0]), 
		.dcache_rdata_w2_m		(dcache_rdata_w2_m[63:0]), 
		.rparity_w2_m			(rparity_w2_m[7:0]), 
		.dcache_rdata_w3_m		(dcache_rdata_w3_m[63:0]), 
		.rparity_w3_m			(rparity_w3_m[7:0]), 
		.vnw_ary			(vnw_ary));
	mux_macro__mux_aope__ports_2__width_64 mx_way0_data(
		.din0				(dcache_rdata_w0_m[63:0]), 
		.din1				
		(lsu_l2fill_or_byp_data_m[63:0]), 
		.sel0				(dcache_bypass_m_), 
		.dout				(rdata_w0_m[63:0]));
	msff_ctl_macro__fs_1__width_8 dff_msb_w0(
		.scan_in			(dff_msb_w0_scanin[7:0]), 
		.scan_out			(dff_msb_w0_scanout[7:0]), 
		.l1clk				(l1clk_out_pm), 
		.din				({dcache_rdata_w0_m[63],
		dcache_rdata_w0_m[55], dcache_rdata_w0_m[47],
		dcache_rdata_w0_m[39], dcache_rdata_w0_m[31],
		dcache_rdata_w0_m[23], dcache_rdata_w0_m[15],
		dcache_rdata_w0_m[7]}), 
		.dout				(dcache_rdata_msb_w0_b[7:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_8 dff_msb_w1(
		.scan_in			(dff_msb_w1_scanin[7:0]), 
		.scan_out			(dff_msb_w1_scanout[7:0]), 
		.l1clk				(l1clk_out_pm), 
		.din				({dcache_rdata_w1_m[63],
		dcache_rdata_w1_m[55], dcache_rdata_w1_m[47],
		dcache_rdata_w1_m[39], dcache_rdata_w1_m[31],
		dcache_rdata_w1_m[23], dcache_rdata_w1_m[15],
		dcache_rdata_w1_m[7]}), 
		.dout				(dcache_rdata_msb_w1_b[7:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_8 dff_msb_w2(
		.scan_in			(dff_msb_w2_scanin[7:0]), 
		.scan_out			(dff_msb_w2_scanout[7:0]), 
		.l1clk				(l1clk_out_pm), 
		.din				({dcache_rdata_w2_m[63],
		dcache_rdata_w2_m[55], dcache_rdata_w2_m[47],
		dcache_rdata_w2_m[39], dcache_rdata_w2_m[31],
		dcache_rdata_w2_m[23], dcache_rdata_w2_m[15],
		dcache_rdata_w2_m[7]}), 
		.dout				(dcache_rdata_msb_w2_b[7:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_8 dff_msb_w3(
		.scan_in			(dff_msb_w3_scanin[7:0]), 
		.scan_out			(dff_msb_w3_scanout[7:0]), 
		.l1clk				(l1clk_out_pm), 
		.din				({dcache_rdata_w3_m[63],
		dcache_rdata_w3_m[55], dcache_rdata_w3_m[47],
		dcache_rdata_w3_m[39], dcache_rdata_w3_m[31],
		dcache_rdata_w3_m[23], dcache_rdata_w3_m[15],
		dcache_rdata_w3_m[7]}), 
		.dout				(dcache_rdata_msb_w3_b[7:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_64 dff_rdata_w0_m(
		.scan_in			(dff_rdata_w0_m_scanin[63:0]), 
		.scan_out			(dff_rdata_w0_m_scanout[63:0]), 
		.l1clk				(l1clk_out_pm), 
		.din				(rdata_w0_m[63:0]), 
		.dout				(rdata_w0_b[63:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_8 dff_rparity_w0_m(
		.scan_in			(dff_rparity_w0_m_scanin[7:0]), 
		.scan_out			(dff_rparity_w0_m_scanout[7:0]),
		.l1clk				(l1clk_out_pm), 
		.din				(rparity_w0_m[7:0]), 
		.dout				(rparity_w0_b[7:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_64 dff_rdata_w1_m(
		.scan_in			(dff_rdata_w1_m_scanin[63:0]), 
		.scan_out			(dff_rdata_w1_m_scanout[63:0]), 
		.l1clk				(l1clk_out_pm), 
		.din				(rdata_w1_m[63:0]), 
		.dout				(rdata_w1_b[63:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_8 dff_rparity_w1_m(
		.scan_in			(dff_rparity_w1_m_scanin[7:0]), 
		.scan_out			(dff_rparity_w1_m_scanout[7:0]),
		.l1clk				(l1clk_out_pm), 
		.din				(rparity_w1_m[7:0]), 
		.dout				(rparity_w1_b[7:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_64 dff_rdata_w2_m(
		.scan_in			(dff_rdata_w2_m_scanin[63:0]), 
		.scan_out			(dff_rdata_w2_m_scanout[63:0]), 
		.l1clk				(l1clk_out_pm), 
		.din				(rdata_w2_m[63:0]), 
		.dout				(rdata_w2_b[63:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_8 dff_rparity_w2_m(
		.scan_in			(dff_rparity_w2_m_scanin[7:0]), 
		.scan_out			(dff_rparity_w2_m_scanout[7:0]),
		.l1clk				(l1clk_out_pm), 
		.din				(rparity_w2_m[7:0]), 
		.dout				(rparity_w2_b[7:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_64 dff_rdata_w3_m(
		.scan_in			(dff_rdata_w3_m_scanin[63:0]), 
		.scan_out			(dff_rdata_w3_m_scanout[63:0]), 
		.l1clk				(l1clk_out_pm), 
		.din				(rdata_w3_m[63:0]), 
		.dout				(rdata_w3_b[63:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_8 dff_rparity_w3_m(
		.scan_in			(dff_rparity_w3_m_scanin[7:0]), 
		.scan_out			(dff_rparity_w3_m_scanout[7:0]),
		.l1clk				(l1clk_out_pm), 
		.din				(rparity_w3_m[7:0]), 
		.dout				(rparity_w3_b[7:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	mux_macro__mux_aope__ports_2__width_4 mx_sel_way(
		.din0				(dcache_alt_rsel_way_b[3:0]), 
		.din1				(dcache_rsel_way_b[3:0]), 
		.sel0				(dcache_alt_way_sel_b), 
		.dout				(dcache_rd_sel_way_b[3:0]));
	mux_macro__mux_aonpe__ports_4__width_64 mx_rdata_b(
		.din0				(rdata_w0_b[63:0]), 
		.din1				(rdata_w1_b[63:0]), 
		.din2				(rdata_w2_b[63:0]), 
		.din3				(rdata_w3_b[63:0]), 
		.sel0				(dcache_rd_sel_way_b[0]), 
		.sel1				(dcache_rd_sel_way_b[1]), 
		.sel2				(dcache_rd_sel_way_b[2]), 
		.sel3				(dcache_rd_sel_way_b[3]), 
		.dout				(dcache_rdata_b[63:0]));
	mux_macro__mux_aonpe__ports_4__width_8 mx_rparity_b(
		.din0				(rparity_w0_b[7:0]), 
		.din1				(rparity_w1_b[7:0]), 
		.din2				(rparity_w2_b[7:0]), 
		.din3				(rparity_w3_b[7:0]), 
		.sel0				(dcache_rd_sel_way_b[0]), 
		.sel1				(dcache_rd_sel_way_b[1]), 
		.sel2				(dcache_rd_sel_way_b[2]), 
		.sel3				(dcache_rd_sel_way_b[3]), 
		.dout				(dcache_rparity_b[7:0]));
	xor_macro__ports_3__width_4 w0_par0(
		.din0				({dcache_rdata_w0_m[0],
		dcache_rdata_w0_m[3], dcache_rdata_w0_m[6], w0_p0_0}), 
		.din1				({dcache_rdata_w0_m[1],
		dcache_rdata_w0_m[4], dcache_rdata_w0_m[7], w0_p0_1}), 
		.din2				({dcache_rdata_w0_m[2],
		dcache_rdata_w0_m[5], rparity_w0_m[0], w0_p0_2}), 
		.dout				({w0_p0_0, w0_p0_1, w0_p0_2,
		w0_parity_m[0]}));
	xor_macro__ports_3__width_4 w0_par1(
		.din0				({dcache_rdata_w0_m[8],
		dcache_rdata_w0_m[11], dcache_rdata_w0_m[14], w0_p1_0}), 
		.din1				({dcache_rdata_w0_m[9],
		dcache_rdata_w0_m[12], dcache_rdata_w0_m[15], w0_p1_1}), 
		.din2				({dcache_rdata_w0_m[10],
		dcache_rdata_w0_m[13], rparity_w0_m[1], w0_p1_2}), 
		.dout				({w0_p1_0, w0_p1_1, w0_p1_2,
		w0_parity_m[1]}));
	xor_macro__ports_3__width_4 w0_par2(
		.din0				({dcache_rdata_w0_m[16],
		dcache_rdata_w0_m[19], dcache_rdata_w0_m[22], w0_p2_0}), 
		.din1				({dcache_rdata_w0_m[17],
		dcache_rdata_w0_m[20], dcache_rdata_w0_m[23], w0_p2_1}), 
		.din2				({dcache_rdata_w0_m[18],
		dcache_rdata_w0_m[21], rparity_w0_m[2], w0_p2_2}), 
		.dout				({w0_p2_0, w0_p2_1, w0_p2_2,
		w0_parity_m[2]}));
	xor_macro__ports_3__width_4 w0_par3(
		.din0				({dcache_rdata_w0_m[24],
		dcache_rdata_w0_m[27], dcache_rdata_w0_m[30], w0_p3_0}), 
		.din1				({dcache_rdata_w0_m[25],
		dcache_rdata_w0_m[28], dcache_rdata_w0_m[31], w0_p3_1}), 
		.din2				({dcache_rdata_w0_m[26],
		dcache_rdata_w0_m[29], rparity_w0_m[3], w0_p3_2}), 
		.dout				({w0_p3_0, w0_p3_1, w0_p3_2,
		w0_parity_m[3]}));
	xor_macro__ports_3__width_4 w0_par4(
		.din0				({dcache_rdata_w0_m[32],
		dcache_rdata_w0_m[35], dcache_rdata_w0_m[38], w0_p4_0}), 
		.din1				({dcache_rdata_w0_m[33],
		dcache_rdata_w0_m[36], dcache_rdata_w0_m[39], w0_p4_1}), 
		.din2				({dcache_rdata_w0_m[34],
		dcache_rdata_w0_m[37], rparity_w0_m[4], w0_p4_2}), 
		.dout				({w0_p4_0, w0_p4_1, w0_p4_2,
		w0_parity_m[4]}));
	xor_macro__ports_3__width_4 w0_par5(
		.din0				({dcache_rdata_w0_m[40],
		dcache_rdata_w0_m[43], dcache_rdata_w0_m[46], w0_p5_0}), 
		.din1				({dcache_rdata_w0_m[41],
		dcache_rdata_w0_m[44], dcache_rdata_w0_m[47], w0_p5_1}), 
		.din2				({dcache_rdata_w0_m[42],
		dcache_rdata_w0_m[45], rparity_w0_m[5], w0_p5_2}), 
		.dout				({w0_p5_0, w0_p5_1, w0_p5_2,
		w0_parity_m[5]}));
	xor_macro__ports_3__width_4 w0_par6(
		.din0				({dcache_rdata_w0_m[48],
		dcache_rdata_w0_m[51], dcache_rdata_w0_m[54], w0_p6_0}), 
		.din1				({dcache_rdata_w0_m[49],
		dcache_rdata_w0_m[52], dcache_rdata_w0_m[55], w0_p6_1}), 
		.din2				({dcache_rdata_w0_m[50],
		dcache_rdata_w0_m[53], rparity_w0_m[6], w0_p6_2}), 
		.dout				({w0_p6_0, w0_p6_1, w0_p6_2,
		w0_parity_m[6]}));
	xor_macro__ports_3__width_4 w0_par7(
		.din0				({dcache_rdata_w0_m[56],
		dcache_rdata_w0_m[59], dcache_rdata_w0_m[62], w0_p7_0}), 
		.din1				({dcache_rdata_w0_m[57],
		dcache_rdata_w0_m[60], dcache_rdata_w0_m[63], w0_p7_1}), 
		.din2				({dcache_rdata_w0_m[58],
		dcache_rdata_w0_m[61], rparity_w0_m[7], w0_p7_2}), 
		.dout				({w0_p7_0, w0_p7_1, w0_p7_2,
		w0_parity_m[7]}));
	xor_macro__ports_3__width_4 w1_par0(
		.din0				({dcache_rdata_w1_m[0],
		dcache_rdata_w1_m[3], dcache_rdata_w1_m[6], w1_p0_0}), 
		.din1				({dcache_rdata_w1_m[1],
		dcache_rdata_w1_m[4], dcache_rdata_w1_m[7], w1_p0_1}), 
		.din2				({dcache_rdata_w1_m[2],
		dcache_rdata_w1_m[5], rparity_w1_m[0], w1_p0_2}), 
		.dout				({w1_p0_0, w1_p0_1, w1_p0_2,
		w1_parity_m[0]}));
	xor_macro__ports_3__width_4 w1_par1(
		.din0				({dcache_rdata_w1_m[8],
		dcache_rdata_w1_m[11], dcache_rdata_w1_m[14], w1_p1_0}), 
		.din1				({dcache_rdata_w1_m[9],
		dcache_rdata_w1_m[12], dcache_rdata_w1_m[15], w1_p1_1}), 
		.din2				({dcache_rdata_w1_m[10],
		dcache_rdata_w1_m[13], rparity_w1_m[1], w1_p1_2}), 
		.dout				({w1_p1_0, w1_p1_1, w1_p1_2,
		w1_parity_m[1]}));
	xor_macro__ports_3__width_4 w1_par2(
		.din0				({dcache_rdata_w1_m[16],
		dcache_rdata_w1_m[19], dcache_rdata_w1_m[22], w1_p2_0}), 
		.din1				({dcache_rdata_w1_m[17],
		dcache_rdata_w1_m[20], dcache_rdata_w1_m[23], w1_p2_1}), 
		.din2				({dcache_rdata_w1_m[18],
		dcache_rdata_w1_m[21], rparity_w1_m[2], w1_p2_2}), 
		.dout				({w1_p2_0, w1_p2_1, w1_p2_2,
		w1_parity_m[2]}));
	xor_macro__ports_3__width_4 w1_par3(
		.din0				({dcache_rdata_w1_m[24],
		dcache_rdata_w1_m[27], dcache_rdata_w1_m[30], w1_p3_0}), 
		.din1				({dcache_rdata_w1_m[25],
		dcache_rdata_w1_m[28], dcache_rdata_w1_m[31], w1_p3_1}), 
		.din2				({dcache_rdata_w1_m[26],
		dcache_rdata_w1_m[29], rparity_w1_m[3], w1_p3_2}), 
		.dout				({w1_p3_0, w1_p3_1, w1_p3_2,
		w1_parity_m[3]}));
	xor_macro__ports_3__width_4 w1_par4(
		.din0				({dcache_rdata_w1_m[32],
		dcache_rdata_w1_m[35], dcache_rdata_w1_m[38], w1_p4_0}), 
		.din1				({dcache_rdata_w1_m[33],
		dcache_rdata_w1_m[36], dcache_rdata_w1_m[39], w1_p4_1}), 
		.din2				({dcache_rdata_w1_m[34],
		dcache_rdata_w1_m[37], rparity_w1_m[4], w1_p4_2}), 
		.dout				({w1_p4_0, w1_p4_1, w1_p4_2,
		w1_parity_m[4]}));
	xor_macro__ports_3__width_4 w1_par5(
		.din0				({dcache_rdata_w1_m[40],
		dcache_rdata_w1_m[43], dcache_rdata_w1_m[46], w1_p5_0}), 
		.din1				({dcache_rdata_w1_m[41],
		dcache_rdata_w1_m[44], dcache_rdata_w1_m[47], w1_p5_1}), 
		.din2				({dcache_rdata_w1_m[42],
		dcache_rdata_w1_m[45], rparity_w1_m[5], w1_p5_2}), 
		.dout				({w1_p5_0, w1_p5_1, w1_p5_2,
		w1_parity_m[5]}));
	xor_macro__ports_3__width_4 w1_par6(
		.din0				({dcache_rdata_w1_m[48],
		dcache_rdata_w1_m[51], dcache_rdata_w1_m[54], w1_p6_0}), 
		.din1				({dcache_rdata_w1_m[49],
		dcache_rdata_w1_m[52], dcache_rdata_w1_m[55], w1_p6_1}), 
		.din2				({dcache_rdata_w1_m[50],
		dcache_rdata_w1_m[53], rparity_w1_m[6], w1_p6_2}), 
		.dout				({w1_p6_0, w1_p6_1, w1_p6_2,
		w1_parity_m[6]}));
	xor_macro__ports_3__width_4 w1_par7(
		.din0				({dcache_rdata_w1_m[56],
		dcache_rdata_w1_m[59], dcache_rdata_w1_m[62], w1_p7_0}), 
		.din1				({dcache_rdata_w1_m[57],
		dcache_rdata_w1_m[60], dcache_rdata_w1_m[63], w1_p7_1}), 
		.din2				({dcache_rdata_w1_m[58],
		dcache_rdata_w1_m[61], rparity_w1_m[7], w1_p7_2}), 
		.dout				({w1_p7_0, w1_p7_1, w1_p7_2,
		w1_parity_m[7]}));
	xor_macro__ports_3__width_4 w2_par0(
		.din0				({dcache_rdata_w2_m[0],
		dcache_rdata_w2_m[3], dcache_rdata_w2_m[6], w2_p0_0}), 
		.din1				({dcache_rdata_w2_m[1],
		dcache_rdata_w2_m[4], dcache_rdata_w2_m[7], w2_p0_1}), 
		.din2				({dcache_rdata_w2_m[2],
		dcache_rdata_w2_m[5], rparity_w2_m[0], w2_p0_2}), 
		.dout				({w2_p0_0, w2_p0_1, w2_p0_2,
		w2_parity_m[0]}));
	xor_macro__ports_3__width_4 w2_par1(
		.din0				({dcache_rdata_w2_m[8],
		dcache_rdata_w2_m[11], dcache_rdata_w2_m[14], w2_p1_0}), 
		.din1				({dcache_rdata_w2_m[9],
		dcache_rdata_w2_m[12], dcache_rdata_w2_m[15], w2_p1_1}), 
		.din2				({dcache_rdata_w2_m[10],
		dcache_rdata_w2_m[13], rparity_w2_m[1], w2_p1_2}), 
		.dout				({w2_p1_0, w2_p1_1, w2_p1_2,
		w2_parity_m[1]}));
	xor_macro__ports_3__width_4 w2_par2(
		.din0				({dcache_rdata_w2_m[16],
		dcache_rdata_w2_m[19], dcache_rdata_w2_m[22], w2_p2_0}), 
		.din1				({dcache_rdata_w2_m[17],
		dcache_rdata_w2_m[20], dcache_rdata_w2_m[23], w2_p2_1}), 
		.din2				({dcache_rdata_w2_m[18],
		dcache_rdata_w2_m[21], rparity_w2_m[2], w2_p2_2}), 
		.dout				({w2_p2_0, w2_p2_1, w2_p2_2,
		w2_parity_m[2]}));
	xor_macro__ports_3__width_4 w2_par3(
		.din0				({dcache_rdata_w2_m[24],
		dcache_rdata_w2_m[27], dcache_rdata_w2_m[30], w2_p3_0}), 
		.din1				({dcache_rdata_w2_m[25],
		dcache_rdata_w2_m[28], dcache_rdata_w2_m[31], w2_p3_1}), 
		.din2				({dcache_rdata_w2_m[26],
		dcache_rdata_w2_m[29], rparity_w2_m[3], w2_p3_2}), 
		.dout				({w2_p3_0, w2_p3_1, w2_p3_2,
		w2_parity_m[3]}));
	xor_macro__ports_3__width_4 w2_par4(
		.din0				({dcache_rdata_w2_m[32],
		dcache_rdata_w2_m[35], dcache_rdata_w2_m[38], w2_p4_0}), 
		.din1				({dcache_rdata_w2_m[33],
		dcache_rdata_w2_m[36], dcache_rdata_w2_m[39], w2_p4_1}), 
		.din2				({dcache_rdata_w2_m[34],
		dcache_rdata_w2_m[37], rparity_w2_m[4], w2_p4_2}), 
		.dout				({w2_p4_0, w2_p4_1, w2_p4_2,
		w2_parity_m[4]}));
	xor_macro__ports_3__width_4 w2_par5(
		.din0				({dcache_rdata_w2_m[40],
		dcache_rdata_w2_m[43], dcache_rdata_w2_m[46], w2_p5_0}), 
		.din1				({dcache_rdata_w2_m[41],
		dcache_rdata_w2_m[44], dcache_rdata_w2_m[47], w2_p5_1}), 
		.din2				({dcache_rdata_w2_m[42],
		dcache_rdata_w2_m[45], rparity_w2_m[5], w2_p5_2}), 
		.dout				({w2_p5_0, w2_p5_1, w2_p5_2,
		w2_parity_m[5]}));
	xor_macro__ports_3__width_4 w2_par6(
		.din0				({dcache_rdata_w2_m[48],
		dcache_rdata_w2_m[51], dcache_rdata_w2_m[54], w2_p6_0}), 
		.din1				({dcache_rdata_w2_m[49],
		dcache_rdata_w2_m[52], dcache_rdata_w2_m[55], w2_p6_1}), 
		.din2				({dcache_rdata_w2_m[50],
		dcache_rdata_w2_m[53], rparity_w2_m[6], w2_p6_2}), 
		.dout				({w2_p6_0, w2_p6_1, w2_p6_2,
		w2_parity_m[6]}));
	xor_macro__ports_3__width_4 w2_par7(
		.din0				({dcache_rdata_w2_m[56],
		dcache_rdata_w2_m[59], dcache_rdata_w2_m[62], w2_p7_0}), 
		.din1				({dcache_rdata_w2_m[57],
		dcache_rdata_w2_m[60], dcache_rdata_w2_m[63], w2_p7_1}), 
		.din2				({dcache_rdata_w2_m[58],
		dcache_rdata_w2_m[61], rparity_w2_m[7], w2_p7_2}), 
		.dout				({w2_p7_0, w2_p7_1, w2_p7_2,
		w2_parity_m[7]}));
	xor_macro__ports_3__width_4 w3_par0(
		.din0				({dcache_rdata_w3_m[0],
		dcache_rdata_w3_m[3], dcache_rdata_w3_m[6], w3_p0_0}), 
		.din1				({dcache_rdata_w3_m[1],
		dcache_rdata_w3_m[4], dcache_rdata_w3_m[7], w3_p0_1}), 
		.din2				({dcache_rdata_w3_m[2],
		dcache_rdata_w3_m[5], rparity_w3_m[0], w3_p0_2}), 
		.dout				({w3_p0_0, w3_p0_1, w3_p0_2,
		w3_parity_m[0]}));
	xor_macro__ports_3__width_4 w3_par1(
		.din0				({dcache_rdata_w3_m[8],
		dcache_rdata_w3_m[11], dcache_rdata_w3_m[14], w3_p1_0}), 
		.din1				({dcache_rdata_w3_m[9],
		dcache_rdata_w3_m[12], dcache_rdata_w3_m[15], w3_p1_1}), 
		.din2				({dcache_rdata_w3_m[10],
		dcache_rdata_w3_m[13], rparity_w3_m[1], w3_p1_2}), 
		.dout				({w3_p1_0, w3_p1_1, w3_p1_2,
		w3_parity_m[1]}));
	xor_macro__ports_3__width_4 w3_par2(
		.din0				({dcache_rdata_w3_m[16],
		dcache_rdata_w3_m[19], dcache_rdata_w3_m[22], w3_p2_0}), 
		.din1				({dcache_rdata_w3_m[17],
		dcache_rdata_w3_m[20], dcache_rdata_w3_m[23], w3_p2_1}), 
		.din2				({dcache_rdata_w3_m[18],
		dcache_rdata_w3_m[21], rparity_w3_m[2], w3_p2_2}), 
		.dout				({w3_p2_0, w3_p2_1, w3_p2_2,
		w3_parity_m[2]}));
	xor_macro__ports_3__width_4 w3_par3(
		.din0				({dcache_rdata_w3_m[24],
		dcache_rdata_w3_m[27], dcache_rdata_w3_m[30], w3_p3_0}), 
		.din1				({dcache_rdata_w3_m[25],
		dcache_rdata_w3_m[28], dcache_rdata_w3_m[31], w3_p3_1}), 
		.din2				({dcache_rdata_w3_m[26],
		dcache_rdata_w3_m[29], rparity_w3_m[3], w3_p3_2}), 
		.dout				({w3_p3_0, w3_p3_1, w3_p3_2,
		w3_parity_m[3]}));
	xor_macro__ports_3__width_4 w3_par4(
		.din0				({dcache_rdata_w3_m[32],
		dcache_rdata_w3_m[35], dcache_rdata_w3_m[38], w3_p4_0}), 
		.din1				({dcache_rdata_w3_m[33],
		dcache_rdata_w3_m[36], dcache_rdata_w3_m[39], w3_p4_1}), 
		.din2				({dcache_rdata_w3_m[34],
		dcache_rdata_w3_m[37], rparity_w3_m[4], w3_p4_2}), 
		.dout				({w3_p4_0, w3_p4_1, w3_p4_2,
		w3_parity_m[4]}));
	xor_macro__ports_3__width_4 w3_par5(
		.din0				({dcache_rdata_w3_m[40],
		dcache_rdata_w3_m[43], dcache_rdata_w3_m[46], w3_p5_0}), 
		.din1				({dcache_rdata_w3_m[41],
		dcache_rdata_w3_m[44], dcache_rdata_w3_m[47], w3_p5_1}), 
		.din2				({dcache_rdata_w3_m[42],
		dcache_rdata_w3_m[45], rparity_w3_m[5], w3_p5_2}), 
		.dout				({w3_p5_0, w3_p5_1, w3_p5_2,
		w3_parity_m[5]}));
	xor_macro__ports_3__width_4 w3_par6(
		.din0				({dcache_rdata_w3_m[48],
		dcache_rdata_w3_m[51], dcache_rdata_w3_m[54], w3_p6_0}), 
		.din1				({dcache_rdata_w3_m[49],
		dcache_rdata_w3_m[52], dcache_rdata_w3_m[55], w3_p6_1}), 
		.din2				({dcache_rdata_w3_m[50],
		dcache_rdata_w3_m[53], rparity_w3_m[6], w3_p6_2}), 
		.dout				({w3_p6_0, w3_p6_1, w3_p6_2,
		w3_parity_m[6]}));
	xor_macro__ports_3__width_4 w3_par7(
		.din0				({dcache_rdata_w3_m[56],
		dcache_rdata_w3_m[59], dcache_rdata_w3_m[62], w3_p7_0}), 
		.din1				({dcache_rdata_w3_m[57],
		dcache_rdata_w3_m[60], dcache_rdata_w3_m[63], w3_p7_1}), 
		.din2				({dcache_rdata_w3_m[58],
		dcache_rdata_w3_m[61], rparity_w3_m[7], w3_p7_2}), 
		.dout				({w3_p7_0, w3_p7_1, w3_p7_2,
		w3_parity_m[7]}));
	msff_ctl_macro__fs_1__width_8 dff_byte_perr_w0(
		.scan_in			(dff_byte_perr_w0_scanin[7:0]), 
		.scan_out			(dff_byte_perr_w0_scanout[7:0]),
		.l1clk				(l1clk_out_pm), 
		.din				(w0_parity_m[7:0]), 
		.dout				(w0_parity_b[7:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_8 dff_byte_perr_w1(
		.scan_in			(dff_byte_perr_w1_scanin[7:0]), 
		.scan_out			(dff_byte_perr_w1_scanout[7:0]),
		.l1clk				(l1clk_out_pm), 
		.din				(w1_parity_m[7:0]), 
		.dout				(w1_parity_b[7:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_8 dff_byte_perr_w2(
		.scan_in			(dff_byte_perr_w2_scanin[7:0]), 
		.scan_out			(dff_byte_perr_w2_scanout[7:0]),
		.l1clk				(l1clk_out_pm), 
		.din				(w2_parity_m[7:0]), 
		.dout				(w2_parity_b[7:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_8 dff_byte_perr_w3(
		.scan_in			(dff_byte_perr_w3_scanin[7:0]), 
		.scan_out			(dff_byte_perr_w3_scanout[7:0]),
		.l1clk				(l1clk_out_pm), 
		.din				(w3_parity_m[7:0]), 
		.dout				(w3_parity_b[7:0]), 
		.siclk				(siclk), 
		.soclk				(soclk));
	mux_macro__mux_aonpe__ports_8__width_1 parity_w0(
		.din0				(1'b1), 
		.din1				(1'b1), 
		.din2				(1'b1), 
		.din3				(1'b1), 
		.din4				(1'b1), 
		.din5				(1'b1), 
		.din6				(1'b1), 
		.din7				(1'b1), 
		.sel0				(w0_parity_b[0]), 
		.sel1				(w0_parity_b[1]), 
		.sel2				(w0_parity_b[2]), 
		.sel3				(w0_parity_b[3]), 
		.sel4				(w0_parity_b[4]), 
		.sel5				(w0_parity_b[5]), 
		.sel6				(w0_parity_b[6]), 
		.sel7				(w0_parity_b[7]), 
		.dout				(w0_parity_err_b));
	mux_macro__mux_aonpe__ports_8__width_1 parity_w1(
		.din0				(1'b1), 
		.din1				(1'b1), 
		.din2				(1'b1), 
		.din3				(1'b1), 
		.din4				(1'b1), 
		.din5				(1'b1), 
		.din6				(1'b1), 
		.din7				(1'b1), 
		.sel0				(w1_parity_b[0]), 
		.sel1				(w1_parity_b[1]), 
		.sel2				(w1_parity_b[2]), 
		.sel3				(w1_parity_b[3]), 
		.sel4				(w1_parity_b[4]), 
		.sel5				(w1_parity_b[5]), 
		.sel6				(w1_parity_b[6]), 
		.sel7				(w1_parity_b[7]), 
		.dout				(w1_parity_err_b));
	mux_macro__mux_aonpe__ports_8__width_1 parity_w2(
		.din0				(1'b1), 
		.din1				(1'b1), 
		.din2				(1'b1), 
		.din3				(1'b1), 
		.din4				(1'b1), 
		.din5				(1'b1), 
		.din6				(1'b1), 
		.din7				(1'b1), 
		.sel0				(w2_parity_b[0]), 
		.sel1				(w2_parity_b[1]), 
		.sel2				(w2_parity_b[2]), 
		.sel3				(w2_parity_b[3]), 
		.sel4				(w2_parity_b[4]), 
		.sel5				(w2_parity_b[5]), 
		.sel6				(w2_parity_b[6]), 
		.sel7				(w2_parity_b[7]), 
		.dout				(w2_parity_err_b));
	mux_macro__mux_aonpe__ports_8__width_1 parity_w3(
		.din0				(1'b1), 
		.din1				(1'b1), 
		.din2				(1'b1), 
		.din3				(1'b1), 
		.din4				(1'b1), 
		.din5				(1'b1), 
		.din6				(1'b1), 
		.din7				(1'b1), 
		.sel0				(w3_parity_b[0]), 
		.sel1				(w3_parity_b[1]), 
		.sel2				(w3_parity_b[2]), 
		.sel3				(w3_parity_b[3]), 
		.sel4				(w3_parity_b[4]), 
		.sel5				(w3_parity_b[5]), 
		.sel6				(w3_parity_b[6]), 
		.sel7				(w3_parity_b[7]), 
		.dout				(w3_parity_err_b));
	msff_ctl_macro__fs_1__width_12 dff_red_in(
		.scan_in			(dff_red_in_scanin[11:0]), 
		.scan_out			(dff_red_in_scanout[11:0]), 
		.l1clk				(l1clk_in), 
		.din				({fuse_dca_repair_value[5:0],
		fuse_dca_repair_en[1:0], fuse_dca_rid[1:0], fuse_dca_wen,
		fuse_red_reset}), 
		.dout				({fuse_dca_repair_value_ff[5:0],
		fuse_dca_repair_en_ff[1:0], fuse_dca_rid_ff[1:0],
		fuse_dca_wen_ff, fuse_red_reset_ff}), 
		.siclk				(siclk), 
		.soclk				(soclk));
	msff_ctl_macro__fs_1__width_8 dff_red_out(
		.scan_in			(dff_red_out_scanin[7:0]), 
		.scan_out			(dff_red_out_scanout[7:0]), 
		.l1clk				(l1clk_out), 
		.din				
		({dca_fuse_repair_value_pre[5:0], dca_fuse_repair_en_pre[1:0]}),
		.dout				({dca_fuse_repair_value[5:0],
		dca_fuse_repair_en[1:0]}), 
		.siclk				(siclk), 
		.soclk				(soclk));
endmodule

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 36871 */
// No timescale specified
module mux_macro__mux_aonpe__ports_4__width_64(din0, sel0, din1, sel1, din2, 
	sel2, din3, sel3, dout);

	input	[63:0]		din0;
	input			sel0;
	input	[63:0]		din1;
	input			sel1;
	input	[63:0]		din2;
	input			sel2;
	input	[63:0]		din3;
	input			sel3;
	output	[63:0]		dout;

	wire			buffout0;
	wire			buffout1;
	wire			buffout2;
	wire			buffout3;

	cl_dp1_muxbuff4_8x c0_0(
		.in0				(sel0), 
		.in1				(sel1), 
		.in2				(sel2), 
		.in3				(sel3), 
		.out0				(buffout0), 
		.out1				(buffout1), 
		.out2				(buffout2), 
		.out3				(buffout3));
	mux4s #(64) d0_0(
		.sel0				(buffout0), 
		.sel1				(buffout1), 
		.sel2				(buffout2), 
		.sel3				(buffout3), 
		.in0				(din0[63:0]), 
		.in1				(din1[63:0]), 
		.in2				(din2[63:0]), 
		.in3				(din3[63:0]), 
		.dout				(dout[63:0]));
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 40507 */
// No timescale specified
module msff_ctl_macro__fs_1__width_64(din, l1clk, scan_in, siclk, soclk, dout, 
	scan_out);

	input	[63:0]		din;
	input			l1clk;
	input	[63:0]		scan_in;
	input			siclk;
	input			soclk;
	output	[63:0]		dout;
	output	[63:0]		scan_out;

	wire	[63:0]		fdin;

	assign fdin[63:0] = din[63:0];

	dff #(64) d0_0(
		.l1clk				(l1clk), 
		.siclk				(siclk), 
		.soclk				(soclk), 
		.d				(fdin[63:0]), 
		.si				(scan_in[63:0]), 
		.so				(scan_out[63:0]), 
		.q				(dout[63:0]));
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 58446 */
// No timescale specified
module msff_ctl_macro__fs_1__width_5(din, l1clk, scan_in, siclk, soclk, dout, 
	scan_out);

	input	[4:0]		din;
	input			l1clk;
	input	[4:0]		scan_in;
	input			siclk;
	input			soclk;
	output	[4:0]		dout;
	output	[4:0]		scan_out;

	wire	[4:0]		fdin;

	assign fdin[4:0] = din[4:0];

	dff #(5) d0_0(
		.l1clk				(l1clk), 
		.siclk				(siclk), 
		.soclk				(soclk), 
		.d				(fdin[4:0]), 
		.si				(scan_in[4:0]), 
		.so				(scan_out[4:0]), 
		.q				(dout[4:0]));
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 58527 */
// No timescale specified
module msff_ctl_macro__fs_1__width_8(din, l1clk, scan_in, siclk, soclk, dout, 
	scan_out);

	input	[7:0]		din;
	input			l1clk;
	input	[7:0]		scan_in;
	input			siclk;
	input			soclk;
	output	[7:0]		dout;
	output	[7:0]		scan_out;

	wire	[7:0]		fdin;

	assign fdin[7:0] = din[7:0];

	dff #(8) d0_0(
		.l1clk				(l1clk), 
		.siclk				(siclk), 
		.soclk				(soclk), 
		.d				(fdin[7:0]), 
		.si				(scan_in[7:0]), 
		.so				(scan_out[7:0]), 
		.q				(dout[7:0]));
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 61614 */
// No timescale specified
module msff_ctl_macro__fs_1__width_3(din, l1clk, scan_in, siclk, soclk, dout, 
	scan_out);

	input	[2:0]		din;
	input			l1clk;
	input	[2:0]		scan_in;
	input			siclk;
	input			soclk;
	output	[2:0]		dout;
	output	[2:0]		scan_out;

	wire	[2:0]		fdin;

	assign fdin[2:0] = din[2:0];

	dff #(3) d0_0(
		.l1clk				(l1clk), 
		.siclk				(siclk), 
		.soclk				(soclk), 
		.d				(fdin[2:0]), 
		.si				(scan_in[2:0]), 
		.so				(scan_out[2:0]), 
		.q				(dout[2:0]));
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 62461 */
// No timescale specified
module mux_macro__mux_aonpe__ports_8__width_1(din0, sel0, din1, sel1, din2, 
	sel2, din3, sel3, din4, sel4, din5, sel5, din6, sel6, din7, sel7, dout);

	input	[0:0]		din0;
	input			sel0;
	input	[0:0]		din1;
	input			sel1;
	input	[0:0]		din2;
	input			sel2;
	input	[0:0]		din3;
	input			sel3;
	input	[0:0]		din4;
	input			sel4;
	input	[0:0]		din5;
	input			sel5;
	input	[0:0]		din6;
	input			sel6;
	input	[0:0]		din7;
	input			sel7;
	output	[0:0]		dout;

	wire			buffout0;
	wire			buffout1;
	wire			buffout2;
	wire			buffout3;
	wire			buffout4;
	wire			buffout5;
	wire			buffout6;
	wire			buffout7;

	cl_dp1_muxbuff8_8x c0_0(
		.in0				(sel0), 
		.in1				(sel1), 
		.in2				(sel2), 
		.in3				(sel3), 
		.in4				(sel4), 
		.in5				(sel5), 
		.in6				(sel6), 
		.in7				(sel7), 
		.out0				(buffout0), 
		.out1				(buffout1), 
		.out2				(buffout2), 
		.out3				(buffout3), 
		.out4				(buffout4), 
		.out5				(buffout5), 
		.out6				(buffout6), 
		.out7				(buffout7));
	mux8s #(1) d0_0(
		.sel0				(buffout0), 
		.sel1				(buffout1), 
		.sel2				(buffout2), 
		.sel3				(buffout3), 
		.sel4				(buffout4), 
		.sel5				(buffout5), 
		.sel6				(buffout6), 
		.sel7				(buffout7), 
		.in0				(din0[0]), 
		.in1				(din1[0]), 
		.in2				(din2[0]), 
		.in3				(din3[0]), 
		.in4				(din4[0]), 
		.in5				(din5[0]), 
		.in6				(din6[0]), 
		.in7				(din7[0]), 
		.dout				(dout[0]));
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 129372 */
// No timescale specified
module mux_macro__mux_aope__ports_2__width_8(din0, din1, sel0, dout);

	input	[7:0]		din0;
	input	[7:0]		din1;
	input			sel0;
	output	[7:0]		dout;

	wire			psel0;
	wire			psel1;

	cl_dp1_penc2_8x c0_0(
		.sel0				(sel0), 
		.psel0				(psel0), 
		.psel1				(psel1));
	mux2s #(8) d0_0(
		.sel0				(psel0), 
		.sel1				(psel1), 
		.in0				(din0[7:0]), 
		.in1				(din1[7:0]), 
		.dout				(dout[7:0]));
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 129421 */
// No timescale specified
module mux_macro__mux_aodec__ports_4__width_4(din0, din1, din2, din3, sel, dout)
	;

	input	[3:0]		din0;
	input	[3:0]		din1;
	input	[3:0]		din2;
	input	[3:0]		din3;
	input	[1:0]		sel;
	output	[3:0]		dout;

	wire			psel0;
	wire			psel1;
	wire			psel2;
	wire			psel3;

	cl_dp1_pdec4_8x c0_0(
		.test				(1'b1), 
		.sel0				(sel[0]), 
		.sel1				(sel[1]), 
		.psel0				(psel0), 
		.psel1				(psel1), 
		.psel2				(psel2), 
		.psel3				(psel3));
	mux4s #(4) d0_0(
		.sel0				(psel0), 
		.sel1				(psel1), 
		.sel2				(psel2), 
		.sel3				(psel3), 
		.in0				(din0[3:0]), 
		.in1				(din1[3:0]), 
		.in2				(din2[3:0]), 
		.in3				(din3[3:0]), 
		.dout				(dout[3:0]));
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 129458 */
// No timescale specified
module tisram_msff_macro__fs_1__width_7(d, scan_in, l1clk, siclk, soclk, 
	scan_out, latout, latout_l);

	input	[6:0]		d;
	input	[6:0]		scan_in;
	input			l1clk;
	input			siclk;
	input			soclk;
	output	[6:0]		scan_out;
	output	[6:0]		latout;
	output	[6:0]		latout_l;

	tisram_msff #(7) d0_0(
		.d				(d[6:0]), 
		.si				(scan_in[6:0]), 
		.so				(scan_out[6:0]), 
		.l1clk				(l1clk), 
		.siclk				(siclk), 
		.soclk				(soclk), 
		.latout				(latout[6:0]), 
		.latout_l			(latout_l[6:0]));
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 129483 */
// No timescale specified
module tisram_msff_macro__fs_1__width_16(d, scan_in, l1clk, siclk, soclk, 
	scan_out, latout, latout_l);

	input	[15:0]		d;
	input	[15:0]		scan_in;
	input			l1clk;
	input			siclk;
	input			soclk;
	output	[15:0]		scan_out;
	output	[15:0]		latout;
	output	[15:0]		latout_l;

	tisram_msff #(16) d0_0(
		.d				(d[15:0]), 
		.si				(scan_in[15:0]), 
		.so				(scan_out[15:0]), 
		.l1clk				(l1clk), 
		.siclk				(siclk), 
		.soclk				(soclk), 
		.latout				(latout[15:0]), 
		.latout_l			(latout_l[15:0]));
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 129508 */
// No timescale specified
module msff_ctl_macro__fs_1__width_144(din, l1clk, scan_in, siclk, soclk, dout, 
	scan_out);

	input	[143:0]		din;
	input			l1clk;
	input	[143:0]		scan_in;
	input			siclk;
	input			soclk;
	output	[143:0]		dout;
	output	[143:0]		scan_out;

	wire	[143:0]		fdin;

	assign fdin[143:0] = din[143:0];

	dff #(144) d0_0(
		.l1clk				(l1clk), 
		.siclk				(siclk), 
		.soclk				(soclk), 
		.d				(fdin[143:0]), 
		.si				(scan_in[143:0]), 
		.so				(scan_out[143:0]), 
		.q				(dout[143:0]));
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 129535 */
// No timescale specified
module n2_dca_sp_9kb_array(l1clk, l1clk_wr, l1clk_red, rd_en_top_b, rd_en_bot_b,
	rd_en_a, wr_en_a, wr_en_b, wr_inh_b, addr_b, byte_wr_en_b, wr_waysel_b, 
	dcache_wdata_m, dcache_wparity_m, dcache_rdata_w0_m, rparity_w0_m, 
	dcache_rdata_w1_m, rparity_w1_m, dcache_rdata_w2_m, rparity_w2_m, 
	dcache_rdata_w3_m, rparity_w3_m, fuse_dca_repair_value, 
	fuse_dca_repair_en, fuse_dca_rid, fuse_dca_wen, fuse_red_reset, 
	dca_fuse_repair_value, dca_fuse_repair_en, vnw_ary);

	input			l1clk;
	input			l1clk_wr;
	input			l1clk_red;
	input			rd_en_top_b;
	input			rd_en_bot_b;
	input			rd_en_a;
	input			wr_en_a;
	input			wr_en_b;
	input			wr_inh_b;
	input	[10:3]		addr_b;
	input	[15:0]		byte_wr_en_b;
	input	[3:0]		wr_waysel_b;
	input	[127:0]		dcache_wdata_m;
	input	[15:0]		dcache_wparity_m;
	output	[63:0]		dcache_rdata_w0_m;
	output	[7:0]		rparity_w0_m;
	output	[63:0]		dcache_rdata_w1_m;
	output	[7:0]		rparity_w1_m;
	output	[63:0]		dcache_rdata_w2_m;
	output	[7:0]		rparity_w2_m;
	output	[63:0]		dcache_rdata_w3_m;
	output	[7:0]		rparity_w3_m;
	input	[5:0]		fuse_dca_repair_value;
	input	[1:0]		fuse_dca_repair_en;
	input	[1:0]		fuse_dca_rid;
	input			fuse_dca_wen;
	input			fuse_red_reset;
	output	[5:0]		dca_fuse_repair_value;
	output	[1:0]		dca_fuse_repair_en;
	input			vnw_ary;

	wire			fuse_red_reset_qual;
	wire			fuse_dca_wen_qual;
	wire	[3:0]		red_id;
	wire	[3:0]		red_reg_clk_;
	wire	[5:0]		red_data;
	wire	[1:0]		red_enable;
	wire	[8:0]		w0_byte7_l_unused;
	wire	[8:0]		w0_byte6_l_unused;
	wire	[8:0]		w0_byte5_l_unused;
	wire	[8:0]		w0_byte4_l_unused;
	wire	[8:0]		w0_byte3_l_unused;
	wire	[8:0]		w0_byte2_l_unused;
	wire	[8:0]		w0_byte1_l_unused;
	wire	[8:0]		w0_byte0_l_unused;
	wire	[8:0]		w1_byte7_l_unused;
	wire	[8:0]		w1_byte6_l_unused;
	wire	[8:0]		w1_byte5_l_unused;
	wire	[8:0]		w1_byte4_l_unused;
	wire	[8:0]		w1_byte3_l_unused;
	wire	[8:0]		w1_byte2_l_unused;
	wire	[8:0]		w1_byte1_l_unused;
	wire	[8:0]		w1_byte0_l_unused;
	wire	[8:0]		w2_byte7_l_unused;
	wire	[8:0]		w2_byte6_l_unused;
	wire	[8:0]		w2_byte5_l_unused;
	wire	[8:0]		w2_byte4_l_unused;
	wire	[8:0]		w2_byte3_l_unused;
	wire	[8:0]		w2_byte2_l_unused;
	wire	[8:0]		w2_byte1_l_unused;
	wire	[8:0]		w2_byte0_l_unused;
	wire	[8:0]		w3_byte7_l_unused;
	wire	[8:0]		w3_byte6_l_unused;
	wire	[8:0]		w3_byte5_l_unused;
	wire	[8:0]		w3_byte4_l_unused;
	wire	[8:0]		w3_byte3_l_unused;
	wire	[8:0]		w3_byte2_l_unused;
	wire	[8:0]		w3_byte1_l_unused;
	wire	[8:0]		w3_byte0_l_unused;
	reg	[5:0]		red_reg_d_bl;
	reg	[5:0]		red_reg_d_br;
	reg	[5:0]		red_reg_d_tl;
	reg	[5:0]		red_reg_d_tr;
	reg	[1:0]		red_reg_en_bl;
	reg	[1:0]		red_reg_en_br;
	reg	[1:0]		red_reg_en_tl;
	reg	[1:0]		red_reg_en_tr;
	supply0			vss;
	supply1			vdd;

	assign fuse_red_reset_qual = (fuse_red_reset & (~wr_inh_b));
	assign fuse_dca_wen_qual = (fuse_dca_wen & (~wr_inh_b));
	assign red_id[0] = ((~fuse_dca_rid[1]) & (~fuse_dca_rid[0]));
	assign red_id[1] = ((~fuse_dca_rid[1]) & fuse_dca_rid[0]);
	assign red_id[2] = (fuse_dca_rid[1] & (~fuse_dca_rid[0]));
	assign red_id[3] = (fuse_dca_rid[1] & fuse_dca_rid[0]);
	assign red_reg_clk_[0] = (~((~l1clk_red) & ((red_id[0] & 
		fuse_dca_wen_qual) | fuse_red_reset_qual)));
	assign red_reg_clk_[1] = (~((~l1clk_red) & ((red_id[1] & 
		fuse_dca_wen_qual) | fuse_red_reset_qual)));
	assign red_reg_clk_[2] = (~((~l1clk_red) & ((red_id[2] & 
		fuse_dca_wen_qual) | fuse_red_reset_qual)));
	assign red_reg_clk_[3] = (~((~l1clk_red) & ((red_id[3] & 
		fuse_dca_wen_qual) | fuse_red_reset_qual)));
	assign red_data[5:0] = (fuse_dca_repair_value[5:0] & {6 {
		(~fuse_red_reset_qual)}});
	assign red_enable[1:0] = (fuse_dca_repair_en[1:0] & {2 {
		(~fuse_red_reset_qual)}});
	assign dca_fuse_repair_value[5:0] = ((((red_reg_d_tr[5:0] & {6 {
		red_id[3]}}) | (red_reg_d_tl[5:0] & {6 {red_id[2]}})) | (
		red_reg_d_br[5:0] & {6 {red_id[1]}})) | (red_reg_d_bl[5:0] & {6 
		{red_id[0]}}));
	assign dca_fuse_repair_en[1:0] = ((((red_reg_en_tr[1:0] & {2 {red_id[3]}
		}) | (red_reg_en_tl[1:0] & {2 {red_id[2]}})) | (
		red_reg_en_br[1:0] & {2 {red_id[1]}})) | (red_reg_en_bl[1:0] & {
		2 {red_id[0]}}));

	n2_dca_sp_9kb_bank way01(
		.red_data_l			(red_reg_d_tl[5:0]), 
		.red_enable_l			(red_reg_en_tl[1:0]), 
		.red_data_r			(red_reg_d_tr[5:0]), 
		.red_enable_r			(red_reg_en_tr[1:0]), 
		.rd_en_b			(rd_en_top_b), 
		.wr_waysel_b			(wr_waysel_b[1:0]), 
		.wrd_byte15_a			({dcache_wparity_m[15],
		dcache_wdata_m[127:120]}), 
		.wrd_byte14_a			({dcache_wparity_m[14],
		dcache_wdata_m[119:112]}), 
		.wrd_byte13_a			({dcache_wparity_m[13],
		dcache_wdata_m[111:104]}), 
		.wrd_byte12_a			({dcache_wparity_m[12],
		dcache_wdata_m[103:96]}), 
		.wrd_byte11_a			({dcache_wparity_m[11],
		dcache_wdata_m[95:88]}), 
		.wrd_byte10_a			({dcache_wparity_m[10],
		dcache_wdata_m[87:80]}), 
		.wrd_byte9_a			({dcache_wparity_m[9],
		dcache_wdata_m[79:72]}), 
		.wrd_byte8_a			({dcache_wparity_m[8],
		dcache_wdata_m[71:64]}), 
		.wrd_byte7_a			({dcache_wparity_m[7],
		dcache_wdata_m[63:56]}), 
		.wrd_byte6_a			({dcache_wparity_m[6],
		dcache_wdata_m[55:48]}), 
		.wrd_byte5_a			({dcache_wparity_m[5],
		dcache_wdata_m[47:40]}), 
		.wrd_byte4_a			({dcache_wparity_m[4],
		dcache_wdata_m[39:32]}), 
		.wrd_byte3_a			({dcache_wparity_m[3],
		dcache_wdata_m[31:24]}), 
		.wrd_byte2_a			({dcache_wparity_m[2],
		dcache_wdata_m[23:16]}), 
		.wrd_byte1_a			({dcache_wparity_m[1],
		dcache_wdata_m[15:8]}), 
		.wrd_byte0_a			({dcache_wparity_m[0],
		dcache_wdata_m[7:0]}), 
		.w0_byte7_h			({rparity_w0_m[7],
		dcache_rdata_w0_m[63:56]}), 
		.w0_byte6_h			({rparity_w0_m[6],
		dcache_rdata_w0_m[55:48]}), 
		.w0_byte5_h			({rparity_w0_m[5],
		dcache_rdata_w0_m[47:40]}), 
		.w0_byte4_h			({rparity_w0_m[4],
		dcache_rdata_w0_m[39:32]}), 
		.w0_byte3_h			({rparity_w0_m[3],
		dcache_rdata_w0_m[31:24]}), 
		.w0_byte2_h			({rparity_w0_m[2],
		dcache_rdata_w0_m[23:16]}), 
		.w0_byte1_h			({rparity_w0_m[1],
		dcache_rdata_w0_m[15:8]}), 
		.w0_byte0_h			({rparity_w0_m[0],
		dcache_rdata_w0_m[7:0]}), 
		.w1_byte7_h			({rparity_w1_m[7],
		dcache_rdata_w1_m[63:56]}), 
		.w1_byte6_h			({rparity_w1_m[6],
		dcache_rdata_w1_m[55:48]}), 
		.w1_byte5_h			({rparity_w1_m[5],
		dcache_rdata_w1_m[47:40]}), 
		.w1_byte4_h			({rparity_w1_m[4],
		dcache_rdata_w1_m[39:32]}), 
		.w1_byte3_h			({rparity_w1_m[3],
		dcache_rdata_w1_m[31:24]}), 
		.w1_byte2_h			({rparity_w1_m[2],
		dcache_rdata_w1_m[23:16]}), 
		.w1_byte1_h			({rparity_w1_m[1],
		dcache_rdata_w1_m[15:8]}), 
		.w1_byte0_h			({rparity_w1_m[0],
		dcache_rdata_w1_m[7:0]}), 
		.w0_byte7_l			(w0_byte7_l_unused[8:0]), 
		.w0_byte6_l			(w0_byte6_l_unused[8:0]), 
		.w0_byte5_l			(w0_byte5_l_unused[8:0]), 
		.w0_byte4_l			(w0_byte4_l_unused[8:0]), 
		.w0_byte3_l			(w0_byte3_l_unused[8:0]), 
		.w0_byte2_l			(w0_byte2_l_unused[8:0]), 
		.w0_byte1_l			(w0_byte1_l_unused[8:0]), 
		.w0_byte0_l			(w0_byte0_l_unused[8:0]), 
		.w1_byte7_l			(w1_byte7_l_unused[8:0]), 
		.w1_byte6_l			(w1_byte6_l_unused[8:0]), 
		.w1_byte5_l			(w1_byte5_l_unused[8:0]), 
		.w1_byte4_l			(w1_byte4_l_unused[8:0]), 
		.w1_byte3_l			(w1_byte3_l_unused[8:0]), 
		.w1_byte2_l			(w1_byte2_l_unused[8:0]), 
		.w1_byte1_l			(w1_byte1_l_unused[8:0]), 
		.w1_byte0_l			(w1_byte0_l_unused[8:0]), 
		.l1clk				(l1clk), 
		.l1clk_wr			(l1clk_wr), 
		.rd_en_a			(rd_en_a), 
		.wr_en_a			(wr_en_a), 
		.wr_en_b			(wr_en_b), 
		.wr_inh_b			(wr_inh_b), 
		.addr_b				(addr_b[10:3]), 
		.byte_wr_en_b			(byte_wr_en_b[15:0]), 
		.vnw_ary			(vnw_ary));
	n2_dca_sp_9kb_bank way23(
		.red_data_l			(red_reg_d_bl[5:0]), 
		.red_enable_l			(red_reg_en_bl[1:0]), 
		.red_data_r			(red_reg_d_br[5:0]), 
		.red_enable_r			(red_reg_en_br[1:0]), 
		.rd_en_b			(rd_en_bot_b), 
		.wr_waysel_b			(wr_waysel_b[3:2]), 
		.wrd_byte15_a			({dcache_wparity_m[15],
		dcache_wdata_m[127:120]}), 
		.wrd_byte14_a			({dcache_wparity_m[14],
		dcache_wdata_m[119:112]}), 
		.wrd_byte13_a			({dcache_wparity_m[13],
		dcache_wdata_m[111:104]}), 
		.wrd_byte12_a			({dcache_wparity_m[12],
		dcache_wdata_m[103:96]}), 
		.wrd_byte11_a			({dcache_wparity_m[11],
		dcache_wdata_m[95:88]}), 
		.wrd_byte10_a			({dcache_wparity_m[10],
		dcache_wdata_m[87:80]}), 
		.wrd_byte9_a			({dcache_wparity_m[9],
		dcache_wdata_m[79:72]}), 
		.wrd_byte8_a			({dcache_wparity_m[8],
		dcache_wdata_m[71:64]}), 
		.wrd_byte7_a			({dcache_wparity_m[7],
		dcache_wdata_m[63:56]}), 
		.wrd_byte6_a			({dcache_wparity_m[6],
		dcache_wdata_m[55:48]}), 
		.wrd_byte5_a			({dcache_wparity_m[5],
		dcache_wdata_m[47:40]}), 
		.wrd_byte4_a			({dcache_wparity_m[4],
		dcache_wdata_m[39:32]}), 
		.wrd_byte3_a			({dcache_wparity_m[3],
		dcache_wdata_m[31:24]}), 
		.wrd_byte2_a			({dcache_wparity_m[2],
		dcache_wdata_m[23:16]}), 
		.wrd_byte1_a			({dcache_wparity_m[1],
		dcache_wdata_m[15:8]}), 
		.wrd_byte0_a			({dcache_wparity_m[0],
		dcache_wdata_m[7:0]}), 
		.w0_byte7_h			({rparity_w2_m[7],
		dcache_rdata_w2_m[63:56]}), 
		.w0_byte6_h			({rparity_w2_m[6],
		dcache_rdata_w2_m[55:48]}), 
		.w0_byte5_h			({rparity_w2_m[5],
		dcache_rdata_w2_m[47:40]}), 
		.w0_byte4_h			({rparity_w2_m[4],
		dcache_rdata_w2_m[39:32]}), 
		.w0_byte3_h			({rparity_w2_m[3],
		dcache_rdata_w2_m[31:24]}), 
		.w0_byte2_h			({rparity_w2_m[2],
		dcache_rdata_w2_m[23:16]}), 
		.w0_byte1_h			({rparity_w2_m[1],
		dcache_rdata_w2_m[15:8]}), 
		.w0_byte0_h			({rparity_w2_m[0],
		dcache_rdata_w2_m[7:0]}), 
		.w1_byte7_h			({rparity_w3_m[7],
		dcache_rdata_w3_m[63:56]}), 
		.w1_byte6_h			({rparity_w3_m[6],
		dcache_rdata_w3_m[55:48]}), 
		.w1_byte5_h			({rparity_w3_m[5],
		dcache_rdata_w3_m[47:40]}), 
		.w1_byte4_h			({rparity_w3_m[4],
		dcache_rdata_w3_m[39:32]}), 
		.w1_byte3_h			({rparity_w3_m[3],
		dcache_rdata_w3_m[31:24]}), 
		.w1_byte2_h			({rparity_w3_m[2],
		dcache_rdata_w3_m[23:16]}), 
		.w1_byte1_h			({rparity_w3_m[1],
		dcache_rdata_w3_m[15:8]}), 
		.w1_byte0_h			({rparity_w3_m[0],
		dcache_rdata_w3_m[7:0]}), 
		.w0_byte7_l			(w2_byte7_l_unused[8:0]), 
		.w0_byte6_l			(w2_byte6_l_unused[8:0]), 
		.w0_byte5_l			(w2_byte5_l_unused[8:0]), 
		.w0_byte4_l			(w2_byte4_l_unused[8:0]), 
		.w0_byte3_l			(w2_byte3_l_unused[8:0]), 
		.w0_byte2_l			(w2_byte2_l_unused[8:0]), 
		.w0_byte1_l			(w2_byte1_l_unused[8:0]), 
		.w0_byte0_l			(w2_byte0_l_unused[8:0]), 
		.w1_byte7_l			(w3_byte7_l_unused[8:0]), 
		.w1_byte6_l			(w3_byte6_l_unused[8:0]), 
		.w1_byte5_l			(w3_byte5_l_unused[8:0]), 
		.w1_byte4_l			(w3_byte4_l_unused[8:0]), 
		.w1_byte3_l			(w3_byte3_l_unused[8:0]), 
		.w1_byte2_l			(w3_byte2_l_unused[8:0]), 
		.w1_byte1_l			(w3_byte1_l_unused[8:0]), 
		.w1_byte0_l			(w3_byte0_l_unused[8:0]), 
		.l1clk				(l1clk), 
		.l1clk_wr			(l1clk_wr), 
		.rd_en_a			(rd_en_a), 
		.wr_en_a			(wr_en_a), 
		.wr_en_b			(wr_en_b), 
		.wr_inh_b			(wr_inh_b), 
		.addr_b				(addr_b[10:3]), 
		.byte_wr_en_b			(byte_wr_en_b[15:0]), 
		.vnw_ary			(vnw_ary));

	initial begin
	  red_reg_d_bl[5:0] = 6'b0;
	  red_reg_en_bl[1:0] = 2'b0;
	  red_reg_d_br[5:0] = 6'b0;
	  red_reg_en_br[1:0] = 2'b0;
	  red_reg_d_tl[5:0] = 6'b0;
	  red_reg_en_tl[1:0] = 2'b0;
	  red_reg_d_tr[5:0] = 6'b0;
	  red_reg_en_tr[1:0] = 2'b0;
	end
	always @(red_reg_clk_ or red_data or red_enable) begin
	  if (~red_reg_clk_[0]) begin
	    red_reg_d_bl[5:0] = red_data[5:0];
	    red_reg_en_bl[1:0] = red_enable[1:0];
	  end
	  if (~red_reg_clk_[1]) begin
	    red_reg_d_br[5:0] = red_data[5:0];
	    red_reg_en_br[1:0] = red_enable[1:0];
	  end
	  if (~red_reg_clk_[2]) begin
	    red_reg_d_tl[5:0] = red_data[5:0];
	    red_reg_en_tl[1:0] = red_enable[1:0];
	  end
	  if (~red_reg_clk_[3]) begin
	    red_reg_d_tr[5:0] = red_data[5:0];
	    red_reg_en_tr[1:0] = red_enable[1:0];
	  end
	end
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 129875 */
// No timescale specified
module n2_dca_sp_9kb_bank(l1clk, l1clk_wr, rd_en_b, rd_en_a, wr_en_a, wr_en_b, 
	wr_inh_b, addr_b, byte_wr_en_b, wr_waysel_b, red_data_l, red_data_r, 
	red_enable_l, red_enable_r, vnw_ary, wrd_byte15_a, wrd_byte14_a, 
	wrd_byte13_a, wrd_byte12_a, wrd_byte11_a, wrd_byte10_a, wrd_byte9_a, 
	wrd_byte8_a, wrd_byte7_a, wrd_byte6_a, wrd_byte5_a, wrd_byte4_a, 
	wrd_byte3_a, wrd_byte2_a, wrd_byte1_a, wrd_byte0_a, w1_byte7_h, 
	w1_byte6_h, w1_byte5_h, w1_byte4_h, w1_byte3_h, w1_byte2_h, w1_byte1_h, 
	w1_byte0_h, w1_byte7_l, w1_byte6_l, w1_byte5_l, w1_byte4_l, w1_byte3_l, 
	w1_byte2_l, w1_byte1_l, w1_byte0_l, w0_byte7_h, w0_byte6_h, w0_byte5_h, 
	w0_byte4_h, w0_byte3_h, w0_byte2_h, w0_byte1_h, w0_byte0_h, w0_byte7_l, 
	w0_byte6_l, w0_byte5_l, w0_byte4_l, w0_byte3_l, w0_byte2_l, w0_byte1_l, 
	w0_byte0_l);

	input			l1clk;
	input			l1clk_wr;
	input			rd_en_b;
	input			rd_en_a;
	input			wr_en_a;
	input			wr_en_b;
	input			wr_inh_b;
	input	[10:3]		addr_b;
	input	[15:0]		byte_wr_en_b;
	input	[1:0]		wr_waysel_b;
	input	[5:0]		red_data_l;
	input	[5:0]		red_data_r;
	input	[1:0]		red_enable_l;
	input	[1:0]		red_enable_r;
	input			vnw_ary;
	input	[8:0]		wrd_byte15_a;
	input	[8:0]		wrd_byte14_a;
	input	[8:0]		wrd_byte13_a;
	input	[8:0]		wrd_byte12_a;
	input	[8:0]		wrd_byte11_a;
	input	[8:0]		wrd_byte10_a;
	input	[8:0]		wrd_byte9_a;
	input	[8:0]		wrd_byte8_a;
	input	[8:0]		wrd_byte7_a;
	input	[8:0]		wrd_byte6_a;
	input	[8:0]		wrd_byte5_a;
	input	[8:0]		wrd_byte4_a;
	input	[8:0]		wrd_byte3_a;
	input	[8:0]		wrd_byte2_a;
	input	[8:0]		wrd_byte1_a;
	input	[8:0]		wrd_byte0_a;
	output	[8:0]		w1_byte7_h;
	output	[8:0]		w1_byte6_h;
	output	[8:0]		w1_byte5_h;
	output	[8:0]		w1_byte4_h;
	output	[8:0]		w1_byte3_h;
	output	[8:0]		w1_byte2_h;
	output	[8:0]		w1_byte1_h;
	output	[8:0]		w1_byte0_h;
	output	[8:0]		w1_byte7_l;
	output	[8:0]		w1_byte6_l;
	output	[8:0]		w1_byte5_l;
	output	[8:0]		w1_byte4_l;
	output	[8:0]		w1_byte3_l;
	output	[8:0]		w1_byte2_l;
	output	[8:0]		w1_byte1_l;
	output	[8:0]		w1_byte0_l;
	output	[8:0]		w0_byte7_h;
	output	[8:0]		w0_byte6_h;
	output	[8:0]		w0_byte5_h;
	output	[8:0]		w0_byte4_h;
	output	[8:0]		w0_byte3_h;
	output	[8:0]		w0_byte2_h;
	output	[8:0]		w0_byte1_h;
	output	[8:0]		w0_byte0_h;
	output	[8:0]		w0_byte7_l;
	output	[8:0]		w0_byte6_l;
	output	[8:0]		w0_byte5_l;
	output	[8:0]		w0_byte4_l;
	output	[8:0]		w0_byte3_l;
	output	[8:0]		w0_byte2_l;
	output	[8:0]		w0_byte1_l;
	output	[8:0]		w0_byte0_l;

	wire	[71:0]		w0_sao_h;
	wire	[71:0]		w0_sao_l;
	wire	[71:0]		w1_sao_h;
	wire	[71:0]		w1_sao_l;
	wire	[15:0]		red_unused;
	wire	[143:0]		wrd;
	wire	[287:0]		din;
	wire	[287:0]		byte_mask;
	wire	[287:0]		byte_mask_inv;
	wire	[287:0]		temp;
	wire	[287:0]		new_data;
	wire			w0_wcs;
	wire			w1_wcs;
	wire	[287:0]		wr_data;
	wire			rcs_l;
	wire	[71:0]		w0_dout;
	wire	[71:0]		w1_dout;
	wire			l1clk_b;

	reg	[(288 - 1):0]	mem[(128 - 1):0];
	reg	[(288 - 1):0]	local_dout;
	integer			i;
	reg	[71:0]		w0_sao_h_r;
	reg	[71:0]		w0_sao_l_r;
	reg	[71:0]		w1_sao_h_r;
	reg	[71:0]		w1_sao_l_r;
	supply0			vss;
	supply1			vdd;

	assign red_unused[15:0] = {red_data_l[5:0], red_enable_l[1:0], 
		red_data_r[5:0], red_enable_r[1:0]};
	assign wrd[143:0] = {wrd_byte15_a[8:0], wrd_byte14_a[8:0], 
		wrd_byte13_a[8:0], wrd_byte12_a[8:0], wrd_byte11_a[8:0], 
		wrd_byte10_a[8:0], wrd_byte9_a[8:0], wrd_byte8_a[8:0], 
		wrd_byte7_a[8:0], wrd_byte6_a[8:0], wrd_byte5_a[8:0], 
		wrd_byte4_a[8:0], wrd_byte3_a[8:0], wrd_byte2_a[8:0], 
		wrd_byte1_a[8:0], wrd_byte0_a[8:0]};
	assign din[287:0] = {wrd[143:0], wrd[143:0]};
	assign byte_mask[287:0] = {{9 {byte_wr_en_b[15]}}, {9
		{byte_wr_en_b[14]}}, {9 {byte_wr_en_b[13]}}, {9
		{byte_wr_en_b[12]}}, {9 {byte_wr_en_b[11]}}, {9
		{byte_wr_en_b[10]}}, {9 {byte_wr_en_b[9]}}, {9
		{byte_wr_en_b[8]}}, {9 {byte_wr_en_b[7]}}, {9
		{byte_wr_en_b[6]}}, {9 {byte_wr_en_b[5]}}, {9
		{byte_wr_en_b[4]}}, {9 {byte_wr_en_b[3]}}, {9
		{byte_wr_en_b[2]}}, {9 {byte_wr_en_b[1]}}, {9
		{byte_wr_en_b[0]}}, {9 {byte_wr_en_b[15]}}, {9
		{byte_wr_en_b[14]}}, {9 {byte_wr_en_b[13]}}, {9
		{byte_wr_en_b[12]}}, {9 {byte_wr_en_b[11]}}, {9
		{byte_wr_en_b[10]}}, {9 {byte_wr_en_b[9]}}, {9
		{byte_wr_en_b[8]}}, {9 {byte_wr_en_b[7]}}, {9
		{byte_wr_en_b[6]}}, {9 {byte_wr_en_b[5]}}, {9
		{byte_wr_en_b[4]}}, {9 {byte_wr_en_b[3]}}, {9
		{byte_wr_en_b[2]}}, {9 {byte_wr_en_b[1]}}, {9 {byte_wr_en_b[0]}}
		};
	assign byte_mask_inv[287:0] = (~byte_mask[287:0]);
	assign temp[287:0] = mem[addr_b[10:4]];
	assign new_data[287:0] = ((temp[287:0] & byte_mask_inv[287:0]) | (
		din[287:0] & byte_mask[287:0]));
	assign w0_wcs = (((wr_waysel_b[0] & wr_en_b) & (~wr_inh_b)) & (~rd_en_b)
		);
	assign w1_wcs = (((wr_waysel_b[1] & wr_en_b) & (~wr_inh_b)) & (~rd_en_b)
		);
	assign wr_data[143:0] = (w0_wcs ? new_data[143:0] : temp[143:0]);
	assign wr_data[287:144] = (w1_wcs ? new_data[287:144] : temp[287:144]);
	assign rcs_l = (rd_en_b & (~wr_en_b));
	assign w0_dout[71:0] = (addr_b[3] ? local_dout[71:0] : 
		local_dout[143:72]);
	assign w1_dout[71:0] = (addr_b[3] ? local_dout[215:144] : 
		local_dout[287:216]);
	assign l1clk_b = (~l1clk);
	assign w0_sao_h[71:0] = (w0_sao_h_r[71:0] & {72 {l1clk_b}});
	assign w0_sao_l[71:0] = (w0_sao_l_r[71:0] & {72 {l1clk_b}});
	assign w1_sao_h[71:0] = (w1_sao_h_r[71:0] & {72 {l1clk_b}});
	assign w1_sao_l[71:0] = (w1_sao_l_r[71:0] & {72 {l1clk_b}});
	assign w0_byte7_h[8:0] = w0_sao_h[71:63];
	assign w0_byte6_h[8:0] = w0_sao_h[62:54];
	assign w0_byte5_h[8:0] = w0_sao_h[53:45];
	assign w0_byte4_h[8:0] = w0_sao_h[44:36];
	assign w0_byte3_h[8:0] = w0_sao_h[35:27];
	assign w0_byte2_h[8:0] = w0_sao_h[26:18];
	assign w0_byte1_h[8:0] = w0_sao_h[17:9];
	assign w0_byte0_h[8:0] = w0_sao_h[8:0];
	assign w0_byte7_l[8:0] = w0_sao_l[71:63];
	assign w0_byte6_l[8:0] = w0_sao_l[62:54];
	assign w0_byte5_l[8:0] = w0_sao_l[53:45];
	assign w0_byte4_l[8:0] = w0_sao_l[44:36];
	assign w0_byte3_l[8:0] = w0_sao_l[35:27];
	assign w0_byte2_l[8:0] = w0_sao_l[26:18];
	assign w0_byte1_l[8:0] = w0_sao_l[17:9];
	assign w0_byte0_l[8:0] = w0_sao_l[8:0];
	assign w1_byte7_h[8:0] = w1_sao_h[71:63];
	assign w1_byte6_h[8:0] = w1_sao_h[62:54];
	assign w1_byte5_h[8:0] = w1_sao_h[53:45];
	assign w1_byte4_h[8:0] = w1_sao_h[44:36];
	assign w1_byte3_h[8:0] = w1_sao_h[35:27];
	assign w1_byte2_h[8:0] = w1_sao_h[26:18];
	assign w1_byte1_h[8:0] = w1_sao_h[17:9];
	assign w1_byte0_h[8:0] = w1_sao_h[8:0];
	assign w1_byte7_l[8:0] = w1_sao_l[71:63];
	assign w1_byte6_l[8:0] = w1_sao_l[62:54];
	assign w1_byte5_l[8:0] = w1_sao_l[53:45];
	assign w1_byte4_l[8:0] = w1_sao_l[44:36];
	assign w1_byte3_l[8:0] = w1_sao_l[35:27];
	assign w1_byte2_l[8:0] = w1_sao_l[26:18];
	assign w1_byte1_l[8:0] = w1_sao_l[17:9];
	assign w1_byte0_l[8:0] = w1_sao_l[8:0];

	initial begin
	  for (i = 0; (i < 128); i = (i + 1)) begin
	    mem[i] = 288'b0;
	  end
	end
	always @(negedge l1clk_wr) begin
	  if (w0_wcs | w1_wcs) begin
	    if (rcs_l) begin
	      mem[addr_b[10:4]] <= 288'hxxxxxxxx;
	    end
	    else
	      begin
		mem[addr_b[10:4]] <= wr_data;
	      end
	  end
	end
	always @(l1clk) begin
	  if (~l1clk) begin
	    local_dout[(288 - 1):0] <= 288'b0;
	  end
	  else
	    begin
	      if (rcs_l) begin
		if ((w0_wcs | w1_wcs) | wr_inh_b) begin
		  local_dout[(288 - 1):0] <= 288'hxxxxxxxx;
		end
		else
		  begin
		    local_dout[(288 - 1):0] <= mem[addr_b[10:4]];
		  end
	      end
	    end
	end
	always @(negedge l1clk) begin
	  w0_sao_h_r[71:0] <= (w0_dout[71:0] & {72 {(rd_en_a & (~wr_en_a))}});
	  w0_sao_l_r[71:0] <= ((~w0_dout[71:0]) & {72 {(rd_en_a & (~wr_en_a))}})
		  ;
	  w1_sao_h_r[71:0] <= (w1_dout[71:0] & {72 {(rd_en_a & (~wr_en_a))}});
	  w1_sao_l_r[71:0] <= ((~w1_dout[71:0]) & {72 {(rd_en_a & (~wr_en_a))}})
		  ;
	end
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 130103 */
// No timescale specified
module mux_macro__mux_aope__ports_2__width_64(din0, din1, sel0, dout);

	input	[63:0]		din0;
	input	[63:0]		din1;
	input			sel0;
	output	[63:0]		dout;

	wire			psel0;
	wire			psel1;

	cl_dp1_penc2_8x c0_0(
		.sel0				(sel0), 
		.psel0				(psel0), 
		.psel1				(psel1));
	mux2s #(64) d0_0(
		.sel0				(psel0), 
		.sel1				(psel1), 
		.in0				(din0[63:0]), 
		.in1				(din1[63:0]), 
		.dout				(dout[63:0]));
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 130127 */
// No timescale specified
module mux_macro__mux_aope__ports_2__width_4(din0, din1, sel0, dout);

	input	[3:0]		din0;
	input	[3:0]		din1;
	input			sel0;
	output	[3:0]		dout;

	wire			psel0;
	wire			psel1;

	cl_dp1_penc2_8x c0_0(
		.sel0				(sel0), 
		.psel0				(psel0), 
		.psel1				(psel1));
	mux2s #(4) d0_0(
		.sel0				(psel0), 
		.sel1				(psel1), 
		.in0				(din0[3:0]), 
		.in1				(din1[3:0]), 
		.dout				(dout[3:0]));
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 130151 */
// No timescale specified
module mux_macro__mux_aonpe__ports_4__width_8(din0, sel0, din1, sel1, din2, 
	sel2, din3, sel3, dout);

	input	[7:0]		din0;
	input			sel0;
	input	[7:0]		din1;
	input			sel1;
	input	[7:0]		din2;
	input			sel2;
	input	[7:0]		din3;
	input			sel3;
	output	[7:0]		dout;

	wire			buffout0;
	wire			buffout1;
	wire			buffout2;
	wire			buffout3;

	cl_dp1_muxbuff4_8x c0_0(
		.in0				(sel0), 
		.in1				(sel1), 
		.in2				(sel2), 
		.in3				(sel3), 
		.out0				(buffout0), 
		.out1				(buffout1), 
		.out2				(buffout2), 
		.out3				(buffout3));
	mux4s #(8) d0_0(
		.sel0				(buffout0), 
		.sel1				(buffout1), 
		.sel2				(buffout2), 
		.sel3				(buffout3), 
		.in0				(din0[7:0]), 
		.in1				(din1[7:0]), 
		.in2				(din2[7:0]), 
		.in3				(din3[7:0]), 
		.dout				(dout[7:0]));
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 130192 */
// No timescale specified
module xor_macro__ports_3__width_4(din0, din1, din2, dout);

	input	[3:0]		din0;
	input	[3:0]		din1;
	input	[3:0]		din2;
	output	[3:0]		dout;

	xor3 #(4) d0_0(
		.in0				(din0[3:0]), 
		.in1				(din1[3:0]), 
		.in2				(din2[3:0]), 
		.out				(dout[3:0]));
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 130208 */
// No timescale specified
module msff_ctl_macro__fs_1__width_12(din, l1clk, scan_in, siclk, soclk, dout, 
	scan_out);

	input	[11:0]		din;
	input			l1clk;
	input	[11:0]		scan_in;
	input			siclk;
	input			soclk;
	output	[11:0]		dout;
	output	[11:0]		scan_out;

	wire	[11:0]		fdin;

	assign fdin[11:0] = din[11:0];

	dff #(12) d0_0(
		.l1clk				(l1clk), 
		.siclk				(siclk), 
		.soclk				(soclk), 
		.d				(fdin[11:0]), 
		.si				(scan_in[11:0]), 
		.so				(scan_out[11:0]), 
		.q				(dout[11:0]));
endmodule
`endcelldefine

`celldefine
/* Source file "1_core_8_thrd_dut_rtl.v.edt.3", line 129396 */
// No timescale specified
module tisram_msff_macro__fs_1__width_8(d, scan_in, l1clk, siclk, soclk,
        scan_out, latout, latout_l);

        input   [7:0]           d;
        input   [7:0]           scan_in;
        input                   l1clk;
        input                   siclk;
        input                   soclk;
        output  [7:0]           scan_out;
        output  [7:0]           latout;
        output  [7:0]           latout_l;

        tisram_msff #(8) d0_0(
                .d                              (d[7:0]),
                .si                             (scan_in[7:0]),
                .so                             (scan_out[7:0]),
                .l1clk                          (l1clk),
                .siclk                          (siclk),
                .soclk                          (soclk),
                .latout                         (latout[7:0]),
                .latout_l                       (latout_l[7:0]));
endmodule
`endcelldefine


`endif // `ifdef FPGA
