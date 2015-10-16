// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: n2_ict_sp_1920b_cust.v
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
module n2_ict_sp_1920b_cust (
  l2clk, 
  scan_in, 
  tcu_pce_ov, 
  tcu_scan_en, 
  tcu_aclk, 
  tcu_bclk, 
  tcu_se_scancollar_in, 
  tcu_array_wr_inhibit, 
  agd_ic_index_bf, 
  agc_fill_wrway_bf, 
  ftp_tg_rd_req_bf, 
  ftp_tg_wr_req_bf, 
  ftp_tg_clk_en, 
  agd_ict_wrtag_bf, 
  ict_itlb_way_0_tag_f, 
  ict_itlb_way_1_tag_f, 
  ict_itlb_way_2_tag_f, 
  ict_itlb_way_3_tag_f, 
  ict_itlb_way_4_tag_f, 
  ict_itlb_way_5_tag_f, 
  ict_itlb_way_6_tag_f, 
  ict_itlb_way_7_tag_f, 
  scan_out)  ;
wire l1clk_din;
wire l1clk_in;
wire l1clk_array;
wire pce_ov;
wire stop;
wire siclk;
wire soclk;
wire wr_inhibit;
wire [2:0] wrway_b;
wire [7:0] wrway_dec_b;
wire wr_inhibit_;
wire wrreq_b;
wire [7:0] wr_en_way_b;
wire [7:0] wr_en_way_f;
wire [7:0] wr_en_unused;
wire wrway_reg_scanin;
wire wrway_reg_scanout;
wire [2:0] wrway_b_unused;
wire index_reg_i_5_scanin;
wire index_reg_i_5_scanout;
wire [10:5] index_f;
wire [10:5] index_f_l_unused;
wire index_reg_i_6_scanin;
wire index_reg_i_6_scanout;
wire index_reg_i_7_scanin;
wire index_reg_i_7_scanout;
wire index_reg_i_8_scanin;
wire index_reg_i_8_scanout;
wire index_reg_i_9_scanin;
wire index_reg_i_9_scanout;
wire index_reg_i_10_scanin;
wire index_reg_i_10_scanout;
wire rdreq_reg_scanin;
wire rdreq_reg_scanout;
wire rdreq_a;
wire rdreq_f;
wire rdreq_f_unused;
wire wrreq_reg_scanin;
wire wrreq_reg_scanout;
wire wrreq_a;
wire rdreq_reg_dup_scanin;
wire rdreq_reg_dup_scanout;
wire rdreq_b;
wire rdreq_f_l_dup_unused;
wire wrreq_reg_dup_scanin;
wire wrreq_reg_dup_scanout;
wire wrreq_b_;
wire rd_en_b;
wire [29:0] wrtag_reg_in;
wire wrtag_reg_scanin;
wire wrtag_reg_scanout;
wire [29:0] wrtag_reg_out;
wire [29:0] ic_wrtag_f_l;
wire [29:0] ic_wrtag_f;


   input          l2clk;
   input          scan_in;
   input          tcu_pce_ov;
   input          tcu_scan_en;
   input          tcu_aclk;
   input          tcu_bclk;
   input          tcu_se_scancollar_in;
   input          tcu_array_wr_inhibit;

   input [10:5]   agd_ic_index_bf;
   input [2:0]    agc_fill_wrway_bf;     // way to write to, this is
                                     	       // sent by the l2c over the cpx
   input          ftp_tg_rd_req_bf;
   input          ftp_tg_wr_req_bf;
   input          ftp_tg_clk_en;


   
   input [29:0]   agd_ict_wrtag_bf;      // tag + 1b parity

   output [29:0]  ict_itlb_way_0_tag_f; // Tag compare is done in TLB block
   output [29:0]  ict_itlb_way_1_tag_f; // Tag compare is done in TLB block
   output [29:0]  ict_itlb_way_2_tag_f; // Tag compare is done in TLB block
   output [29:0]  ict_itlb_way_3_tag_f; // Tag compare is done in TLB block
   output [29:0]  ict_itlb_way_4_tag_f; // Tag compare is done in TLB block
   output [29:0]  ict_itlb_way_5_tag_f; // Tag compare is done in TLB block
   output [29:0]  ict_itlb_way_6_tag_f; // Tag compare is done in TLB block
   output [29:0]  ict_itlb_way_7_tag_f; // Tag compare is done in TLB block
   output         scan_out;

