library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity address_calc_ula is
    Port (
        input1 : in std_logic_vector(31 downto 0);
        input2 : in std_logic_vector(31 downto 0);
        result : out std_logic_vector(31 downto 0)
    );
end address_calc_ula;

architecture Behavioral of address_calc_ula is
begin
    -- A ULA para cálculo de endereço realiza uma operação de soma
    result <= input1 + input2;
end Behavioral;
