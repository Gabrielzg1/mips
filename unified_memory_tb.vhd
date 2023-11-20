library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity unified_memory_tb is
end unified_memory_tb;

architecture behavior of unified_memory_tb is

    component unified_memory
        Port ( 
            clk : in std_logic;
            mem_address : in std_logic_vector(31 downto 0);
            mem_write_data : in std_logic_vector(31 downto 0);
            mem_read_data : out std_logic_vector(31 downto 0);
            mem_write : in std_logic;
            mem_read : in std_logic
        );
    end component;

    signal clk: std_logic := '0';
    signal mem_address: std_logic_vector(31 downto 0) := (others => '0');
    signal mem_write_data: std_logic_vector(31 downto 0) := (others => '0');
    signal mem_read_data: std_logic_vector(31 downto 0);
    signal mem_write: std_logic := '0';
    signal mem_read: std_logic := '0';

    begin
        uut: unified_memory 
            port map (
                clk => clk,
                mem_address => mem_address,
                mem_write_data => mem_write_data,
                mem_read_data => mem_read_data,
                mem_write => mem_write,
                mem_read => mem_read
            );

        -- Processo para gerar o clock
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
            -- Teste de escrita
            mem_write <= '1'; -- Habilita escrita
            mem_read <= '0';  -- Desabilita leitura
            for i in 0 to 4 loop
                mem_address <= std_logic_vector(to_unsigned(i, 32));
                mem_write_data <= std_logic_vector(to_unsigned(100 + i, 32));
                wait for 20 ns;
            end loop;

            mem_write <= '0'; -- Desabilita escrita

            -- Teste de leitura
            mem_read <= '1';  -- Habilita leitura
            for i in 0 to 4 loop
                mem_address <= std_logic_vector(to_unsigned(i, 32));
                wait for 20 ns;
            end loop;

            mem_read <= '0'; -- Desabilita leitura

            wait;
        end process;

end behavior;
