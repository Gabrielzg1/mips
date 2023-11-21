library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- Adicionado para operações numéricas

entity mips is
    port(
        clk: in std_logic;
        example_counter: buffer integer := 0
    );
end mips;

architecture beh of mips is

--	-- Sinais /  Valores Dos 'fios' 
	signal instr_address: std_logic_vector(31 downto 0); -- Endereço da instrução
	signal next_address: std_logic_vector(31 downto 0); -- Proximo endereço de PC
	signal instruction: std_logic_vector(31 downto 0); -- Instrução atual
	signal read_data_1, read_data_2, write_data, extended_immediate, shifted_immediate, alu_in_2, alu_result, incremented_address, add2_result, mux4_result, concatenated_pc_and_jump_address, mem_read_data: std_logic_vector(31 downto 0):= "00000000000000000000000000000000";
	signal shifted_jump_address: std_logic_vector(27 downto 0);
	signal jump_address: std_logic_vector(25 downto 0);
	signal immediate: std_logic_vector(15 downto 0);
	signal opcode, funct: std_logic_vector(5 downto 0);
	signal rs, rt, rd, shampt, write_reg: std_logic_vector(4 downto 0);
	signal alu_control_fuct: std_logic_vector(3 downto 0);

	
	-- Instanciando todos os componentens
	component PC
		 Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        pc_in : in STD_LOGIC_VECTOR (31 downto 0);
        pc_write : in STD_LOGIC;
        pc_out : out STD_LOGIC_VECTOR (31 downto 0)
    );
	end component;
	
	component instruction_memory
	Port (
        address : in std_logic_vector(31 downto 0); -- Endereço de 32 bits
        instruction : out std_logic_vector(31 downto 0) -- Instrução de 32 bits
    );
	 end component;
	 
	 component data_memory
	 Port (
        address   : in  std_logic_vector(7 downto 0); -- Endereço de 8 bits
        write_data   : in  std_logic_vector(31 downto 0); -- Dados para escrita de 32 bits
        mem_read  : in  std_logic; -- Sinal de controle para leitura
        mem_write : in  std_logic; -- Sinal de controle para escrita
        data_out  : out std_logic_vector(31 downto 0) -- Dados lidos de 32 bits
    );
	 end component;
	 
	 component registers
	  Port (
        clk : in std_logic;
        reg_write : in std_logic; -- Sinal para controlar a escrita no registrador
        read_reg1 : in std_logic_vector(4 downto 0); -- Número do primeiro registrador para leitura
        read_reg2 : in std_logic_vector(4 downto 0); -- Número do segundo registrador para leitura
        write_reg : in std_logic_vector(4 downto 0); -- Número do registrador para escrita
        write_data : in std_logic_vector(31 downto 0); -- Dados a serem escritos
        read_data1 : out std_logic_vector(31 downto 0); -- Dados do primeiro registrador lido
        read_data2 : out std_logic_vector(31 downto 0) -- Dados do segundo registrador lido
    );
	 end component;
	 
	 component sign_extender
	 Port (
        input_16bit  : in  std_logic_vector(15 downto 0); -- Entrada de 16 bits
        output_32bit : out std_logic_vector(31 downto 0)  -- Saída de 32 bits
    );
	 end component;
	 
	 component control
	  port (
        opcode: in std_logic_vector(5 downto 0);
        reg_dest, jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write: out std_logic;
        alu_op: out std_logic_vector(1 downto 0)
    );
	 end component;
	 -- 3 Ulas diferentes --> cada uma tem uma funcao 
	 
	 -- Ula para as operacoes em geral (principal)
	 component arithmetic_ula 
	 port (
		input_a, input_b: std_logic_vector(31 downto 0);
		operation_code: in std_logic_vector(3 downto 0);
		flag_zero: out std_logic;
		result: out std_logic_vector(31 downto 0)
	);
	end component;
	
	-- Ula para somar 4 em pc, entra o valor atual e sai somado 
	component pc_increment_ula
	 Port (
        pc_input : in std_logic_vector(31 downto 0);
        pc_output : out std_logic_vector(31 downto 0)
    );
	 end component;
	 
	 -- Ula para somar o endereco extendido e ajustado em pc
	 component address_calc_ula
	 Port (
        input1 : in std_logic_vector(31 downto 0);
        input2 : in std_logic_vector(31 downto 0);
        result : out std_logic_vector(31 downto 0)
    );
	 end component;
	 
	 component mux2_to_1
	 Port (
        input0 : in  std_logic_vector(31 downto 0); -- Entrada 0
        input1 : in  std_logic_vector(31 downto 0); -- Entrada 1
        op : in  std_logic; -- Sinal de seleção
        output : out std_logic_vector(31 downto 0) -- Saída
    );
	 end component;
	 
	 component shift_left_2
	 Port (
        input : in  std_logic_vector(31 downto 0); -- Entrada de 32 bits
        output : out std_logic_vector(31 downto 0) -- Saída de 32 bits
    );
	 end component;
	 
	 component alu_control
	 port (
        funct: in std_logic_vector(5 downto 0);
        alu_op: in std_logic_vector(1 downto 0);
        operation_code: out std_logic_vector(3 downto 0)
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


    process(clk)
    begin
        if rising_edge(clk) then
            example_counter <= example_counter + 1;
        end if;
    end process;
end beh;
