library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Declaração da entidade do testbench
entity mux2_to_1_tb is
-- Testbench não tem portas
end mux2_to_1_tb;

-- Arquitetura do testbench
architecture Behavioral of mux2_to_1_tb is

    -- Componente que será testado
    component mux2_to_1
        Port (
            input0 : in  std_logic_vector(31 downto 0);
            input1 : in  std_logic_vector(31 downto 0);
            op : in  std_logic;
            output : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Sinais para simulação
    signal tb_input0 : std_logic_vector(31 downto 0);
    signal tb_input1 : std_logic_vector(31 downto 0);
    signal tb_op : std_logic;
    signal tb_output : std_logic_vector(31 downto 0);

begin

    -- Instância do componente a ser testado
    uut: mux2_to_1 Port Map (
        input0 => tb_input0,
        input1 => tb_input1,
        op => tb_op,
        output => tb_output
    );

    -- Processo de teste
    process
    begin
        -- Definindo os valores de entrada
        tb_input0 <= X"AAAAAAAA"; -- Valor de exemplo para input0
        tb_input1 <= X"55555555"; -- Valor de exemplo para input1

        -- Teste com op = '0'
        tb_op <= '0';
        wait for 10 ns;

        -- Teste com op = '1'
        tb_op <= '1';
        wait for 10 ns;

        -- Adicione mais testes conforme necessário

        -- Finaliza a simulação
        wait;
    end process;

end Behavioral;
