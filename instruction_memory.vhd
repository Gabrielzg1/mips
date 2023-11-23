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
    signal memory : memory_array := (
		
        0 => "00100000010000010000000000000101",  -- addi r2, r1, 5  
        1 => "00100000010000010000000000000101",  
        -- Restante ...
        others => (others => '0') 
    );
begin
    -- Processo para ler a instrução da memória
    process(address)
    variable addr_index : integer;
    begin
        -- Considera o endereço como endereçamento baseado em palavras de 32 bits
        addr_index := to_integer(unsigned(address(31 downto 2)));
        if addr_index >= 0 and addr_index <= 255 then
            instruction <= memory(addr_index);
        else
            instruction <= (others => '0'); -- Valor padrão se fora do intervalo
        end if;
    end process;
end Behavioral;
