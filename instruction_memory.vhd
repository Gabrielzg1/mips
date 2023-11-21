library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Corrigido para usar o NUMERIC_STD

-- Declaração da entidade
entity instruction_memory is
    Port (
        address : in std_logic_vector(7 downto 0); -- Endereço de 8 bits
        instruction : out std_logic_vector(31 downto 0) -- Instrução de 32 bits
    );
end instruction_memory;

-- Arquitetura da memória de instruções
architecture Behavioral of instruction_memory is
    -- Definição do tipo e tamanho da memória
    type memory_array is array (0 to 255) of std_logic_vector(31 downto 0);
    -- Declaração da memória
    signal memory : memory_array := (
        0 => "00000000000001110000000000000000", -- Instruções
        1 => "00000000000000001111100000000000", -- Deve ser preenchida
        -- Adicione mais instruções conforme necessário
        others => (others => '0') -- Restante preenchido com zeros
    );
begin
    -- Processo para ler a instrução da memória
    process(address)
    begin
        instruction <= memory(to_integer(unsigned(address)));
    end process;
end Behavioral;
