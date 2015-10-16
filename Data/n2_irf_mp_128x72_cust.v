// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: n2_irf_mp_128x72_cust.v
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
module n2_irf_mp_128x72_cust (
  l2clk, 
  scan_in, 
  tcu_pce_ov, 
  tcu_aclk, 
  tcu_bclk, 
  tcu_array_wr_inhibit, 
  tcu_scan_en, 
  tcu_se_scancollar_in, 
  clken, 
  rd_tid, 
  rd_addr_p0, 
  rd_addr_p1, 
  rd_addr_p2, 
  rd_en_p0, 
  rd_en_p1, 
  rd_en_p2, 
  wr_en_p0, 
  wr_en_p1, 
  wr_tid_p0, 
  wr_tid_p1, 
  wr_addr_p0, 
  wr_addr_p1, 
  wr_data_p0, 
  wr_data_p1, 
  save_tid, 
  save_local_addr, 
  save_even_addr, 
  save_odd_addr, 
  save_even_en, 
  save_odd_en, 
  save_local_en, 
  restore_tid, 
  restore_local_addr, 
  restore_even_addr, 
  restore_odd_addr, 
  restore_even_en, 
  restore_odd_en, 
  restore_local_en, 
  save_global_en, 
  save_global_tid, 
  save_global_addr, 
  restore_global_en, 
  restore_global_tid, 
  restore_global_addr, 
  dout_p0, 
  dout_p1, 
  dout_p2, 
  scan_out);
wire siclk;
wire soclk;
wire l1clk_sci;
wire [35:0] i_wr_data_1st_p0_ff_scanin;
wire [35:0] i_wr_data_1st_p0_ff_scanout;
wire [71:0] wr_data_p0_ff;
wire [35:0] i_wr_data_1st_p1_ff_scanin;
wire [35:0] i_wr_data_1st_p1_ff_scanout;
wire [71:0] wr_data_p1_ff;
wire [19:0] i_rd_control_ff_scanin;
wire [19:0] i_rd_control_ff_scanout;
wire l1clk_free;
wire rd_en_p0_ff;
wire rd_en_p1_ff;
wire rd_en_p2_ff;
wire [4:0] rd_addr_p0_ff;
wire [4:0] rd_addr_p1_ff;
wire [4:0] rd_addr_p2_ff;
wire [1:0] rd_tid_ff;
wire [19:0] rd_control_l1_l_unused;
wire [19:0] rd_control_ff_l_unused;
wire [19:0] rd_control_ff_unused;
wire [15:0] i_wr_control_ff_scanin;
wire [15:0] i_wr_control_ff_scanout;
wire [4:0] wr_addr_p1_ff;
wire [1:0] wr_tid_p1_ff;
wire wr_en_p1_ff;
wire [4:0] wr_addr_p0_ff;
wire [1:0] wr_tid_p0_ff;
wire wr_en_p0_ff;
wire [16:0] i_restore_ff_scanin;
wire [16:0] i_restore_ff_scanout;
wire [1:0] restore_even_addr_ff;
wire [2:0] restore_local_addr_ff;
wire [1:0] restore_odd_addr_ff;
wire [1:0] restore_global_addr_ff;
wire restore_even_en_ff;
wire restore_odd_en_ff;
wire restore_local_en_ff;
wire restore_global_en_ff;
wire [1:0] restore_tid_ff;
wire [1:0] restore_global_tid_ff;
wire [16:0] i_save_ff_scanin;
wire [16:0] i_save_ff_scanout;
wire [1:0] save_even_addr_ff;
wire [2:0] save_local_addr_ff;
wire [1:0] save_odd_addr_ff;
wire [1:0] save_global_addr_ff;
wire save_even_en_ff;
wire save_odd_en_ff;
wire save_local_en_ff;
wire save_global_en_ff;
wire [1:0] save_tid_ff;
wire [1:0] save_global_tid_ff;
wire [35:0] i_wr_data_2nd_p0_ff_scanin;
wire [35:0] i_wr_data_2nd_p0_ff_scanout;
wire [35:0] i_wr_data_2nd_p1_ff_scanin;
wire [35:0] i_wr_data_2nd_p1_ff_scanout;


input		l2clk;
input		scan_in;
input		tcu_pce_ov;
input		tcu_aclk;
input		tcu_bclk;
input		tcu_array_wr_inhibit;
input		tcu_scan_en;
input		tcu_se_scancollar_in;


// *** Power Management ***
input		clken;

// *** Reading controls ***
input [1:0]	rd_tid;
input [4:0]	rd_addr_p0;
input [4:0]	rd_addr_p1;
input [4:0]	rd_addr_p2;
input		rd_en_p0;
input		rd_en_p1;
input		rd_en_p2;

// *** Writing controls ***
input		wr_en_p0;
input		wr_en_p1;
input [1:0]	wr_tid_p0;
input [1:0]	wr_tid_p1;
input [4:0]	wr_addr_p0;
input [4:0]	wr_addr_p1;

// *** Write data ports ***
input [71:0]	wr_data_p0;
input [71:0]	wr_data_p1;

// *** Window swapping controls ***
input [1:0]	save_tid;
input [2:0]	save_local_addr;
input [1:0]	save_even_addr;
input [1:0]	save_odd_addr;
input		save_even_en;
input		save_odd_en;
input		save_local_en;

input [1:0]	restore_tid;
input [2:0]	restore_local_addr;
input [1:0]	restore_even_addr;
input [1:0]	restore_odd_addr;
input		restore_even_en;
input		restore_odd_en;
input		restore_local_en;

input		save_global_en;
input [1:0]	save_global_tid;
input [1:0]	save_global_addr;

input		restore_global_en;
input [1:0]	restore_global_tid;
input [1:0]	restore_global_addr;



output [71:0]	dout_p0;			// RS1 operand : [71:64] contains 8-bit ECC, [63:0] contains 64-bit data
output [71:0]	dout_p1;			// RS2 operand : [71:64] contains 8-bit ECC, [63:0] contains 64-bit data
output [71:0]	dout_p2;			// RS3 operand : [71:64] contains 8-bit ECC, [63:0] contains 64-bit data

output		scan_out;

`ifndef FPGA
// JDL
// synopsys translate_off
`endif

   
assign siclk	= tcu_aclk;
assign soclk	= tcu_bclk;


// 0in custom -fire (wr_en_p0       & wr_en_p1          & (wr_tid_p0[1:0]       == wr_tid_p1[1:0]))          -message "IRF p0 & p1 ports wrote to same TID"

