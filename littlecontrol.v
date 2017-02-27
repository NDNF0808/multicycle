//`timescale 1ps/1ps
module littlecontrol(
                     input [1:0]      Aluop,
                     input [5:0]      funct,
                     output reg [2:0] controlline
                     );
    always @ (*)
      begin
          
          controlline[2] = (funct[1] & Aluop[1]) | Aluop[0];
          controlline[1] = ~funct[2]| ~Aluop[1];
          controlline[0] = (funct[0] | funct[3]) & Aluop[1];
      end
endmodule // littlecontrol
 