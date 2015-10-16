// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: n2_frf_mp_256x78_cust.v
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
module n2_frf_mp_256x78_cust (
  frf_r1_data, 
  frf_r1_ecc, 
  frf_r2_data, 
  frf_r2_ecc, 
  l2clk, 
  scan_in, 
  pce, 
  tcu_pce_ov, 
  tcu_aclk, 
  tcu_bclk, 
  tcu_array_wr_inhibit, 
  tcu_scan_en, 
  tcu_se_scancollar_in, 
  main_clken, 
  scan_out, 
  r_tid, 
  r1_valid, 
  r1_addr, 
  r2_valid, 
  r2_addr, 
  w1_tid, 
  w1_valid, 
  w1_addr, 
  w2_tid, 
  w2_valid, 
  w2_addr, 
  w1_data, 
  w1_ecc, 
  w2_data, 
  w2_ecc);
wire siclk;
wire soclk;
wire l1clk;
wire l1clk_main;
wire [13:0] w1_ecc_synd_fb_to_fw_scanin;
wire [13:0] w1_ecc_synd_fb_to_fw_scanout;
wire [13:0] w1_ecc_fw;
wire [13:0] w2_ecc_synd_fb_to_fw_scanin;
wire [13:0] w2_ecc_synd_fb_to_fw_scanout;
wire [13:0] w2_ecc_fw;
wire [14:0] frf_read_ctl_in2ph2_scanin;
wire [14:0] frf_read_ctl_in2ph2_scanout;
wire [4:0] r1_addr_ph2;
wire [4:0] r2_addr_ph2;
wire r1_valid_ph2;
wire r2_valid_ph2;
wire [2:0] r_tid_ph2;
wire [63:0] fw_w2data_scanin;
wire [63:0] fw_w2data_scanout;
wire [63:0] w2_data_fw;
wire [63:0] fw_w1data_scanin;
wire [63:0] fw_w1data_scanout;
wire [63:0] w1_data_fw;
wire [19:0] frf_write_input_ctl_in2fb_scanin;
wire [19:0] frf_write_input_ctl_in2fb_scanout;
wire [2:0] w1_tid_fw;
wire [1:0] w1_valid_fw;
wire [4:0] w1_addr_fw;
wire [2:0] w2_tid_fw;
wire [1:0] w2_valid_fw;
wire [4:0] w2_addr_fw;
wire l1clk_free;


   // -----------------------------------------------------------------------
   // Read output ports
   // -----------------------------------------------------------------------
   output  [63:0] frf_r1_data;
   output  [13:0] frf_r1_ecc;
   output  [63:0] frf_r2_data;
   output  [13:0] frf_r2_ecc;

   // -----------------------------------------------------------------------
   // global signals
   // -----------------------------------------------------------------------

   input        l2clk;
   input        scan_in;
   input	pce;
   input        tcu_pce_ov;
   input        tcu_aclk;
   input        tcu_bclk;
   input        tcu_array_wr_inhibit;
   input	tcu_scan_en;
   input        tcu_se_scancollar_in;

   input        main_clken;

   output       scan_out;


   // -----------------------------------------------------------------------
   // Reading controls
   // -----------------------------------------------------------------------
   input    [2:0] r_tid;
   input          r1_valid;
   input    [4:0] r1_addr;
   input          r2_valid;
   input    [4:0] r2_addr;
 
   // -----------------------------------------------------------------------
   // Writing controls 
   // -----------------------------------------------------------------------
   input    [2:0] w1_tid;
   input    [1:0] w1_valid;
   input    [4:0] w1_addr;
   input    [2:0] w2_tid;
   input    [1:0] w2_valid;
   input    [4:0] w2_addr;

   // -----------------------------------------------------------------------
   // Write data ports
   // -----------------------------------------------------------------------
   input   [63:0] w1_data;
   input   [13:0] w1_ecc;
   input   [63:0] w2_data;
   input   [13:0] w2_ecc;

