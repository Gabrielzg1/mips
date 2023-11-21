library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Declaração da entidade do testbench
entity shift_left_2_tb is
-- Testbench não tem portas
end shift_left_2_tb;

-- Arquitetura do testbench
architecture Behavioral of shift_left_2_tb is

    -- Componente que será testado
    component shift_left_2
        Port (
            input : in  std_logic_vector(31 downto 0);
            output : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Sinais para simulação
    signal tb_input : std_logic_vector(31 downto 0);
    signal tb_output : std_logic_vector(31 downto 0);

begin

    -- Instância do componente a ser testado
    uut: shift_left_2 Port Map (
        input => tb_input,
        output => tb_output
    );

    -- Processo de teste
    process
    begin
        -- Teste 1: Deslocamento de um valor específico
        tb_input <= X"00000001"; -- Valor de exemplo para input
        wait for 10 ns;

        -- Teste 2: Deslocamento de outro valor
        tb_input <= X"40000000"; -- Outro valor de exemplo
        wait for 10 ns;

        -- Adicione mais testes conforme necessário

        -- Finaliza a simulação
        wait;
    end process;

end Behavioral;
