library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 -- Adicionado para operações numéricas

entity mips is
    port(
        clk: in std_logic;
        example_counter: buffer integer := 0
    );
end mips;

architecture beh of mips is

--	-- Sinais /  Valores Dos 'fios' 
	signal instr_address: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";-- Endereço da instrução
	signal next_address: std_logic_vector(31 downto 0); -- Proximo endereço de PC
	signal instruction: std_logic_vector(31 downto 0); -- Instrução atual
	signal read_data_1, read_data_2, write_data, extended_immediate, shifted_immediate, alu_in_2, alu_result, incremented_address, address_adder_result, mux4_result, concatenated_pc_and_jump_address, mem_read_data: std_logic_vector(31 downto 0):= "00000000000000000000000000000000";
	signal shifted_jump_address: std_logic_vector(27 downto 0);
	signal jump_address: std_logic_vector(25 downto 0);
	signal immediate: std_logic_vector(15 downto 0);
	signal opcode, funct: std_logic_vector(5 downto 0);
	signal rs, rt, rd, shampt, write_reg: std_logic_vector(4 downto 0);
	signal alu_control_fuct: std_logic_vector(3 downto 0);
	signal alu_op: std_logic_vector(1 downto 0);
	
	-- saidas do CONTROL + sinal do branch	
	signal reg_dest, jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, alu_zero, branch_and_alu_zero: std_logic:= '0';
	
	
	
	-- Instanciando todos os componentens
	component PC
		 Port (
        clk : in STD_LOGIC;
        pc_in : in STD_LOGIC_VECTOR (31 downto 0); -- Endereço de entrada
        pc_out : out STD_LOGIC_VECTOR (31 downto 0) -- Endereço atual (saída)
    );
    
	end component;
	
	
	component control
        port(
            opcode: in std_logic_vector(5 downto 0);
            reg_dest, jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write: out std_logic;
            alu_op: out std_logic_vector(1 downto 0)
        );
    end component;

	
	component instruction_memory
	Port (
        address : in std_logic_vector(31 downto 0); -- Endereço de 32 bits
        instruction : out std_logic_vector(31 downto 0) -- Instrução de 32 bits
    );
	 end component;
	

	 	
	-- Ula para somar 4 em pc, entra o valor atual e sai somado 
	component pc_increment_ula
	 Port (
        pc_input : in std_logic_vector(31 downto 0);
        pc_output : out std_logic_vector(31 downto 0)
    );
	 end component;

	
begin
	opcode <= instruction(31 downto 26);
	rs <= instruction(25 downto 21);
	rt <= instruction(20 downto 16);
	rd <= instruction(15 downto 11);
	shampt <= instruction(10 downto 6);
	funct <= instruction(5 downto 0);
	immediate <= instruction(15 downto 0);
	jump_address <= instruction(25 downto 0);
	
	
	-- MAPEANDO AS PORTAS

	
	 Instruc_Mem : instruction_memory port map (
	 	address => instr_address,
		instruction => instruction
	);
	
	
	CONTROL1: control port map (
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
	


    process(clk)
    begin
        if rising_edge(clk) then
            example_counter <= example_counter + 1;
        end if;
    end process;
end beh;
