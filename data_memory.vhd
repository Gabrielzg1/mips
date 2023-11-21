library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Declaração da entidade
entity data_memory is
    Port (
        address   : in  std_logic_vector(7 downto 0); -- Endereço de 8 bits
        write_data   : in  std_logic_vector(31 downto 0); -- Dados para escrita de 32 bits
        mem_read  : in  std_logic; -- Sinal de controle para leitura
        mem_write : in  std_logic; -- Sinal de controle para escrita
        data_out  : out std_logic_vector(31 downto 0) -- Dados lidos de 32 bits
    );
end data_memory;

-- Arquitetura da memória de dados
architecture Behavioral of data_memory is
    -- Definição do tipo e tamanho da memória
    type memory_array is array (0 to 255) of std_logic_vector(31 downto 0);
    -- Declaração da memória
    signal memory : memory_array := (others => (others => '0')); -- Inicializada com zeros
begin
    -- Processo para leitura e escrita da memória
    process(address, mem_read, mem_write, write_data)
    begin
        -- Verifica se ambos mem_read e mem_write são '0'
        if mem_read = '0' and mem_write = '0' then
            -- Não faça nada
        elsif mem_read = '1' then
            -- Leitura da memória
            data_out <= memory(to_integer(unsigned(address)));
        elsif mem_write = '1' then
            -- Escrita na memória
            memory(to_integer(unsigned(address))) <= write_data;
        end if;
    end process;
end Behavioral;
