// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: n2_dva_dp_32x32_cust.v
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
module n2_dva_dp_32x32_cust (
  l2clk, 
  tcu_pce_ov, 
  tcu_se_scancollar_in, 
  tcu_scan_en, 
  tcu_array_wr_inhibit, 
  tcu_aclk, 
  tcu_bclk, 
  pce, 
  scan_in, 
  rd_addr, 
  wr_addr, 
  din, 
  bit_wen, 
  rd_en, 
  wr_en, 
  dout, 
  scan_out);
wire pce_ov;
wire stop;
wire siclk;
wire soclk;
wire l1clk_in;
wire l1clk_free;
wire dff_bit_en_scanin;
wire dff_bit_en_scanout;
wire [31:0] bit_wen_d1;
wire dff_wr_en_scanin;
wire dff_wr_en_scanout;
wire wr_en_d1;
wire dff_rd_addr_scanin;
wire dff_rd_addr_scanout;
wire [4:0] rd_addr_d1;
wire [4:0] mq_l_rd_addr_unused;
wire [4:0] q_rd_addr_unused;
wire [4:0] q_l_rd_addr_unused;
wire dff_rd_en_scanin;
wire dff_rd_en_scanout;
wire rd_en_d1;
wire mq_l_rd_en_unused;
wire q_rd_en_unused;
wire q_l_rd_en_unused;
wire dff_wr_addr_scanin;
wire dff_wr_addr_scanout;
wire [4:0] wr_addr_d1;
wire dff_din_scanin;
wire dff_din_scanout;
wire [31:0] din_d1;
wire wr_inhibit_;
wire wr_en_qual;
wire rd_en_qual;


input		l2clk;
input		tcu_pce_ov;
input		tcu_se_scancollar_in;
input		tcu_scan_en;
input		tcu_array_wr_inhibit;
input		tcu_aclk;
input		tcu_bclk;
input		pce;


input		scan_in;
input	[4:0]	rd_addr;
input	[4:0]	wr_addr;
input	[31:0]	din;
input	[31:0]	bit_wen;
input		rd_en;
input		wr_en;
   
output	[31:0]	dout;
output		scan_out;

`ifndef FPGA
// synopsys translate_off
`endif

assign pce_ov = tcu_pce_ov;
assign stop   = 1'b0;
assign siclk  = tcu_aclk ;
assign soclk  = tcu_bclk;

//================================================
// Clock headers
//================================================
n2_dva_dp_32x32_cust_l1clkhdr_ctl_macro l1ch_in (
	.l2clk	(l2clk), 
	.l1en 	(pce), 
	.se	(tcu_se_scancollar_in),
	.l1clk	(l1clk_in),
  .pce_ov(pce_ov),
  .stop(stop)
);

n2_dva_dp_32x32_cust_l1clkhdr_ctl_macro l1ch_free (
	.l2clk	(l2clk), 
	.l1en 	(pce), 
	.se	(tcu_scan_en),
	.l1clk	(l1clk_free),
  .pce_ov(pce_ov),
  .stop(stop)
);

