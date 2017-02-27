module mem(
           input [31:0]      pcvalue, aluout, data2,
           input             IoD, MemRead, MemWrite, clk,
           output reg [31:0] memdata);
    wire [31:0]          address;
    reg [31:0]           mem [2**16-1:0];
    
    assign address = (IoD) ? aluout :pcvalue;
    initial
      begin
          $readmemh ("mem.txt", mem, 0, 99);
      end
    always @ (*)
      begin
          if (MemRead)
            memdata = mem[address]; 
          
      end
    
    always @ (posedge clk)
      begin
            if (MemWrite)
              mem[address] <= data2;
      end
    
endmodule // mem


    