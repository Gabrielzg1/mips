library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mips_tb is
    -- Testbench não tem portas
end mips_tb;

architecture behavior of mips_tb is
    -- Componente a ser testado
    component mips
        port(
            clk: in std_logic;
            example_counter: out integer
        );
    end component;

    signal clk: std_logic := '0';
    signal example_counter: integer;

    -- Instância do componente MIPS
    begin
        uut: mips port map (clk => clk, example_counter => example_counter);

        -- Processo para gerar o clock
        clk_process: process
        begin
            clk <= '0';
            wait for 10 ns; -- Ajuste o período do clock conforme necessário
            clk <= '1';
            wait for 10 ns;
        end process;
end behavior;
