library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity PC is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        pc_in : in STD_LOGIC_VECTOR (31 downto 0);
        pc_write : in STD_LOGIC;
        pc_out : out STD_LOGIC_VECTOR (31 downto 0)
    );
end PC;

architecture Behavioral of PC is
    signal pc_value : STD_LOGIC_VECTOR (31 downto 0) := (others => '0'); -- Inicializa o PC com 0
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                pc_value <= (others => '0'); -- Reseta o PC para 0
            elsif pc_write = '1' then
                pc_value <= pc_in; -- Atualiza o PC se o sinal de controle estiver ativo
            end if;
        end if;
    end process;

    pc_out <= pc_value; -- Saída sempre reflete o valor atual do PC
end Behavioral;
