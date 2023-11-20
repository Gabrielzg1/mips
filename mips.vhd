library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- Adicionado para operações numéricas

entity mips is
    port(
        ck: in std_logic;
        example_counter: buffer integer := 0
    );
end mips;

architecture beh of mips is
begin
    process(ck)
    begin
        if rising_edge(ck) then
            example_counter <= example_counter + 1;
        end if;
    end process;
end beh;
