library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- Adicionado para operações numéricas

entity shift_left_jump is
    Port ( input_26bits : in STD_LOGIC_VECTOR (25 downto 0);
           output_28bits : out STD_LOGIC_VECTOR (27 downto 0));
end shift_left_jump;

architecture Behavioral of shift_left_jump is
begin
    -- Realiza o shift left de 2 bits
    output_28bits <= input_26bits & "00";
end Behavioral;
