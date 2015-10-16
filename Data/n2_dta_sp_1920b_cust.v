// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: n2_dta_sp_1920b_cust.v
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
module n2_dta_sp_1920b_cust (
  index0_x, 
  index1_x, 
  index_sel_x, 
  wrway_x, 
  rdreq_x, 
  wrreq_x, 
  wrtag_x, 
  dta_clken, 
  rdtag_w0_y, 
  rdtag_w1_y, 
  rdtag_w2_y, 
  rdtag_w3_y, 
  l2clk, 
  scan_in, 
  tcu_pce_ov, 
  tcu_aclk, 
  tcu_bclk, 
  tcu_se_scancollar_in, 
  tcu_scan_en, 
  tcu_array_wr_inhibit, 
  scan_out);
wire l1clk_din;
wire l1clk_in;
wire l1clk_array;
wire [6:0] index_x;
wire dff_inputs1_scanin;
wire dff_inputs1_scanout;
wire [1:0] wrway_y;
wire [6:0] index_y;
wire [8:0] dff_inputs1_unused;
wire dff_inputs2_scanin;
wire dff_inputs2_scanout;
wire [0:0] index_y_unused;
wire dff_inputs3_scanin;
wire dff_inputs3_scanout;
wire rdreq_b;
wire wrreq_b;
wire [1:0] dff_inputs3_unused;
wire dff_inputs4_scanin;
wire dff_inputs4_scanout;
wire rdreq_a;
wire wrreq_a;
wire dff_wrtag_scanin;
wire dff_wrtag_scanout;
wire [29:0] wrtag_y;
wire [1:0] wrway_y_;
wire wr_inhibit_;
wire wr_inhibit;
wire [3:0] wr_way;


input	[6:0]	index0_x;	// address0 (used for read)
input	[6:0]	index1_x;	// address1 (used for write)
input		index_sel_x;	// selects between index1 and index0
input	[1:0]	wrway_x;	// way to write to
input		rdreq_x;	// read enable
input		wrreq_x;	// write enable
// 0in bits_on -var {rdreq_x,wrreq_x} -max 1 -message "Attempt to read AND write dtag on same cycle"
// 0in custom -fire ((rdreq_x | wrreq_x) & ~dta_clken) -message "Attempt to read or write with clock disabled"
input	[29:0]	wrtag_x;      // write data
input		dta_clken;	// array clock enable

output	[29:0]	rdtag_w0_y;    // read data split into 4 ports
output	[29:0]	rdtag_w1_y;    // read data
output	[29:0]	rdtag_w2_y;    // read data
output	[29:0]	rdtag_w3_y;    // read data

input		l2clk;
input		scan_in;
input		tcu_pce_ov;
input		tcu_aclk;
input		tcu_bclk;
input		tcu_se_scancollar_in;
input		tcu_scan_en;
input		tcu_array_wr_inhibit;
output		scan_out;

`ifndef FPGA
// synopsys translate_off
`endif

wire pce_ov = tcu_pce_ov;
wire stop   = 1'b0;
wire siclk  = tcu_aclk ;
wire soclk  = tcu_bclk;

//================================================
// Clock headers
//================================================

// This clock gates the wrtag input flops.
n2_dta_sp_1920b_cust_l1clkhdr_ctl_macro l1ch_din (	
        .l2clk	(l2clk), 
        .l1en 	(dta_clken),
	.se	(tcu_se_scancollar_in),
        .l1clk	(l1clk_din),
  .pce_ov(pce_ov),
  .stop(stop)
);

