-- OP: sz
-- and_operation: 0000
-- or_operation: 0001
-- add_op: 0010
-- sub_neq: 0011 (for bne)
-- sub_op: 0110
-- less_than_set: 0111

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu_control is
    port (
        funct: in std_logic_vector(5 downto 0);
        alu_op: in std_logic_vector(1 downto 0);
        operation_code: out std_logic_vector(3 downto 0)
    );
end alu_control;

architecture behavior of alu_control is
    signal and_operation: std_logic_vector(3 downto 0) := "0000";
    signal or_operation: std_logic_vector(3 downto 0) := "0001";
    signal add_op: std_logic_vector(3 downto 0) := "0010";
    signal sub_neq: std_logic_vector(3 downto 0) := "0011";
    signal sub_op: std_logic_vector(3 downto 0) := "0110";
    signal less_than_set: std_logic_vector(3 downto 0) := "0111";

begin
    operation_code <= add_op when(alu_op="00" or (alu_op="10" and funct="100000")) else
                     sub_op when(alu_op="01" or (alu_op="10" and funct="100010")) else
                     sub_neq when(alu_op="11") else
                     and_operation when(alu_op="10" and funct="100100") else
                     or_operation when(alu_op="10" and funct="100101") else
                     less_than_set when(alu_op="10" and funct="101010") else
                     "0000";
end behavior;
