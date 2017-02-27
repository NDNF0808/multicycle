module regfile(input [4:0] rs, rt, rd,
               input [31:0] aluout, memdatareg,
               input RegDst, MemtoReg, RegWrite, clk,
               output reg [31:0] data1, data2
                
               );
    wire [4:0]               writereg;
    wire [31:0]              regwritedata;
    reg [31:0]               regfile [2**5-1:0];
   // reg [31:0]               regmem [2**5-1:0];
    initial
      begin
          $readmemh ("reg.txt", regfile, 0, 31);
      end
     
    
    assign writereg = (RegDst) ? rd: rt;
    assign regwritedata = (MemtoReg) ? memdatareg : aluout;
    always @ (negedge clk)
      if (RegWrite)
        regfile[writereg] <= regwritedata;
    assign #50  data1 = (rs != 0)? regfile [rs] : 0;
    assign #50 data2 = (rt != 0)? regfile [rt] : 0;
endmodule // regfi