------------------------------------------------------
-- Arithmetic Logic Unit (ALU) Component
--
-- This component takes two inputs and performs one of 5
-- operations, including (add, subtract, AND, OR, 
-- less than), and returns the result.
--
-- Returns a zero flag, which is true if both inputs
-- are equal, and false otherwise.
------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity arithmetic_ula is 
	port (
		input_a, input_b: std_logic_vector(31 downto 0);
		operation_code: in std_logic_vector(3 downto 0);
		flag_zero: out std_logic;
		result: out std_logic_vector(31 downto 0)
	);
end arithmetic_ula;

architecture behavior of arithmetic_ula is
	signal and_operation: std_logic_vector(3 downto 0) := "0000";
	signal or_operation: std_logic_vector(3 downto 0) := "0001";
	signal add_op: std_logic_vector(3 downto 0) := "0010";
	signal sub_neq: std_logic_vector(3 downto 0) := "0011";
	signal sub_op: std_logic_vector(3 downto 0) := "0110";
	signal less_than_set: std_logic_vector(3 downto 0) := "0111";

	begin

	result <=
				input_a + input_b when(operation_code=add_op) else
				input_a - input_b when(operation_code=sub_op or operation_code=sub_neq) else
				input_a and input_b when(operation_code=and_operation) else
				input_a or input_b when(operation_code=or_operation) else
				"00000000000000000000000000000001" when(operation_code=less_than_set and input_a < input_b) else
				"00000000000000000000000000000000" when(operation_code=less_than_set);

	flag_zero <=	'1' when ((input_a = input_b) and operation_code=sub_neq) else 
					'0' when(input_a=input_b and operation_code=sub_neq) 
					else '0';

end behavior;
