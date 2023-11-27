library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity arithmetic_ula is 
    port (
        input_a, input_b: in std_logic_vector(31 downto 0);
        operation_code: in std_logic_vector(3 downto 0);
        flag_zero: out std_logic;
        result: out std_logic_vector(31 downto 0)
    );
end arithmetic_ula;

architecture behavior of arithmetic_ula is
    signal and_operation: std_logic_vector(3 downto 0) := "0000";
    signal or_operation: std_logic_vector(3 downto 0) := "0001";
    signal add_op: std_logic_vector(3 downto 0) := "0010";
    signal sub_beq: std_logic_vector(3 downto 0) := "0011";
    signal sub_op: std_logic_vector(3 downto 0) := "0110";
    signal less_than_set: std_logic_vector(3 downto 0) := "0111";
    signal temp_result: std_logic_vector(31 downto 0); -- Sinal intermediário para armazenar o resultado

begin

    -- Atribuições condicionais para a operação
    temp_result <=
        input_a + input_b when operation_code = add_op else
        input_a - input_b when operation_code = sub_op or operation_code = sub_beq else
        input_a and input_b when operation_code = and_operation else
        input_a or input_b when operation_code = or_operation else
        "00000000000000000000000000000001" when operation_code = less_than_set and input_a < input_b else
        "00000000000000000000000000000000";

    -- Atribuir temp_result ao result
    result <= temp_result;

    -- Lógica para a flag zero
    flag_zero <= '1' when temp_result = "00000000000000000000000000000000" else '0';

end behavior;