`ifndef FPGA
   // synopsys translate_off
`endif

   assign siclk		= tcu_aclk;
   assign soclk		= tcu_bclk;

   n2_frf_mp_256x78_cust_l1clkhdr_ctl_macro	clkgen (
    .l2clk  (l2clk          		),
    .l1en   (pce			),
    .pce_ov (tcu_pce_ov			),
    .stop   (1'b0			),
    .se	    (tcu_se_scancollar_in	),
    .l1clk  (l1clk			));


   n2_frf_mp_256x78_cust_l1clkhdr_ctl_macro	clkgen_main (
    .l2clk  (l2clk          		),
    .l1en   (main_clken			),
    .pce_ov (tcu_pce_ov			),
    .stop   (1'b0			),
    .se	    (tcu_se_scancollar_in	),
    .l1clk  (l1clk_main			));



   n2_frf_mp_256x78_cust_msff_ctl_macro__fs_1__width_14	w1_ecc_synd_fb_to_fw		 (
     .scan_in(w1_ecc_synd_fb_to_fw_scanin[13:0]),
     .scan_out(w1_ecc_synd_fb_to_fw_scanout[13:0]),
    .l1clk (l1clk_main),
    .din   (w1_ecc   [13:0]),
    .dout  (w1_ecc_fw[13:0]),
  .siclk(siclk),
  .soclk(soclk));
   
   n2_frf_mp_256x78_cust_msff_ctl_macro__fs_1__scanreverse_1__width_14	w2_ecc_synd_fb_to_fw		 (
     .scan_in(w2_ecc_synd_fb_to_fw_scanin[13:0]),
     .scan_out(w2_ecc_synd_fb_to_fw_scanout[13:0]),
    .l1clk (l1clk_main),
    .din   (w2_ecc   [13:0]),
    .dout  (w2_ecc_fw[13:0]),
  .siclk(siclk),
  .soclk(soclk));

   n2_frf_mp_256x78_cust_msff_ctl_macro__fs_1__width_15	frf_read_ctl_in2ph2		 (
     .scan_in(frf_read_ctl_in2ph2_scanin[14:0]),
     .scan_out(frf_read_ctl_in2ph2_scanout[14:0]),
    .l1clk (l1clk),
    .din   ({r1_addr [4:0],    // requires free running clk or dec_fgu_decode_d en
  	     r2_addr [4:0],    // requires free running clk or dec_fgu_decode_d en
  	     r1_valid     ,    // requires free running clk or dec_fgu_decode_d en
  	     r2_valid     ,    // requires free running clk or dec_fgu_decode_d en
  	     r_tid   [2:0]}),  // requires free running clk or dec_fgu_decode_d en
    .dout  ({r1_addr_ph2[4:0],
  	     r2_addr_ph2[4:0],   
  	     r1_valid_ph2    ,
  	     r2_valid_ph2    ,
  	     r_tid_ph2  [2:0]}),
  .siclk(siclk),
  .soclk(soclk));


   n2_frf_mp_256x78_cust_msff_ctl_macro__fs_1__scanreverse_1__width_64	fw_w2data			 (
     .scan_in(fw_w2data_scanin[63:0]),
     .scan_out(fw_w2data_scanout[63:0]),
     .l1clk (l1clk_main),
     .din   (w2_data   [63:0]),
     .dout  (w2_data_fw[63:0]),
  .siclk(siclk),
  .soclk(soclk));
   
   n2_frf_mp_256x78_cust_msff_ctl_macro__fs_1__width_64	fw_w1data			 (
     .scan_in(fw_w1data_scanin[63:0]),
     .scan_out(fw_w1data_scanout[63:0]),
     .l1clk (l1clk_main),
     .din   (w1_data   [63:0]),
     .dout  (w1_data_fw[63:0]),
  .siclk(siclk),
  .soclk(soclk));


   n2_frf_mp_256x78_cust_msff_ctl_macro__fs_1__width_20	frf_write_input_ctl_in2fb	 (
     .scan_in(frf_write_input_ctl_in2fb_scanin[19:0]),
     .scan_out(frf_write_input_ctl_in2fb_scanout[19:0]),
     .l1clk (l1clk_main),
     .din   ({w1_tid      [2:0],
              w1_valid    [1:0],
              w1_addr     [4:0],
              w2_tid      [2:0],
              w2_valid    [1:0],
              w2_addr     [4:0]}),
     .dout  ({w1_tid_fw   [2:0],
              w1_valid_fw [1:0],
              w1_addr_fw  [4:0],
              w2_tid_fw   [2:0],
              w2_valid_fw [1:0],
              w2_addr_fw  [4:0]}),
  .siclk(siclk),
  .soclk(soclk));




// L2 clock "free-running" clock
n2_frf_mp_256x78_cust_l1clkhdr_ctl_macro	clkgen_free (
  .l2clk  (l2clk			),
  .l1en   (pce				),
  .pce_ov (tcu_pce_ov			),
  .stop	  (1'b0				),
  .se	  (tcu_scan_en			),
  .l1clk  (l1clk_free			));

fgu_frf_array	frf_array_o			(
  .clk      ( l1clk_free				),
  .r1_valid ( r1_valid_ph2				),
  .r1_addr  ({r_tid_ph2[2:0]  , r1_addr_ph2[4:0]}	),
  .r2_valid ( r2_valid_ph2				),
  .r2_addr  ({r_tid_ph2[2:0]  , r2_addr_ph2[4:0]}	),
  .w1_valid ( w1_valid_fw[0]				),
  .w1_addr  ({w1_tid_fw[2:0]  , w1_addr_fw[4:0]}	),
  .w1_data  ({w1_ecc_fw[6:0]  , w1_data_fw[31:0]}	),
  .w2_valid ( w2_valid_fw[0]				),
  .w2_addr  ({w2_tid_fw[2:0]  , w2_addr_fw[4:0]}	),
  .w2_data  ({w2_ecc_fw[6:0]  , w2_data_fw[31:0]}	),
     .r1_data   ({frf_r1_ecc[6:0]   , frf_r1_data[31:0]}	),
     .r2_data   ({frf_r2_ecc[6:0]   , frf_r2_data[31:0]}	),
  .tcu_array_wr_inhibit(tcu_array_wr_inhibit));



fgu_frf_array	frf_array_e			(
  .clk      ( l1clk_free				),
  .r1_valid ( r1_valid_ph2				),
  .r1_addr  ({r_tid_ph2[2:0]  , r1_addr_ph2[4:0]}	),
  .r2_valid ( r2_valid_ph2				),
  .r2_addr  ({r_tid_ph2[2:0]  , r2_addr_ph2[4:0]}	),
  .w1_valid ( w1_valid_fw[1]				),
  .w1_addr  ({w1_tid_fw[2:0]  , w1_addr_fw[4:0]}	),
  .w1_data  ({w1_ecc_fw[13:7] , w1_data_fw[63:32]}	),
  .w2_valid ( w2_valid_fw[1]				),
  .w2_addr  ({w2_tid_fw[2:0]  , w2_addr_fw[4:0]}	),
  .w2_data  ({w2_ecc_fw[13:7] , w2_data_fw[63:32]}	),
     .r1_data   ({frf_r1_ecc[13:7]  , frf_r1_data[63:32]}	),
     .r2_data   ({frf_r2_ecc[13:7]  , frf_r2_data[63:32]}	),
  .tcu_array_wr_inhibit(tcu_array_wr_inhibit));





supply0 vss;
supply1 vdd;





// scanorder start
//      w1_ecc_synd_fb_to_fw_scanin[13:7]
//      fw_w1data_scanin[63:32]
//      frf_write_input_ctl_in2fb_scanin[16]
//      frf_read_ctl_in2ph2_scanin[14:10]
//      frf_write_input_ctl_in2fb_scanin[9:7]
//      frf_write_input_ctl_in2fb_scanin[0]
//      frf_read_ctl_in2ph2_scanin[2:0]
//      frf_read_ctl_in2ph2_scanin[9:5]
//      frf_write_input_ctl_in2fb_scanin[4]
//      frf_write_input_ctl_in2fb_scanin[5]
//      w1_ecc_synd_fb_to_fw_scanin[6:0]
//      fw_w1data_scanin[31:0]
//      fw_w2data_scanin[0:31]
//      w2_ecc_synd_fb_to_fw_scanin[0:6]
//      frf_write_input_ctl_in2fb_scanin[15]
//      frf_write_input_ctl_in2fb_scanin[1]
//      frf_write_input_ctl_in2fb_scanin[2]
//      frf_write_input_ctl_in2fb_scanin[3]
//      frf_read_ctl_in2ph2_scanin[3]
//      frf_read_ctl_in2ph2_scanin[4]
//      frf_write_input_ctl_in2fb_scanin[10]
//      frf_write_input_ctl_in2fb_scanin[11]
//      frf_write_input_ctl_in2fb_scanin[12]
//      frf_write_input_ctl_in2fb_scanin[13]
//      frf_write_input_ctl_in2fb_scanin[14]
//      frf_write_input_ctl_in2fb_scanin[17]
//      frf_write_input_ctl_in2fb_scanin[18]
//      frf_write_input_ctl_in2fb_scanin[19]
//      frf_write_input_ctl_in2fb_scanin[6]
//      fw_w2data_scanin[32:63]
//      w2_ecc_synd_fb_to_fw_scanin[7:13]
// scanorder end
// fixscan start
assign w1_ecc_synd_fb_to_fw_scanin[13]=scan_in;
assign w1_ecc_synd_fb_to_fw_scanin[12]=w1_ecc_synd_fb_to_fw_scanout[13];
assign w1_ecc_synd_fb_to_fw_scanin[11]=w1_ecc_synd_fb_to_fw_scanout[12];
assign w1_ecc_synd_fb_to_fw_scanin[10]=w1_ecc_synd_fb_to_fw_scanout[11];
assign w1_ecc_synd_fb_to_fw_scanin[9]=w1_ecc_synd_fb_to_fw_scanout[10];
assign w1_ecc_synd_fb_to_fw_scanin[8]=w1_ecc_synd_fb_to_fw_scanout[9];
assign w1_ecc_synd_fb_to_fw_scanin[7]=w1_ecc_synd_fb_to_fw_scanout[8];
assign fw_w1data_scanin[63]=w1_ecc_synd_fb_to_fw_scanout[7];
assign fw_w1data_scanin[62]=fw_w1data_scanout[63];
assign fw_w1data_scanin[61]=fw_w1data_scanout[62];
assign fw_w1data_scanin[60]=fw_w1data_scanout[61];
assign fw_w1data_scanin[59]=fw_w1data_scanout[60];
assign fw_w1data_scanin[58]=fw_w1data_scanout[59];
assign fw_w1data_scanin[57]=fw_w1data_scanout[58];
assign fw_w1data_scanin[56]=fw_w1data_scanout[57];
assign fw_w1data_scanin[55]=fw_w1data_scanout[56];
assign fw_w1data_scanin[54]=fw_w1data_scanout[55];
assign fw_w1data_scanin[53]=fw_w1data_scanout[54];
assign fw_w1data_scanin[52]=fw_w1data_scanout[53];
assign fw_w1data_scanin[51]=fw_w1data_scanout[52];
assign fw_w1data_scanin[50]=fw_w1data_scanout[51];
assign fw_w1data_scanin[49]=fw_w1data_scanout[50];
assign fw_w1data_scanin[48]=fw_w1data_scanout[49];
assign fw_w1data_scanin[47]=fw_w1data_scanout[48];
assign fw_w1data_scanin[46]=fw_w1data_scanout[47];
assign fw_w1data_scanin[45]=fw_w1data_scanout[46];
assign fw_w1data_scanin[44]=fw_w1data_scanout[45];
assign fw_w1data_scanin[43]=fw_w1data_scanout[44];
assign fw_w1data_scanin[42]=fw_w1data_scanout[43];
assign fw_w1data_scanin[41]=fw_w1data_scanout[42];
assign fw_w1data_scanin[40]=fw_w1data_scanout[41];
assign fw_w1data_scanin[39]=fw_w1data_scanout[40];
assign fw_w1data_scanin[38]=fw_w1data_scanout[39];
assign fw_w1data_scanin[37]=fw_w1data_scanout[38];
assign fw_w1data_scanin[36]=fw_w1data_scanout[37];
assign fw_w1data_scanin[35]=fw_w1data_scanout[36];
assign fw_w1data_scanin[34]=fw_w1data_scanout[35];
assign fw_w1data_scanin[33]=fw_w1data_scanout[34];
assign fw_w1data_scanin[32]=fw_w1data_scanout[33];
assign frf_write_input_ctl_in2fb_scanin[16]=fw_w1data_scanout[32];
assign frf_read_ctl_in2ph2_scanin[14]=frf_write_input_ctl_in2fb_scanout[16];
assign frf_read_ctl_in2ph2_scanin[13]=frf_read_ctl_in2ph2_scanout[14];
assign frf_read_ctl_in2ph2_scanin[12]=frf_read_ctl_in2ph2_scanout[13];
assign frf_read_ctl_in2ph2_scanin[11]=frf_read_ctl_in2ph2_scanout[12];
assign frf_read_ctl_in2ph2_scanin[10]=frf_read_ctl_in2ph2_scanout[11];
assign frf_write_input_ctl_in2fb_scanin[9]=frf_read_ctl_in2ph2_scanout[10];
assign frf_write_input_ctl_in2fb_scanin[8]=frf_write_input_ctl_in2fb_scanout[9];
assign frf_write_input_ctl_in2fb_scanin[7]=frf_write_input_ctl_in2fb_scanout[8];
assign frf_write_input_ctl_in2fb_scanin[0]=frf_write_input_ctl_in2fb_scanout[7];
assign frf_read_ctl_in2ph2_scanin[2]=frf_write_input_ctl_in2fb_scanout[0];
assign frf_read_ctl_in2ph2_scanin[1]=frf_read_ctl_in2ph2_scanout[2];
assign frf_read_ctl_in2ph2_scanin[0]=frf_read_ctl_in2ph2_scanout[1];
assign frf_read_ctl_in2ph2_scanin[9]=frf_read_ctl_in2ph2_scanout[0];
assign frf_read_ctl_in2ph2_scanin[8]=frf_read_ctl_in2ph2_scanout[9];
assign frf_read_ctl_in2ph2_scanin[7]=frf_read_ctl_in2ph2_scanout[8];
assign frf_read_ctl_in2ph2_scanin[6]=frf_read_ctl_in2ph2_scanout[7];
assign frf_read_ctl_in2ph2_scanin[5]=frf_read_ctl_in2ph2_scanout[6];
assign frf_write_input_ctl_in2fb_scanin[4]=frf_read_ctl_in2ph2_scanout[5];
assign frf_write_input_ctl_in2fb_scanin[5]=frf_write_input_ctl_in2fb_scanout[4];
assign w1_ecc_synd_fb_to_fw_scanin[6]=frf_write_input_ctl_in2fb_scanout[5];
assign w1_ecc_synd_fb_to_fw_scanin[5]=w1_ecc_synd_fb_to_fw_scanout[6];
assign w1_ecc_synd_fb_to_fw_scanin[4]=w1_ecc_synd_fb_to_fw_scanout[5];
assign w1_ecc_synd_fb_to_fw_scanin[3]=w1_ecc_synd_fb_to_fw_scanout[4];
assign w1_ecc_synd_fb_to_fw_scanin[2]=w1_ecc_synd_fb_to_fw_scanout[3];
assign w1_ecc_synd_fb_to_fw_scanin[1]=w1_ecc_synd_fb_to_fw_scanout[2];
assign w1_ecc_synd_fb_to_fw_scanin[0]=w1_ecc_synd_fb_to_fw_scanout[1];
assign fw_w1data_scanin[31]=w1_ecc_synd_fb_to_fw_scanout[0];
assign fw_w1data_scanin[30]=fw_w1data_scanout[31];
assign fw_w1data_scanin[29]=fw_w1data_scanout[30];
assign fw_w1data_scanin[28]=fw_w1data_scanout[29];
assign fw_w1data_scanin[27]=fw_w1data_scanout[28];
assign fw_w1data_scanin[26]=fw_w1data_scanout[27];
assign fw_w1data_scanin[25]=fw_w1data_scanout[26];
assign fw_w1data_scanin[24]=fw_w1data_scanout[25];
assign fw_w1data_scanin[23]=fw_w1data_scanout[24];
assign fw_w1data_scanin[22]=fw_w1data_scanout[23];
assign fw_w1data_scanin[21]=fw_w1data_scanout[22];
assign fw_w1data_scanin[20]=fw_w1data_scanout[21];
assign fw_w1data_scanin[19]=fw_w1data_scanout[20];
assign fw_w1data_scanin[18]=fw_w1data_scanout[19];
assign fw_w1data_scanin[17]=fw_w1data_scanout[18];
assign fw_w1data_scanin[16]=fw_w1data_scanout[17];
assign fw_w1data_scanin[15]=fw_w1data_scanout[16];
assign fw_w1data_scanin[14]=fw_w1data_scanout[15];
assign fw_w1data_scanin[13]=fw_w1data_scanout[14];
assign fw_w1data_scanin[12]=fw_w1data_scanout[13];
assign fw_w1data_scanin[11]=fw_w1data_scanout[12];
assign fw_w1data_scanin[10]=fw_w1data_scanout[11];
assign fw_w1data_scanin[9]=fw_w1data_scanout[10];
assign fw_w1data_scanin[8]=fw_w1data_scanout[9];
assign fw_w1data_scanin[7]=fw_w1data_scanout[8];
assign fw_w1data_scanin[6]=fw_w1data_scanout[7];
assign fw_w1data_scanin[5]=fw_w1data_scanout[6];
assign fw_w1data_scanin[4]=fw_w1data_scanout[5];
assign fw_w1data_scanin[3]=fw_w1data_scanout[4];
assign fw_w1data_scanin[2]=fw_w1data_scanout[3];
assign fw_w1data_scanin[1]=fw_w1data_scanout[2];
assign fw_w1data_scanin[0]=fw_w1data_scanout[1];
assign fw_w2data_scanin[0]=fw_w1data_scanout[0];
assign fw_w2data_scanin[1]=fw_w2data_scanout[0];
assign fw_w2data_scanin[2]=fw_w2data_scanout[1];
assign fw_w2data_scanin[3]=fw_w2data_scanout[2];
assign fw_w2data_scanin[4]=fw_w2data_scanout[3];
assign fw_w2data_scanin[5]=fw_w2data_scanout[4];
assign fw_w2data_scanin[6]=fw_w2data_scanout[5];
assign fw_w2data_scanin[7]=fw_w2data_scanout[6];
assign fw_w2data_scanin[8]=fw_w2data_scanout[7];
assign fw_w2data_scanin[9]=fw_w2data_scanout[8];
assign fw_w2data_scanin[10]=fw_w2data_scanout[9];
assign fw_w2data_scanin[11]=fw_w2data_scanout[10];
assign fw_w2data_scanin[12]=fw_w2data_scanout[11];
assign fw_w2data_scanin[13]=fw_w2data_scanout[12];
assign fw_w2data_scanin[14]=fw_w2data_scanout[13];
assign fw_w2data_scanin[15]=fw_w2data_scanout[14];
assign fw_w2data_scanin[16]=fw_w2data_scanout[15];
assign fw_w2data_scanin[17]=fw_w2data_scanout[16];
assign fw_w2data_scanin[18]=fw_w2data_scanout[17];
assign fw_w2data_scanin[19]=fw_w2data_scanout[18];
assign fw_w2data_scanin[20]=fw_w2data_scanout[19];
assign fw_w2data_scanin[21]=fw_w2data_scanout[20];
assign fw_w2data_scanin[22]=fw_w2data_scanout[21];
assign fw_w2data_scanin[23]=fw_w2data_scanout[22];
assign fw_w2data_scanin[24]=fw_w2data_scanout[23];
assign fw_w2data_scanin[25]=fw_w2data_scanout[24];
assign fw_w2data_scanin[26]=fw_w2data_scanout[25];
assign fw_w2data_scanin[27]=fw_w2data_scanout[26];
assign fw_w2data_scanin[28]=fw_w2data_scanout[27];
assign fw_w2data_scanin[29]=fw_w2data_scanout[28];
assign fw_w2data_scanin[30]=fw_w2data_scanout[29];
assign fw_w2data_scanin[31]=fw_w2data_scanout[30];
assign w2_ecc_synd_fb_to_fw_scanin[0]=fw_w2data_scanout[31];
assign w2_ecc_synd_fb_to_fw_scanin[1]=w2_ecc_synd_fb_to_fw_scanout[0];
assign w2_ecc_synd_fb_to_fw_scanin[2]=w2_ecc_synd_fb_to_fw_scanout[1];
assign w2_ecc_synd_fb_to_fw_scanin[3]=w2_ecc_synd_fb_to_fw_scanout[2];
assign w2_ecc_synd_fb_to_fw_scanin[4]=w2_ecc_synd_fb_to_fw_scanout[3];
assign w2_ecc_synd_fb_to_fw_scanin[5]=w2_ecc_synd_fb_to_fw_scanout[4];
assign w2_ecc_synd_fb_to_fw_scanin[6]=w2_ecc_synd_fb_to_fw_scanout[5];
assign frf_write_input_ctl_in2fb_scanin[15]=w2_ecc_synd_fb_to_fw_scanout[6];
assign frf_write_input_ctl_in2fb_scanin[1]=frf_write_input_ctl_in2fb_scanout[15];
assign frf_write_input_ctl_in2fb_scanin[2]=frf_write_input_ctl_in2fb_scanout[1];
assign frf_write_input_ctl_in2fb_scanin[3]=frf_write_input_ctl_in2fb_scanout[2];
assign frf_read_ctl_in2ph2_scanin[3]=frf_write_input_ctl_in2fb_scanout[3];
assign frf_read_ctl_in2ph2_scanin[4]=frf_read_ctl_in2ph2_scanout[3];
assign frf_write_input_ctl_in2fb_scanin[10]=frf_read_ctl_in2ph2_scanout[4];
assign frf_write_input_ctl_in2fb_scanin[11]=frf_write_input_ctl_in2fb_scanout[10];
assign frf_write_input_ctl_in2fb_scanin[12]=frf_write_input_ctl_in2fb_scanout[11];
assign frf_write_input_ctl_in2fb_scanin[13]=frf_write_input_ctl_in2fb_scanout[12];
assign frf_write_input_ctl_in2fb_scanin[14]=frf_write_input_ctl_in2fb_scanout[13];
assign frf_write_input_ctl_in2fb_scanin[17]=frf_write_input_ctl_in2fb_scanout[14];
assign frf_write_input_ctl_in2fb_scanin[18]=frf_write_input_ctl_in2fb_scanout[17];
assign frf_write_input_ctl_in2fb_scanin[19]=frf_write_input_ctl_in2fb_scanout[18];
assign frf_write_input_ctl_in2fb_scanin[6]=frf_write_input_ctl_in2fb_scanout[19];
assign fw_w2data_scanin[32]=frf_write_input_ctl_in2fb_scanout[6];
assign fw_w2data_scanin[33]=fw_w2data_scanout[32];
assign fw_w2data_scanin[34]=fw_w2data_scanout[33];
assign fw_w2data_scanin[35]=fw_w2data_scanout[34];
assign fw_w2data_scanin[36]=fw_w2data_scanout[35];
assign fw_w2data_scanin[37]=fw_w2data_scanout[36];
assign fw_w2data_scanin[38]=fw_w2data_scanout[37];
assign fw_w2data_scanin[39]=fw_w2data_scanout[38];
assign fw_w2data_scanin[40]=fw_w2data_scanout[39];
assign fw_w2data_scanin[41]=fw_w2data_scanout[40];
assign fw_w2data_scanin[42]=fw_w2data_scanout[41];
assign fw_w2data_scanin[43]=fw_w2data_scanout[42];
assign fw_w2data_scanin[44]=fw_w2data_scanout[43];
assign fw_w2data_scanin[45]=fw_w2data_scanout[44];
assign fw_w2data_scanin[46]=fw_w2data_scanout[45];
assign fw_w2data_scanin[47]=fw_w2data_scanout[46];
assign fw_w2data_scanin[48]=fw_w2data_scanout[47];
assign fw_w2data_scanin[49]=fw_w2data_scanout[48];
assign fw_w2data_scanin[50]=fw_w2data_scanout[49];
assign fw_w2data_scanin[51]=fw_w2data_scanout[50];
assign fw_w2data_scanin[52]=fw_w2data_scanout[51];
assign fw_w2data_scanin[53]=fw_w2data_scanout[52];
assign fw_w2data_scanin[54]=fw_w2data_scanout[53];
assign fw_w2data_scanin[55]=fw_w2data_scanout[54];
assign fw_w2data_scanin[56]=fw_w2data_scanout[55];
assign fw_w2data_scanin[57]=fw_w2data_scanout[56];
assign fw_w2data_scanin[58]=fw_w2data_scanout[57];
assign fw_w2data_scanin[59]=fw_w2data_scanout[58];
assign fw_w2data_scanin[60]=fw_w2data_scanout[59];
assign fw_w2data_scanin[61]=fw_w2data_scanout[60];
assign fw_w2data_scanin[62]=fw_w2data_scanout[61];
assign fw_w2data_scanin[63]=fw_w2data_scanout[62];
assign w2_ecc_synd_fb_to_fw_scanin[7]=fw_w2data_scanout[63];
assign w2_ecc_synd_fb_to_fw_scanin[8]=w2_ecc_synd_fb_to_fw_scanout[7];
assign w2_ecc_synd_fb_to_fw_scanin[9]=w2_ecc_synd_fb_to_fw_scanout[8];
assign w2_ecc_synd_fb_to_fw_scanin[10]=w2_ecc_synd_fb_to_fw_scanout[9];
assign w2_ecc_synd_fb_to_fw_scanin[11]=w2_ecc_synd_fb_to_fw_scanout[10];
assign w2_ecc_synd_fb_to_fw_scanin[12]=w2_ecc_synd_fb_to_fw_scanout[11];
assign w2_ecc_synd_fb_to_fw_scanin[13]=w2_ecc_synd_fb_to_fw_scanout[12];
assign scan_out=w2_ecc_synd_fb_to_fw_scanout[13];
// fixscan end

`ifndef FPGA
// synopsys translate_on
`endif

endmodule  // fgu_frf_cust






// any PARAMS parms go into naming of macro

module n2_frf_mp_256x78_cust_l1clkhdr_ctl_macro (
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

module n2_frf_mp_256x78_cust_msff_ctl_macro__fs_1__width_14 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [13:0] fdin;

  input [13:0] din;
  input l1clk;
  input [13:0] scan_in;


  input siclk;
  input soclk;

  output [13:0] dout;
  output [13:0] scan_out;
assign fdin[13:0] = din[13:0];






dff #(14)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[13:0]),
.si(scan_in[13:0]),
.so(scan_out[13:0]),
.q(dout[13:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_frf_mp_256x78_cust_msff_ctl_macro__fs_1__scanreverse_1__width_14 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [13:0] fdin;

  input [13:0] din;
  input l1clk;
  input [13:0] scan_in;


  input siclk;
  input soclk;

  output [13:0] dout;
  output [13:0] scan_out;
assign fdin[13:0] = din[13:0];






dff #(14)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[13:0]),
.si(scan_in[13:0]),
.so(scan_out[13:0]),
.q(dout[13:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_frf_mp_256x78_cust_msff_ctl_macro__fs_1__width_15 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [14:0] fdin;

  input [14:0] din;
  input l1clk;
  input [14:0] scan_in;


  input siclk;
  input soclk;

  output [14:0] dout;
  output [14:0] scan_out;
assign fdin[14:0] = din[14:0];






dff #(15)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[14:0]),
.si(scan_in[14:0]),
.so(scan_out[14:0]),
.q(dout[14:0])
);












endmodule













// any PARAMS parms go into naming of macro

module n2_frf_mp_256x78_cust_msff_ctl_macro__fs_1__scanreverse_1__width_64 (
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













// any PARAMS parms go into naming of macro

module n2_frf_mp_256x78_cust_msff_ctl_macro__fs_1__width_64 (
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













// any PARAMS parms go into naming of macro

module n2_frf_mp_256x78_cust_msff_ctl_macro__fs_1__width_20 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [19:0] fdin;

  input [19:0] din;
  input l1clk;
  input [19:0] scan_in;


  input siclk;
  input soclk;

  output [19:0] dout;
  output [19:0] scan_out;
assign fdin[19:0] = din[19:0];






dff #(20)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[19:0]),
.si(scan_in[19:0]),
.so(scan_out[19:0]),
.q(dout[19:0])
);












endmodule




`ifndef FPGA
module fgu_frf_array (
  clk, 
  tcu_array_wr_inhibit, 
  r1_valid, 
  r1_addr, 
  r2_valid, 
  r2_addr, 
  w1_valid, 
  w1_addr, 
  w2_valid, 
  w2_addr, 
  w1_data, 
  w2_data, 
  r1_data, 
  r2_data);
wire masked_r1_valid;
wire masked_r2_valid;


   input          clk;

   input          tcu_array_wr_inhibit;

   // -----------------------------------------------------------------------
   // Reading controls
   // -----------------------------------------------------------------------
   input          r1_valid;
   input    [7:0] r1_addr;
   input          r2_valid;
   input    [7:0] r2_addr;
 
   // -----------------------------------------------------------------------
   // Writing controls 
   // -----------------------------------------------------------------------
   input          w1_valid;
   input    [7:0] w1_addr;
   input          w2_valid;
   input    [7:0] w2_addr;

   // -----------------------------------------------------------------------
   // Write data ports
   // -----------------------------------------------------------------------
   input   [38:0] w1_data;
   input   [38:0] w2_data;


   // -----------------------------------------------------------------------
   // Read output ports
   // -----------------------------------------------------------------------
   output  [38:0] r1_data;
   output  [38:0] r2_data;

   reg [38:0]    r1_data;            // *** Temporary array read regs (no physical flops involved) ***
   reg [38:0]    r2_data;            // *** Temporary array read regs (no physical flops involved) ***

   assign masked_r1_valid = r1_valid & ~(w1_valid & (r1_addr[7:0] == w1_addr[7:0]))
                                     & ~(w2_valid & (r1_addr[7:0] == w2_addr[7:0]));

   assign masked_r2_valid = r2_valid & ~(w1_valid & (r2_addr[7:0] == w1_addr[7:0]))
                                     & ~(w2_valid & (r2_addr[7:0] == w2_addr[7:0]));













   reg [38:0]    data_array[255:0];

   // *** Initialize section ***
`ifndef NOINITMEM
   integer i;
   initial begin
     for (i=0; i<=255; i=i+1) begin
     	 data_array[i] = {39{1'b0}};
     end
   end
`endif




















   always @ (posedge clk) begin

            r1_data[38:0] <= {39{1'b0}};
            r2_data[38:0] <= {39{1'b0}};

   end // posedge always


   always @ (negedge clk) begin


   // -----------------------------------------------------------------------
   // *** Read Section *** 
   // -----------------------------------------------------------------------

      if (masked_r1_valid) begin
            r1_data[38:0] <= data_array[r1_addr[7:0]];
      end


      if (masked_r2_valid) begin
            r2_data[38:0] <= data_array[r2_addr[7:0]];
      end


   // -----------------------------------------------------------------------
   // *** Write Section *** 
   // -----------------------------------------------------------------------


   // 0in assert -active (w1_valid & w2_valid)  -var (w1_addr[7:0] != w2_addr[7:0]) -message "FGU FRF Multiple Write"


      if (w1_valid & ~tcu_array_wr_inhibit) begin
         data_array[w1_addr[7:0]] <= w1_data[38:0];
      end


      if (w2_valid & ~tcu_array_wr_inhibit) begin 
         data_array[w2_addr[7:0]] <= w2_data[38:0];
      end 



     
     



   end // negedge always


supply0 vss;
supply1 vdd;

endmodule  // fgu_frf_array

`endif

`ifdef FPGA
module fgu_frf_array(clk, tcu_array_wr_inhibit, r1_valid, r1_addr, r2_valid, 
	r2_addr, w1_valid, w1_addr, w2_valid, w2_addr, w1_data, w2_data, 
	r1_data, r2_data);

	input			clk;
	input			tcu_array_wr_inhibit;
	input			r1_valid;
	input	[7:0]		r1_addr;
	input			r2_valid;
	input	[7:0]		r2_addr;
	input			w1_valid;
	input	[7:0]		w1_addr;
	input			w2_valid;
	input	[7:0]		w2_addr;
	input	[38:0]		w1_data;
	input	[38:0]		w2_data;
	output	[38:0]		r1_data;
	output	[38:0]		r2_data;

	wire			masked_r1_valid;
	wire			masked_r2_valid;
	reg	[38:0]		r1_data;
	reg	[38:0]		r2_data;

  
            reg     [38:0]          data_array[255:0];
        integer                 i;

        assign masked_r1_valid = ((r1_valid & (~(w1_valid & (r1_addr[7:0] ==
                w1_addr[7:0])))) & (~(w2_valid & (r1_addr[7:0] == w2_addr[7:0]))
                ));
        assign masked_r2_valid = ((r2_valid & (~(w1_valid & (r2_addr[7:0] ==
                w1_addr[7:0])))) & (~(w2_valid & (r2_addr[7:0] == w2_addr[7:0]))
                ));

        initial begin
          for (i = 0; (i <= 255); i = (i + 1)) begin
            data_array[i] = {39 {1'b0}};
          end
        end
        always @(negedge clk) begin
          if (masked_r1_valid) begin
            r1_data[38:0] <= data_array[r1_addr[7:0]];
          end
          else
            begin
              r1_data[38:0] <= {39 {1'b0}};
            end
          if (masked_r2_valid) begin
            r2_data[38:0] <= data_array[r2_addr[7:0]];
          end
          else
            begin
              r2_data[38:0] <= {39 {1'b0}};
            end
          if (w1_valid & (~tcu_array_wr_inhibit)) begin
            data_array[w1_addr[7:0]] <= w1_data[38:0];
          end
          if (w2_valid & (~tcu_array_wr_inhibit)) begin
            data_array[w2_addr[7:0]] <= w2_data[38:0];
          end
        end

endmodule

`endif