// This clock gates the other input flops and latches.
// It will be not be power managed.
n2_dta_sp_1920b_cust_l1clkhdr_ctl_macro l1ch_in (	
        .l2clk	(l2clk), 
        .l1en 	(1'b1), 
	.se	(tcu_se_scancollar_in),
        .l1clk	(l1clk_in),
  .pce_ov(pce_ov),
  .stop(stop)
);

// This clock gates the array and internal logic.
n2_dta_sp_1920b_cust_l1clkhdr_ctl_macro l1ch_array (
        .l2clk	(l2clk), 
        .l1en 	(dta_clken),
	.se	(tcu_scan_en),
        .l1clk	(l1clk_array),
  .pce_ov(pce_ov),
  .stop(stop)
);

//=========================================================================================
//  Input flops
//=========================================================================================

// 2:1 mux on address input
// address inputs are critical and this mux needs to be merged with the receiving flop.
assign index_x[6:0] = index_sel_x ? index1_x[6:0] : index0_x[6:0];

n2_dta_sp_1920b_cust_tisram_msff_macro__width_9 dff_inputs1  (
	.scan_in(dff_inputs1_scanin),
	.scan_out(dff_inputs1_scanout),
	.l1clk	(l1clk_in),
	.d	({wrway_x[1:0],
		  index_x[0],
		  index_x[1],
		  index_x[2],
		  index_x[3],
		  index_x[4],
		  index_x[5],
		  index_x[6]
		}),
	.latout	({wrway_y[1:0],
		  index_y[0],
		  index_y[1],
		  index_y[2],
		  index_y[3],
		  index_y[4],
		  index_y[5],
		  index_y[6]
		}),
	.latout_l(dff_inputs1_unused[8:0]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_dta_sp_1920b_cust_msff_ctl_macro__width_1 dff_inputs2  (
	.scan_in(dff_inputs2_scanin),
	.scan_out(dff_inputs2_scanout),
	.l1clk	(l1clk_in),
	.din	(index_x[0]),
	.dout	(index_y_unused[0]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_dta_sp_1920b_cust_tisram_msff_macro__width_2 dff_inputs3  (
	.scan_in(dff_inputs3_scanin),
	.scan_out(dff_inputs3_scanout),
	.l1clk	(l1clk_in),
	.d	({rdreq_x,wrreq_x}),
	.latout	({rdreq_b,wrreq_b}),
	.latout_l(dff_inputs3_unused[1:0]),
  .siclk(siclk),
  .soclk(soclk)
);

n2_dta_sp_1920b_cust_msff_ctl_macro__width_2 dff_inputs4  (
	.scan_in(dff_inputs4_scanin),
	.scan_out(dff_inputs4_scanout),
	.l1clk	(l1clk_in),
	.din	({rdreq_x,wrreq_x}),
	.dout	({rdreq_a,wrreq_a}),
  .siclk(siclk),
  .soclk(soclk)
);

n2_dta_sp_1920b_cust_msff_ctl_macro__width_30 dff_wrtag  (
	.scan_in(dff_wrtag_scanin),
	.scan_out(dff_wrtag_scanout),
	.l1clk	(l1clk_din),
	.din	({wrtag_x[0],
		  wrtag_x[1],
		  wrtag_x[2],
		  wrtag_x[3],
		  wrtag_x[4],
		  wrtag_x[5],
		  wrtag_x[6],
		  wrtag_x[7],
		  wrtag_x[8],
		  wrtag_x[9],
		  wrtag_x[10],
		  wrtag_x[11],
		  wrtag_x[12],
		  wrtag_x[13],
		  wrtag_x[14],
		  wrtag_x[15],
		  wrtag_x[16],
		  wrtag_x[17],
		  wrtag_x[18],
		  wrtag_x[19],
		  wrtag_x[20],
		  wrtag_x[21],
		  wrtag_x[22],
		  wrtag_x[23],
		  wrtag_x[24],
		  wrtag_x[25],
		  wrtag_x[26],
		  wrtag_x[27],
		  wrtag_x[28],
		  wrtag_x[29]}),
	.dout	({wrtag_y[0],
		  wrtag_y[1],
		  wrtag_y[2],
		  wrtag_y[3],
		  wrtag_y[4],
		  wrtag_y[5],
		  wrtag_y[6],
		  wrtag_y[7],
		  wrtag_y[8],
		  wrtag_y[9],
		  wrtag_y[10],
		  wrtag_y[11],
		  wrtag_y[12],
		  wrtag_y[13],
		  wrtag_y[14],
		  wrtag_y[15],
		  wrtag_y[16],
		  wrtag_y[17],
		  wrtag_y[18],
		  wrtag_y[19],
		  wrtag_y[20],
		  wrtag_y[21],
		  wrtag_y[22],
		  wrtag_y[23],
		  wrtag_y[24],
		  wrtag_y[25],
		  wrtag_y[26],
		  wrtag_y[27],
		  wrtag_y[28],
		  wrtag_y[29]}),
  .siclk(siclk),
  .soclk(soclk)
);

// Decode write enables
n2_dta_sp_1920b_cust_inv_macro__width_3 way_inv  (
	.din	({wrway_y[1:0], tcu_array_wr_inhibit}),
	.dout	({wrway_y_[1:0],wr_inhibit_})
);

assign wr_inhibit = tcu_array_wr_inhibit;

n2_dta_sp_1920b_cust_and_macro__ports_4__width_4 way_and   (
	.din0	({wrreq_b,    wrreq_b,    wrreq_b,    wrreq_b}),
	.din1	({wrway_y [0],wrway_y_[0],wrway_y [0],wrway_y_[0]}),
	.din2	({wrway_y [1],wrway_y [1],wrway_y_[1],wrway_y_[1]}),
	.din3	({4{wr_inhibit_}}),
	.dout	(wr_way[3:0])
);

n2_dta_sp_1920b_array way0 (
	.clk		(l1clk_array),
	.wr_en_b	(wr_way[0]),
	.rd_en_b	(rdreq_b),
	.wr_en_a	(wrreq_a),
	.rd_en_a	(rdreq_a),
	.addr		(index_y[6:0]),
	.din		(wrtag_y[29:0]),
	.dout		(rdtag_w0_y[29:0]),
  .wr_inhibit(wr_inhibit)
);
n2_dta_sp_1920b_array way1 (
	.clk		(l1clk_array),
	.wr_en_b	(wr_way[1]),
	.rd_en_b	(rdreq_b),
	.wr_en_a	(wrreq_a),
	.rd_en_a	(rdreq_a),
	.addr		(index_y[6:0]),
	.din		(wrtag_y[29:0]),
	.dout		(rdtag_w1_y[29:0]),
  .wr_inhibit(wr_inhibit)
);
n2_dta_sp_1920b_array way2 (
	.clk		(l1clk_array),
	.wr_en_b	(wr_way[2]),
	.rd_en_b	(rdreq_b),
	.wr_en_a	(wrreq_a),
	.rd_en_a	(rdreq_a),
	.addr		(index_y[6:0]),
	.din		(wrtag_y[29:0]),
	.dout		(rdtag_w2_y[29:0]),
  .wr_inhibit(wr_inhibit)
);
n2_dta_sp_1920b_array way3 (
	.clk		(l1clk_array),
	.wr_en_b	(wr_way[3]),
	.rd_en_b	(rdreq_b),
	.wr_en_a	(wrreq_a),
	.rd_en_a	(rdreq_a),
	.addr		(index_y[6:0]),
	.din		(wrtag_y[29:0]),
	.dout		(rdtag_w3_y[29:0]),
  .wr_inhibit(wr_inhibit)
);

supply0 vss;
supply1 vdd;
// fixscan start:
assign dff_inputs1_scanin        = scan_in                  ;
assign dff_inputs2_scanin        = dff_inputs1_scanout      ;
assign dff_inputs3_scanin        = dff_inputs2_scanout      ;
assign dff_inputs4_scanin        = dff_inputs3_scanout      ;
assign dff_wrtag_scanin          = dff_inputs4_scanout      ;
assign scan_out                  = dff_wrtag_scanout        ;
// fixscan end:

`ifndef FPGA
// synopsys translate_on
`endif

endmodule







// any PARAMS parms go into naming of macro

module n2_dta_sp_1920b_cust_l1clkhdr_ctl_macro (
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
//   macro for cl_mc1_tisram_msff_{16,8}x flops
//
//





module n2_dta_sp_1920b_cust_tisram_msff_macro__width_9 (
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

module n2_dta_sp_1920b_cust_msff_ctl_macro__width_1 (
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
//   macro for cl_mc1_tisram_msff_{16,8}x flops
//
//





module n2_dta_sp_1920b_cust_tisram_msff_macro__width_2 (
  d, 
  scan_in, 
  l1clk, 
  siclk, 
  soclk, 
  scan_out, 
  latout, 
  latout_l);
wire [0:0] so;

input [1:0] d;
  input scan_in;
input l1clk;
input siclk;
input soclk;
  output scan_out;
output [1:0] latout;
output [1:0] latout_l;






tisram_msff #(2)  d0_0 (
.d(d[1:0]),
.si({scan_in,so[0:0]}),
.so({so[0:0],scan_out}),
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.latout(latout[1:0]),
.latout_l(latout_l[1:0])
);












//place::generic_place($width,$stack,$left);

endmodule









// any PARAMS parms go into naming of macro

module n2_dta_sp_1920b_cust_msff_ctl_macro__width_2 (
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
.si({scan_in,so[0:0]}),
.so({so[0:0],scan_out}),
.q(dout[1:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_dta_sp_1920b_cust_msff_ctl_macro__width_30 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [29:0] fdin;
wire [28:0] so;

  input [29:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [29:0] dout;
  output scan_out;
assign fdin[29:0] = din[29:0];






dff #(30)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[29:0]),
.si({scan_in,so[28:0]}),
.so({so[28:0],scan_out}),
.q(dout[29:0])
);












endmodule









//
//   invert macro
//
//





module n2_dta_sp_1920b_cust_inv_macro__width_3 (
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
//   and macro for ports = 2,3,4
//
//





module n2_dta_sp_1920b_cust_and_macro__ports_4__width_4 (
  din0, 
  din1, 
  din2, 
  din3, 
  dout);
  input [3:0] din0;
  input [3:0] din1;
  input [3:0] din2;
  input [3:0] din3;
  output [3:0] dout;






and4 #(4)  d0_0 (
.in0(din0[3:0]),
.in1(din1[3:0]),
.in2(din2[3:0]),
.in3(din3[3:0]),
.out(dout[3:0])
);









endmodule






module n2_dta_sp_1920b_array (
  clk, 
  rd_en_b, 
  wr_en_b, 
  rd_en_a, 
  wr_en_a, 
  addr, 
  wr_inhibit, 
  din, 
  dout);
wire rd_en_b_unused;
	

`define	WIDTH 30
`define ENTRIES 128
`define ADDRBITS 7

input			clk;
input	     		rd_en_b;	// comes on negedge
input	     		wr_en_b;	// comes on negedge (way specific)
input	     		rd_en_a;	// comes on posedge
input	     		wr_en_a;	// comes on posedge (not way specific)
input	[`ADDRBITS-1:0]	addr;		// comes on negedge
input			wr_inhibit;	// async

input	[`WIDTH-1:0]	din;		// comes on posedge
output	[`WIDTH-1:0]	dout;








reg	[`WIDTH-1:0]	mem[`ENTRIES-1:0];
reg	[`WIDTH-1:0]	local_dout;

assign rd_en_b_unused = rd_en_b;

`ifndef NOINITMEM
// Emulate reset
integer i;
initial begin
  for (i=0; i<`ENTRIES; i=i+1) begin
    mem[i] = {`WIDTH{1'b0}}; 
  end
  local_dout = {`WIDTH{1'b0}};
end
`endif

//////////////////////
// Read/write array
//////////////////////

always @(negedge clk) begin
    if (wr_en_b) begin
        mem[addr] <= din;



    end
end

always @(posedge clk) begin
    local_dout[`WIDTH-1:0] <= mem[addr];
end

assign dout[`WIDTH-1:0] = local_dout[`WIDTH-1:0] & {`WIDTH{rd_en_a & ~wr_en_a & ~wr_inhibit}};

supply0 vss;
supply1 vdd;


endmodule

