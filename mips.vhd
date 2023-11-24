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
	signal instruction_address: std_logic_vector(31 downto 0);-- Endereço da instrução
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
		  clk : in STD_LOGIC;
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
	 
	component alu_control 
	port (
			funct: in std_logic_vector(5 downto 0);
         alu_op: in std_logic_vector(1 downto 0);
         operation_code: out std_logic_vector(3 downto 0)
    );
	end component;
	
	component mux2_to_1_5bits 
    Port (
        input0 : in  std_logic_vector(4 downto 0); -- Entrada 0
        input1 : in  std_logic_vector(4 downto 0); -- Entrada 1
        op : in  std_logic; -- Sinal de seleção
        output : out std_logic_vector(4 downto 0) -- Saída
    );
	end component mux2_to_1_5bits;
	
	component sign_extender
	Port (
        input_16bit  : in  std_logic_vector(15 downto 0); -- Entrada de 16 bits
        output_32bit : out std_logic_vector(31 downto 0)  -- Saída de 32 bits
    );
	end component sign_extender;
	
	
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
	end component registers;
	
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
	
	next_address <= "00000000000000000000000000000100";
	PC1 : PC port map (
		clk => clk,
		pc_in => next_address,
		pc_out => instruction_address
	
	
	);

	 Instruc_Mem : instruction_memory port map (
		clk => clk,
	 	address => instruction_address,
		instruction => instruction
	);
	
	
	CONTROL1: control port map (
		opcode => opcode, -- ENTRA O OPCODE DA INSTRUCAO E GERA OS SINAIS ABAIXO
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
	
	write_data <= "00000000000000000000000011111100";
	
	
	Control_alu : alu_control port map (
        funct => funct,
        alu_op => alu_op,
        operation_code => alu_control_fuct
	);
	
	-- PC_ADDER: pc_increment_ula port map (
		--pc_input => instruction_address,
      -- pc_output => next_address	
	-- );
	
	mux_out_memory : mux2_to_1_5bits port map (
		  input0 => rt, -- Entrada 0
        input1 => rd, -- Entrada 1
        op => reg_dest,
        output => write_reg -- Saída
	);
	
	sign_extend : sign_extender port map (
		input_16bit => immediate, -- Entrada de 16 bits
      output_32bit => extended_immediate -- Saída de 32 bits
	
	);
	
	Regs : registers port map (
        clk => clk,
        reg_write => reg_write, -- SINAL SE ESCREVE OU NAO NO REG
        read_reg1 => rs, 
        read_reg2 => rt, 
        write_reg => write_reg, -- Número do registrador para escrita
        write_data => write_data, -- Dados a serem escritos
        read_data1 => read_data_1, -- Dados do primeiro registrador lido
        read_data2 => read_data_2 -- Dados do segundo registrador lido
    );
	
	
	


    process(clk)
    begin
        if rising_edge(clk) then
            example_counter <= example_counter + 1;
        end if;
    end process;
end beh;
