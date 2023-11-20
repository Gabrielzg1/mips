library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity data_register is
    Port (
        clk : in STD_LOGIC;
        data_in : in STD_LOGIC_VECTOR (31 downto 0);
        load : in STD_LOGIC; -- Sinal de controle para carregar o valor no registrador
        data_out : out STD_LOGIC_VECTOR (31 downto 0)
    );
end data_register;

architecture Behavioral of data_register is
    signal internal_data : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if load = '1' then
                internal_data <= data_in; -- Carrega o valor no registrador se o sinal de controle estiver ativo
            end if;
        end if;
    end process;

    data_out <= internal_data; -- Saída sempre reflete o valor atual do registrador interno
end Behavioral;
