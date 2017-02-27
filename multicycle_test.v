`include "./multicycle.v"
module test;
    reg clk, reset; 
    
    //reg [31:0]  branchaddr, writedate;
    
    
/*    wire [1:0] ALUOP;
    
    wire       RegDst, Branch1,MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
  */  
    
//    wire [31:0] date1, date2;
     //  wire [31:0] signextend_result;
    //wire [31:0] result;
    
    
    initial
      begin
          #0 reset = 0;
          #4 reset = ~ reset;
          #1 reset = ~ reset;
          
      end 
    initial
      begin
          #0 clk = 0;
          repeat(135)
            #4 clk = ~clk;
      end
    
   /* initial
      begin
          zero =0;
         // pcaddr = 'd2;
          branchaddr = 'd5;
          branch1 = 1;
          writedate = 'd3;
          
      end
    single_cycle single_cycle(.reset(reset),
                              .clk(clk),
                              .branch1(branch1),
                              .zero(zero),
//                              .pcaddr(pcaddr),
                              .branchaddr(branchaddr),
/*                              .ALUOP(ALUOP),
                              .RegDst(RegDst),
                              .Branch1(Branch1),
                              .MemRead(MemRead),
                              .MemWrite(MemWrite),
                              .MemtoReg(MemtoReg),
                              .ALUSrc(ALUSrc),
                              .RegWrite(RegWrite)
 
                             // .date1(date1),
                              //date2(date2),
                            //  .signextend_result(signextend_result),
                              //.pcaddr1(pcaddr1)
                              .result(result)
                              );
    */
    multicycle multicycle(clk, reset);
    
    
    initial
      begin
          $dumpfile("multicycle.vcd");
          $dumpvars(0,test);
      end
endmodule // test

                
