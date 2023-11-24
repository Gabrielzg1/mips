library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control_tb is
-- Testbench entities do not have ports
end control_tb;

architecture behavior of control_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component control
        port(
            opcode: in std_logic_vector(5 downto 0);
            reg_dest, jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write: out std_logic;
            alu_op: out std_logic_vector(1 downto 0)
        );
    end component;

    -- Inputs
    signal opcode: std_logic_vector(5 downto 0) := (others => '0');

    -- Outputs
    signal reg_dest, jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write: std_logic;
    signal alu_op: std_logic_vector(1 downto 0);

    -- Instantiate the Unit Under Test (UUT)
    begin
        uut: control PORT MAP (
            opcode => opcode,
            reg_dest => reg_dest,
            jump => jump,
            branch => branch,
            mem_read => mem_read,
            mem_to_reg => mem_to_reg,
            mem_write => mem_write,
            alu_src => alu_src,
            reg_write => reg_write,
            alu_op => alu_op
        );

    -- Testbench process
    process
    begin
        -- Test with different opcodes
        opcode <= "000000"; -- R-types
        wait for 10 ns;

        opcode <= "001000"; -- addi
        wait for 10 ns;

        opcode <= "000100"; -- beq
        wait for 10 ns;
		  
		  opcode <= "000010"; -- jump
        wait for 10 ns;
		  
		  opcode <= "100011"; -- lw
        wait for 10 ns;
		  
		  opcode <= "101011"; -- sw
        wait for 10 ns;

        -- Add tests for other opcodes...
        -- ...
        
        -- End simulation
        wait;
    end process;
end behavior;
