library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity instruction_register is
    Port (
        clk : in STD_LOGIC;
        instruction_in : in STD_LOGIC_VECTOR (31 downto 0); -- Instrução a ser carregada
        IRwrite : in STD_LOGIC; -- Sinal de controle para carregar a instrução
        instruction_out : out STD_LOGIC_VECTOR (31 downto 0) -- Instrução armazenada
    );
end instruction_register;

architecture Behavioral of instruction_register is
    signal internal_instruction : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if IRwrite = '1' then
                internal_instruction <= instruction_in; -- Carrega a instrução se o sinal de controle estiver ativo
            end if;
        end if;
    end process;

    instruction_out <= internal_instruction; -- Saída sempre reflete a instrução atual no registrador
end Behavioral;