// 0in custom -fire (save_even_en   & restore_even_en   & (save_tid[1:0]        == restore_tid[1:0]))        -message "IRF Save and Restore EVEN   to same TID"
// 0in custom -fire (save_odd_en    & restore_odd_en    & (save_tid[1:0]        == restore_tid[1:0]))        -message "IRF Save and Restore ODD    to same TID"
// 0in custom -fire (save_local_en  & restore_local_en  & (save_tid[1:0]        == restore_tid[1:0]))        -message "IRF Save and Restore LOCAL  to same TID"
// 0in custom -fire (save_global_en & restore_global_en & (save_global_tid[1:0] == restore_global_tid[1:0])) -message "IRF Save and Restore GLOBAL to same TID"



 
n2_irf_mp_128x72_cust_l1clkhdr_ctl_macro	clkgen_sci (
  .l2clk  (l2clk          		),
  .l1en   (clken			),
  .pce_ov (tcu_pce_ov			),
  .stop   (1'b0				),
  .se	  (tcu_se_scancollar_in		),
  .l1clk  (l1clk_sci			));



n2_irf_mp_128x72_cust_msff_ctl_macro__fs_1__width_36	i_wr_data_1st_p0_ff	 (
     .scan_in(i_wr_data_1st_p0_ff_scanin[35:0]),
     .scan_out(i_wr_data_1st_p0_ff_scanout[35:0]),
  .l1clk ( l1clk_sci			),
  .din   ( wr_data_p0[35:0]		),
  .dout  ( wr_data_p0_ff[35:0]		),
  .siclk(siclk),
  .soclk(soclk));


n2_irf_mp_128x72_cust_msff_ctl_macro__fs_1__width_36	i_wr_data_1st_p1_ff	 (
     .scan_in(i_wr_data_1st_p1_ff_scanin[35:0]),
     .scan_out(i_wr_data_1st_p1_ff_scanout[35:0]),
  .l1clk ( l1clk_sci			),
  .din   ( wr_data_p1[35:0]		),
  .dout  ( wr_data_p1_ff[35:0]		),
  .siclk(siclk),
  .soclk(soclk));



n2_irf_mp_128x72_cust_sram_msff_mo_macro__fs_1__width_20	i_rd_control_ff		 (
  .scan_in(i_rd_control_ff_scanin[19:0]),
  .scan_out(i_rd_control_ff_scanout[19:0]),
  .l1clk  ( l1clk_sci			),
  .and_clk( l1clk_free			),
  .d      ({rd_en_p0			,
	    rd_en_p1			,
	    rd_en_p2			,
	    rd_addr_p0[4:0]		,
	    rd_addr_p1[4:0]		,
	    rd_addr_p2[4:0]		,
	    rd_tid[1:0]}		),
  .mq     ({rd_en_p0_ff			,
	    rd_en_p1_ff			,
	    rd_en_p2_ff			,
	    rd_addr_p0_ff[4:0]		,
	    rd_addr_p1_ff[4:0]		,
	    rd_addr_p2_ff[4:0]		,
	    rd_tid_ff[1:0]}		),
  .mq_l   ( rd_control_l1_l_unused[19:0]),
  .q_l    ( rd_control_ff_l_unused[19:0]),
  .q      ( rd_control_ff_unused[19:0]  ),
  .siclk(siclk),
  .soclk(soclk));



n2_irf_mp_128x72_cust_msff_ctl_macro__fs_1__width_16	i_wr_control_ff		 (
     .scan_in(i_wr_control_ff_scanin[15:0]),
     .scan_out(i_wr_control_ff_scanout[15:0]),
  .l1clk ( l1clk_sci			),
  .din   ({wr_addr_p1[4:0]		,
	   wr_tid_p1[1:0]		,
	   wr_en_p1			,
	   wr_addr_p0[4:0]		,
	   wr_tid_p0[1:0]		,
	   wr_en_p0			}),
  .dout  ({wr_addr_p1_ff[4:0]		,
	   wr_tid_p1_ff[1:0]		,
	   wr_en_p1_ff			,
	   wr_addr_p0_ff[4:0]		,
	   wr_tid_p0_ff[1:0]		,
	   wr_en_p0_ff			}),
  .siclk(siclk),
  .soclk(soclk));



n2_irf_mp_128x72_cust_msff_ctl_macro__fs_1__width_17	i_restore_ff		 (
     .scan_in(i_restore_ff_scanin[16:0]),
     .scan_out(i_restore_ff_scanout[16:0]),
  .l1clk ( l1clk_sci			),
  .din   ({restore_even_addr[1:0]	,
	   restore_local_addr[2:0]	,
	   restore_odd_addr[1:0]	,
	   restore_global_addr[1:0]	,
	   restore_even_en		,
	   restore_odd_en		,
	   restore_local_en		,
	   restore_global_en		,
	   restore_tid[1:0]		,
	   restore_global_tid[1:0]	}),
  .dout  ({restore_even_addr_ff[1:0]	,
	   restore_local_addr_ff[2:0]	,
	   restore_odd_addr_ff[1:0]	,
	   restore_global_addr_ff[1:0]	,
	   restore_even_en_ff		,
	   restore_odd_en_ff		,
	   restore_local_en_ff		,
	   restore_global_en_ff		,
	   restore_tid_ff[1:0]		,
	   restore_global_tid_ff[1:0]	}),
  .siclk(siclk),
  .soclk(soclk));




n2_irf_mp_128x72_cust_msff_ctl_macro__fs_1__width_17	i_save_ff		 (
     .scan_in(i_save_ff_scanin[16:0]),
     .scan_out(i_save_ff_scanout[16:0]),
  .l1clk ( l1clk_sci			),
  .din   ({save_even_addr[1:0]		,
	   save_local_addr[2:0]		,
	   save_odd_addr[1:0]		,
	   save_global_addr[1:0]	,
	   save_even_en			,
	   save_odd_en			,
	   save_local_en		,
	   save_global_en		,
	   save_tid[1:0]		,
	   save_global_tid[1:0]		}),
  .dout  ({save_even_addr_ff[1:0]	,
	   save_local_addr_ff[2:0]	,
	   save_odd_addr_ff[1:0]	,
	   save_global_addr_ff[1:0]	,
	   save_even_en_ff		,
	   save_odd_en_ff		,
	   save_local_en_ff		,
	   save_global_en_ff		,
	   save_tid_ff[1:0]		,
	   save_global_tid_ff[1:0]	}),
  .siclk(siclk),
  .soclk(soclk));



n2_irf_mp_128x72_cust_msff_ctl_macro__fs_1__width_36	i_wr_data_2nd_p0_ff	 (
     .scan_in(i_wr_data_2nd_p0_ff_scanin[35:0]),
     .scan_out(i_wr_data_2nd_p0_ff_scanout[35:0]),
  .l1clk ( l1clk_sci			),
  .din   ( wr_data_p0[71:36]		),
  .dout  ( wr_data_p0_ff[71:36]		),
  .siclk(siclk),
  .soclk(soclk));



n2_irf_mp_128x72_cust_msff_ctl_macro__fs_1__width_36	i_wr_data_2nd_p1_ff	 (
     .scan_in(i_wr_data_2nd_p1_ff_scanin[35:0]),
     .scan_out(i_wr_data_2nd_p1_ff_scanout[35:0]),
  .l1clk ( l1clk_sci			),
  .din   ( wr_data_p1[71:36]		),
  .dout  ( wr_data_p1_ff[71:36]		),
  .siclk(siclk),
  .soclk(soclk));




n2_irf_mp_128x72_cust_l1clkhdr_ctl_macro	clkgen_free (
  .l2clk  (l2clk			),
  .l1en   (clken			),
  .pce_ov (tcu_pce_ov			),
  .stop	  (1'b0				),
  .se	  (tcu_scan_en			),
  .l1clk  (l1clk_free			));


exu_irf_array	irf_array		(
  .clk			( l1clk_free				),
  .a_rd_en_p0		( rd_en_p0_ff				),
  .a_rd_en_p1		( rd_en_p1_ff				),
  .a_rd_en_p2		( rd_en_p2_ff				),
  .a_rd_tid		( rd_tid_ff[1:0]			),
  .a_rd_addr_p0		( rd_addr_p0_ff[4:0]			),
  .a_rd_addr_p1		( rd_addr_p1_ff[4:0]			),
  .a_rd_addr_p2		( rd_addr_p2_ff[4:0]			),

  .a_wr_en_p0		( wr_en_p0_ff				),
  .a_wr_tid_p0		( wr_tid_p0_ff[1:0]			),
  .a_wr_addr_p0		( wr_addr_p0_ff[4:0]			),
  .a_wr_data_p0		( wr_data_p0_ff[71:0]			),
  .a_wr_en_p1		( wr_en_p1_ff				),
  .a_wr_tid_p1		( wr_tid_p1_ff[1:0]			),
  .a_wr_addr_p1		( wr_addr_p1_ff[4:0]			),
  .a_wr_data_p1		( wr_data_p1_ff[71:0]			),

  .a_save_tid		( save_tid_ff[1:0]			),
  .a_save_global_tid	( save_global_tid_ff[1:0]		),
  .a_save_global_addr	( save_global_addr_ff[1:0]		),
  .a_save_even_addr	( save_even_addr_ff[1:0]		),
  .a_save_odd_addr	( save_odd_addr_ff[1:0]			),
  .a_save_local_addr	( save_local_addr_ff[2:0]		),
  .a_save_global_en	( save_global_en_ff			),
  .a_save_even_en	( save_even_en_ff			),
  .a_save_local_en	( save_local_en_ff			),
  .a_save_odd_en	( save_odd_en_ff			),

  .a_restore_tid	( restore_tid_ff[1:0]			),
  .a_restore_global_tid	( restore_global_tid_ff[1:0]		),
  .a_restore_global_addr( restore_global_addr_ff[1:0]		),
  .a_restore_even_addr	( restore_even_addr_ff[1:0]		),
  .a_restore_odd_addr	( restore_odd_addr_ff[1:0]		),
  .a_restore_local_addr	( restore_local_addr_ff[2:0]		),
  .a_restore_global_en	( restore_global_en_ff			),
  .a_restore_even_en	( restore_even_en_ff			),
  .a_restore_local_en	( restore_local_en_ff			),
  .a_restore_odd_en	( restore_odd_en_ff			),

	.a_rd_data_p0		( dout_p0[71:0]				),
	.a_rd_data_p1		( dout_p1[71:0]				),
	.a_rd_data_p2		( dout_p2[71:0]				),
  .tcu_array_wr_inhibit(tcu_array_wr_inhibit));



supply0 vss;
supply1 vdd;


// scanorder start
//      i_wr_data_1st_p0_ff_scanin[0]
//      i_wr_data_1st_p1_ff_scanin[0]
//      i_wr_data_1st_p0_ff_scanin[1]
//      i_wr_data_1st_p1_ff_scanin[1]
//      i_wr_data_1st_p0_ff_scanin[2]
//      i_wr_data_1st_p1_ff_scanin[2]
//      i_wr_data_1st_p0_ff_scanin[3]
//      i_wr_data_1st_p1_ff_scanin[3]
//      i_wr_data_1st_p0_ff_scanin[4]
//      i_wr_data_1st_p1_ff_scanin[4]
//      i_wr_data_1st_p0_ff_scanin[5]
//      i_wr_data_1st_p1_ff_scanin[5]
//      i_wr_data_1st_p0_ff_scanin[6]
//      i_wr_data_1st_p1_ff_scanin[6]
//      i_wr_data_1st_p0_ff_scanin[7]
//      i_wr_data_1st_p1_ff_scanin[7]
//      i_wr_data_1st_p0_ff_scanin[8]
//      i_wr_data_1st_p1_ff_scanin[8]
//      i_wr_data_1st_p0_ff_scanin[9]
//      i_wr_data_1st_p1_ff_scanin[9]
//      i_wr_data_1st_p0_ff_scanin[10]
//      i_wr_data_1st_p1_ff_scanin[10]
//      i_wr_data_1st_p0_ff_scanin[11]
//      i_wr_data_1st_p1_ff_scanin[11]
//      i_wr_data_1st_p0_ff_scanin[12]
//      i_wr_data_1st_p1_ff_scanin[12]
//      i_wr_data_1st_p0_ff_scanin[13]
//      i_wr_data_1st_p1_ff_scanin[13]
//      i_wr_data_1st_p0_ff_scanin[14]
//      i_wr_data_1st_p1_ff_scanin[14]
//      i_wr_data_1st_p0_ff_scanin[15]
//      i_wr_data_1st_p1_ff_scanin[15]
//      i_wr_data_1st_p0_ff_scanin[16]
//      i_wr_data_1st_p1_ff_scanin[16]
//      i_wr_data_1st_p0_ff_scanin[17]
//      i_wr_data_1st_p1_ff_scanin[17]
//      i_wr_data_1st_p0_ff_scanin[18]
//      i_wr_data_1st_p1_ff_scanin[18]
//      i_wr_data_1st_p0_ff_scanin[19]
//      i_wr_data_1st_p1_ff_scanin[19]
//      i_wr_data_1st_p0_ff_scanin[20]
//      i_wr_data_1st_p1_ff_scanin[20]
//      i_wr_data_1st_p0_ff_scanin[21]
//      i_wr_data_1st_p1_ff_scanin[21]
//      i_wr_data_1st_p0_ff_scanin[22]
//      i_wr_data_1st_p1_ff_scanin[22]
//      i_wr_data_1st_p0_ff_scanin[23]
//      i_wr_data_1st_p1_ff_scanin[23]
//      i_wr_data_1st_p0_ff_scanin[24]
//      i_wr_data_1st_p1_ff_scanin[24]
//      i_wr_data_1st_p0_ff_scanin[25]
//      i_wr_data_1st_p1_ff_scanin[25]
//      i_wr_data_1st_p0_ff_scanin[26]
//      i_wr_data_1st_p1_ff_scanin[26]
//      i_wr_data_1st_p0_ff_scanin[27]
//      i_wr_data_1st_p1_ff_scanin[27]
//      i_wr_data_1st_p0_ff_scanin[28]
//      i_wr_data_1st_p1_ff_scanin[28]
//      i_wr_data_1st_p0_ff_scanin[29]
//      i_wr_data_1st_p1_ff_scanin[29]
//      i_wr_data_1st_p0_ff_scanin[30]
//      i_wr_data_1st_p1_ff_scanin[30]
//      i_wr_data_1st_p0_ff_scanin[31]
//      i_wr_data_1st_p1_ff_scanin[31]
//      i_wr_data_1st_p0_ff_scanin[32]
//      i_wr_data_1st_p1_ff_scanin[32]
//      i_wr_data_1st_p0_ff_scanin[33]
//      i_wr_data_1st_p1_ff_scanin[33]
//      i_wr_data_1st_p0_ff_scanin[34]
//      i_wr_data_1st_p1_ff_scanin[34]
//      i_wr_data_1st_p0_ff_scanin[35]
//      i_wr_data_1st_p1_ff_scanin[35]

//      i_rd_control_ff_scanin[1]
//      i_rd_control_ff_scanin[0]
//      i_rd_control_ff_scanin[6]
//      i_rd_control_ff_scanin[5]
//      i_rd_control_ff_scanin[4]
//      i_rd_control_ff_scanin[3]
//      i_rd_control_ff_scanin[2]
//      i_rd_control_ff_scanin[17]
//      i_rd_control_ff_scanin[7]
//      i_rd_control_ff_scanin[8]
//      i_rd_control_ff_scanin[9]
//      i_rd_control_ff_scanin[10]
//      i_rd_control_ff_scanin[11]
//      i_rd_control_ff_scanin[18]
//      i_rd_control_ff_scanin[12]
//      i_rd_control_ff_scanin[13]
//      i_rd_control_ff_scanin[14]
//      i_rd_control_ff_scanin[15]
//      i_rd_control_ff_scanin[16]
//      i_rd_control_ff_scanin[19]

//      i_wr_control_ff_scanin[0]
//      i_wr_control_ff_scanin[1]
//      i_wr_control_ff_scanin[2]
//      i_wr_control_ff_scanin[8]
//      i_wr_control_ff_scanin[9]
//      i_wr_control_ff_scanin[10]
//      i_wr_control_ff_scanin[3]
//      i_wr_control_ff_scanin[4]
//      i_wr_control_ff_scanin[5]
//      i_wr_control_ff_scanin[6]
//      i_wr_control_ff_scanin[7]
//      i_wr_control_ff_scanin[11]
//      i_wr_control_ff_scanin[12]
//      i_wr_control_ff_scanin[13]
//      i_wr_control_ff_scanin[14]
//      i_wr_control_ff_scanin[15]


//      i_restore_ff_scanin[1]
//      i_restore_ff_scanin[0]
//      i_restore_ff_scanin[2]
//      i_restore_ff_scanin[3]
//      i_restore_ff_scanin[4]
//      i_restore_ff_scanin[6]
//      i_restore_ff_scanin[5]
//      i_restore_ff_scanin[11]
//      i_restore_ff_scanin[10]
//      i_restore_ff_scanin[9]
//      i_restore_ff_scanin[8]
//      i_restore_ff_scanin[7]
//      i_restore_ff_scanin[12]
//      i_restore_ff_scanin[13]
//      i_restore_ff_scanin[14]
//      i_restore_ff_scanin[15]
//      i_restore_ff_scanin[16]

//      i_save_ff_scanin[1]
//      i_save_ff_scanin[0]
//      i_save_ff_scanin[2]
//      i_save_ff_scanin[3]
//      i_save_ff_scanin[4]
//      i_save_ff_scanin[6]
//      i_save_ff_scanin[5]
//      i_save_ff_scanin[11]
//      i_save_ff_scanin[10]
//      i_save_ff_scanin[9]
//      i_save_ff_scanin[8]
//      i_save_ff_scanin[7]
//      i_save_ff_scanin[12]
//      i_save_ff_scanin[13]
//      i_save_ff_scanin[14]
//      i_save_ff_scanin[15]
//      i_save_ff_scanin[16]


//      i_wr_data_2nd_p0_ff_scanin[0]
//      i_wr_data_2nd_p1_ff_scanin[0]
//      i_wr_data_2nd_p0_ff_scanin[1]
//      i_wr_data_2nd_p1_ff_scanin[1]
//      i_wr_data_2nd_p0_ff_scanin[2]
//      i_wr_data_2nd_p1_ff_scanin[2]
//      i_wr_data_2nd_p0_ff_scanin[3]
//      i_wr_data_2nd_p1_ff_scanin[3]
//      i_wr_data_2nd_p0_ff_scanin[4]
//      i_wr_data_2nd_p1_ff_scanin[4]
//      i_wr_data_2nd_p0_ff_scanin[5]
//      i_wr_data_2nd_p1_ff_scanin[5]
//      i_wr_data_2nd_p0_ff_scanin[6]
//      i_wr_data_2nd_p1_ff_scanin[6]
//      i_wr_data_2nd_p0_ff_scanin[7]
//      i_wr_data_2nd_p1_ff_scanin[7]
//      i_wr_data_2nd_p0_ff_scanin[8]
//      i_wr_data_2nd_p1_ff_scanin[8]
//      i_wr_data_2nd_p0_ff_scanin[9]
//      i_wr_data_2nd_p1_ff_scanin[9]
//      i_wr_data_2nd_p0_ff_scanin[10]
//      i_wr_data_2nd_p1_ff_scanin[10]
//      i_wr_data_2nd_p0_ff_scanin[11]
//      i_wr_data_2nd_p1_ff_scanin[11]
//      i_wr_data_2nd_p0_ff_scanin[12]
//      i_wr_data_2nd_p1_ff_scanin[12]
//      i_wr_data_2nd_p0_ff_scanin[13]
//      i_wr_data_2nd_p1_ff_scanin[13]
//      i_wr_data_2nd_p0_ff_scanin[14]
//      i_wr_data_2nd_p1_ff_scanin[14]
//      i_wr_data_2nd_p0_ff_scanin[15]
//      i_wr_data_2nd_p1_ff_scanin[15]
//      i_wr_data_2nd_p0_ff_scanin[16]
//      i_wr_data_2nd_p1_ff_scanin[16]
//      i_wr_data_2nd_p0_ff_scanin[17]
//      i_wr_data_2nd_p1_ff_scanin[17]
//      i_wr_data_2nd_p0_ff_scanin[18]
//      i_wr_data_2nd_p1_ff_scanin[18]
//      i_wr_data_2nd_p0_ff_scanin[19]
//      i_wr_data_2nd_p1_ff_scanin[19]
//      i_wr_data_2nd_p0_ff_scanin[20]
//      i_wr_data_2nd_p1_ff_scanin[20]
//      i_wr_data_2nd_p0_ff_scanin[21]
//      i_wr_data_2nd_p1_ff_scanin[21]
//      i_wr_data_2nd_p0_ff_scanin[22]
//      i_wr_data_2nd_p1_ff_scanin[22]
//      i_wr_data_2nd_p0_ff_scanin[23]
//      i_wr_data_2nd_p1_ff_scanin[23]
//      i_wr_data_2nd_p0_ff_scanin[24]
//      i_wr_data_2nd_p1_ff_scanin[24]
//      i_wr_data_2nd_p0_ff_scanin[25]
//      i_wr_data_2nd_p1_ff_scanin[25]
//      i_wr_data_2nd_p0_ff_scanin[26]
//      i_wr_data_2nd_p1_ff_scanin[26]
//      i_wr_data_2nd_p0_ff_scanin[27]
//      i_wr_data_2nd_p1_ff_scanin[27]
//      i_wr_data_2nd_p0_ff_scanin[28]
//      i_wr_data_2nd_p1_ff_scanin[28]
//      i_wr_data_2nd_p0_ff_scanin[29]
//      i_wr_data_2nd_p1_ff_scanin[29]
//      i_wr_data_2nd_p0_ff_scanin[30]
//      i_wr_data_2nd_p1_ff_scanin[30]
//      i_wr_data_2nd_p0_ff_scanin[31]
//      i_wr_data_2nd_p1_ff_scanin[31]
//      i_wr_data_2nd_p0_ff_scanin[32]
//      i_wr_data_2nd_p1_ff_scanin[32]
//      i_wr_data_2nd_p0_ff_scanin[33]
//      i_wr_data_2nd_p1_ff_scanin[33]
//      i_wr_data_2nd_p0_ff_scanin[34]
//      i_wr_data_2nd_p1_ff_scanin[34]
//      i_wr_data_2nd_p0_ff_scanin[35]
//      i_wr_data_2nd_p1_ff_scanin[35]

// scanorder end
// fixscan start
assign i_wr_data_1st_p0_ff_scanin[0]=scan_in;
assign i_wr_data_1st_p1_ff_scanin[0]=i_wr_data_1st_p0_ff_scanout[0];
assign i_wr_data_1st_p0_ff_scanin[1]=i_wr_data_1st_p1_ff_scanout[0];
assign i_wr_data_1st_p1_ff_scanin[1]=i_wr_data_1st_p0_ff_scanout[1];
assign i_wr_data_1st_p0_ff_scanin[2]=i_wr_data_1st_p1_ff_scanout[1];
assign i_wr_data_1st_p1_ff_scanin[2]=i_wr_data_1st_p0_ff_scanout[2];
assign i_wr_data_1st_p0_ff_scanin[3]=i_wr_data_1st_p1_ff_scanout[2];
assign i_wr_data_1st_p1_ff_scanin[3]=i_wr_data_1st_p0_ff_scanout[3];
assign i_wr_data_1st_p0_ff_scanin[4]=i_wr_data_1st_p1_ff_scanout[3];
assign i_wr_data_1st_p1_ff_scanin[4]=i_wr_data_1st_p0_ff_scanout[4];
assign i_wr_data_1st_p0_ff_scanin[5]=i_wr_data_1st_p1_ff_scanout[4];
assign i_wr_data_1st_p1_ff_scanin[5]=i_wr_data_1st_p0_ff_scanout[5];
assign i_wr_data_1st_p0_ff_scanin[6]=i_wr_data_1st_p1_ff_scanout[5];
assign i_wr_data_1st_p1_ff_scanin[6]=i_wr_data_1st_p0_ff_scanout[6];
assign i_wr_data_1st_p0_ff_scanin[7]=i_wr_data_1st_p1_ff_scanout[6];
assign i_wr_data_1st_p1_ff_scanin[7]=i_wr_data_1st_p0_ff_scanout[7];
assign i_wr_data_1st_p0_ff_scanin[8]=i_wr_data_1st_p1_ff_scanout[7];
assign i_wr_data_1st_p1_ff_scanin[8]=i_wr_data_1st_p0_ff_scanout[8];
assign i_wr_data_1st_p0_ff_scanin[9]=i_wr_data_1st_p1_ff_scanout[8];
assign i_wr_data_1st_p1_ff_scanin[9]=i_wr_data_1st_p0_ff_scanout[9];
assign i_wr_data_1st_p0_ff_scanin[10]=i_wr_data_1st_p1_ff_scanout[9];
assign i_wr_data_1st_p1_ff_scanin[10]=i_wr_data_1st_p0_ff_scanout[10];
assign i_wr_data_1st_p0_ff_scanin[11]=i_wr_data_1st_p1_ff_scanout[10];
assign i_wr_data_1st_p1_ff_scanin[11]=i_wr_data_1st_p0_ff_scanout[11];
assign i_wr_data_1st_p0_ff_scanin[12]=i_wr_data_1st_p1_ff_scanout[11];
assign i_wr_data_1st_p1_ff_scanin[12]=i_wr_data_1st_p0_ff_scanout[12];
assign i_wr_data_1st_p0_ff_scanin[13]=i_wr_data_1st_p1_ff_scanout[12];
assign i_wr_data_1st_p1_ff_scanin[13]=i_wr_data_1st_p0_ff_scanout[13];
assign i_wr_data_1st_p0_ff_scanin[14]=i_wr_data_1st_p1_ff_scanout[13];
assign i_wr_data_1st_p1_ff_scanin[14]=i_wr_data_1st_p0_ff_scanout[14];
assign i_wr_data_1st_p0_ff_scanin[15]=i_wr_data_1st_p1_ff_scanout[14];
assign i_wr_data_1st_p1_ff_scanin[15]=i_wr_data_1st_p0_ff_scanout[15];
assign i_wr_data_1st_p0_ff_scanin[16]=i_wr_data_1st_p1_ff_scanout[15];
assign i_wr_data_1st_p1_ff_scanin[16]=i_wr_data_1st_p0_ff_scanout[16];
assign i_wr_data_1st_p0_ff_scanin[17]=i_wr_data_1st_p1_ff_scanout[16];
assign i_wr_data_1st_p1_ff_scanin[17]=i_wr_data_1st_p0_ff_scanout[17];
assign i_wr_data_1st_p0_ff_scanin[18]=i_wr_data_1st_p1_ff_scanout[17];
assign i_wr_data_1st_p1_ff_scanin[18]=i_wr_data_1st_p0_ff_scanout[18];
assign i_wr_data_1st_p0_ff_scanin[19]=i_wr_data_1st_p1_ff_scanout[18];
assign i_wr_data_1st_p1_ff_scanin[19]=i_wr_data_1st_p0_ff_scanout[19];
assign i_wr_data_1st_p0_ff_scanin[20]=i_wr_data_1st_p1_ff_scanout[19];
assign i_wr_data_1st_p1_ff_scanin[20]=i_wr_data_1st_p0_ff_scanout[20];
assign i_wr_data_1st_p0_ff_scanin[21]=i_wr_data_1st_p1_ff_scanout[20];
assign i_wr_data_1st_p1_ff_scanin[21]=i_wr_data_1st_p0_ff_scanout[21];
assign i_wr_data_1st_p0_ff_scanin[22]=i_wr_data_1st_p1_ff_scanout[21];
assign i_wr_data_1st_p1_ff_scanin[22]=i_wr_data_1st_p0_ff_scanout[22];
assign i_wr_data_1st_p0_ff_scanin[23]=i_wr_data_1st_p1_ff_scanout[22];
assign i_wr_data_1st_p1_ff_scanin[23]=i_wr_data_1st_p0_ff_scanout[23];
assign i_wr_data_1st_p0_ff_scanin[24]=i_wr_data_1st_p1_ff_scanout[23];
assign i_wr_data_1st_p1_ff_scanin[24]=i_wr_data_1st_p0_ff_scanout[24];
assign i_wr_data_1st_p0_ff_scanin[25]=i_wr_data_1st_p1_ff_scanout[24];
assign i_wr_data_1st_p1_ff_scanin[25]=i_wr_data_1st_p0_ff_scanout[25];
assign i_wr_data_1st_p0_ff_scanin[26]=i_wr_data_1st_p1_ff_scanout[25];
assign i_wr_data_1st_p1_ff_scanin[26]=i_wr_data_1st_p0_ff_scanout[26];
assign i_wr_data_1st_p0_ff_scanin[27]=i_wr_data_1st_p1_ff_scanout[26];
assign i_wr_data_1st_p1_ff_scanin[27]=i_wr_data_1st_p0_ff_scanout[27];
assign i_wr_data_1st_p0_ff_scanin[28]=i_wr_data_1st_p1_ff_scanout[27];
assign i_wr_data_1st_p1_ff_scanin[28]=i_wr_data_1st_p0_ff_scanout[28];
assign i_wr_data_1st_p0_ff_scanin[29]=i_wr_data_1st_p1_ff_scanout[28];
assign i_wr_data_1st_p1_ff_scanin[29]=i_wr_data_1st_p0_ff_scanout[29];
assign i_wr_data_1st_p0_ff_scanin[30]=i_wr_data_1st_p1_ff_scanout[29];
assign i_wr_data_1st_p1_ff_scanin[30]=i_wr_data_1st_p0_ff_scanout[30];
assign i_wr_data_1st_p0_ff_scanin[31]=i_wr_data_1st_p1_ff_scanout[30];
assign i_wr_data_1st_p1_ff_scanin[31]=i_wr_data_1st_p0_ff_scanout[31];
assign i_wr_data_1st_p0_ff_scanin[32]=i_wr_data_1st_p1_ff_scanout[31];
assign i_wr_data_1st_p1_ff_scanin[32]=i_wr_data_1st_p0_ff_scanout[32];
assign i_wr_data_1st_p0_ff_scanin[33]=i_wr_data_1st_p1_ff_scanout[32];
assign i_wr_data_1st_p1_ff_scanin[33]=i_wr_data_1st_p0_ff_scanout[33];
assign i_wr_data_1st_p0_ff_scanin[34]=i_wr_data_1st_p1_ff_scanout[33];
assign i_wr_data_1st_p1_ff_scanin[34]=i_wr_data_1st_p0_ff_scanout[34];
assign i_wr_data_1st_p0_ff_scanin[35]=i_wr_data_1st_p1_ff_scanout[34];
assign i_wr_data_1st_p1_ff_scanin[35]=i_wr_data_1st_p0_ff_scanout[35];
assign i_rd_control_ff_scanin[1]=i_wr_data_1st_p1_ff_scanout[35];
assign i_rd_control_ff_scanin[0]=i_rd_control_ff_scanout[1];
assign i_rd_control_ff_scanin[6]=i_rd_control_ff_scanout[0];
assign i_rd_control_ff_scanin[5]=i_rd_control_ff_scanout[6];
assign i_rd_control_ff_scanin[4]=i_rd_control_ff_scanout[5];
assign i_rd_control_ff_scanin[3]=i_rd_control_ff_scanout[4];
assign i_rd_control_ff_scanin[2]=i_rd_control_ff_scanout[3];
assign i_rd_control_ff_scanin[17]=i_rd_control_ff_scanout[2];
assign i_rd_control_ff_scanin[7]=i_rd_control_ff_scanout[17];
assign i_rd_control_ff_scanin[8]=i_rd_control_ff_scanout[7];
assign i_rd_control_ff_scanin[9]=i_rd_control_ff_scanout[8];
assign i_rd_control_ff_scanin[10]=i_rd_control_ff_scanout[9];
assign i_rd_control_ff_scanin[11]=i_rd_control_ff_scanout[10];
assign i_rd_control_ff_scanin[18]=i_rd_control_ff_scanout[11];
assign i_rd_control_ff_scanin[12]=i_rd_control_ff_scanout[18];
assign i_rd_control_ff_scanin[13]=i_rd_control_ff_scanout[12];
assign i_rd_control_ff_scanin[14]=i_rd_control_ff_scanout[13];
assign i_rd_control_ff_scanin[15]=i_rd_control_ff_scanout[14];
assign i_rd_control_ff_scanin[16]=i_rd_control_ff_scanout[15];
assign i_rd_control_ff_scanin[19]=i_rd_control_ff_scanout[16];
assign i_wr_control_ff_scanin[0]=i_rd_control_ff_scanout[19];
assign i_wr_control_ff_scanin[1]=i_wr_control_ff_scanout[0];
assign i_wr_control_ff_scanin[2]=i_wr_control_ff_scanout[1];
assign i_wr_control_ff_scanin[8]=i_wr_control_ff_scanout[2];
assign i_wr_control_ff_scanin[9]=i_wr_control_ff_scanout[8];
assign i_wr_control_ff_scanin[10]=i_wr_control_ff_scanout[9];
assign i_wr_control_ff_scanin[3]=i_wr_control_ff_scanout[10];
assign i_wr_control_ff_scanin[4]=i_wr_control_ff_scanout[3];
assign i_wr_control_ff_scanin[5]=i_wr_control_ff_scanout[4];
assign i_wr_control_ff_scanin[6]=i_wr_control_ff_scanout[5];
assign i_wr_control_ff_scanin[7]=i_wr_control_ff_scanout[6];
assign i_wr_control_ff_scanin[11]=i_wr_control_ff_scanout[7];
assign i_wr_control_ff_scanin[12]=i_wr_control_ff_scanout[11];
assign i_wr_control_ff_scanin[13]=i_wr_control_ff_scanout[12];
assign i_wr_control_ff_scanin[14]=i_wr_control_ff_scanout[13];
assign i_wr_control_ff_scanin[15]=i_wr_control_ff_scanout[14];
assign i_restore_ff_scanin[1]=i_wr_control_ff_scanout[15];
assign i_restore_ff_scanin[0]=i_restore_ff_scanout[1];
assign i_restore_ff_scanin[2]=i_restore_ff_scanout[0];
assign i_restore_ff_scanin[3]=i_restore_ff_scanout[2];
assign i_restore_ff_scanin[4]=i_restore_ff_scanout[3];
assign i_restore_ff_scanin[6]=i_restore_ff_scanout[4];
assign i_restore_ff_scanin[5]=i_restore_ff_scanout[6];
assign i_restore_ff_scanin[11]=i_restore_ff_scanout[5];
assign i_restore_ff_scanin[10]=i_restore_ff_scanout[11];
assign i_restore_ff_scanin[9]=i_restore_ff_scanout[10];
assign i_restore_ff_scanin[8]=i_restore_ff_scanout[9];
assign i_restore_ff_scanin[7]=i_restore_ff_scanout[8];
assign i_restore_ff_scanin[12]=i_restore_ff_scanout[7];
assign i_restore_ff_scanin[13]=i_restore_ff_scanout[12];
assign i_restore_ff_scanin[14]=i_restore_ff_scanout[13];
assign i_restore_ff_scanin[15]=i_restore_ff_scanout[14];
assign i_restore_ff_scanin[16]=i_restore_ff_scanout[15];
assign i_save_ff_scanin[1]=i_restore_ff_scanout[16];
assign i_save_ff_scanin[0]=i_save_ff_scanout[1];
assign i_save_ff_scanin[2]=i_save_ff_scanout[0];
assign i_save_ff_scanin[3]=i_save_ff_scanout[2];
assign i_save_ff_scanin[4]=i_save_ff_scanout[3];
assign i_save_ff_scanin[6]=i_save_ff_scanout[4];
assign i_save_ff_scanin[5]=i_save_ff_scanout[6];
assign i_save_ff_scanin[11]=i_save_ff_scanout[5];
assign i_save_ff_scanin[10]=i_save_ff_scanout[11];
assign i_save_ff_scanin[9]=i_save_ff_scanout[10];
assign i_save_ff_scanin[8]=i_save_ff_scanout[9];
assign i_save_ff_scanin[7]=i_save_ff_scanout[8];
assign i_save_ff_scanin[12]=i_save_ff_scanout[7];
assign i_save_ff_scanin[13]=i_save_ff_scanout[12];
assign i_save_ff_scanin[14]=i_save_ff_scanout[13];
assign i_save_ff_scanin[15]=i_save_ff_scanout[14];
assign i_save_ff_scanin[16]=i_save_ff_scanout[15];
assign i_wr_data_2nd_p0_ff_scanin[0]=i_save_ff_scanout[16];
assign i_wr_data_2nd_p1_ff_scanin[0]=i_wr_data_2nd_p0_ff_scanout[0];
assign i_wr_data_2nd_p0_ff_scanin[1]=i_wr_data_2nd_p1_ff_scanout[0];
assign i_wr_data_2nd_p1_ff_scanin[1]=i_wr_data_2nd_p0_ff_scanout[1];
assign i_wr_data_2nd_p0_ff_scanin[2]=i_wr_data_2nd_p1_ff_scanout[1];
assign i_wr_data_2nd_p1_ff_scanin[2]=i_wr_data_2nd_p0_ff_scanout[2];
assign i_wr_data_2nd_p0_ff_scanin[3]=i_wr_data_2nd_p1_ff_scanout[2];
assign i_wr_data_2nd_p1_ff_scanin[3]=i_wr_data_2nd_p0_ff_scanout[3];
assign i_wr_data_2nd_p0_ff_scanin[4]=i_wr_data_2nd_p1_ff_scanout[3];
assign i_wr_data_2nd_p1_ff_scanin[4]=i_wr_data_2nd_p0_ff_scanout[4];
assign i_wr_data_2nd_p0_ff_scanin[5]=i_wr_data_2nd_p1_ff_scanout[4];
assign i_wr_data_2nd_p1_ff_scanin[5]=i_wr_data_2nd_p0_ff_scanout[5];
assign i_wr_data_2nd_p0_ff_scanin[6]=i_wr_data_2nd_p1_ff_scanout[5];
assign i_wr_data_2nd_p1_ff_scanin[6]=i_wr_data_2nd_p0_ff_scanout[6];
assign i_wr_data_2nd_p0_ff_scanin[7]=i_wr_data_2nd_p1_ff_scanout[6];
assign i_wr_data_2nd_p1_ff_scanin[7]=i_wr_data_2nd_p0_ff_scanout[7];
assign i_wr_data_2nd_p0_ff_scanin[8]=i_wr_data_2nd_p1_ff_scanout[7];
assign i_wr_data_2nd_p1_ff_scanin[8]=i_wr_data_2nd_p0_ff_scanout[8];
assign i_wr_data_2nd_p0_ff_scanin[9]=i_wr_data_2nd_p1_ff_scanout[8];
assign i_wr_data_2nd_p1_ff_scanin[9]=i_wr_data_2nd_p0_ff_scanout[9];
assign i_wr_data_2nd_p0_ff_scanin[10]=i_wr_data_2nd_p1_ff_scanout[9];
assign i_wr_data_2nd_p1_ff_scanin[10]=i_wr_data_2nd_p0_ff_scanout[10];
assign i_wr_data_2nd_p0_ff_scanin[11]=i_wr_data_2nd_p1_ff_scanout[10];
assign i_wr_data_2nd_p1_ff_scanin[11]=i_wr_data_2nd_p0_ff_scanout[11];
assign i_wr_data_2nd_p0_ff_scanin[12]=i_wr_data_2nd_p1_ff_scanout[11];
assign i_wr_data_2nd_p1_ff_scanin[12]=i_wr_data_2nd_p0_ff_scanout[12];
assign i_wr_data_2nd_p0_ff_scanin[13]=i_wr_data_2nd_p1_ff_scanout[12];
assign i_wr_data_2nd_p1_ff_scanin[13]=i_wr_data_2nd_p0_ff_scanout[13];
assign i_wr_data_2nd_p0_ff_scanin[14]=i_wr_data_2nd_p1_ff_scanout[13];
assign i_wr_data_2nd_p1_ff_scanin[14]=i_wr_data_2nd_p0_ff_scanout[14];
assign i_wr_data_2nd_p0_ff_scanin[15]=i_wr_data_2nd_p1_ff_scanout[14];
assign i_wr_data_2nd_p1_ff_scanin[15]=i_wr_data_2nd_p0_ff_scanout[15];
assign i_wr_data_2nd_p0_ff_scanin[16]=i_wr_data_2nd_p1_ff_scanout[15];
assign i_wr_data_2nd_p1_ff_scanin[16]=i_wr_data_2nd_p0_ff_scanout[16];
assign i_wr_data_2nd_p0_ff_scanin[17]=i_wr_data_2nd_p1_ff_scanout[16];
assign i_wr_data_2nd_p1_ff_scanin[17]=i_wr_data_2nd_p0_ff_scanout[17];
assign i_wr_data_2nd_p0_ff_scanin[18]=i_wr_data_2nd_p1_ff_scanout[17];
assign i_wr_data_2nd_p1_ff_scanin[18]=i_wr_data_2nd_p0_ff_scanout[18];
assign i_wr_data_2nd_p0_ff_scanin[19]=i_wr_data_2nd_p1_ff_scanout[18];
assign i_wr_data_2nd_p1_ff_scanin[19]=i_wr_data_2nd_p0_ff_scanout[19];
assign i_wr_data_2nd_p0_ff_scanin[20]=i_wr_data_2nd_p1_ff_scanout[19];
assign i_wr_data_2nd_p1_ff_scanin[20]=i_wr_data_2nd_p0_ff_scanout[20];
assign i_wr_data_2nd_p0_ff_scanin[21]=i_wr_data_2nd_p1_ff_scanout[20];
assign i_wr_data_2nd_p1_ff_scanin[21]=i_wr_data_2nd_p0_ff_scanout[21];
assign i_wr_data_2nd_p0_ff_scanin[22]=i_wr_data_2nd_p1_ff_scanout[21];
assign i_wr_data_2nd_p1_ff_scanin[22]=i_wr_data_2nd_p0_ff_scanout[22];
assign i_wr_data_2nd_p0_ff_scanin[23]=i_wr_data_2nd_p1_ff_scanout[22];
assign i_wr_data_2nd_p1_ff_scanin[23]=i_wr_data_2nd_p0_ff_scanout[23];
assign i_wr_data_2nd_p0_ff_scanin[24]=i_wr_data_2nd_p1_ff_scanout[23];
assign i_wr_data_2nd_p1_ff_scanin[24]=i_wr_data_2nd_p0_ff_scanout[24];
assign i_wr_data_2nd_p0_ff_scanin[25]=i_wr_data_2nd_p1_ff_scanout[24];
assign i_wr_data_2nd_p1_ff_scanin[25]=i_wr_data_2nd_p0_ff_scanout[25];
assign i_wr_data_2nd_p0_ff_scanin[26]=i_wr_data_2nd_p1_ff_scanout[25];
assign i_wr_data_2nd_p1_ff_scanin[26]=i_wr_data_2nd_p0_ff_scanout[26];
assign i_wr_data_2nd_p0_ff_scanin[27]=i_wr_data_2nd_p1_ff_scanout[26];
assign i_wr_data_2nd_p1_ff_scanin[27]=i_wr_data_2nd_p0_ff_scanout[27];
assign i_wr_data_2nd_p0_ff_scanin[28]=i_wr_data_2nd_p1_ff_scanout[27];
assign i_wr_data_2nd_p1_ff_scanin[28]=i_wr_data_2nd_p0_ff_scanout[28];
assign i_wr_data_2nd_p0_ff_scanin[29]=i_wr_data_2nd_p1_ff_scanout[28];
assign i_wr_data_2nd_p1_ff_scanin[29]=i_wr_data_2nd_p0_ff_scanout[29];
assign i_wr_data_2nd_p0_ff_scanin[30]=i_wr_data_2nd_p1_ff_scanout[29];
assign i_wr_data_2nd_p1_ff_scanin[30]=i_wr_data_2nd_p0_ff_scanout[30];
assign i_wr_data_2nd_p0_ff_scanin[31]=i_wr_data_2nd_p1_ff_scanout[30];
assign i_wr_data_2nd_p1_ff_scanin[31]=i_wr_data_2nd_p0_ff_scanout[31];
assign i_wr_data_2nd_p0_ff_scanin[32]=i_wr_data_2nd_p1_ff_scanout[31];
assign i_wr_data_2nd_p1_ff_scanin[32]=i_wr_data_2nd_p0_ff_scanout[32];
assign i_wr_data_2nd_p0_ff_scanin[33]=i_wr_data_2nd_p1_ff_scanout[32];
assign i_wr_data_2nd_p1_ff_scanin[33]=i_wr_data_2nd_p0_ff_scanout[33];
assign i_wr_data_2nd_p0_ff_scanin[34]=i_wr_data_2nd_p1_ff_scanout[33];
assign i_wr_data_2nd_p1_ff_scanin[34]=i_wr_data_2nd_p0_ff_scanout[34];
assign i_wr_data_2nd_p0_ff_scanin[35]=i_wr_data_2nd_p1_ff_scanout[34];
assign i_wr_data_2nd_p1_ff_scanin[35]=i_wr_data_2nd_p0_ff_scanout[35];
assign scan_out=i_wr_data_2nd_p1_ff_scanout[35];
// fixscan end

`ifndef FPGA
// synopsys translate_on
`endif

endmodule






// any PARAMS parms go into naming of macro

module n2_irf_mp_128x72_cust_l1clkhdr_ctl_macro (
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

module n2_irf_mp_128x72_cust_msff_ctl_macro__fs_1__width_36 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [35:0] fdin;

  input [35:0] din;
  input l1clk;
  input [35:0] scan_in;


  input siclk;
  input soclk;

  output [35:0] dout;
  output [35:0] scan_out;
assign fdin[35:0] = din[35:0];






dff #(36)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[35:0]),
.si(scan_in[35:0]),
.so(scan_out[35:0]),
.q(dout[35:0])
);












endmodule









//
//   macro for cl_mc1_sram_msff_mo_{16,8,4}x flops
//
//





module n2_irf_mp_128x72_cust_sram_msff_mo_macro__fs_1__width_20 (
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
input [19:0] d;
  input [19:0] scan_in;
input l1clk;
input and_clk;
input siclk;
input soclk;
output [19:0] mq;
output [19:0] mq_l;
  output [19:0] scan_out;
output [19:0] q;
output [19:0] q_l;






new_dlata #(20)  d0_0 (
.d(d[19:0]),
.si(scan_in[19:0]),
.so(scan_out[19:0]),
.l1clk(l1clk),
.and_clk(and_clk),
.siclk(siclk),
.soclk(soclk),
.q(q[19:0]),
.q_l(q_l[19:0]),
.mq(mq[19:0]),
.mq_l(mq_l[19:0])
);










//place::generic_place($width,$stack,$left);

endmodule









// any PARAMS parms go into naming of macro

module n2_irf_mp_128x72_cust_msff_ctl_macro__fs_1__width_16 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [15:0] fdin;

  input [15:0] din;
  input l1clk;
  input [15:0] scan_in;


  input siclk;
  input soclk;

  output [15:0] dout;
  output [15:0] scan_out;
assign fdin[15:0] = din[15:0];






dff #(16)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[15:0]),
.si(scan_in[15:0]),
.so(scan_out[15:0]),
.q(dout[15:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_irf_mp_128x72_cust_msff_ctl_macro__fs_1__width_17 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [16:0] fdin;

  input [16:0] din;
  input l1clk;
  input [16:0] scan_in;


  input siclk;
  input soclk;

  output [16:0] dout;
  output [16:0] scan_out;
assign fdin[16:0] = din[16:0];






dff #(17)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[16:0]),
.si(scan_in[16:0]),
.so(scan_out[16:0]),
.q(dout[16:0])
);












endmodule






`ifndef FPGA

module exu_irf_array (
  clk, 
  tcu_array_wr_inhibit, 
  a_rd_en_p0, 
  a_rd_en_p1, 
  a_rd_en_p2, 
  a_rd_tid, 
  a_rd_addr_p0, 
  a_rd_addr_p1, 
  a_rd_addr_p2, 
  a_wr_en_p0, 
  a_wr_tid_p0, 
  a_wr_addr_p0, 
  a_wr_data_p0, 
  a_wr_en_p1, 
  a_wr_tid_p1, 
  a_wr_addr_p1, 
  a_wr_data_p1, 
  a_save_tid, 
  a_save_global_tid, 
  a_save_global_addr, 
  a_save_even_addr, 
  a_save_local_addr, 
  a_save_odd_addr, 
  a_save_global_en, 
  a_save_even_en, 
  a_save_local_en, 
  a_save_odd_en, 
  a_restore_tid, 
  a_restore_global_tid, 
  a_restore_global_addr, 
  a_restore_even_addr, 
  a_restore_odd_addr, 
  a_restore_local_addr, 
  a_restore_global_en, 
  a_restore_even_en, 
  a_restore_local_en, 
  a_restore_odd_en, 
  a_rd_data_p0, 
  a_rd_data_p1, 
  a_rd_data_p2);
wire [6:0] thr_rs1;
wire [6:0] thr_rs2;
wire [6:0] thr_rs3;
wire [6:0] thr_rd_w;
wire [6:0] thr_rd_w2;
wire rd_en_p0;
wire rd_en_p1;
wire rd_en_p2;
wire wr_en_p0;
wire wr_en_p1;
wire p0_rd_eq_wr;
wire p1_rd_eq_wr;
wire p2_rd_eq_wr;


input		clk;

input		tcu_array_wr_inhibit;

input		a_rd_en_p0;
input		a_rd_en_p1;
input		a_rd_en_p2;
input  [1:0]	a_rd_tid;
input  [4:0]	a_rd_addr_p0;
input  [4:0]	a_rd_addr_p1;
input  [4:0]	a_rd_addr_p2;

input		a_wr_en_p0;
input  [1:0]	a_wr_tid_p0;
input  [4:0]	a_wr_addr_p0;
input  [71:0]	a_wr_data_p0;

input		a_wr_en_p1;
input  [1:0]	a_wr_tid_p1;
input  [4:0]	a_wr_addr_p1;
input  [71:0]	a_wr_data_p1;


input  [1:0]	a_save_tid;
input  [1:0]	a_save_global_tid;
input  [1:0]	a_save_global_addr;
input  [2:1]	a_save_even_addr;
input  [2:0]	a_save_local_addr;
input  [2:1]	a_save_odd_addr;
input		a_save_global_en;
input		a_save_even_en;
input		a_save_local_en;
input		a_save_odd_en;

input  [1:0]	a_restore_tid;
input  [1:0]	a_restore_global_tid;
input  [1:0]	a_restore_global_addr;
input  [2:1]	a_restore_even_addr;
input  [2:1]	a_restore_odd_addr;
input  [2:0]	a_restore_local_addr;
input		a_restore_global_en;
input		a_restore_even_en;
input		a_restore_local_en;
input		a_restore_odd_en;


output [71:0]	a_rd_data_p0;
output [71:0]	a_rd_data_p1;
output [71:0]	a_rd_data_p2;




   reg [71:0]	active_window[127:0];		// Physical active array : 4(thread) x 32(reg) x 72 bit registers

   reg [71:0]	locals[255:0];			// Physical shadow array : 4(thread) x  8(reg) x 8(shadow)
   reg [71:0]	evens[127:0];			// Physical shadow array : 4(thread) x  8(reg) x 4(shadow)
   reg [71:0]	odds[127:0];			// Physical shadow array : 4(thread) x  8(reg) x 4(shadow)
   reg [71:0]	globals[127:0];			// Physical shadow array : 4(thread) x  8(reg) x 4(shadow)


   integer 	i;				// *** Temporary array      index (no physical flops involved) ***

   reg [71:0]	rd_data_p0;			// *** Temporary array read regs  (no physical flops involved) ***
   reg [71:0]	rd_data_p1;			// *** Temporary array read regs  (no physical flops involved) ***
   reg [71:0]	rd_data_p2;			// *** Temporary array read regs  (no physical flops involved) ***


// For Axis, make synthesizable by making all writes to active_window occur at negedge (normal write and restore)
// Reads of active occur at both edges (read and save)





   // -----------------------------------------------------------------------
   // *** initialization section ***
   // -----------------------------------------------------------------------

   initial begin
       active_window[0]  = {72{1'b0}};		// TID=0 G0 location is always ZERO - location is tied to ground, no memory cell at this address
       active_window[32] = {72{1'b0}};		// TID=1 G0 location is always ZERO - location is tied to ground, no memory cell at this address
       active_window[64] = {72{1'b0}};		// TID=2 G0 location is always ZERO - location is tied to ground, no memory cell at this address
       active_window[96] = {72{1'b0}};		// TID=3 G0 location is always ZERO - location is tied to ground, no memory cell at this address
   end


`ifndef NOINITMEM
   initial begin
     for (i=0; i<128; i=i+1) begin
       active_window[i] = {72{1'b0}};
       evens[i]         = {72{1'b0}};
       odds[i]          = {72{1'b0}};
       globals[i]       = {72{1'b0}};
       locals[i]        = {72{1'b0}};
       locals[i+128]    = {72{1'b0}};
     end
   end
`endif



 
// Concatenate the thread and index bits together

assign thr_rs1[6:0]	= {a_rd_tid[1:0]   , a_rd_addr_p0[4:0] };
assign thr_rs2[6:0]	= {a_rd_tid[1:0]   , a_rd_addr_p1[4:0] };
assign thr_rs3[6:0]	= {a_rd_tid[1:0]   , a_rd_addr_p2[4:0] };
assign thr_rd_w[6:0]	= {a_wr_tid_p0[1:0], a_wr_addr_p0[4:0] };
assign thr_rd_w2[6:0]	= {a_wr_tid_p1[1:0], a_wr_addr_p1[4:0] };


// Clear read enables if reading G0; clear write enables if writing G0;

assign rd_en_p0		= a_rd_en_p0 & (thr_rs1[4:0]   != 5'b00000) & ~tcu_array_wr_inhibit;
assign rd_en_p1		= a_rd_en_p1 & (thr_rs2[4:0]   != 5'b00000) & ~tcu_array_wr_inhibit;
assign rd_en_p2		= a_rd_en_p2 & (thr_rs3[4:0]   != 5'b00000) & ~tcu_array_wr_inhibit;

assign wr_en_p0		= a_wr_en_p0 & (thr_rd_w[4:0]  != 5'b00000) & ~tcu_array_wr_inhibit;
assign wr_en_p1		= a_wr_en_p1 & (thr_rd_w2[4:0] != 5'b00000) & ~tcu_array_wr_inhibit;

assign p0_rd_eq_wr	= (wr_en_p0 & (thr_rs1[6:0] == thr_rd_w[6:0])) | (wr_en_p1 & (thr_rs1[6:0] == thr_rd_w2[6:0]));
assign p1_rd_eq_wr	= (wr_en_p0 & (thr_rs2[6:0] == thr_rd_w[6:0])) | (wr_en_p1 & (thr_rs2[6:0] == thr_rd_w2[6:0]));
assign p2_rd_eq_wr	= (wr_en_p0 & (thr_rs3[6:0] == thr_rd_w[6:0])) | (wr_en_p1 & (thr_rs3[6:0] == thr_rd_w2[6:0]));



   always @ (clk or rd_en_p0 or rd_en_p1 or rd_en_p2 or thr_rs1 or thr_rs2 or thr_rs3 or p0_rd_eq_wr or p1_rd_eq_wr or p2_rd_eq_wr)

      begin

	if (clk)
	  begin 
	    if (rd_en_p0)
	      begin
	        if (p0_rd_eq_wr)	rd_data_p0[71:0] 	<= {72{1'bx}};
	        else			rd_data_p0[71:0]	<= active_window[thr_rs1[6:0]];
	      end
	    else			rd_data_p0[71:0] 	<= {72{1'b0}};


	    if (rd_en_p1)
	      begin
	        if (p1_rd_eq_wr)	rd_data_p1[71:0] 	<= {72{1'bx}};
	        else			rd_data_p1[71:0]	<= active_window[thr_rs2[6:0]];
	      end
	    else			rd_data_p1[71:0] 	<= {72{1'b0}};


	    if (rd_en_p2)
	      begin
	        if (p2_rd_eq_wr)	rd_data_p2[71:0] 	<= {72{1'bx}};
	        else			rd_data_p2[71:0]	<= active_window[thr_rs3[6:0]];
	      end
	    else			rd_data_p2[71:0] 	<= {72{1'b0}};

        end

      end		// ALWAYS CLK ...




   always @ (negedge clk)

      begin

	if (wr_en_p0)	active_window[thr_rd_w[6:0]]	<= a_wr_data_p0[71:0];

	if (wr_en_p1)	active_window[thr_rd_w2[6:0]]	<= a_wr_data_p1[71:0];























      end		// NEGEDGE ALWAYS



 
   /////////////////////////////////////////////
   // Globals
   //-----------------------------------
   // rml inputs are latched on rising edge
   // 1st cycle used for decode
   // 2nd cycle stores active window in phase 1
   // 3rd cycle loads new globals in phase 1
   /////////////////////////////////////////////

   ////////////////////////////
   // locals, ins and outs
   //-------------------------
   // E - set up inputs to flop
   // M - Decode
   // W  (phase 1) - Save
   // W  (phase 2) - write is allowed for save because restore will get killed
   // W2 (phase 1) - Restore
   // W2 (phase 2) - write is allowed
   //
   // actions that occur in phase one are modelled as occurring on the
   // rising edge
   //
   // swaps to the same thread in consecutive cycles not allowed
   /////////////////////////////


   // For synthesis, flop inputs again, then do write of active window on negedge...
   always @ (posedge clk) begin






       // *** *** *** *** *** *** *** *** *** SAVE *** *** *** *** *** *** *** *** ***


       if (a_save_global_en & ~tcu_array_wr_inhibit) begin		// save the globals (0-7 in active window)

          globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b000}]	<= active_window[{a_save_global_tid[1:0], 5'b00000}];
          globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b001}]	<= active_window[{a_save_global_tid[1:0], 5'b00001}];
          globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b010}]	<= active_window[{a_save_global_tid[1:0], 5'b00010}];
          globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b011}]	<= active_window[{a_save_global_tid[1:0], 5'b00011}];
          globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b100}]	<= active_window[{a_save_global_tid[1:0], 5'b00100}];
          globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b101}]	<= active_window[{a_save_global_tid[1:0], 5'b00101}];
          globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b110}]	<= active_window[{a_save_global_tid[1:0], 5'b00110}];
          globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b111}]	<= active_window[{a_save_global_tid[1:0], 5'b00111}];

       end


       if (a_save_odd_en & ~tcu_array_wr_inhibit) begin			// save the ins in odd window (8-15 in active window)

          odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b000}]			<= active_window[{a_save_tid[1:0], 5'b01000}];
          odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b001}]			<= active_window[{a_save_tid[1:0], 5'b01001}];
          odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b010}]			<= active_window[{a_save_tid[1:0], 5'b01010}];
          odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b011}]			<= active_window[{a_save_tid[1:0], 5'b01011}];
          odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b100}]			<= active_window[{a_save_tid[1:0], 5'b01100}];
          odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b101}]			<= active_window[{a_save_tid[1:0], 5'b01101}];
          odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b110}]			<= active_window[{a_save_tid[1:0], 5'b01110}];
          odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b111}]			<= active_window[{a_save_tid[1:0], 5'b01111}];

       end


       if (a_save_local_en & ~tcu_array_wr_inhibit) begin			// save the locals (16-23 in active window)

          locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b000}]		<= active_window[{a_save_tid[1:0], 5'b10000}];
          locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b001}]		<= active_window[{a_save_tid[1:0], 5'b10001}];
          locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b010}]		<= active_window[{a_save_tid[1:0], 5'b10010}];
          locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b011}]		<= active_window[{a_save_tid[1:0], 5'b10011}];
          locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b100}]		<= active_window[{a_save_tid[1:0], 5'b10100}];
          locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b101}]		<= active_window[{a_save_tid[1:0], 5'b10101}];
          locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b110}]		<= active_window[{a_save_tid[1:0], 5'b10110}];
          locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b111}]		<= active_window[{a_save_tid[1:0], 5'b10111}];

       end


       if (a_save_even_en & ~tcu_array_wr_inhibit) begin			// save the ins in even window (24-31 in active window)

          evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b000}]		<= active_window[{a_save_tid[1:0], 5'b11000}];
          evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b001}]		<= active_window[{a_save_tid[1:0], 5'b11001}];
          evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b010}]		<= active_window[{a_save_tid[1:0], 5'b11010}];
          evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b011}]		<= active_window[{a_save_tid[1:0], 5'b11011}];
          evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b100}]		<= active_window[{a_save_tid[1:0], 5'b11100}];
          evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b101}]		<= active_window[{a_save_tid[1:0], 5'b11101}];
          evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b110}]		<= active_window[{a_save_tid[1:0], 5'b11110}];
          evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b111}]		<= active_window[{a_save_tid[1:0], 5'b11111}];

       end




       // *** *** *** *** *** *** *** *** *** RESTORE *** *** *** *** *** *** *** *** ***


       if (a_restore_global_en & ~tcu_array_wr_inhibit) begin		// restore the globals (0-7 in active window)

          active_window[{a_restore_global_tid[1:0], 5'b00000}]			<= globals[{a_restore_global_tid[1:0], a_restore_global_addr[1:0], 3'b000}];
          active_window[{a_restore_global_tid[1:0], 5'b00001}]			<= globals[{a_restore_global_tid[1:0], a_restore_global_addr[1:0], 3'b001}];
          active_window[{a_restore_global_tid[1:0], 5'b00010}]			<= globals[{a_restore_global_tid[1:0], a_restore_global_addr[1:0], 3'b010}];
          active_window[{a_restore_global_tid[1:0], 5'b00011}]			<= globals[{a_restore_global_tid[1:0], a_restore_global_addr[1:0], 3'b011}];
          active_window[{a_restore_global_tid[1:0], 5'b00100}]			<= globals[{a_restore_global_tid[1:0], a_restore_global_addr[1:0], 3'b100}];
          active_window[{a_restore_global_tid[1:0], 5'b00101}]			<= globals[{a_restore_global_tid[1:0], a_restore_global_addr[1:0], 3'b101}];
          active_window[{a_restore_global_tid[1:0], 5'b00110}]			<= globals[{a_restore_global_tid[1:0], a_restore_global_addr[1:0], 3'b110}];
          active_window[{a_restore_global_tid[1:0], 5'b00111}]			<= globals[{a_restore_global_tid[1:0], a_restore_global_addr[1:0], 3'b111}];

       end


       if (a_restore_odd_en & ~tcu_array_wr_inhibit) begin			// restore the ins in odd window (8-15 in active window)

         active_window[{a_restore_tid[1:0], 5'b01000}]				<= odds[{a_restore_tid[1:0], a_restore_odd_addr[2:1], 3'b000}];
         active_window[{a_restore_tid[1:0], 5'b01001}]				<= odds[{a_restore_tid[1:0], a_restore_odd_addr[2:1], 3'b001}];
         active_window[{a_restore_tid[1:0], 5'b01010}]				<= odds[{a_restore_tid[1:0], a_restore_odd_addr[2:1], 3'b010}];
         active_window[{a_restore_tid[1:0], 5'b01011}]				<= odds[{a_restore_tid[1:0], a_restore_odd_addr[2:1], 3'b011}];
         active_window[{a_restore_tid[1:0], 5'b01100}]				<= odds[{a_restore_tid[1:0], a_restore_odd_addr[2:1], 3'b100}];
         active_window[{a_restore_tid[1:0], 5'b01101}]				<= odds[{a_restore_tid[1:0], a_restore_odd_addr[2:1], 3'b101}];
         active_window[{a_restore_tid[1:0], 5'b01110}]				<= odds[{a_restore_tid[1:0], a_restore_odd_addr[2:1], 3'b110}];
         active_window[{a_restore_tid[1:0], 5'b01111}]				<= odds[{a_restore_tid[1:0], a_restore_odd_addr[2:1], 3'b111}];

       end


       if (a_restore_local_en & ~tcu_array_wr_inhibit) begin			// restore the locals (16-23 in active window)

         active_window[{a_restore_tid[1:0], 5'b10000}]				<= locals[{a_restore_tid[1:0], a_restore_local_addr[2:0], 3'b000}];
         active_window[{a_restore_tid[1:0], 5'b10001}]				<= locals[{a_restore_tid[1:0], a_restore_local_addr[2:0], 3'b001}];
         active_window[{a_restore_tid[1:0], 5'b10010}]				<= locals[{a_restore_tid[1:0], a_restore_local_addr[2:0], 3'b010}];
         active_window[{a_restore_tid[1:0], 5'b10011}]				<= locals[{a_restore_tid[1:0], a_restore_local_addr[2:0], 3'b011}];
         active_window[{a_restore_tid[1:0], 5'b10100}]				<= locals[{a_restore_tid[1:0], a_restore_local_addr[2:0], 3'b100}];
         active_window[{a_restore_tid[1:0], 5'b10101}]				<= locals[{a_restore_tid[1:0], a_restore_local_addr[2:0], 3'b101}];
         active_window[{a_restore_tid[1:0], 5'b10110}]				<= locals[{a_restore_tid[1:0], a_restore_local_addr[2:0], 3'b110}];
         active_window[{a_restore_tid[1:0], 5'b10111}]				<= locals[{a_restore_tid[1:0], a_restore_local_addr[2:0], 3'b111}];

       end


       if (a_restore_even_en & ~tcu_array_wr_inhibit) begin			// restore the ins in even window (24-31 in active window)

         active_window[{a_restore_tid[1:0], 5'b11000}]				<= evens[{a_restore_tid[1:0], a_restore_even_addr[2:1], 3'b000}];
         active_window[{a_restore_tid[1:0], 5'b11001}]				<= evens[{a_restore_tid[1:0], a_restore_even_addr[2:1], 3'b001}];
         active_window[{a_restore_tid[1:0], 5'b11010}]				<= evens[{a_restore_tid[1:0], a_restore_even_addr[2:1], 3'b010}];
         active_window[{a_restore_tid[1:0], 5'b11011}]				<= evens[{a_restore_tid[1:0], a_restore_even_addr[2:1], 3'b011}];
         active_window[{a_restore_tid[1:0], 5'b11100}]				<= evens[{a_restore_tid[1:0], a_restore_even_addr[2:1], 3'b100}];
         active_window[{a_restore_tid[1:0], 5'b11101}]				<= evens[{a_restore_tid[1:0], a_restore_even_addr[2:1], 3'b101}];
         active_window[{a_restore_tid[1:0], 5'b11110}]				<= evens[{a_restore_tid[1:0], a_restore_even_addr[2:1], 3'b110}];
         active_window[{a_restore_tid[1:0], 5'b11111}]				<= evens[{a_restore_tid[1:0], a_restore_even_addr[2:1], 3'b111}];

       end


    end		// POSEDGE ALWAYS


assign a_rd_data_p0[71:0]	= rd_data_p0[71:0];
assign a_rd_data_p1[71:0]	= rd_data_p1[71:0];
assign a_rd_data_p2[71:0]	= rd_data_p2[71:0];


supply0 vss;
supply1 vdd;

endmodule
`endif // `ifndef FPGA


`ifdef FPGA

module exu_irf_array(clk, tcu_array_wr_inhibit, a_rd_en_p0, a_rd_en_p1, 
	a_rd_en_p2, a_rd_tid, a_rd_addr_p0, a_rd_addr_p1, a_rd_addr_p2, 
	a_wr_en_p0, a_wr_tid_p0, a_wr_addr_p0, a_wr_data_p0, a_wr_en_p1, 
	a_wr_tid_p1, a_wr_addr_p1, a_wr_data_p1, a_save_tid, a_save_global_tid, 
	a_save_global_addr, a_save_even_addr, a_save_local_addr, 
	a_save_odd_addr, a_save_global_en, a_save_even_en, a_save_local_en, 
	a_save_odd_en, a_restore_tid, a_restore_global_tid, 
	a_restore_global_addr, a_restore_even_addr, a_restore_odd_addr, 
	a_restore_local_addr, a_restore_global_en, a_restore_even_en, 
	a_restore_local_en, a_restore_odd_en, a_rd_data_p0, a_rd_data_p1, 
	a_rd_data_p2);

	input			clk;
	input			tcu_array_wr_inhibit;
	input			a_rd_en_p0;
	input			a_rd_en_p1;
	input			a_rd_en_p2;
	input	[1:0]		a_rd_tid;
	input	[4:0]		a_rd_addr_p0;
	input	[4:0]		a_rd_addr_p1;
	input	[4:0]		a_rd_addr_p2;
	input			a_wr_en_p0;
	input	[1:0]		a_wr_tid_p0;
	input	[4:0]		a_wr_addr_p0;
	input	[71:0]		a_wr_data_p0;
	input			a_wr_en_p1;
	input	[1:0]		a_wr_tid_p1;
	input	[4:0]		a_wr_addr_p1;
	input	[71:0]		a_wr_data_p1;
	input	[1:0]		a_save_tid;
	input	[1:0]		a_save_global_tid;
	input	[1:0]		a_save_global_addr;
	input	[2:1]		a_save_even_addr;
	input	[2:0]		a_save_local_addr;
	input	[2:1]		a_save_odd_addr;
	input			a_save_global_en;
	input			a_save_even_en;
	input			a_save_local_en;
	input			a_save_odd_en;
	input	[1:0]		a_restore_tid;
	input	[1:0]		a_restore_global_tid;
	input	[1:0]		a_restore_global_addr;
	input	[2:1]		a_restore_even_addr;
	input	[2:1]		a_restore_odd_addr;
	input	[2:0]		a_restore_local_addr;
	input			a_restore_global_en;
	input			a_restore_even_en;
	input			a_restore_local_en;
	input			a_restore_odd_en;
	output	[71:0]		a_rd_data_p0;
	output	[71:0]		a_rd_data_p1;
	output	[71:0]		a_rd_data_p2;

	wire	[6:0]		thr_rs1;
	wire	[6:0]		thr_rs2;
	wire	[6:0]		thr_rs3;
	wire	[6:0]		thr_rd_w;
	wire	[6:0]		thr_rd_w2;
	wire			rd_en_p0;
	wire			rd_en_p1;
	wire			rd_en_p2;
	wire			wr_en_p0;
	wire			wr_en_p1;
	wire			p0_rd_eq_wr;
	wire			p1_rd_eq_wr;
	wire			p2_rd_eq_wr;

        reg     [71:0]          active_window[127:0];
        reg     [71:0]          locals[255:0];
        reg     [71:0]          evens[127:0];
        reg     [71:0]          odds[127:0];
        reg     [71:0]          globals[127:0];
	integer			i;
	reg	[71:0]		rd_data_p0;
	reg	[71:0]		rd_data_p1;
	reg	[71:0]		rd_data_p2;
	reg	[1:0]		a_restore_global_tid_d1;
	reg	[1:0]		a_restore_tid_d1;
	reg	[1:0]		a_restore_global_addr_d1;
	reg	[2:1]		a_restore_odd_addr_d1;
	reg	[2:1]		a_restore_even_addr_d1;
	reg	[2:0]		a_restore_local_addr_d1;
	reg			a_save_global_en_d1;
	reg			tcu_array_wr_inhibit_d1;
	reg			a_save_odd_en_d1;
	reg			a_save_local_en_d1;
	reg			a_save_even_en_d1;
	reg			a_restore_global_en_d1;
	reg			a_restore_odd_en_d1;
	reg			a_restore_local_en_d1;
	reg			a_restore_even_en_d1;
	supply0			vss;
	supply1			vdd;


        assign thr_rs1[6:0] = {a_rd_tid[1:0], a_rd_addr_p0[4:0]};
        assign thr_rs2[6:0] = {a_rd_tid[1:0], a_rd_addr_p1[4:0]};
        assign thr_rs3[6:0] = {a_rd_tid[1:0], a_rd_addr_p2[4:0]};
        assign thr_rd_w[6:0] = {a_wr_tid_p0[1:0], a_wr_addr_p0[4:0]};
        assign thr_rd_w2[6:0] = {a_wr_tid_p1[1:0], a_wr_addr_p1[4:0]};




	assign rd_en_p0 = ((a_rd_en_p0 & (thr_rs1[4:0] != 5'b0)) & (~
		tcu_array_wr_inhibit));
	assign rd_en_p1 = ((a_rd_en_p1 & (thr_rs2[4:0] != 5'b0)) & (~
		tcu_array_wr_inhibit));
	assign rd_en_p2 = ((a_rd_en_p2 & (thr_rs3[4:0] != 5'b0)) & (~
		tcu_array_wr_inhibit));
	assign wr_en_p0 = ((a_wr_en_p0 & (thr_rd_w[4:0] != 5'b0)) & (~
		tcu_array_wr_inhibit));
	assign wr_en_p1 = ((a_wr_en_p1 & (thr_rd_w2[4:0] != 5'b0)) & (~
		tcu_array_wr_inhibit));
	assign p0_rd_eq_wr = ((wr_en_p0 & (thr_rs1[6:0] == thr_rd_w[6:0])) | (
		wr_en_p1 & (thr_rs1[6:0] == thr_rd_w2[6:0])));
	assign p1_rd_eq_wr = ((wr_en_p0 & (thr_rs2[6:0] == thr_rd_w[6:0])) | (
		wr_en_p1 & (thr_rs2[6:0] == thr_rd_w2[6:0])));
	assign p2_rd_eq_wr = ((wr_en_p0 & (thr_rs3[6:0] == thr_rd_w[6:0])) | (
		wr_en_p1 & (thr_rs3[6:0] == thr_rd_w2[6:0])));
	assign a_rd_data_p0[71:0] = rd_data_p0[71:0];
	assign a_rd_data_p1[71:0] = rd_data_p1[71:0];
	assign a_rd_data_p2[71:0] = rd_data_p2[71:0];

	initial begin
	  active_window[0] = {72 {1'b0}};
	  active_window[32] = {72 {1'b0}};
	  active_window[64] = {72 {1'b0}};
	  active_window[96] = {72 {1'b0}};
	end
	initial begin
	  for (i = 0; (i < 128); i = (i + 1)) begin
	    active_window[i] = {72 {1'b0}};
	    evens[i] = {72 {1'b0}};
	    odds[i] = {72 {1'b0}};
	    globals[i] = {72 {1'b0}};
	    locals[i] = {72 {1'b0}};
	    locals[(i + 128)] = {72 {1'b0}};
	  end
	end
	always @(clk or rd_en_p0 or rd_en_p1 or rd_en_p2 or thr_rs1 or thr_rs2
		or thr_rs3 or p0_rd_eq_wr or p1_rd_eq_wr or p2_rd_eq_wr) begin
	  if (clk) begin
	    if (rd_en_p0) begin
	      if (p0_rd_eq_wr) begin
		rd_data_p0[71:0] <= {72 {1'bx}};
	      end
	      else begin
		rd_data_p0[71:0] <= active_window[thr_rs1[6:0]];
	      end
	    end
	    else begin
	      rd_data_p0[71:0] <= {72 {1'b0}};
	    end
	    if (rd_en_p1) begin
	      if (p1_rd_eq_wr) begin
		rd_data_p1[71:0] <= {72 {1'bx}};
	      end
	      else begin
		rd_data_p1[71:0] <= active_window[thr_rs2[6:0]];
	      end
	    end
	    else begin
	      rd_data_p1[71:0] <= {72 {1'b0}};
	    end
	    if (rd_en_p2) begin
	      if (p2_rd_eq_wr) begin
		rd_data_p2[71:0] <= {72 {1'bx}};
	      end
	      else begin
		rd_data_p2[71:0] <= active_window[thr_rs3[6:0]];
	      end
	    end
	    else begin
	      rd_data_p2[71:0] <= {72 {1'b0}};
	    end
	  end
	end
	always @(negedge clk) begin
	  if (wr_en_p0) begin
	    active_window[thr_rd_w[6:0]] <= a_wr_data_p0[71:0];
	  end
	  if (wr_en_p1) begin
	    active_window[thr_rd_w2[6:0]] <= a_wr_data_p1[71:0];
	  end
	  if (a_restore_global_en_d1 & (~tcu_array_wr_inhibit_d1)) begin
	    active_window[{a_restore_global_tid_d1[1:0], 5'b0}] <= 
		    globals[{a_restore_global_tid_d1[1:0],
		    a_restore_global_addr_d1[1:0], 3'b0}];
	    active_window[{a_restore_global_tid_d1[1:0], 5'b1}] <= 
		    globals[{a_restore_global_tid_d1[1:0],
		    a_restore_global_addr_d1[1:0], 3'b1}];
	    active_window[{a_restore_global_tid_d1[1:0], 5'b00010}] <= 
		    globals[{a_restore_global_tid_d1[1:0],
		    a_restore_global_addr_d1[1:0], 3'd2}];
	    active_window[{a_restore_global_tid_d1[1:0], 5'b00011}] <= 
		    globals[{a_restore_global_tid_d1[1:0],
		    a_restore_global_addr_d1[1:0], 3'd3}];
	    active_window[{a_restore_global_tid_d1[1:0], 5'b00100}] <= 
		    globals[{a_restore_global_tid_d1[1:0],
		    a_restore_global_addr_d1[1:0], 3'd4}];
	    active_window[{a_restore_global_tid_d1[1:0], 5'b00101}] <= 
		    globals[{a_restore_global_tid_d1[1:0],
		    a_restore_global_addr_d1[1:0], 3'd5}];
	    active_window[{a_restore_global_tid_d1[1:0], 5'b00110}] <= 
		    globals[{a_restore_global_tid_d1[1:0],
		    a_restore_global_addr_d1[1:0], 3'd6}];
	    active_window[{a_restore_global_tid_d1[1:0], 5'b00111}] <= 
		    globals[{a_restore_global_tid_d1[1:0],
		    a_restore_global_addr_d1[1:0], 3'd7}];
	  end
	  if (a_restore_odd_en_d1 & (~tcu_array_wr_inhibit_d1)) begin
	    active_window[{a_restore_tid_d1[1:0], 5'b01000}] <= 
		    odds[{a_restore_tid_d1[1:0], a_restore_odd_addr_d1[2:1],
		    3'b0}];
	    active_window[{a_restore_tid_d1[1:0], 5'b01001}] <= 
		    odds[{a_restore_tid_d1[1:0], a_restore_odd_addr_d1[2:1],
		    3'b1}];
	    active_window[{a_restore_tid_d1[1:0], 5'b01010}] <= 
		    odds[{a_restore_tid_d1[1:0], a_restore_odd_addr_d1[2:1],
		    3'd2}];
	    active_window[{a_restore_tid_d1[1:0], 5'b01011}] <= 
		    odds[{a_restore_tid_d1[1:0], a_restore_odd_addr_d1[2:1],
		    3'd3}];
	    active_window[{a_restore_tid_d1[1:0], 5'b01100}] <= 
		    odds[{a_restore_tid_d1[1:0], a_restore_odd_addr_d1[2:1],
		    3'd4}];
	    active_window[{a_restore_tid_d1[1:0], 5'b01101}] <= 
		    odds[{a_restore_tid_d1[1:0], a_restore_odd_addr_d1[2:1],
		    3'd5}];
	    active_window[{a_restore_tid_d1[1:0], 5'b01110}] <= 
		    odds[{a_restore_tid_d1[1:0], a_restore_odd_addr_d1[2:1],
		    3'd6}];
	    active_window[{a_restore_tid_d1[1:0], 5'b01111}] <= 
		    odds[{a_restore_tid_d1[1:0], a_restore_odd_addr_d1[2:1],
		    3'd7}];
	  end
	  if (a_restore_local_en_d1 & (~tcu_array_wr_inhibit_d1)) begin
	    active_window[{a_restore_tid_d1[1:0], 5'b10000}] <= 
		    locals[{a_restore_tid_d1[1:0], a_restore_local_addr_d1[2:0],
		    3'b0}];
	    active_window[{a_restore_tid_d1[1:0], 5'b10001}] <= 
		    locals[{a_restore_tid_d1[1:0], a_restore_local_addr_d1[2:0],
		    3'b1}];
	    active_window[{a_restore_tid_d1[1:0], 5'b10010}] <= 
		    locals[{a_restore_tid_d1[1:0], a_restore_local_addr_d1[2:0],
		    3'd2}];
	    active_window[{a_restore_tid_d1[1:0], 5'b10011}] <= 
		    locals[{a_restore_tid_d1[1:0], a_restore_local_addr_d1[2:0],
		    3'd3}];
	    active_window[{a_restore_tid_d1[1:0], 5'b10100}] <= 
		    locals[{a_restore_tid_d1[1:0], a_restore_local_addr_d1[2:0],
		    3'd4}];
	    active_window[{a_restore_tid_d1[1:0], 5'b10101}] <= 
		    locals[{a_restore_tid_d1[1:0], a_restore_local_addr_d1[2:0],
		    3'd5}];
	    active_window[{a_restore_tid_d1[1:0], 5'b10110}] <= 
		    locals[{a_restore_tid_d1[1:0], a_restore_local_addr_d1[2:0],
		    3'd6}];
	    active_window[{a_restore_tid_d1[1:0], 5'b10111}] <= 
		    locals[{a_restore_tid_d1[1:0], a_restore_local_addr_d1[2:0],
		    3'd7}];
	  end
	  if (a_restore_even_en_d1 & (~tcu_array_wr_inhibit_d1)) begin
	    active_window[{a_restore_tid_d1[1:0], 5'b11000}] <= 
		    evens[{a_restore_tid_d1[1:0], a_restore_even_addr_d1[2:1],
		    3'b0}];
	    active_window[{a_restore_tid_d1[1:0], 5'b11001}] <= 
		    evens[{a_restore_tid_d1[1:0], a_restore_even_addr_d1[2:1],
		    3'b1}];
	    active_window[{a_restore_tid_d1[1:0], 5'b11010}] <= 
		    evens[{a_restore_tid_d1[1:0], a_restore_even_addr_d1[2:1],
		    3'd2}];
	    active_window[{a_restore_tid_d1[1:0], 5'b11011}] <= 
		    evens[{a_restore_tid_d1[1:0], a_restore_even_addr_d1[2:1],
		    3'd3}];
	    active_window[{a_restore_tid_d1[1:0], 5'b11100}] <= 
		    evens[{a_restore_tid_d1[1:0], a_restore_even_addr_d1[2:1],
		    3'd4}];
	    active_window[{a_restore_tid_d1[1:0], 5'b11101}] <= 
		    evens[{a_restore_tid_d1[1:0], a_restore_even_addr_d1[2:1],
		    3'd5}];
	    active_window[{a_restore_tid_d1[1:0], 5'b11110}] <= 
		    evens[{a_restore_tid_d1[1:0], a_restore_even_addr_d1[2:1],
		    3'd6}];
	    active_window[{a_restore_tid_d1[1:0], 5'b11111}] <= 
		    evens[{a_restore_tid_d1[1:0], a_restore_even_addr_d1[2:1],
		    3'd7}];
	  end
	end
	always @(posedge clk) begin
	  tcu_array_wr_inhibit_d1 <= tcu_array_wr_inhibit;
	  a_restore_global_tid_d1[1:0] <= a_restore_global_tid[1:0];
	  a_restore_global_addr_d1[1:0] <= a_restore_global_addr[1:0];
	  a_restore_tid_d1[1:0] <= a_restore_tid[1:0];
	  a_restore_odd_addr_d1[2:1] <= a_restore_odd_addr[2:1];
	  a_restore_local_addr_d1[2:0] <= a_restore_local_addr[2:0];
	  a_restore_even_addr_d1[2:1] <= a_restore_even_addr[2:1];
	  a_restore_global_en_d1 <= a_restore_global_en;
	  a_restore_odd_en_d1 <= a_restore_odd_en;
	  a_restore_local_en_d1 <= a_restore_local_en;
	  a_restore_even_en_d1 <= a_restore_even_en;
	  if (a_save_global_en & (~tcu_array_wr_inhibit)) begin
	    globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b0}] <= 
		    active_window[{a_save_global_tid[1:0], 5'b0}];
	    globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b1}] <= 
		    active_window[{a_save_global_tid[1:0], 5'b1}];
	    globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'd2}] <= 
		    active_window[{a_save_global_tid[1:0], 5'b00010}];
	    globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'd3}] <= 
		    active_window[{a_save_global_tid[1:0], 5'b00011}];
	    globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'd4}] <= 
		    active_window[{a_save_global_tid[1:0], 5'b00100}];
	    globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'd5}] <= 
		    active_window[{a_save_global_tid[1:0], 5'b00101}];
	    globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'd6}] <= 
		    active_window[{a_save_global_tid[1:0], 5'b00110}];
	    globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'd7}] <= 
		    active_window[{a_save_global_tid[1:0], 5'b00111}];
	  end
	  if (a_save_odd_en & (~tcu_array_wr_inhibit)) begin
	    odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b0}] <= 
		    active_window[{a_save_tid[1:0], 5'b01000}];
	    odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b1}] <= 
		    active_window[{a_save_tid[1:0], 5'b01001}];
	    odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'd2}] <= 
		    active_window[{a_save_tid[1:0], 5'b01010}];
	    odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'd3}] <= 
		    active_window[{a_save_tid[1:0], 5'b01011}];
	    odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'd4}] <= 
		    active_window[{a_save_tid[1:0], 5'b01100}];
	    odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'd5}] <= 
		    active_window[{a_save_tid[1:0], 5'b01101}];
	    odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'd6}] <= 
		    active_window[{a_save_tid[1:0], 5'b01110}];
	    odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'd7}] <= 
		    active_window[{a_save_tid[1:0], 5'b01111}];
	  end
	  if (a_save_local_en & (~tcu_array_wr_inhibit)) begin
	    locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b0}] <= 
		    active_window[{a_save_tid[1:0], 5'b10000}];
	    locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b1}] <= 
		    active_window[{a_save_tid[1:0], 5'b10001}];
	    locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'd2}] <= 
		    active_window[{a_save_tid[1:0], 5'b10010}];
	    locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'd3}] <= 
		    active_window[{a_save_tid[1:0], 5'b10011}];
	    locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'd4}] <= 
		    active_window[{a_save_tid[1:0], 5'b10100}];
	    locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'd5}] <= 
		    active_window[{a_save_tid[1:0], 5'b10101}];
	    locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'd6}] <= 
		    active_window[{a_save_tid[1:0], 5'b10110}];
	    locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'd7}] <= 
		    active_window[{a_save_tid[1:0], 5'b10111}];
	  end
	  if (a_save_even_en & (~tcu_array_wr_inhibit)) begin
	    evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b0}] <= 
		    active_window[{a_save_tid[1:0], 5'b11000}];
	    evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b1}] <= 
		    active_window[{a_save_tid[1:0], 5'b11001}];
	    evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'd2}] <= 
		    active_window[{a_save_tid[1:0], 5'b11010}];
	    evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'd3}] <= 
		    active_window[{a_save_tid[1:0], 5'b11011}];
	    evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'd4}] <= 
		    active_window[{a_save_tid[1:0], 5'b11100}];
	    evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'd5}] <= 
		    active_window[{a_save_tid[1:0], 5'b11101}];
	    evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'd6}] <= 
		    active_window[{a_save_tid[1:0], 5'b11110}];
	    evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'd7}] <= 
		    active_window[{a_save_tid[1:0], 5'b11111}];
	  end
	end

endmodule

`endif // `ifdef FPGA

