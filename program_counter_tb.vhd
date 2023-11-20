library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity program_counter_tb is
    -- Testbench não tem portas
end program_counter_tb;

architecture behavior of program_counter_tb is

    -- Componente a ser testado
    component pc
        Port (
            clk : in std_logic;
            reset : in std_logic;
            pc_in : in std_logic_vector(31 downto 0);
            pc_write : in std_logic;
            pc_out : out std_logic_vector(31 downto 0)
        );
    end component;

    signal clk: std_logic := '0';
    signal reset: std_logic := '0';
    signal pc_in: std_logic_vector(31 downto 0) := (others => '0');
    signal pc_write: std_logic := '0';
    signal pc_out: std_logic_vector(31 downto 0);

    begin
        uut: PC
            port map (
                clk => clk,
                reset => reset,
                pc_in => pc_in,
                pc_write => pc_write,
                pc_out => pc_out
            );

        clk_process: process
        begin
            while true loop
                clk <= '0';
                wait for 10 ns;
                clk <= '1';
                wait for 10 ns;
            end loop;
        end process;

        test_process: process
        begin
            reset <= '1';
            wait for 20 ns;
            reset <= '0';
            wait for 20 ns;

            pc_in <= std_logic_vector(to_unsigned(8, 32));
            pc_write <= '1';
            wait for 20 ns;

            pc_write <= '0';
            wait for 20 ns;

            pc_in <= std_logic_vector(unsigned(pc_out) + to_unsigned(4, 32));
            pc_write <= '1';
            wait for 20 ns;

            wait;
        end process;
end behavior;
