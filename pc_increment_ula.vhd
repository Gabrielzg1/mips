library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pc_increment_ula is
    Port (
        pc_input : in std_logic_vector(31 downto 0);
        pc_output : out std_logic_vector(31 downto 0)
    );
end pc_increment_ula;

architecture Behavioral of pc_increment_ula is
begin
    -- Incrementa o valor de PC em "4" ----> * Como estamos trabalhando com vetor, soma 1 no indice do vetor
    pc_output <= pc_input + "00000000000000000000000000000001";
end Behavioral;
