// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: n2_stb_cm_64x45_cust.v
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
module n2_stb_cm_64x45_cust (
  stb_cam_rw_ptr, 
  stb_cam_rw_tid, 
  stb_cam_wptr_vld, 
  stb_cam_rptr_vld, 
  stb_camwr_data, 
  stb_cam_vld, 
  stb_cam_cm_tid, 
  stb_cam_line_en, 
  stb_quad_ld_cam, 
  stb_rdata_ramc, 
  stb_ld_partial_raw, 
  stb_cam_hit_ptr, 
  stb_cam_hit, 
  stb_cam_mhit, 
  l2clk, 
  scan_in, 
  tcu_pce_ov, 
  tcu_aclk, 
  tcu_bclk, 
  tcu_scan_en, 
  tcu_se_scancollar_in, 
  tcu_se_scancollar_out, 
  tcu_array_wr_inhibit, 
  pce, 
  scan_out);
wire l1clk_in;
wire l1clk_out;
wire l1clk_free;
wire [44:0] stb_rdata;
wire [44:0] stb_rdata_;
wire [44:0] stb_rdata_ramc_;
wire dff_out_mask_scanin;
wire dff_out_mask_scanout;
wire mo_din_scanin;
wire mo_din_scanout;
wire [2:0] cam_rw_tid;
wire [2:0] cam_rw_ptr;
wire rptr_vld;
wire wptr_vld;
wire [7:0] mo_din_q_unused;
wire [7:0] mo_din_q_l_unused;
wire [7:0] mo_din_mq_l_unused;
wire cam_vld_din_scanin;
wire cam_vld_din_scanout;
wire cam_vld;
wire cam_vld_din_q_unused;
wire cam_vld_din_q_l_unused;
wire cam_tid_din_scanin;
wire cam_tid_din_scanout;
wire [2:0] cam_cm_tid;
wire dff_out_addr_scanin;
wire dff_out_addr_scanout;
wire [45:0] camwr_din_scanin;
wire [45:0] camwr_din_scanout;
wire [44:0] camwr_data;
wire cam_ldq;
wire [45:0] camwr_din_q_unused;
wire [45:0] camwr_din_q_l_unused;


input	[2:0]	stb_cam_rw_ptr ;	// wr pointer for single port.
input	[2:0]	stb_cam_rw_tid ;	// thread id for rw.
input		stb_cam_wptr_vld ;	// write pointer vld
input		stb_cam_rptr_vld ;	// read pointer vld

input	[44:0]	stb_camwr_data ;	// data for compare/write
input		stb_cam_vld ;		// cam is required.
input	[2:0]	stb_cam_cm_tid ;	// thread id for cam operation.
input	[7:0]	stb_cam_line_en;	// mask for squashing cam results (unflopped input)

input		stb_quad_ld_cam ; 	// quad-ld cam.


output	[44:0]	stb_rdata_ramc ;  // rd data from CAM RAM.
output		stb_ld_partial_raw ; // ld with partial raw.
output	[2:0]	stb_cam_hit_ptr ;
output		stb_cam_hit ;	  // any hit in stb
output		stb_cam_mhit ;	  // multiple hits in stb	

input		l2clk;
input		scan_in;
input		tcu_pce_ov;
input		tcu_aclk;
input		tcu_bclk;
input		tcu_scan_en;
input		tcu_se_scancollar_in;
input		tcu_se_scancollar_out;
input		tcu_array_wr_inhibit;
input		pce;
output		scan_out;

`ifndef FPGA
// synopsys translate_off
`endif

wire pce_ov = tcu_pce_ov;
wire stop   = 1'b0;
wire siclk  = tcu_aclk ;
wire soclk  = tcu_bclk;

integer	i,l;

//================================================
// Clock headers
//================================================
n2_stb_cm_64x45_cust_l1clkhdr_ctl_macro l1ch_in (
	.l2clk	(l2clk), 
	.l1en 	(pce), 
	.se	(tcu_se_scancollar_in),
	.l1clk	(l1clk_in),
  .pce_ov(pce_ov),
  .stop(stop)
);

n2_stb_cm_64x45_cust_l1clkhdr_ctl_macro l1ch_out (
	.l2clk	(l2clk), 
	.l1en 	(pce), 
	.se	(tcu_se_scancollar_out),
	.l1clk	(l1clk_out),
  .pce_ov(pce_ov),
  .stop(stop)
);