`ifndef FPGA
// synopsys translate_off
`endif

//================================================
// Clock headers
//================================================
// This clock gates the wrtag input flops.
n2_ict_sp_1920b_cust_l1clkhdr_ctl_macro l1ch_din (
        .l2clk  (l2clk),
        .l1en   (ftp_tg_clk_en),
        .se     (tcu_se_scancollar_in),
        .l1clk  (l1clk_din),
  .pce_ov(pce_ov),
  .stop(stop)
);



n2_ict_sp_1920b_cust_l1clkhdr_ctl_macro l1ch_in (
        .l2clk  (l2clk),
        .l1en   (1'b1),
        .se     (tcu_se_scancollar_in),
        .l1clk  (l1clk_in),
  .pce_ov(pce_ov),
  .stop(stop)
);

// This clock gates the array and internal logic.
n2_ict_sp_1920b_cust_l1clkhdr_ctl_macro l1ch_free (
        .l2clk  (l2clk),
        .l1en   (ftp_tg_clk_en),
        .se     (tcu_scan_en),
        .l1clk  (l1clk_array),
  .pce_ov(pce_ov),
  .stop(stop)
);





   assign pce_ov = tcu_pce_ov;
   assign stop   = 1'b0;
   assign siclk  = tcu_aclk ;
   assign soclk  = tcu_bclk;
   assign wr_inhibit  = tcu_array_wr_inhibit;


   ///////////////////////
   // Code starts here 
   ///////////////////////
   // assign wr_en_way_0_f = wrreq_f & (wrway_f[2:0] == 3'b000) ;  
   // assign wr_en_way_1_f = wrreq_f & (wrway_f[2:0] == 3'b001) ;  
   // assign wr_en_way_2_f = wrreq_f & (wrway_f[2:0] == 3'b010) ;  
   // assign wr_en_way_3_f = wrreq_f & (wrway_f[2:0] == 3'b011) ;  
   // assign wr_en_way_4_f = wrreq_f & (wrway_f[2:0] == 3'b100) ;  
   // assign wr_en_way_5_f = wrreq_f & (wrway_f[2:0] == 3'b101) ;  
   // assign wr_en_way_6_f = wrreq_f & (wrway_f[2:0] == 3'b110) ;  
   // assign wr_en_way_7_f = wrreq_f & (wrway_f[2:0] == 3'b111) ;  

   //////////////////////////////////////////////////////////
   // 4:8 decode                                           //
   //////////////////////////////////////////////////////////
   n2_ict_sp_1920b_cust_mux_macro__mux_aodec__ports_8__width_8 wr_way_decode    (
        .din0   (8'b00000001),
        .din1   (8'b00000010),
        .din2   (8'b00000100),
        .din3   (8'b00001000),
        .din4   (8'b00010000),
        .din5   (8'b00100000),
        .din6   (8'b01000000),
        .din7   (8'b10000000),
        .sel    (wrway_b[2:0]),
        .dout   (wrway_dec_b[7:0])
   );

n2_ict_sp_1920b_cust_inv_macro__width_1 wr_inhibit_gate   (
    .din(wr_inhibit),
    .dout(wr_inhibit_)
);

n2_ict_sp_1920b_cust_and_macro__ports_3__width_8 wr_en_gate    (
    .din0(wrway_dec_b[7:0]),
    .din1({8{wrreq_b}}),
    .din2({8{wr_inhibit_}}),
    .dout(wr_en_way_b[7:0])
);


assign wr_en_way_f[7:0] = wr_en_way_b[7:0] ;
assign wr_en_unused[7:0] = wr_en_way_f[7:0] ;

   ///////////////////////////////////////////////////////////////
   // Scan chain connections                                    //
   ///////////////////////////////////////////////////////////////
   ///////////////////////////////////////////////////////////////
   // Flop the inputs                                           //
   ///////////////////////////////////////////////////////////////
 n2_ict_sp_1920b_cust_tisram_msff_macro__width_3      wrway_reg                (
  .scan_in(wrway_reg_scanin),
  .scan_out(wrway_reg_scanout),
  .l1clk ( l1clk_in                             ),
  .d ( agc_fill_wrway_bf[2:0]                   ),
  .latout( wrway_b[2:0]                         ),
  .latout_l( wrway_b_unused[2:0]                ),
  .siclk(siclk),
  .soclk(soclk));

 n2_ict_sp_1920b_cust_tisram_msff_macro__width_1      index_reg_i_5              (
  .scan_in(index_reg_i_5_scanin),
  .scan_out(index_reg_i_5_scanout),
  .l1clk ( l1clk_in                             ),
  .d ( agd_ic_index_bf[5]                    ),
  .latout( index_f[5]                        ),
  .latout_l( index_f_l_unused[5]            ),
  .siclk(siclk),
  .soclk(soclk));


 n2_ict_sp_1920b_cust_tisram_msff_macro__width_1      index_reg_i_6              (
  .scan_in(index_reg_i_6_scanin),
  .scan_out(index_reg_i_6_scanout),
  .l1clk ( l1clk_in                             ),
  .d ( agd_ic_index_bf[6]                    ),
  .latout( index_f[6]                        ),
  .latout_l( index_f_l_unused[6]            ),
  .siclk(siclk),
  .soclk(soclk));


 n2_ict_sp_1920b_cust_tisram_msff_macro__width_1      index_reg_i_7              (
  .scan_in(index_reg_i_7_scanin),
  .scan_out(index_reg_i_7_scanout),
  .l1clk ( l1clk_in                             ),
  .d ( agd_ic_index_bf[7]                    ),
  .latout( index_f[7]                        ),
  .latout_l( index_f_l_unused[7]            ),
  .siclk(siclk),
  .soclk(soclk));


 n2_ict_sp_1920b_cust_tisram_msff_macro__width_1      index_reg_i_8              (
  .scan_in(index_reg_i_8_scanin),
  .scan_out(index_reg_i_8_scanout),
  .l1clk ( l1clk_in                             ),
  .d ( agd_ic_index_bf[8]                    ),
  .latout( index_f[8]                        ),
  .latout_l( index_f_l_unused[8]            ),
  .siclk(siclk),
  .soclk(soclk));


 n2_ict_sp_1920b_cust_tisram_msff_macro__width_1      index_reg_i_9              (
  .scan_in(index_reg_i_9_scanin),
  .scan_out(index_reg_i_9_scanout),
  .l1clk ( l1clk_in                             ),
  .d ( agd_ic_index_bf[9]                    ),
  .latout( index_f[9]                        ),
  .latout_l( index_f_l_unused[9]            ),
  .siclk(siclk),
  .soclk(soclk));


 n2_ict_sp_1920b_cust_tisram_msff_macro__width_1      index_reg_i_10              (
  .scan_in(index_reg_i_10_scanin),
  .scan_out(index_reg_i_10_scanout),
  .l1clk ( l1clk_in                             ),
  .d ( agd_ic_index_bf[10]                    ),
  .latout( index_f[10]                        ),
  .latout_l( index_f_l_unused[10]            ),
  .siclk(siclk),
  .soclk(soclk));



 n2_ict_sp_1920b_cust_msff_ctl_macro__width_1      rdreq_reg                (
  .scan_in(rdreq_reg_scanin),
  .scan_out(rdreq_reg_scanout),
  .l1clk ( l1clk_in                             ),
  .din ( ftp_tg_rd_req_bf                         ),
  .dout( rdreq_a                              ),
  .siclk(siclk),
  .soclk(soclk)) ;

assign rdreq_f = rdreq_a ;
assign rdreq_f_unused = rdreq_f ;

 n2_ict_sp_1920b_cust_msff_ctl_macro__width_1      wrreq_reg                (
  .scan_in(wrreq_reg_scanin),
  .scan_out(wrreq_reg_scanout),
  .l1clk ( l1clk_in                             ),
  .din ( ftp_tg_wr_req_bf                         ),
  .dout( wrreq_a                              ),
  .siclk(siclk),
  .soclk(soclk)) ;

 n2_ict_sp_1920b_cust_tisram_msff_macro__width_1      rdreq_reg_dup                (
  .scan_in(rdreq_reg_dup_scanin),
  .scan_out(rdreq_reg_dup_scanout),
  .l1clk ( l1clk_in                             ),
  .d ( ftp_tg_rd_req_bf                         ),
  .latout( rdreq_b                              ),
  .latout_l( rdreq_f_l_dup_unused                     ),
  .siclk(siclk),
  .soclk(soclk));


 n2_ict_sp_1920b_cust_tisram_msff_macro__width_1      wrreq_reg_dup                (
  .scan_in(wrreq_reg_dup_scanin),
  .scan_out(wrreq_reg_dup_scanout),
  .l1clk ( l1clk_in                             ),
  .d ( ftp_tg_wr_req_bf                         ),
  .latout( wrreq_b                              ),
  .latout_l( wrreq_b_                           ),
  .siclk(siclk),
  .soclk(soclk));


n2_ict_sp_1920b_cust_and_macro__ports_3__width_1 read_and   (
        .din0   (rdreq_b),
        .din1   (wrreq_b_),
        .din2   (wr_inhibit_),
        .dout   (rd_en_b)
);


   // write data regsiter

assign wrtag_reg_in[29:0] = {agd_ict_wrtag_bf[0],
                             agd_ict_wrtag_bf[1],
                             agd_ict_wrtag_bf[2],
                             agd_ict_wrtag_bf[3],
                             agd_ict_wrtag_bf[4],
                             agd_ict_wrtag_bf[5],
                             agd_ict_wrtag_bf[6],
                             agd_ict_wrtag_bf[7],
                             agd_ict_wrtag_bf[8],
                             agd_ict_wrtag_bf[9],
                             agd_ict_wrtag_bf[10],
                             agd_ict_wrtag_bf[11],
                             agd_ict_wrtag_bf[12],
                             agd_ict_wrtag_bf[13],
                             agd_ict_wrtag_bf[14],
                             agd_ict_wrtag_bf[15],
                             agd_ict_wrtag_bf[16],
                             agd_ict_wrtag_bf[17],
                             agd_ict_wrtag_bf[18],
                             agd_ict_wrtag_bf[19],
                             agd_ict_wrtag_bf[20],
                             agd_ict_wrtag_bf[21],
                             agd_ict_wrtag_bf[22],
                             agd_ict_wrtag_bf[23],
                             agd_ict_wrtag_bf[24],
                             agd_ict_wrtag_bf[25],
                             agd_ict_wrtag_bf[26],
                             agd_ict_wrtag_bf[27],
                             agd_ict_wrtag_bf[28],
                             agd_ict_wrtag_bf[29]} ;

n2_ict_sp_1920b_cust_msffi_ctl_macro__width_30	wrtag_reg    (
  .scan_in(wrtag_reg_scanin),
  .scan_out(wrtag_reg_scanout),
  .l1clk(l1clk_din),
  .din(wrtag_reg_in[29:0]),
  .q_l (wrtag_reg_out[29:0]				),
  .siclk(siclk),
  .soclk(soclk));

assign ic_wrtag_f_l[29:0] = {wrtag_reg_out[0],
                             wrtag_reg_out[1],
                             wrtag_reg_out[2],
                             wrtag_reg_out[3],
                             wrtag_reg_out[4],
                             wrtag_reg_out[5],
                             wrtag_reg_out[6],
                             wrtag_reg_out[7],
                             wrtag_reg_out[8],
                             wrtag_reg_out[9],
                             wrtag_reg_out[10],
                             wrtag_reg_out[11],
                             wrtag_reg_out[12],
                             wrtag_reg_out[13],
                             wrtag_reg_out[14],
                             wrtag_reg_out[15],
                             wrtag_reg_out[16],
                             wrtag_reg_out[17],
                             wrtag_reg_out[18],
                             wrtag_reg_out[19],
                             wrtag_reg_out[20],
                             wrtag_reg_out[21],
                             wrtag_reg_out[22],
                             wrtag_reg_out[23],
                             wrtag_reg_out[24],
                             wrtag_reg_out[25],
                             wrtag_reg_out[26],
                             wrtag_reg_out[27],
                             wrtag_reg_out[28],
                             wrtag_reg_out[29]} ;

n2_ict_sp_1920b_cust_inv_macro__width_30 data_inv  (
    .din(ic_wrtag_f_l[29:0]),
    .dout(ic_wrtag_f[29:0]) ) ;

/////////////////////////////////////////////////////////////////
// Instantiate each TAG way ARRAY.                             //
/////////////////////////////////////////////////////////////////
// WAY 0               ///////
//////////////////////////////
n2_ict_sp_1920b_array tag_way_0 (.addr(index_f[10:5]),        // comes on negedge
                                .rd_en_b(rd_en_b),            // comes on negedge
                                .wr_en_w_b(wr_en_way_b[0]),   // comes on negedge
                                .rd_en_a(rdreq_a),            // comes on posedge
                                .wrreq_a(wrreq_a),            // comes on posedge
                                .din(ic_wrtag_f[29:0]),
                                .dout(ict_itlb_way_0_tag_f[29:0]),
                                .clk(l1clk_array),
  .wr_inhibit(wr_inhibit)
                              );


//////////////////////////////
// WAY 1               ///////
//////////////////////////////
n2_ict_sp_1920b_array tag_way_1  (.addr(index_f[10:5]),
                                .rd_en_b(rd_en_b),            // comes on negedge
                                .wr_en_w_b(wr_en_way_b[1]),   // comes on negedge
                                .rd_en_a(rdreq_a),            // comes on posedge
                                .wrreq_a(wrreq_a),            // comes on posedge
                                .wr_inhibit(wr_inhibit),
                                .din(ic_wrtag_f[29:0]),
                                .dout(ict_itlb_way_1_tag_f[29:0]),
                                .clk(l1clk_array)
                              );
//////////////////////////////
// WAY 2               ///////
//////////////////////////////
n2_ict_sp_1920b_array tag_way_2  (.addr(index_f[10:5]),
                                .rd_en_b(rd_en_b),            // comes on negedge
                                .wr_en_w_b(wr_en_way_b[2]),   // comes on negedge
                                .rd_en_a(rdreq_a),            // comes on posedge
                                .wrreq_a(wrreq_a),            // comes on posedge
                                .wr_inhibit(wr_inhibit),
                                .din(ic_wrtag_f[29:0]),
                                .dout(ict_itlb_way_2_tag_f[29:0]),
                                .clk(l1clk_array)
                              );
//////////////////////////////
// WAY 3               ///////
//////////////////////////////
n2_ict_sp_1920b_array tag_way_3  (.addr(index_f[10:5]),
                                .rd_en_b(rd_en_b),            // comes on negedge
                                .wr_en_w_b(wr_en_way_b[3]),   // comes on negedge
                                .rd_en_a(rdreq_a),            // comes on posedge
                                .wrreq_a(wrreq_a),            // comes on posedge
                                .wr_inhibit(wr_inhibit),
                                .din(ic_wrtag_f[29:0]),
                                .dout(ict_itlb_way_3_tag_f[29:0]),
                                .clk(l1clk_array)
                              );
//////////////////////////////
// WAY 4               ///////
//////////////////////////////
n2_ict_sp_1920b_array tag_way_4  (.addr(index_f[10:5]),
                                .rd_en_b(rd_en_b),            // comes on negedge
                                .wr_en_w_b(wr_en_way_b[4]),   // comes on negedge
                                .rd_en_a(rdreq_a),            // comes on posedge
                                .wrreq_a(wrreq_a),            // comes on posedge
                                .wr_inhibit(wr_inhibit),
                                .din(ic_wrtag_f[29:0]),
                                .dout(ict_itlb_way_4_tag_f[29:0]),
                                .clk(l1clk_array)
                              );
//////////////////////////////
// WAY 5               ///////
//////////////////////////////
n2_ict_sp_1920b_array tag_way_5  (.addr(index_f[10:5]),
                                .rd_en_b(rd_en_b),            // comes on negedge
                                .wr_en_w_b(wr_en_way_b[5]),   // comes on negedge
                                .rd_en_a(rdreq_a),            // comes on posedge
                                .wrreq_a(wrreq_a),            // comes on posedge
                                .wr_inhibit(wr_inhibit),
                                .din(ic_wrtag_f[29:0]),
                                .dout(ict_itlb_way_5_tag_f[29:0]),
                                .clk(l1clk_array)
                              );
//////////////////////////////
// WAY 6               ///////
//////////////////////////////
n2_ict_sp_1920b_array tag_way_6  (.addr(index_f[10:5]),
                                .rd_en_b(rd_en_b),            // comes on negedge
                                .wr_en_w_b(wr_en_way_b[6]),   // comes on negedge
                                .rd_en_a(rdreq_a),            // comes on posedge
                                .wrreq_a(wrreq_a),            // comes on posedge
                                .wr_inhibit(wr_inhibit),
                                .din(ic_wrtag_f[29:0]),
                                .dout(ict_itlb_way_6_tag_f[29:0]),
                                .clk(l1clk_array)
                              );
//////////////////////////////
// WAY 7               ///////
//////////////////////////////
n2_ict_sp_1920b_array tag_way_7  (.addr(index_f[10:5]),
                                .rd_en_b(rd_en_b),            // comes on negedge
                                .wr_en_w_b(wr_en_way_b[7]),   // comes on negedge
                                .rd_en_a(rdreq_a),            // comes on posedge
                                .wrreq_a(wrreq_a),            // comes on posedge
                                .wr_inhibit(wr_inhibit),
                                .din(ic_wrtag_f[29:0]),
                                .dout(ict_itlb_way_7_tag_f[29:0]),
                                .clk(l1clk_array)
                              );
supply0 vss;
supply1 vdd;

// scan_in                  ->
// agc_fill_wrway_bf<2>     - 43th
// agc_fill_wrway_bf<1>     - 42th
// agc_fill_wrway_bf<0>     - 41th
// agd_ic_index_bf<5>       - 40th
// agd_ic_index_bf<6>       - 39th
// agd_ic_index_bf<7>       - 38th
// agd_ic_index_bf<8>       - 37th
// agd_ic_index_bf<9>       - 36th
// agd_ic_index_bf<10>      - 35th
// ftp_tg_rd_req_bf         - 34th
// ftp_tg_wr_req_bf         - 33th
// ftp_tg_rd_req_bf         - 32th
// ftp_tg_wr_req_bf         - 31th
// agd_ict_wrtag_bf<0>      - 30th
// agd_ict_wrtag_bf<1>      - 29th
// .....            ..      - ..
// agd_ict_wrtag_bf<27>     - 3rd
// agd_ict_wrtag_bf<28>     - 2nd
// agd_ict_wrtag_bf<29>     - 1st
// scan_out





// fixscan start:
assign wrway_reg_scanin          = scan_in                  ;
assign index_reg_i_5_scanin      = wrway_reg_scanout        ;
assign index_reg_i_6_scanin      = index_reg_i_5_scanout    ;
assign index_reg_i_7_scanin      = index_reg_i_6_scanout    ;
assign index_reg_i_8_scanin      = index_reg_i_7_scanout    ;
assign index_reg_i_9_scanin      = index_reg_i_8_scanout    ;
assign index_reg_i_10_scanin     = index_reg_i_9_scanout    ;
assign rdreq_reg_scanin          = index_reg_i_10_scanout   ;
assign wrreq_reg_scanin          = rdreq_reg_scanout        ;
assign rdreq_reg_dup_scanin      = wrreq_reg_scanout        ;
assign wrreq_reg_dup_scanin      = rdreq_reg_dup_scanout    ;
assign wrtag_reg_scanin          = wrreq_reg_dup_scanout    ;
assign scan_out                  = wrtag_reg_scanout        ;
// fixscan end:

`ifndef FPGA
// synopsys translate_on
`endif

endmodule // sparc_ifu_ict












// any PARAMS parms go into naming of macro

module n2_ict_sp_1920b_cust_l1clkhdr_ctl_macro (
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

module n2_ict_sp_1920b_cust_mux_macro__mux_aodec__ports_8__width_8 (
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


//
//   invert macro
//
//





module n2_ict_sp_1920b_cust_inv_macro__width_1 (
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





module n2_ict_sp_1920b_cust_and_macro__ports_3__width_8 (
  din0, 
  din1, 
  din2, 
  dout);
  input [7:0] din0;
  input [7:0] din1;
  input [7:0] din2;
  output [7:0] dout;






and3 #(8)  d0_0 (
.in0(din0[7:0]),
.in1(din1[7:0]),
.in2(din2[7:0]),
.out(dout[7:0])
);









endmodule





//
//   macro for cl_mc1_tisram_msff_{16,8}x flops
//
//





module n2_ict_sp_1920b_cust_tisram_msff_macro__width_3 (
  d, 
  scan_in, 
  l1clk, 
  siclk, 
  soclk, 
  scan_out, 
  latout, 
  latout_l);
wire [1:0] so;

input [2:0] d;
  input scan_in;
input l1clk;
input siclk;
input soclk;
  output scan_out;
output [2:0] latout;
output [2:0] latout_l;






tisram_msff #(3)  d0_0 (
.d(d[2:0]),
.si({scan_in,so[1:0]}),
.so({so[1:0],scan_out}),
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.latout(latout[2:0]),
.latout_l(latout_l[2:0])
);












//place::generic_place($width,$stack,$left);

endmodule





//
//   macro for cl_mc1_tisram_msff_{16,8}x flops
//
//





module n2_ict_sp_1920b_cust_tisram_msff_macro__width_1 (
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









// any PARAMS parms go into naming of macro

module n2_ict_sp_1920b_cust_msff_ctl_macro__width_1 (
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
//   and macro for ports = 2,3,4
//
//





module n2_ict_sp_1920b_cust_and_macro__ports_3__width_1 (
  din0, 
  din1, 
  din2, 
  dout);
  input [0:0] din0;
  input [0:0] din1;
  input [0:0] din2;
  output [0:0] dout;






and3 #(1)  d0_0 (
.in0(din0[0:0]),
.in1(din1[0:0]),
.in2(din2[0:0]),
.out(dout[0:0])
);









endmodule









// any PARAMS parms go into naming of macro

module n2_ict_sp_1920b_cust_msffi_ctl_macro__width_30 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  q_l, 
  scan_out);
wire [28:0] so;

  input [29:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [29:0] q_l;
  output scan_out;






msffi #(30)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(din[29:0]),
.si({scan_in,so[28:0]}),
.so({so[28:0],scan_out}),
.q_l(q_l[29:0])
);












endmodule









//
//   invert macro
//
//





module n2_ict_sp_1920b_cust_inv_macro__width_30 (
  din, 
  dout);
  input [29:0] din;
  output [29:0] dout;






inv #(30)  d0_0 (
.in(din[29:0]),
.out(dout[29:0])
);









endmodule






module n2_ict_sp_1920b_array (
  clk, 
  rd_en_b, 
  wr_en_w_b, 
  rd_en_a, 
  wrreq_a, 
  addr, 
  wr_inhibit, 
  din, 
  dout);
wire rd_en_b_unused;


`define WIDTH 30
`define ENTRIES 64
`define ADDRBITS 6


input			clk;
input	     		rd_en_b;	// comes on negedge
input	     		wr_en_w_b;	// comes on negedge (way specific)
input	     		rd_en_a;	// comes on posedge
input	     		wrreq_a;	// comes on posedge (not way specific)
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
    if (wr_en_w_b) begin
        mem[addr] <= din;



    end
end

// always @(clk or rd_en_a or wr_en_a or addr) begin
//    if (clk) begin
//      if (rd_en_a) begin
//          if (wr_en_a)
//              local_dout[`WIDTH-1:0] = `WIDTH'hx;
//          else    
//              local_dout[`WIDTH-1:0] = mem[addr] ;
//      end
//      else
//          local_dout[`WIDTH-1:0] = `WIDTH'h0;
// end

 always @(posedge clk) begin
  if (rd_en_b)
     local_dout[`WIDTH-1:0] <= mem[addr];
  else
     local_dout[`WIDTH-1:0] <= `WIDTH'h0;
 end

assign dout[`WIDTH-1:0] = local_dout[`WIDTH-1:0] & {`WIDTH{rd_en_a & ~wrreq_a & ~wr_inhibit}};

supply0 vss;
supply1 vdd;


endmodule

