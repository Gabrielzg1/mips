library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
-- Declaração da entidade

entity data_memory is
    Port (
        clk        : in  std_logic; -- Sinal de clock
        address    : in  std_logic_vector(31 downto 0);
        write_data : in  std_logic_vector(31 downto 0);
        mem_read   : in  std_logic;
        mem_write  : in  std_logic;
        data_out   : out std_logic_vector(31 downto 0)
    );
end data_memory;

-- Arquitetura da memória de dados
architecture Behavioral of data_memory is
    type memory_array is array (0 to 31) of std_logic_vector(31 downto 0); -- Tamanho corrigido
    signal memory : memory_array := (others => (others => '0'));
begin
    -- Leitura assíncrona
    data_out <= memory(conv_integer(address(6 downto 2))) when mem_read = '1' else (others => '0');
	 
    -- Processo sensível ao clock para escrita
    process(clk)
    begin
        if falling_edge(clk) then
            if mem_write = '1' then
                memory(conv_integer(address(6 downto 2))) <= write_data;
            end if;
        end if;
    end process;

end Behavioral;
