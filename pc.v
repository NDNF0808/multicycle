`timescale 1ps/1ps
//`include "./mul2_1.v"
module pc(
          input [31:0]     aluresult, jumpaddr, aluout,
          input             reset, clk, zero, PcWriteCond, PcWrite, 
          input [1:0] PcSource,
         input [25:0] addr26,
          output reg [31:0] pcvalue);
    wire                    Pccontrol;
    assign Pccontrol = (zero & PcWriteCond) | PcWrite;
    
    
    always @ (posedge reset)
      pcvalue = 32'b0;
    
         
    always @(posedge clk)
      if (Pccontrol)
      begin
/*       multiplexer(    .a(branchaddr),
                                            .b(pcaddr),
                                             .y(prepc),
                                            .s(pcsrc)
                                            );
          
          multiplexer(.a(jumpaddr),
                                         .b(prepc),
                                         .y(pcvalue),
                                         .s(jump)
                                         );
 always 语句中不能调用模块
 */
/*     assign prepc = pcsrc? branchaddr : pcaddr;
          assign pcvalue = jump ? jumpaddr : prepc;
  不行，因为assign语句是并行执行的
 */        
          
     //    prepc <= (pcsrc) ? branchaddr : pcaddr;
       //   pcvalue <= (jump)?  jumpaddr : prepc;
          
  if (PcSource == 2'b00)
    pcvalue <= aluresult;
  else if(PcSource == 2'b01)
    pcvalue <= aluout;
  else if(PcSource == 2'b10)
    pcvalue <= jumpaddr;
          
 
end // always @ (posedge clk)
    
endmodule // pc
