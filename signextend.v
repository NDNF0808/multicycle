//`timescale 1ps/1ps

module signextend(input [15:0] immediate,
                  output [31:0] signextend_result);
    assign signextend_result = {{16{immediate[15]}},immediate};
endmodule // signextend
