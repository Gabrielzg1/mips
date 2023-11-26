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
            clk: in std_logic
            
        );
    end component;

    signal clk: std_logic := '0';


    -- Contador para controlar o número de ciclos de clock
    signal clk_counter: integer := 0;

    -- Instância do componente MIPS
    begin
        uut: mips port map (clk => clk);

        -- Processo para gerar o clock
        clk_process: process
        begin
            while clk_counter < 2 loop
               clk <= '0';
                wait for 100 ns; -- Ajuste o período do clock conforme necessário
               clk <= '1';
                wait for 100 ns;
                clk_counter <= clk_counter + 1; -- Incrementa o contador a cada ciclo de clock
            end loop;
          wait; -- Encerra o processo após 32 ciclos de clock
        end process;
					
		
		
end behavior;
