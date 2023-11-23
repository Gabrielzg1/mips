library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Declaração da entidade
entity data_memory is
    Port (
        clk        : in  std_logic; -- Sinal de clock adicionado
        address    : in  std_logic_vector(31 downto 0);
        write_data : in  std_logic_vector(31 downto 0);
        mem_read   : in  std_logic;
        mem_write  : in  std_logic;
        data_out   : out std_logic_vector(31 downto 0)
    );
end data_memory;


-- Arquitetura da memória de dados
architecture Behavioral of data_memory is
    type memory_array is array (0 to 255) of std_logic_vector(31 downto 0);
    signal memory : memory_array := (others => (others => '0'));
begin
     process(clk)
    begin
        if rising_edge(clk) then
            if mem_read = '1' then
                data_out <= memory(to_integer(unsigned(address)));
            elsif mem_write = '1' then
                memory(to_integer(unsigned(address))) <= write_data;
            else
                data_out <= (others => '0');
            end if;
        end if;
    end process;
end Behavioral;
