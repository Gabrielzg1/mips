library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity program_counter_tb is
-- O testbench não possui portas.
end program_counter_tb;

architecture behavior of program_counter_tb is 
    -- Componente a ser testado
    component PC
        Port (
            clk : in STD_LOGIC;
            pc_in : in STD_LOGIC_VECTOR (31 downto 0);
            pc_out : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    -- Sinais para simulação
    signal clk : STD_LOGIC := '0';
    signal pc_in : STD_LOGIC_VECTOR (31 downto 0);
    signal pc_out : STD_LOGIC_VECTOR (31 downto 0);

    -- Instância do componente PC
    begin
        uut: PC port map (clk => clk, pc_in => pc_in, pc_out => pc_out);

        -- Processo para gerar o clock
        clk_process : process
        begin
            while true loop
                clk <= '0';
                wait for 10 ns; -- Ajuste este tempo conforme necessário para a frequência do seu clock
                clk <= '1';
                wait for 10 ns;
            end loop;
        end process;

        -- Processo de Teste
        stim_proc: process
        begin		
            -- Teste com diferentes valores de entrada
            pc_in <= (others => '0'); -- Testando com o valor inicial 0
            wait for 20 ns;
            pc_in <= "00000000000000000000000000000001"; -- Testando com o valor 1
            wait for 20 ns;
            pc_in <= "00000000000000000000000000000010"; -- Testando com o valor 2
            wait for 20 ns;
            pc_in <= "00000000000000000000000000000011"; -- Testando com o valor 3
            wait for 20 ns;

            -- Finalize a simulação
            wait;
        end process;
end behavior;
