`include "./alu.v"
`include "./bigcontrol.v"
`include "./dr.v"
`include "./ir.v"
`include "./littlecontrol.v"
`include "./mem.v"
`include "./pc.v"
`include "./regfile.v"
`include "./signextend.v"
`include "./fin.v"
module multicycle(input clk, reset
                  );
    
    wire [31:0]  pc_value, alu_out, alu_result, jump_addr, data_1,data_2, mem_data, memdata_reg, signextend_result1,signextend_result_shift1;
    
    wire        Alu_SrcA, ze_ro, Pc_WriteCond, Pc_Write, Io_D, Mem_Read, Mem_Write, IR_write, Mem_toReg, Reg_Dst, Reg_Write ;
    wire [5:0]   op_code, fun_ct;
    wire [4:0]   r_s, r_t, r_d, sh_amt;
    wire [15:0]  imm_ediate;
    wire [2:0]   control_line;
    
    wire [1:0]   Pc_Source, Alu_SrcB, Alu_op;
    wire [25:0]  addr_26;
    pc pc(alu_result, jump_addr, alu_out, reset, clk, ze_ro, Pc_WriteCond, Pc_Write, Pc_Source, addr_26, pc_value );
    mem mem(pc_value, alu_out, data_2, Io_D, Mem_Read, Mem_Write, clk, mem_data );
    ir ir(mem_data, clk, IR_write, op_code, fun_ct, r_s, r_t, r_d, sh_amt, imm_ediate, addr_26);
    regfile regfile(r_s, r_t, r_d, alu_out, memdata_reg, Reg_Dst, Mem_toReg, Reg_Write,clk, data_1, data_2);
    
    dr dr (mem_data, clk, memdata_reg) ;
    alu alu(data_1, data_2, pc_value, signextend_result1, signextend_result_shift1, Alu_SrcB, Alu_SrcA, clk, control_line, alu_result, alu_out, ze_ro);
    signextend signextend(imm_ediate, signextend_result1);
    littlecontrol littlecontrol( Alu_op, fun_ct, control_line);
    fin fin(alu_result, pc_value, signextend_result1, addr_26, jump_addr, signextend_result_shift1);
    bigcontrol bigcontrol(clk, reset, op_code, Pc_WriteCond, Pc_Write, Io_D, Mem_Read, Mem_Write, Mem_toReg, IR_write, Reg_Dst, Reg_Write, Alu_SrcA, Alu_SrcB, Alu_op, Pc_Source);
endmodule // multicycle

 
    
    
     
