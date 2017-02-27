
module bigcontrol(
                  input            clk, reset,
                  input [5:0]      opcode,
                  output           PcWriteCond, PcWrite, IoD,MemRead, MemWrite, MemtoReg,IRwrite, RegDst, RegWrite, AluSrcA, 
                  output  [1:0] AluSrcB, Aluop, PcSource
                  );
    reg [3:0]                  state, nextstate;
    parameter s0 = 4'b0000;
    parameter s1 = 4'b0001;
    parameter s2 = 4'b0010;
    parameter s3 = 4'b0011;
    parameter s4 = 4'b0100;
    parameter s5 = 4'b0101;
    parameter s6 = 4'b0110;
    parameter s7 = 4'b0111;
    parameter s8 = 4'b1000;
    parameter s9 = 4'b1001;
    parameter s10 = 4'b1010;
    parameter s11 = 4'b1011;
    
    //////////////////////状态寄存器///////////////
always @ (posedge reset, posedge clk)
  begin
  if (reset)
    state <= s0;
  else
    state <= nextstate;
  end
    
    //////////////////////////////次态逻辑///////////////
 always @ (*)
   begin
       if (state == s0)
         nextstate = s1;
       else if((state == s1)  && (opcode == 6'b100011 || opcode == 6'b101011) )
         nextstate = s2;
       else if( (state == s2) && (opcode == 6'b100011))
         nextstate = s3;
       else if (state == s3)
         nextstate = s4;
       else if (state == s2 && (opcode == 6'b101011))
         nextstate = s5;
       else if(state == s1 && opcode ==6'b000000)
         nextstate = s6;
       else if(state == s6 )
         nextstate = s7;
       else if(state == s1 && opcode ==6'b000100)
         nextstate = s8;
       else if(state == s1 && opcode == 6'b001000)
         nextstate = s9;
       else if(state == s9 )
         nextstate = s10;
       else if (state == s1 && opcode == 6'b000010)
         nextstate = s11;
       
       else if (state == s4 || state == s5 || state == s7 || state == s8 || state == s10 || state == s11 )
         nextstate = s0;
   end // always @ (*)
    /////////////////////////////输出逻辑//////////////////////
    assign      PcWrite = (state == s0 || state == s11) ? 1:0;
      assign     PcWriteCond = (state == s8) ? 1:0;
    assign      IoD = (state == s3 || state == s5) ? 1:0;
    assign       MemRead = (state == s0 ||  state == s3) ? 1:0;
    assign      MemWrite = (state == s5 ) ? 1:0;
    assign  IRwrite = (state == s0) ? 1:0;
    assign       MemtoReg = (state == s4) ? 1 :0;
    assign        PcSource[1] = (state == s11) ? 1:0;
    assign        PcSource[0] = (state == s8) ? 1:0;
    assign       Aluop[1] = (state == s6) ? 1:0;
    assign       Aluop[0] = (state == s8) ? 1:0;
    assign         AluSrcB[1] = (state ==s1 || state == s2 || state == s9) ? 1:0;
    assign        AluSrcB[0] = (state == s0 || state == s1) ? 1:0;
    assign        AluSrcA = (state == s2 || state == s6 || state == s8 || state == s9)? 1:0;
    assign        RegWrite = (state == s4 || state == s7 || state == s10) ? 1:0;
    assign        RegDst = (state == s7) ? 1:0;
    
endmodule // bigcontrol
