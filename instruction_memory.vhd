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

    type mem_array is array(0 to 63) of STD_LOGIC_VECTOR (31 downto 0);
    signal data_mem: mem_array := ( 
        "00100000000000010000000000000001", -- valor fibbo ------ 1
	     "10101100000000010000000000000001", --  mem [ 1 ]
		  
		  "00100000000000100000000000000001", -- valor fibbo ------ 1
	     "10101100000000100000000000000010", --   mem [ 2 ]
		  
	     "00100000000000110000000000000010", -- valor fibbo ------ 2
        "10101100000000110000000000000011", --  mem [ 3 ]
		 
		  "00100000000001000000000000000011", -- valor fibbo ------ 3
		  "10101100000001000000000000000100", --  mem [ 4 ]
		  
		  "00100000000001010000000000000101", -- valor fibbo ------ 5
	     "10101100000001010000000000000101", --  mem [ 5 ]
		  
		  "00100000000001100000000000001000", -- valor fibbo ------ 8
	     "10101100000001100000000000000110", --  mem [ 6 ]
		  
		  "00100000000001110000000000001101", -- valor fibbo ------ 13
	     "10101100000001110000000000000111", --  mem [ 7 ]
		  
		  
        -- ... mais instruções ...
        others => "00000000000000000000000000000000" 
    );

begin
 
            -- Mapeia o endereço de leitura para a instrução correspondente
            instruction <= data_mem(to_integer(unsigned(address(31 downto 2))));
   
    
end behavioral;
