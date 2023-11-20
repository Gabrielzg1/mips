library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registers_tb is
    -- Testbench não tem portas
end registers_tb;

architecture behavior of registers_tb is

    -- Componente a ser testado
    component registers
        Port (
            clk : in std_logic;
            reg_write : in std_logic;
            read_reg1 : in std_logic_vector(4 downto 0);
            read_reg2 : in std_logic_vector(4 downto 0);
            write_reg : in std_logic_vector(4 downto 0);
            write_data : in std_logic_vector(31 downto 0);
            read_data1 : out std_logic_vector(31 downto 0);
            read_data2 : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Sinais para simulação
    signal clk: std_logic := '0';
    signal reg_write: std_logic := '0';
    signal read_reg1, read_reg2, write_reg: std_logic_vector(4 downto 0) := (others => '0');
    signal write_data: std_logic_vector(31 downto 0) := (others => '0');
    signal read_data1, read_data2: std_logic_vector(31 downto 0);

    -- Instância do componente de registradores
    begin
        uut: registers
            port map (
                clk => clk,
                reg_write => reg_write,
                read_reg1 => read_reg1,
                read_reg2 => read_reg2,
                write_reg => write_reg,
                write_data => write_data,
                read_data1 => read_data1,
                read_data2 => read_data2
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

        -- Processo de teste
        test_process: process
        begin
            -- Teste de escrita
            reg_write <= '1';
            write_reg <= std_logic_vector(to_unsigned(5, 5)); -- Escrevendo no registrador 5
            write_data <= std_logic_vector(to_unsigned(123, 32)); -- Valor 123
            wait for 20 ns;

            reg_write <= '0';

            -- Teste de leitura dos registradores
            read_reg1 <= std_logic_vector(to_unsigned(5, 5)); -- Lendo o registrador 5
            read_reg2 <= std_logic_vector(to_unsigned(0, 5)); -- Lendo o registrador 0 (deve ser 0)
            wait for 20 ns;

            -- Encerra simulação
            wait;
        end process;

end behavior;
