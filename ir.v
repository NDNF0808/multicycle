



module ir(
           input [31:0]      memdata,
           input             clk, IRwrite,
           output reg [5:0]  opcode, funct,
           output reg [4:0]  rs, rt, rd, shamt,
           output reg [15:0] immediate,
           output reg [25:0] addr26);
reg   [31:0] currentmemdata;

    always @ (posedge  clk)
      begin
          if (IRwrite)
            currentmemdata  <= memdata;
      end
    always @ (*)
      begin
          opcode = currentmemdata[31:26];
          funct = currentmemdata [5:0];
          rs = currentmemdata [25:21];
          rt = currentmemdata [20:16];
          rd = currentmemdata [15:11];
          shamt = currentmemdata [10:6];
          immediate = currentmemdata [15:0];
          addr26 = currentmemdata [25:0];
      end // always @ (*)
endmodule // ir

          
      