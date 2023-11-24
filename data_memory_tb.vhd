library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Declaração da entidade do testbench
entity data_memory_tb is
    -- O testbench não possui portas
end data_memory_tb;

-- Arquitetura do testbench
architecture Behavioral of data_memory_tb is
    -- Componente a ser testado
    component data_memory
        Port (
            clk        : in  std_logic;
            address    : in  std_logic_vector(31 downto 0);
            write_data : in  std_logic_vector(31 downto 0);
            mem_read   : in  std_logic;
            mem_write  : in  std_logic;
            data_out   : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Sinais para interagir com o componente
    signal clk        : std_logic := '0';
    signal address    : std_logic_vector(31 downto 0) := (others => '0');
    signal write_data : std_logic_vector(31 downto 0) := (others => '0');
    signal mem_read   : std_logic := '0';
    signal mem_write  : std_logic := '0';
    signal data_out   : std_logic_vector(31 downto 0);

   

begin
    -- Instanciando o componente
    uut: data_memory port map (
        clk        => clk,
        address    => address,
        write_data => write_data,
        mem_read   => mem_read,
        mem_write  => mem_write,
        data_out   => data_out
    );

    -- Processo para gerar o clock
    clk_process : process
    begin
        clk <= '0';
        wait for 20 ns;
        clk <= '1';
        wait for 20 ns;
    end process;

    -- Processo de teste
    test_process : process
    begin
        -- Inicialização
        wait for 40 ns;
        mem_read   <= '0';
        mem_write  <= '0';
        address    <= (others => '0');
        write_data <= (others => '0');

        -- Teste de escrita
        address    <= std_logic_vector(to_unsigned(5, 32));
        write_data <= std_logic_vector(to_unsigned(123, 32));
        mem_write  <= '1';
        wait for 40 ns;
        mem_write  <= '0';

        -- Teste de leitura
        wait for 40 ns;
        mem_read   <= '1';
        wait for 40 ns;
        mem_read   <= '0';

        -- Finaliza a simulação após alguns ciclos
        wait for 40 ns;
        assert false report "Fim da simulação" severity failure;
    end process;

end Behavioral;
