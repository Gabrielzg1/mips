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
            ck: in std_logic;
            example_counter: out integer
        );
    end component;

    signal ck: std_logic := '0';
    signal example_counter: integer;

    -- Instância do componente MIPS
    begin
        uut: mips port map (ck => ck, example_counter => example_counter);

        -- Processo para gerar o clock
        ck_process: process
        begin
            ck <= '0';
            wait for 10 ns; -- Ajuste o período do clock conforme necessário
            ck <= '1';
            wait for 10 ns;
        end process;
end behavior;
