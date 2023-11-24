library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sign_extender is
    Port (
        input_16bit  : in  std_logic_vector(15 downto 0); -- Entrada de 16 bits
        output_32bit : out std_logic_vector(31 downto 0)  -- Saída de 32 bits
    );
end sign_extender;

architecture Behavioral of sign_extender is
begin
    process(input_16bit)
    begin
        output_32bit <= std_logic_vector(resize(signed(input_16bit), 32));
    end process;
end Behavioral;