n2_stb_cm_64x45_cust_l1clkhdr_ctl_macro l1ch_free (
	.l2clk	(l2clk), 
	.l1en 	(pce), 
	.se	(tcu_scan_en),
	.l1clk	(l1clk_free),
  .pce_ov(pce_ov),
  .stop(stop)
);

///////////////////////////////////////////////////////////////
// Input/output flops/latches
///////////////////////////////////////////////////////////////

// Output flops are inverted.
n2_stb_cm_64x45_cust_inv_macro__width_45 rdata_in_inv  (
	.din	(stb_rdata[44:0]),
	.dout	(stb_rdata_[44:0])
);
n2_stb_cm_64x45_cust_inv_macro__width_45 rdata_out_inv  (
	.din	(stb_rdata_ramc_[44:0]),
	.dout	(stb_rdata_ramc[44:0])
);

n2_stb_cm_64x45_cust_msff_ctl_macro__width_8 dff_out_mask  (
	.scan_in(dff_out_mask_scanin),
	.scan_out(dff_out_mask_scanout),
	.l1clk	(l1clk_out),
	.din	(stb_rdata_[7:0]),
	.dout	(stb_rdata_ramc_[7:0]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_stb_cm_64x45_cust_sram_msff_mo_macro__width_8 mo_din  (
	.scan_in(mo_din_scanin),
	.scan_out(mo_din_scanout),
	.l1clk	(l1clk_in),
	.and_clk(l1clk_free),
	.d	({stb_cam_rw_tid[2:0],stb_cam_rw_ptr[2:0],stb_cam_rptr_vld,stb_cam_wptr_vld}),
	.mq	({cam_rw_tid[2:0],    cam_rw_ptr[2:0],    rptr_vld,        wptr_vld}),
	.q	(mo_din_q_unused[7:0]),
	.q_l	( mo_din_q_l_unused[7:0]),
	.mq_l	( mo_din_mq_l_unused[7:0]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_stb_cm_64x45_cust_scm_msff_lat_macro__width_1 cam_vld_din  (
	.scan_in(cam_vld_din_scanin),
	.scan_out(cam_vld_din_scanout),
	.l1clk	(l1clk_in),
	.d	(stb_cam_vld),
	.latout	(cam_vld),
	.q	( cam_vld_din_q_unused),
	.q_l	( cam_vld_din_q_l_unused),
  .siclk(siclk),
  .soclk(soclk)   
);

n2_stb_cm_64x45_cust_msff_ctl_macro__width_3 cam_tid_din  (
	.scan_in(cam_tid_din_scanin),
	.scan_out(cam_tid_din_scanout),
	.l1clk	(l1clk_in),
	.din	(stb_cam_cm_tid[2:0]),
	.dout	(cam_cm_tid[2:0]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_stb_cm_64x45_cust_msff_ctl_macro__width_37 dff_out_addr  (
	.scan_in(dff_out_addr_scanin),
	.scan_out(dff_out_addr_scanout),
	.l1clk	(l1clk_out),
	.din	(stb_rdata_[44:8]),
	.dout	(stb_rdata_ramc_[44:8]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_stb_cm_64x45_cust_scm_msff_lat_macro__fs_1__width_46 camwr_din   (
	.scan_in(camwr_din_scanin[45:0]),
	.scan_out(camwr_din_scanout[45:0]),
	.l1clk	(l1clk_in),
	.d	({stb_camwr_data[44:0],stb_quad_ld_cam}),
	.latout	({    camwr_data[44:0],cam_ldq}),
	.q	(camwr_din_q_unused[45:0]),
	.q_l	(camwr_din_q_l_unused[45:0]),
  .siclk(siclk),
  .soclk(soclk)
);

// 0in bits_on -var {wptr_vld,rptr_vld} -max 1
// 0in bits_on -var {wptr_vld,cam_vld} -max 1

n2_stb_cm_64x45_array cam_array (
	.cam_line_en	(stb_cam_line_en[7:0]),
	.clk		(l1clk_free),
  .cam_rw_ptr(cam_rw_ptr[2:0]),
  .cam_rw_tid(cam_rw_tid[2:0]),
  .wptr_vld(wptr_vld),
  .rptr_vld(rptr_vld),
  .camwr_data(camwr_data[44:0]),
  .cam_vld(cam_vld),
  .cam_cm_tid(cam_cm_tid[2:0]),
  .cam_ldq(cam_ldq),
  .stb_rdata(stb_rdata[44:0]),
  .stb_ld_partial_raw(stb_ld_partial_raw),
  .stb_cam_hit_ptr(stb_cam_hit_ptr[2:0]),
  .stb_cam_hit(stb_cam_hit),
  .stb_cam_mhit(stb_cam_mhit),
  .tcu_array_wr_inhibit(tcu_array_wr_inhibit),
  .siclk(siclk)
);



supply0 vss;
supply1 vdd;
// fixscan start:
assign dff_out_mask_scanin       = scan_in                  ;
assign mo_din_scanin             = dff_out_mask_scanout     ;
assign cam_vld_din_scanin        = mo_din_scanout           ;
assign cam_tid_din_scanin        = cam_vld_din_scanout      ;
assign dff_out_addr_scanin       = cam_tid_din_scanout      ;
assign camwr_din_scanin[0]       = dff_out_addr_scanout     ;
assign camwr_din_scanin[9]       = camwr_din_scanout[0]     ;
assign camwr_din_scanin[10]      = camwr_din_scanout[9]     ;
assign camwr_din_scanin[11]      = camwr_din_scanout[10]     ;
assign camwr_din_scanin[12]      = camwr_din_scanout[11]     ;
assign camwr_din_scanin[13]      = camwr_din_scanout[12]     ;
assign camwr_din_scanin[14]      = camwr_din_scanout[13]     ;
assign camwr_din_scanin[15]      = camwr_din_scanout[14]     ;
assign camwr_din_scanin[16]      = camwr_din_scanout[15]     ;
assign camwr_din_scanin[17]      = camwr_din_scanout[16]     ;
assign camwr_din_scanin[18]      = camwr_din_scanout[17]     ;
assign camwr_din_scanin[19]      = camwr_din_scanout[18]     ;
assign camwr_din_scanin[20]      = camwr_din_scanout[19]     ;
assign camwr_din_scanin[21]      = camwr_din_scanout[20]     ;
assign camwr_din_scanin[22]      = camwr_din_scanout[21]     ;
assign camwr_din_scanin[23]      = camwr_din_scanout[22]     ;
assign camwr_din_scanin[24]      = camwr_din_scanout[23]     ;
assign camwr_din_scanin[25]      = camwr_din_scanout[24]     ;
assign camwr_din_scanin[26]      = camwr_din_scanout[25]     ;
assign camwr_din_scanin[27]      = camwr_din_scanout[26]     ;
assign camwr_din_scanin[28]      = camwr_din_scanout[27]     ;
assign camwr_din_scanin[29]      = camwr_din_scanout[28]     ;
assign camwr_din_scanin[30]      = camwr_din_scanout[29]     ;
assign camwr_din_scanin[31]      = camwr_din_scanout[30]     ;
assign camwr_din_scanin[32]      = camwr_din_scanout[31]     ;
assign camwr_din_scanin[33]      = camwr_din_scanout[32]     ;
assign camwr_din_scanin[34]      = camwr_din_scanout[33]     ;
assign camwr_din_scanin[35]      = camwr_din_scanout[34]     ;
assign camwr_din_scanin[36]      = camwr_din_scanout[35]     ;
assign camwr_din_scanin[37]      = camwr_din_scanout[36]     ;
assign camwr_din_scanin[38]      = camwr_din_scanout[37]     ;
assign camwr_din_scanin[39]      = camwr_din_scanout[38]     ;
assign camwr_din_scanin[40]      = camwr_din_scanout[39]     ;
assign camwr_din_scanin[41]      = camwr_din_scanout[40]     ;
assign camwr_din_scanin[42]      = camwr_din_scanout[41]     ;
assign camwr_din_scanin[43]      = camwr_din_scanout[42]     ;
assign camwr_din_scanin[44]      = camwr_din_scanout[43]     ;
assign camwr_din_scanin[45]      = camwr_din_scanout[44]     ;
assign camwr_din_scanin[1]       = camwr_din_scanout[45]     ;
assign camwr_din_scanin[2]       = camwr_din_scanout[1]     ;
assign camwr_din_scanin[3]       = camwr_din_scanout[2]     ;
assign camwr_din_scanin[4]       = camwr_din_scanout[3]     ;
assign camwr_din_scanin[5]       = camwr_din_scanout[4]     ;
assign camwr_din_scanin[6]       = camwr_din_scanout[5]     ;
assign camwr_din_scanin[7]       = camwr_din_scanout[6]     ;
assign camwr_din_scanin[8]       = camwr_din_scanout[7]     ;
assign scan_out                  = camwr_din_scanout[8]     ;
// fixscan end:

`ifndef FPGA
// synopsys translate_on
`endif

endmodule






// any PARAMS parms go into naming of macro

module n2_stb_cm_64x45_cust_l1clkhdr_ctl_macro (
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





module n2_stb_cm_64x45_cust_inv_macro__width_45 (
  din, 
  dout);
  input [44:0] din;
  output [44:0] dout;






inv #(45)  d0_0 (
.in(din[44:0]),
.out(dout[44:0])
);









endmodule









// any PARAMS parms go into naming of macro

module n2_stb_cm_64x45_cust_msff_ctl_macro__width_8 (
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









//
//   macro for cl_mc1_sram_msff_mo_{16,8,4}x flops
//
//





module n2_stb_cm_64x45_cust_sram_msff_mo_macro__width_8 (
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
wire [6:0] so;

input [7:0] d;
  input scan_in;
input l1clk;
input and_clk;
input siclk;
input soclk;
output [7:0] mq;
output [7:0] mq_l;
  output scan_out;
output [7:0] q;
output [7:0] q_l;






new_dlata #(8)  d0_0 (
.d(d[7:0]),
.si({scan_in,so[6:0]}),
.so({so[6:0],scan_out}),
.l1clk(l1clk),
.and_clk(and_clk),
.siclk(siclk),
.soclk(soclk),
.q(q[7:0]),
.q_l(q_l[7:0]),
.mq(mq[7:0]),
.mq_l(mq_l[7:0])
);










//place::generic_place($width,$stack,$left);

endmodule





//
//   macro for cl_mc1_scm_msff_lat_{4}x flops
//
//





module n2_stb_cm_64x45_cust_scm_msff_lat_macro__width_1 (
  d, 
  scan_in, 
  l1clk, 
  siclk, 
  soclk, 
  latout, 
  scan_out, 
  q, 
  q_l);
input [0:0] d;
  input scan_in;
input l1clk;
input siclk;
input soclk;
output [0:0] latout;
  output scan_out;
output [0:0] q;
output [0:0] q_l;






scm_msff_lat #(1)  d0_0 (
.d(d[0:0]),
.si(scan_in),
.so(scan_out),
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.q(q[0:0]),
.q_l(q_l[0:0]),
.latout(latout[0:0])
);










//place::generic_place($width,$stack,$left);

endmodule









// any PARAMS parms go into naming of macro

module n2_stb_cm_64x45_cust_msff_ctl_macro__width_3 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [2:0] fdin;
wire [1:0] so;

  input [2:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [2:0] dout;
  output scan_out;
assign fdin[2:0] = din[2:0];






dff #(3)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[2:0]),
.si({scan_in,so[1:0]}),
.so({so[1:0],scan_out}),
.q(dout[2:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_stb_cm_64x45_cust_msff_ctl_macro__width_37 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [36:0] fdin;
wire [35:0] so;

  input [36:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [36:0] dout;
  output scan_out;
assign fdin[36:0] = din[36:0];






dff #(37)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[36:0]),
.si({scan_in,so[35:0]}),
.so({so[35:0],scan_out}),
.q(dout[36:0])
);












endmodule









//
//   macro for cl_mc1_scm_msff_lat_{4}x flops
//
//





module n2_stb_cm_64x45_cust_scm_msff_lat_macro__fs_1__width_46 (
  d, 
  scan_in, 
  l1clk, 
  siclk, 
  soclk, 
  latout, 
  scan_out, 
  q, 
  q_l);
input [45:0] d;
  input [45:0] scan_in;
input l1clk;
input siclk;
input soclk;
output [45:0] latout;
  output [45:0] scan_out;
output [45:0] q;
output [45:0] q_l;






scm_msff_lat #(46)  d0_0 (
.d(d[45:0]),
.si(scan_in[45:0]),
.so(scan_out[45:0]),
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.q(q[45:0]),
.q_l(q_l[45:0]),
.latout(latout[45:0])
);










//place::generic_place($width,$stack,$left);

endmodule





`ifndef FPGA
module n2_stb_cm_64x45_array (
  cam_rw_ptr, 
  cam_rw_tid, 
  wptr_vld, 
  rptr_vld, 
  camwr_data, 
  cam_vld, 
  cam_cm_tid, 
  cam_line_en, 
  cam_ldq, 
  stb_rdata, 
  stb_ld_partial_raw, 
  stb_cam_hit_ptr, 
  stb_cam_hit, 
  stb_cam_mhit, 
  clk, 
  tcu_array_wr_inhibit, 
  siclk);
wire [5:0] rw_addr;
wire write_vld;
wire read_vld;
wire [7:0] byte_overlap_mx;
wire [7:0] byte_match_mx;
wire [7:0] ptag_hit_mx;
wire [7:0] cam_hit;


input	[2:0]	cam_rw_ptr ;	// wr pointer for single port.
input	[2:0]	cam_rw_tid ;	// thread id for rw.
input		wptr_vld ;	// write pointer vld
input		rptr_vld ;	// read pointer vld

input	[44:0]	camwr_data ;	// data for compare/write
input		cam_vld ;	// cam is required.
input	[2:0]	cam_cm_tid ;	// thread id for cam operation.
input	[7:0]	cam_line_en;	// mask for squashing cam results (unflopped input)

input		cam_ldq ; 	// quad-ld cam.


output	[44:0]	stb_rdata;	// rd data from CAM RAM.
output		stb_ld_partial_raw ; // ld with partial raw.
output	[2:0]	stb_cam_hit_ptr ;
output		stb_cam_hit ;	  // any hit in stb
output		stb_cam_mhit ;	  // multiple hits in stb	

input		clk;
input		tcu_array_wr_inhibit;
input		siclk;

integer	i,l;

///////////////////////////////////////////////////////////////
// The array
///////////////////////////////////////////////////////////////

reg	[44:0]	stb_ramc[63:0];
reg	[44:0]	stb_rdata;

//=========================================================================================
//	initialize array
//=========================================================================================

`ifndef NOINITMEM
initial begin
  for (i=0;i<64;i=i+1) begin
  stb_ramc[i] =  45'd0;
  end
end
`endif

assign rw_addr[5:0] = {cam_rw_tid[2:0],cam_rw_ptr[2:0]};

assign write_vld = wptr_vld & ~tcu_array_wr_inhibit;
assign read_vld  = rptr_vld & ~tcu_array_wr_inhibit;

///////////
// Write
///////////
always @ (clk or write_vld or rw_addr or camwr_data or cam_vld) begin
    if (clk & write_vld) begin
        if (cam_vld)
            stb_ramc[rw_addr] <= 45'hx;
	else
            stb_ramc[rw_addr] <= camwr_data[44:0];
    end
end




///////////
// Read
///////////

always @(clk or read_vld or rw_addr or write_vld) begin
    if (clk) begin
	if (write_vld | ~read_vld)
		stb_rdata[44:0] <= 45'hx;
	else
		stb_rdata[44:0] <= stb_ramc[rw_addr];
    end
end

//=========================================================================================
//	CAM contents
//=========================================================================================

// - Generate full/partial raw for incoming load.
// - Output signals need to be qualified with per entry
// vlds before causing any subsequent event, the read of
// the DATA RAM specifically.

// Mapping of cam/write data
// 
//	| 	39-3=37b(pa)	|	8b(bytemask)	| <- use
//	|	44:8		|	7:0		| <- input port

reg	[44:0]	ramc_entry;
reg	[36:0]	cam_tag;
reg	[7:0]	cam_bmask;
reg	[63:0]	ptag_hit;
reg	[63:0]	byte_match;
reg	[63:0]	byte_overlap;

// ptag_hit indicates a match at the dword (or qword for quad loads) boundary
// byte_match indciates match at the byte level within the dword
// byte_overlap checks that all bytes in incoming bmask has a corresponding mask bit
//  set in the cam entry.  This differentiates between full and partial raw.

always @(posedge clk) begin
  for (l=0;l<64;l=l+1) begin
    ramc_entry[44:0] = stb_ramc[l] ;
    cam_tag[36:0] = ramc_entry[44:8] ;
    cam_bmask[7:0] = ramc_entry[7:0] ;
    ptag_hit[l] <= (cam_tag[36:1] == camwr_data[44:9]) & (((cam_tag[0] == camwr_data[8]) & ~cam_ldq) | cam_ldq) & cam_vld;
    byte_match[l] <= |(cam_bmask[7:0] & camwr_data[7:0]) & cam_vld;
    byte_overlap[l] <= |(~cam_bmask[7:0] & camwr_data[7:0]) & cam_vld ;
  end	
end

// CAM values will be indeterminate while scanning

always @(posedge siclk) begin
    ptag_hit[63:0] <= 64'hx; 
    byte_match[63:0] <= 64'hx; 
    byte_overlap[63:0] <= 64'hx; 
end


// Mux the raw signals down to 8b quantities. Line enable comes mid-way thru cycle.

assign	byte_overlap_mx[7:0] =
	({8{(cam_cm_tid[2:0] == 3'b000)}} & byte_overlap[7:0]  ) | 
	({8{(cam_cm_tid[2:0] == 3'b001)}} & byte_overlap[15:8] ) |
	({8{(cam_cm_tid[2:0] == 3'b010)}} & byte_overlap[23:16]) |
	({8{(cam_cm_tid[2:0] == 3'b011)}} & byte_overlap[31:24]) |
	({8{(cam_cm_tid[2:0] == 3'b100)}} & byte_overlap[39:32]) |
	({8{(cam_cm_tid[2:0] == 3'b101)}} & byte_overlap[47:40]) |
	({8{(cam_cm_tid[2:0] == 3'b110)}} & byte_overlap[55:48]) |
	({8{(cam_cm_tid[2:0] == 3'b111)}} & byte_overlap[63:56]) ;

assign	byte_match_mx[7:0] =
	({8{(cam_cm_tid[2:0] == 3'b000)}} & byte_match[7:0]  ) |
	({8{(cam_cm_tid[2:0] == 3'b001)}} & byte_match[15:8] ) |
	({8{(cam_cm_tid[2:0] == 3'b010)}} & byte_match[23:16]) |
	({8{(cam_cm_tid[2:0] == 3'b011)}} & byte_match[31:24]) |
	({8{(cam_cm_tid[2:0] == 3'b100)}} & byte_match[39:32]) |
	({8{(cam_cm_tid[2:0] == 3'b101)}} & byte_match[47:40]) |
	({8{(cam_cm_tid[2:0] == 3'b110)}} & byte_match[55:48]) |
	({8{(cam_cm_tid[2:0] == 3'b111)}} & byte_match[63:56]) ;

assign	ptag_hit_mx[7:0] =
	({8{(cam_cm_tid[2:0] == 3'b000)}} & ptag_hit[7:0]  ) |
	({8{(cam_cm_tid[2:0] == 3'b001)}} & ptag_hit[15:8] ) |
	({8{(cam_cm_tid[2:0] == 3'b010)}} & ptag_hit[23:16]) |
	({8{(cam_cm_tid[2:0] == 3'b011)}} & ptag_hit[31:24]) |
	({8{(cam_cm_tid[2:0] == 3'b100)}} & ptag_hit[39:32]) |
	({8{(cam_cm_tid[2:0] == 3'b101)}} & ptag_hit[47:40]) |
	({8{(cam_cm_tid[2:0] == 3'b110)}} & ptag_hit[55:48]) |
	({8{(cam_cm_tid[2:0] == 3'b111)}} & ptag_hit[63:56]) ;

assign	stb_ld_partial_raw =  
	|(ptag_hit_mx[7:0] & byte_match_mx[7:0] &  byte_overlap_mx[7:0] & cam_line_en[7:0]) ;

assign	cam_hit[7:0] = 
	ptag_hit_mx[7:0] & byte_match_mx[7:0] & cam_line_en[7:0] ;
assign	stb_cam_hit = |(cam_hit[7:0]);

// The stb data is meant to be read for single hit full raw case. It may actually be read
// for full raw, partial raw or multiple hit case but the read output will be ignored for
// partial and multiple hit case. Multiple hits will not cause a hazard as the ptr is first
// encoded and then decoded to form the wdline for the stb-data
// Use cam_hit result to void false hits.
assign	stb_cam_hit_ptr[0] 	=  cam_hit[1] | cam_hit[3] | cam_hit[5] | cam_hit[7] ;
assign	stb_cam_hit_ptr[1] 	=  cam_hit[2] | cam_hit[3] | cam_hit[6] | cam_hit[7] ;
assign	stb_cam_hit_ptr[2] 	=  cam_hit[4] | cam_hit[5] | cam_hit[6] | cam_hit[7] ;

//Generating multiple hits
assign  stb_cam_mhit            =  (cam_hit[0]  & cam_hit[1]) | (cam_hit[2] & cam_hit[3])  |
                                   (cam_hit[4]  & cam_hit[5]) | (cam_hit[6] & cam_hit[7])  |
                                   ((cam_hit[0] | cam_hit[1]) & (cam_hit[2] | cam_hit[3])) |
                                   ((cam_hit[4] | cam_hit[5]) & (cam_hit[6] | cam_hit[7])) |
                                   ((|cam_hit[3:0]) & (|cam_hit[7:4]));

supply0 vss;
supply1 vdd;
endmodule
`endif



`ifdef FPGA

module n2_stb_cm_64x45_array(cam_rw_ptr, cam_rw_tid, wptr_vld, rptr_vld, 
	camwr_data, cam_vld, cam_cm_tid, cam_line_en, cam_ldq, stb_rdata, 
	stb_ld_partial_raw, stb_cam_hit_ptr, stb_cam_hit, stb_cam_mhit, clk, 
	tcu_array_wr_inhibit, siclk);

	input	[2:0]		cam_rw_ptr;
	input	[2:0]		cam_rw_tid;
	input			wptr_vld;
	input			rptr_vld;
	input	[44:0]		camwr_data;
	input			cam_vld;
	input	[2:0]		cam_cm_tid;
	input	[7:0]		cam_line_en;
	input			cam_ldq;
	output	[44:0]		stb_rdata;
	output			stb_ld_partial_raw;
	output	[2:0]		stb_cam_hit_ptr;
	output			stb_cam_hit;
	output			stb_cam_mhit;
	input			clk;
	input			tcu_array_wr_inhibit;
	input			siclk;

	wire	[5:0]		rw_addr;
	wire			write_vld;
	wire			read_vld;
	wire	[7:0]		byte_overlap_mx;
	wire	[7:0]		byte_match_mx;
	wire	[7:0]		ptag_hit_mx;
	wire	[7:0]		cam_hit;
	integer			i;
	integer			l;

	reg	[44:0]		stb_ramc[63:0];
	reg	[44:0]		stb_rdata;
	reg	[44:0]		ramc_entry;
	reg	[36:0]		cam_tag;
	reg	[7:0]		cam_bmask;
	reg	[63:0]		ptag_hit;
	reg	[63:0]		byte_match;
	reg	[63:0]		byte_overlap;
	supply0			vss;
	supply1			vdd;

	assign rw_addr[5:0] = {cam_rw_tid[2:0], cam_rw_ptr[2:0]};
	assign write_vld = (wptr_vld & (~tcu_array_wr_inhibit));
	assign read_vld = (rptr_vld & (~tcu_array_wr_inhibit));
	assign byte_overlap_mx[7:0] = (((((((({8 {(cam_cm_tid[2:0] == 3'b0)}} & 
		byte_overlap[7:0]) | ({8 {(cam_cm_tid[2:0] == 3'b1)}} & 
		byte_overlap[15:8])) | ({8 {(cam_cm_tid[2:0] == 3'd2)}} & 
		byte_overlap[23:16])) | ({8 {(cam_cm_tid[2:0] == 3'd3)}} & 
		byte_overlap[31:24])) | ({8 {(cam_cm_tid[2:0] == 3'd4)}} & 
		byte_overlap[39:32])) | ({8 {(cam_cm_tid[2:0] == 3'd5)}} & 
		byte_overlap[47:40])) | ({8 {(cam_cm_tid[2:0] == 3'd6)}} & 
		byte_overlap[55:48])) | ({8 {(cam_cm_tid[2:0] == 3'd7)}} & 
		byte_overlap[63:56]));
	assign byte_match_mx[7:0] = (((((((({8 {(cam_cm_tid[2:0] == 3'b0)}} & 
		byte_match[7:0]) | ({8 {(cam_cm_tid[2:0] == 3'b1)}} & 
		byte_match[15:8])) | ({8 {(cam_cm_tid[2:0] == 3'd2)}} & 
		byte_match[23:16])) | ({8 {(cam_cm_tid[2:0] == 3'd3)}} & 
		byte_match[31:24])) | ({8 {(cam_cm_tid[2:0] == 3'd4)}} & 
		byte_match[39:32])) | ({8 {(cam_cm_tid[2:0] == 3'd5)}} & 
		byte_match[47:40])) | ({8 {(cam_cm_tid[2:0] == 3'd6)}} & 
		byte_match[55:48])) | ({8 {(cam_cm_tid[2:0] == 3'd7)}} & 
		byte_match[63:56]));
	assign ptag_hit_mx[7:0] = (((((((({8 {(cam_cm_tid[2:0] == 3'b0)}} & 
		ptag_hit[7:0]) | ({8 {(cam_cm_tid[2:0] == 3'b1)}} & 
		ptag_hit[15:8])) | ({8 {(cam_cm_tid[2:0] == 3'd2)}} & 
		ptag_hit[23:16])) | ({8 {(cam_cm_tid[2:0] == 3'd3)}} & 
		ptag_hit[31:24])) | ({8 {(cam_cm_tid[2:0] == 3'd4)}} & 
		ptag_hit[39:32])) | ({8 {(cam_cm_tid[2:0] == 3'd5)}} & 
		ptag_hit[47:40])) | ({8 {(cam_cm_tid[2:0] == 3'd6)}} & 
		ptag_hit[55:48])) | ({8 {(cam_cm_tid[2:0] == 3'd7)}} & 
		ptag_hit[63:56]));
	assign stb_ld_partial_raw = (|(((ptag_hit_mx[7:0] & byte_match_mx[7:0]) 
		& byte_overlap_mx[7:0]) & cam_line_en[7:0]));
	assign cam_hit[7:0] = ((ptag_hit_mx[7:0] & byte_match_mx[7:0]) & 
		cam_line_en[7:0]);
	assign stb_cam_hit = (|cam_hit[7:0]);
	assign stb_cam_hit_ptr[0] = (((cam_hit[1] | cam_hit[3]) | cam_hit[5]) | 
		cam_hit[7]);
	assign stb_cam_hit_ptr[1] = (((cam_hit[2] | cam_hit[3]) | cam_hit[6]) | 
		cam_hit[7]);
	assign stb_cam_hit_ptr[2] = (((cam_hit[4] | cam_hit[5]) | cam_hit[6]) | 
		cam_hit[7]);
	assign stb_cam_mhit = (((((((cam_hit[0] & cam_hit[1]) | (cam_hit[2] & 
		cam_hit[3])) | (cam_hit[4] & cam_hit[5])) | (cam_hit[6] & 
		cam_hit[7])) | ((cam_hit[0] | cam_hit[1]) & (cam_hit[2] | 
		cam_hit[3]))) | ((cam_hit[4] | cam_hit[5]) & (cam_hit[6] | 
		cam_hit[7]))) | ((|cam_hit[3:0]) & (|cam_hit[7:4])));

	initial begin
	  for (i = 0; (i < 64); i = (i + 1)) begin
	    stb_ramc[i] = 45'b0;
	  end
	end
	always @(clk or write_vld or rw_addr or camwr_data or cam_vld) begin
	  if (clk & write_vld) begin
	    if (cam_vld) begin
	      stb_ramc[rw_addr] <= 45'hxxxxxxxxxxxx;
	    end
	    else begin
	      stb_ramc[rw_addr] <= camwr_data[44:0];
	    end
	  end
	end
	always @(clk or read_vld or rw_addr or write_vld) begin
	  if (clk) begin
	    if (write_vld | (~read_vld)) begin
	      stb_rdata[44:0] <= 45'hxxxxxxxxxxxx;
	    end
	    else begin
	      stb_rdata[44:0] <= stb_ramc[rw_addr];
	    end
	  end
	end
	always @(posedge clk) begin
	  for (l = 0; (l < 64); l = (l + 1)) begin
	    ramc_entry[44:0] = stb_ramc[l];
	    cam_tag[36:0] = ramc_entry[44:8];
	    cam_bmask[7:0] = ramc_entry[7:0];
	    ptag_hit[l] <= (((cam_tag[36:1] == camwr_data[44:9]) & (((cam_tag[0]
		    == camwr_data[8]) & (~cam_ldq)) | cam_ldq)) & cam_vld);
	    byte_match[l] <= ((|(cam_bmask[7:0] & camwr_data[7:0])) & cam_vld);
	    byte_overlap[l] <= ((|((~cam_bmask[7:0]) & camwr_data[7:0])) & 
		    cam_vld);
	  end
	end
endmodule

`endif	// `ifdef FPGA

