library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all; -- Para operações numéricas

entity unified_memory is
    Port ( 
        clk : in STD_LOGIC;
        mem_address : in STD_LOGIC_VECTOR (31 downto 0);
        mem_write_data : in STD_LOGIC_VECTOR (31 downto 0);
        mem_read_data : out STD_LOGIC_VECTOR (31 downto 0);
        mem_write : in STD_LOGIC; -- Sinal para controlar a escrita
        mem_read : in STD_LOGIC   -- Sinal para controlar a leitura
    );
end unified_memory;


architecture Behavioral of unified_memory is
    type memory_array is array (0 to 1023) of STD_LOGIC_VECTOR (31 downto 0);
    signal memory : memory_array;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if mem_write = '1' then
                memory(to_integer(unsigned(mem_address))) <= mem_write_data;
            end if;

            if mem_read = '1' then
                mem_read_data <= memory(to_integer(unsigned(mem_address)));
            end if;
        end if;
    end process;
end Behavioral;
