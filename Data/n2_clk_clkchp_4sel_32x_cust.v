// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: n2_clk_clkchp_4sel_32x_cust.v
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
module n2_clk_clkchp_4sel_32x_cust (tck, aclk, bclk, s500, s1000, s1500, s2000);
input tck, s500, s1000, s1500, s2000;
output aclk, bclk;

// synopsys translate_off

reg aclk, bclk;

initial
	begin
	aclk=1'b0;
	bclk=1'b0;
	end
always@(posedge tck)
	begin
        bclk=1'b0;
	#1 if(tck==1) aclk=1'b1;
        #1 if(s500==1) aclk=1'b0;
        #1 if(s1000==1) aclk=1'b0;
        #1 if(s1500==1) aclk=1'b0;
        #1  if(s2000==1) aclk=1'b0;
	end
always@(negedge tck)
	begin
	#1 if(tck==0 && aclk==0)   bclk=1'b1;
        #1 if(s500==1)   bclk=1'b0;
        #1 if(s1000==1) bclk=1'b0;
        #1 if(s1500==1) bclk=1'b0;
        #1 if(s2000==1) bclk=1'b0;
	end

// synopsys translate_on

endmodule