///////////////////////////////////////////////////////////////
// Flop the inputs                                           //
///////////////////////////////////////////////////////////////
n2_dva_dp_32x32_cust_msff_ctl_macro__scanreverse_1__width_32 dff_bit_en   (
	.scan_in(dff_bit_en_scanin),
	.scan_out(dff_bit_en_scanout),
	.l1clk(l1clk_in),
	.din(bit_wen[31:0]),
	.dout(bit_wen_d1[31:0]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_dva_dp_32x32_cust_msff_ctl_macro__width_1 dff_wr_en  (
	.scan_in(dff_wr_en_scanin),
	.scan_out(dff_wr_en_scanout),
	.l1clk(l1clk_in),
	.din(wr_en),
	.dout(wr_en_d1),
  .siclk(siclk),
  .soclk(soclk)
);

n2_dva_dp_32x32_cust_sram_msff_mo_macro__scanreverse_1__width_5 dff_rd_addr   (
	.scan_in(dff_rd_addr_scanin),
	.scan_out(dff_rd_addr_scanout),
	.l1clk(l1clk_in),
	.and_clk(l1clk_free),
	.d(rd_addr[4:0]),
	.mq(rd_addr_d1[4:0]),
	.mq_l(mq_l_rd_addr_unused[4:0]),
	.q(q_rd_addr_unused[4:0]),
	.q_l(q_l_rd_addr_unused[4:0]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_dva_dp_32x32_cust_sram_msff_mo_macro__width_1 dff_rd_en  (
	.scan_in(dff_rd_en_scanin),
	.scan_out(dff_rd_en_scanout),
	.l1clk(l1clk_in),
	.and_clk(l1clk_free),
	.d(rd_en),
	.mq(rd_en_d1),
	.mq_l(mq_l_rd_en_unused),
	.q(q_rd_en_unused),
	.q_l(q_l_rd_en_unused),
  .siclk(siclk),
  .soclk(soclk)
);

n2_dva_dp_32x32_cust_msff_ctl_macro__width_5 dff_wr_addr  (
	.scan_in(dff_wr_addr_scanin),
	.scan_out(dff_wr_addr_scanout),
	.l1clk(l1clk_in),
	.din(wr_addr[4:0]),
	.dout(wr_addr_d1[4:0]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_dva_dp_32x32_cust_msff_ctl_macro__width_32 dff_din  (
	.scan_in(dff_din_scanin),
	.scan_out(dff_din_scanout),
	.l1clk(l1clk_in),
	.din(din[31:0]),
	.dout(din_d1[31:0]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_dva_dp_32x32_cust_inv_macro__width_1 wr_inh_inv  (
	.din	(tcu_array_wr_inhibit),
	.dout	(wr_inhibit_)
);
n2_dva_dp_32x32_cust_and_macro__width_2 wr_and  (
	.din0	({wr_en_d1   ,rd_en_d1}),
	.din1	({wr_inhibit_,wr_inhibit_}),
	.dout	({wr_en_qual ,rd_en_qual})
);

n2_dva_dp_32x32_array array (
	.clk		(l1clk_free),
	.rd_addr	(rd_addr_d1[4:0]),
	.wr_addr	(wr_addr_d1[4:0]),
	.din		(din_d1[31:0]),
	.bit_wen	(bit_wen_d1[31:0]),
	.rd_en		(rd_en_qual),
	.wr_en		(wr_en_qual),
	.dout		(dout[31:0])
);

supply0 vss;
supply1 vdd;

// fixscan start:
assign dff_bit_en_scanin         = scan_in                  ;
assign dff_wr_en_scanin          = dff_bit_en_scanout       ;
assign dff_rd_addr_scanin        = dff_wr_en_scanout        ;
assign dff_rd_en_scanin          = dff_rd_addr_scanout      ;
assign dff_wr_addr_scanin        = dff_rd_en_scanout        ;
assign dff_din_scanin            = dff_wr_addr_scanout      ;
assign scan_out                  = dff_din_scanout          ;
// fixscan end:

`ifndef FPGA
// synopsys translate_on
`endif

endmodule






// any PARAMS parms go into naming of macro

module n2_dva_dp_32x32_cust_l1clkhdr_ctl_macro (
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

module n2_dva_dp_32x32_cust_msff_ctl_macro__scanreverse_1__width_32 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [31:0] fdin;
wire [0:30] so;

  input [31:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [31:0] dout;
  output scan_out;
assign fdin[31:0] = din[31:0];






dff #(32)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[31:0]),
.si({so[0:30],scan_in}),
.so({scan_out,so[0:30]}),
.q(dout[31:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_dva_dp_32x32_cust_msff_ctl_macro__width_1 (
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









//
//   macro for cl_mc1_sram_msff_mo_{16,8,4}x flops
//
//





module n2_dva_dp_32x32_cust_sram_msff_mo_macro__scanreverse_1__width_5 (
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
wire [0:3] so;

input [4:0] d;
  input scan_in;
input l1clk;
input and_clk;
input siclk;
input soclk;
output [4:0] mq;
output [4:0] mq_l;
  output scan_out;
output [4:0] q;
output [4:0] q_l;






new_dlata #(5)  d0_0 (
.d(d[4:0]),
.si({so[0:3],scan_in}),
.so({scan_out,so[0:3]}),
.l1clk(l1clk),
.and_clk(and_clk),
.siclk(siclk),
.soclk(soclk),
.q(q[4:0]),
.q_l(q_l[4:0]),
.mq(mq[4:0]),
.mq_l(mq_l[4:0])
);










//place::generic_place($width,$stack,$left);

endmodule





//
//   macro for cl_mc1_sram_msff_mo_{16,8,4}x flops
//
//





module n2_dva_dp_32x32_cust_sram_msff_mo_macro__width_1 (
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









// any PARAMS parms go into naming of macro

module n2_dva_dp_32x32_cust_msff_ctl_macro__width_5 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [4:0] fdin;
wire [3:0] so;

  input [4:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [4:0] dout;
  output scan_out;
assign fdin[4:0] = din[4:0];






dff #(5)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[4:0]),
.si({scan_in,so[3:0]}),
.so({so[3:0],scan_out}),
.q(dout[4:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_dva_dp_32x32_cust_msff_ctl_macro__width_32 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [31:0] fdin;
wire [30:0] so;

  input [31:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [31:0] dout;
  output scan_out;
assign fdin[31:0] = din[31:0];






dff #(32)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[31:0]),
.si({scan_in,so[30:0]}),
.so({so[30:0],scan_out}),
.q(dout[31:0])
);












endmodule









//
//   invert macro
//
//





module n2_dva_dp_32x32_cust_inv_macro__width_1 (
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





module n2_dva_dp_32x32_cust_and_macro__width_2 (
  din0, 
  din1, 
  dout);
  input [1:0] din0;
  input [1:0] din1;
  output [1:0] dout;






and2 #(2)  d0_0 (
.in0(din0[1:0]),
.in1(din1[1:0]),
.out(dout[1:0])
);









endmodule






module n2_dva_dp_32x32_array (
  clk, 
  rd_addr, 
  wr_addr, 
  din, 
  bit_wen, 
  rd_en, 
  wr_en, 
  dout);
wire [31:0] temp;
wire [31:0] vbit_sa;
wire [31:0] wt_data;
wire [31:0] vbit;


input		clk;
input	[4:0]	rd_addr;
input	[4:0]	wr_addr;
input	[31:0]	din;
input	[31:0]	bit_wen;
input		rd_en;
input		wr_en;
   
output	[31:0]	dout;

reg	[31:0] mem [31:0];
reg	[31:0] 	dout ;

`ifndef NOINITMEM
// Initialize the arrays.
integer i;
initial begin
  for (i=0;i<32;i=i+1) begin
      mem[i] = 32'b0 ;
  end
end 
`endif

/////////////
// Write on negedge
/////////////

assign temp[31:0] = mem[wr_addr[4:0]];

always @(negedge clk) begin
  if (wr_en) begin
    mem[wr_addr[4:0]] <= (bit_wen[31:0] & din[31:0]) | (~bit_wen[31:0] & temp[31:0]);




  end
end

/////////////
// Read 
/////////////

assign vbit_sa[31:0] = mem[rd_addr[4:0]] & {32{rd_en}};

// Handle write-through case.
// Read result is the AND of the previous and new values.
// wt_data represents the precharged write bit line
// It is high when writing a '1' or when not writing.

assign wt_data[31:0]  = {32{rd_addr[4:0] != wr_addr[4:0]}} | ~bit_wen[31:0] | din[31:0] | {32{~wr_en}};

assign vbit[31:0] = vbit_sa[31:0] & wt_data[31:0];

always @(clk or vbit) begin
  if (clk)
    dout[31:0] <= vbit[31:0];
end


supply0 vss;
supply1 vdd;

endmodule

