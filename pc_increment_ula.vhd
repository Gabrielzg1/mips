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
    
     pc_output <= pc_input + "00000000000000000000000000000100";  -- Incrementando o PC em 4 para o próximo endereço de palavra
    
end Behavioral;
