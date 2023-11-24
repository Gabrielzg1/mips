library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity PC is
    Port (
        clk : in STD_LOGIC;
        pc_in : in STD_LOGIC_VECTOR (31 downto 0); -- Endereço de entrada
        pc_out : out STD_LOGIC_VECTOR (31 downto 0) -- Endereço atual (saída)
    );
end PC;

architecture Behavioral of PC is
    signal pc_value : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000"; -- Inicializa o PC com 0
begin
    process(clk)
    begin
        if rising_edge(clk) then
            pc_value <= pc_in; -- Atualiza o PC a cada ciclo de clock com o valor de entrada
        end if;
    end process;

    pc_out <= pc_value; -- Saída sempre reflete o valor atual do PC
end Behavioral;