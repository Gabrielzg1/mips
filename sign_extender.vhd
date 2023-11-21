library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Declaração da entidade
entity sign_extender is
    Port (
        input_16bit  : in  std_logic_vector(15 downto 0); -- Entrada de 16 bits
        output_32bit : out std_logic_vector(31 downto 0)  -- Saída de 32 bits
    );
end sign_extender;

-- Arquitetura do extensor de sinal
architecture Behavioral of sign_extender is
begin
    -- Processo para extensão de sinal
    process(input_16bit)
    begin
        -- Extende com 0s, assumindo que todos os valores são positivos
        output_32bit <= "0000000000000000" & input_16bit;
    end process;
end Behavioral;
