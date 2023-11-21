------------------------------------------------------
-- Control Component
--
-- - reg_dest: use rd as the destination register
-- - jump: jump to the address
-- - branch: 
-- - mem_read: read from data memory
-- - mem_to_reg: write a value from data memory to a register
-- - mem_write: write to data memory
-- - alu_src: use the immediate as the second parameter of the ALU
-- - reg_write: write to a register
-- - alu_op: command to use in the alu control
------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control is
    port (
        opcode: in std_logic_vector(5 downto 0);
        reg_dest, jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write: out std_logic;
        alu_op: out std_logic_vector(1 downto 0)
    );
end control;

architecture behavior of control is
begin
    -- Assigning control signals based on opcode

    --				           R-types				        addi				           beq                            bne                            jump                           lw                               sw
	reg_dest <= 	'1' when opcode="000000"  else '0' when opcode="001000"  else '0' when opcode="000100"  else '0' when opcode="000101"  else '0' when opcode="000010"  else '0' when opcode="100011"  else '0' when opcode="101011"  else '0';
	jump <=			'0' when opcode="000000"  else '0' when opcode="001000"  else '0' when opcode="000100"  else '0' when opcode="000101"  else '1' when opcode="000010"  else '0' when opcode="100011"  else '0' when opcode="101011"  else '0';
	branch <=		'0' when opcode="000000"  else '0' when opcode="001000"  else '1' when opcode="000100"  else '1' when opcode="000101"  else '0' when opcode="000010"  else '0' when opcode="100011"  else '0' when opcode="101011"  else '0';
	mem_read <=		'0' when opcode="000000"  else '0' when opcode="001000"  else '0' when opcode="000100"  else '0' when opcode="000101"  else '0' when opcode="000010"  else '1' when opcode="100011"  else '0' when opcode="101011"  else '0';
	mem_to_reg <= 	'0' when opcode="000000"  else '0' when opcode="001000"  else '0' when opcode="000100"  else '0' when opcode="000101"  else '0' when opcode="000010"  else '1' when opcode="100011"  else '0' when opcode="101011"  else '0';
	mem_write <= 	'0' when opcode="000000"  else '0' when opcode="001000"  else '0' when opcode="000100"  else '0' when opcode="000101"  else '0' when opcode="000010"  else '0' when opcode="100011"  else '1' when opcode="101011"  else '0';
	alu_src <= 		'0' when opcode="000000"  else '1' when opcode="001000"  else '0' when opcode="000100"  else '0' when opcode="000101"  else '0' when opcode="000010"  else '1' when opcode="100011"  else '1' when opcode="101011"  else '0';
	reg_write <= 	'1' when opcode="000000"  else '1' when opcode="001000"  else '0' when opcode="000100"  else '0' when opcode="000101"  else '0' when opcode="000010"  else '1' when opcode="100011"  else '0' when opcode="101011"  else '0';
	alu_op <= 		"10" when opcode="000000" else "00" when opcode="001000" else "01" when opcode="000100" else "11" when opcode="000101" else "00" when opcode="000010" else "00" when opcode="100011"  else "00" when opcode="101011"  else "00";
	
end behavior;
