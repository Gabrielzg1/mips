library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Declaração da entidade
entity shift_left_2 is
    Port (
        input : in  std_logic_vector(31 downto 0); -- Entrada de 32 bits
        output : out std_logic_vector(31 downto 0) -- Saída de 32 bits
    );
end shift_left_2;

-- Arquitetura do componente
architecture Behavioral of shift_left_2 is
begin
    -- Processo para realizar o deslocamento à esquerda
    output <= input(29 downto 0) & "00"; -- Desloca 2 bits para a esquerda
end architecture Behavioral;
