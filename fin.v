module fin(input [31:0] aluresult, pcvalue ,signextend_result,
           input [25:0] addr26,
           output [31:0] jumpaddr,signextend_result_shift);
    assign jumpaddr = {pcvalue[31:28], addr26, 2'b0};
    //assign aluout = aluresult;
    assign signextend_result_shift = signextend_result<<2;
     
endmodule // fin

    