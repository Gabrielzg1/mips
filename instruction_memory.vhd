library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 


entity instruction_memory is
    Port (
        address : in std_logic_vector(31 downto 0); -- Endereço de 32 bits
        instruction : out std_logic_vector(31 downto 0) -- Instrução de 32 bits
    );
end instruction_memory;

architecture Behavioral of instruction_memory is
	
    type memory_array is array (0 to 255) of std_logic_vector(31 downto 0);
	 -- Inserir o progama do fibonnaci aqui: 
    signal memory : memory_array := (
        0 => "00100000010000010000000000000101",  
        1 => "00100000010000010000000000000101", 
        -- Restante ...
		  
        others => (others => '0') 
    );
begin
    -- Processo para ler a instrução da memória
    process(address)
    begin
        instruction <= memory(to_integer(unsigned(address)));
    end process;
end Behavioral;
