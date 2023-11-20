library IEEE;
use IEEE.std_logic_1164.all;

entity mips_tb is
    -- Testbench não possui portas
end mips_tb;

architecture behavior of mips_tb is
    -- Componente a ser testado
    component mips
        port (
            clk : in std_logic;
            rst : in std_logic;
            led : out std_logic_vector(3 downto 0);
            instructions_input: in STD_LOGIC_VECTOR (31 downto 0) array(0 to 31)
        );
    end component;

    -- Sinais para o testbench
    signal clk, rst : std_logic := '0';
    signal led : std_logic_vector(3 downto 0);
    signal instructions : STD_LOGIC_VECTOR (31 downto 0) array(0 to 31);

begin
    -- Instância do MIPS
    uut: mips
        port map (
            clk => clk,
            rst => rst,
            led => led,
            instructions_input => instructions
        );

    -- Processo para gerar o clock
    clk_process :process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Processo de teste
    stim_proc: process
    begin
        -- Inicializa o reset
        rst <= '1';
        wait for 20 ns;
        rst <= '0';

        -- Inserindo instruções no array
        instructions(0) <= "00000000000000000000000000000000"; -- Exemplo de instrução
        instructions(1) <= "00000000000000000000000000000001";
        instructions(2) <= "00000000000000000000000000000010";
        instructions(3) <= "00000000000000000000000000000011";
        instructions(4) <= "00000000000000000000000000000100";

        -- Aqui podem ser adicionados mais testes e verificações

        wait; -- Termina a simulação
    end process;

end behavior;
