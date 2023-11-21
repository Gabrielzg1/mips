library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Declaração da entidade do testbench
entity instruction_memory_tb is
-- Testbench não tem portas
end instruction_memory_tb;

-- Arquitetura do testbench
architecture Behavioral of instruction_memory_tb is

    -- Componente que será testado
    component instruction_memory
        Port (
            address : in std_logic_vector(31 downto 0);
            instruction : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Sinais para simulação
    signal tb_address : std_logic_vector(31 downto 0);
    signal tb_instruction : std_logic_vector(31 downto 0);

begin

    -- Instância do componente a ser testado
    uut: instruction_memory Port Map (
        address => tb_address,
        instruction => tb_instruction
    );

    -- Processo de teste
    process
    begin
        -- Teste com diferentes endereços
        tb_address <= "00000000000000000000000000000000"; -- Exemplo de endereço
        wait for 10 ns;
        tb_address <= "00000000000000000000000000000001";
        wait for 10 ns;
        -- Adicione mais casos de teste conforme necessário

        -- Finaliza a simulação
        wait;
    end process;

end Behavioral;
