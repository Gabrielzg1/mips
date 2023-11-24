library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Declaração da entidade
entity mux2_to_1_5bits is
    Port (
        input0 : in  std_logic_vector(4 downto 0); -- Entrada 0
        input1 : in  std_logic_vector(4 downto 0); -- Entrada 1
        op : in  std_logic; -- Sinal de seleção
        output : out std_logic_vector(4 downto 0) -- Saída
    );
end mux2_to_1_5bits;

-- Arquitetura do MUX
architecture Behavioral of mux2_to_1_5bits is
begin
    -- Processo de seleção
    process(input0, input1, op)
    begin
        if op = '0' then
            output <= input0; -- Seleciona a entrada 0
        else
            output <= input1; -- Seleciona a entrada 1
        end if;
    end process;
end Behavioral;
