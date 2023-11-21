library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity arithmetic_ula_tb is
    -- Testbench não tem entradas ou saídas
end arithmetic_ula_tb;

architecture behavior of arithmetic_ula_tb is 
    -- Componente sob teste
    component arithmetic_ula
        port (
            input_a, input_b: std_logic_vector(31 downto 0);
            operation_code: in std_logic_vector(3 downto 0);
            flag_zero: out std_logic;
            result: out std_logic_vector(31 downto 0)
        );
    end component;

    -- Sinais para interagir com o UUT
    signal input_a, input_b: std_logic_vector(31 downto 0);
    signal operation_code: std_logic_vector(3 downto 0);
    signal flag_zero: std_logic;
    signal result: std_logic_vector(31 downto 0);

begin
    -- Instanciar a UUT
    uut: arithmetic_ula port map (
        input_a => input_a,
        input_b => input_b,
        operation_code => operation_code,
        flag_zero => flag_zero,
        result => result
    );

    -- Processo de teste
    test_process: process
    begin
        -- Teste para adição
        input_a <= "00000000000000000000000000000010"; -- 2
        input_b <= "00000000000000000000000000000011"; -- 3
        operation_code <= "0010"; -- Código para adição
        wait for 10 ns;

        -- Teste para subtração
        input_a <= "00000000000000000000000000000001"; -- 1
        input_b <= "00000000000000000000000000000111"; -- 1
        operation_code <= "0011"; -- Código para subtração
        wait for 10 ns;

        -- Testes adicionais podem ser adicionados aqui

        -- Finalizar o teste
        wait;
    end process test_process;
end behavior;
