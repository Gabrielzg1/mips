library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Declaração da entidade do testbench
entity data_memory_tb is
-- Testbench não tem portas
end data_memory_tb;

-- Arquitetura do testbench
architecture Behavioral of data_memory_tb is

    -- Componente que será testado
    component data_memory
        Port (
            address   : in  std_logic_vector(7 downto 0);
            write_data : in  std_logic_vector(31 downto 0);
            mem_read  : in  std_logic;
            mem_write : in  std_logic;
            data_out  : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Sinais para simulação
    signal tb_address   : std_logic_vector(7 downto 0);
    signal tb_write_data : std_logic_vector(31 downto 0);
    signal tb_mem_read  : std_logic;
    signal tb_mem_write : std_logic;
    signal tb_data_out  : std_logic_vector(31 downto 0);

begin

    -- Instância do componente a ser testado
    uut: data_memory Port Map (
        address => tb_address,
        write_data => tb_write_data,
        mem_read => tb_mem_read,
        mem_write => tb_mem_write,
        data_out => tb_data_out
    );

    -- Processo de teste
    process
    begin
        -- Inicialização dos sinais
        tb_mem_read <= '0';
        tb_mem_write <= '0';
        tb_write_data <= (others => '0');
        wait for 10 ns;

        -- Teste de escrita
        tb_address <= "00000000";
        tb_write_data <= X"12345678"; -- Exemplo de dados para escrita
        tb_mem_write <= '1';
        wait for 10 ns;

        tb_mem_write <= '0';
        wait for 10 ns;

        -- Teste de leitura
        tb_mem_read <= '1';
        wait for 10 ns;

        tb_mem_read <= '0';
        wait for 10 ns;

        -- Adicione mais testes conforme necessário

        -- Finaliza a simulação
        wait;
    end process;

end Behavioral;
