library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_memory is
    port (
       -- clk: in STD_LOGIC; -- Adicionando o sinal de clock
        address: in STD_LOGIC_VECTOR (31 downto 0);
        instruction: out STD_LOGIC_VECTOR (31 downto 0)
    );
end instruction_memory;

architecture behavioral of instruction_memory is

    -- 128 byte instruction memory (32 rows * 4 bytes/row)
    type mem_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
    signal data_mem: mem_array := ( 
        "00100000000000010000000000000001", -- Instrução addi Rn = 0 + valor fibbo 
	     "10101100000000010000000000000000", -- sw Rn, n(r0)
		  "00100000000000100000000000000001", -- Instrução addi Rn = 0 + valor fibbo 
	     "10101100000000100000000000000001", -- sw Rn, n(r0)
	     "00100000000000110000000000000010", -- Instrução addi Rn = 0 + valor fibbo 
        "10101100000000110000000000000010", -- sw Rn, n(r0)
		  
		  "00100000000001000000000000000011", -- Instrução addi Rn = 0 + valor fibbo 
		  "10101100000001000000000000000011", -- sw Rn, n(r0)
		  
		  "00100000000001010000000000000101", -- Instrução addi Rn = 0 + valor fibbo 
	     "10101100000001010000000000000100", -- sw Rn, n(r0)
        -- ... mais instruções ...
        others => "00000000000000000000000000000000" 
    );

begin
 
            -- Mapeia o endereço de leitura para a instrução correspondente
            instruction <= data_mem(to_integer(unsigned(address(31 downto 2))));
   
    
end behavioral;
