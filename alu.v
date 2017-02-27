module alu(input [31:0] data1, data2, pcvalue, signextend_result, signextend_result_shift, 
          input [1:0] AluSrcB,
           input AluSrcA, clk,
           input [2:0] controlline,
           output reg  [31:0] aluresult, aluout,
           output zero
           );
    wire [31:0]   alusource1, alusource2;
  // reg  [31:0]   A, B;
  /*  always @ (posedge clk)
      begin
          A <= data1;
          B <= data2;
      end
    */
    assign alusource1 = (AluSrcA) ? data1 : pcvalue;
    assign alusource2 = (AluSrcB[1]) ? (AluSrcB[0] ? signextend_result_shift : signextend_result) 
      : (AluSrcB[0] ? 'd1 :data2);
    always @ (*)
      begin
        //  #150
              
            case (controlline)
              3'b000:    aluresult = alusource1 & alusource2;
              3'b001:  aluresult = alusource1 | alusource2;
              3'b010:   aluresult = alusource1 + alusource2;
              3'b110:  aluresult = alusource1 - alusource2;
              3'b111:  aluresult = (alusource1 < alusource2)? 1:0;
              default:  aluresult = 'd0;
              
            endcase // case (controlline)
      end // always @ (*)
    assign  zero = (alusource1 == alusource2)? 1:0;
    always @ (posedge clk)
      aluout <= aluresult;
    
endmodule // alu



      