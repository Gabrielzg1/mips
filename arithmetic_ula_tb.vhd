LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY arithmetic_ula_tb IS
END arithmetic_ula_tb;

ARCHITECTURE behavior OF arithmetic_ula_tb IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT arithmetic_ula
    PORT(
         in_1 : IN  std_logic_vector(31 downto 0);
         in_2 : IN  std_logic_vector(31 downto 0);
         alu_control_fuct : IN  std_logic_vector(3 downto 0);
         zero : OUT  std_logic;
         alu_result : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
   
    --Inputs
    signal in_1 : std_logic_vector(31 downto 0) := (others => '0');
    signal in_2 : std_logic_vector(31 downto 0) := (others => '0');
    signal alu_control_fuct : std_logic_vector(3 downto 0) := (others => '0');

    --Outputs
    signal zero : std_logic;
    signal alu_result : std_logic_vector(31 downto 0);

BEGIN 

    -- Instantiate the Unit Under Test (UUT)
   uut: arithmetic_ula PORT MAP (
          in_1 => in_1,
          in_2 => in_2,
          alu_control_fuct => alu_control_fuct,
          zero => zero,
          alu_result => alu_result
        );

    -- Testbench statements here
    -- Example:
    -- Test case 1
    test1: PROCESS
    BEGIN
        -- Initialize Inputs
        in_1 <= (others => '0');
        in_2 <= (others => '0');
        alu_control_fuct <= "0011"; -- Example: Add operation

        -- Wait for 100 ns for global reset to finish
        WAIT FOR 10 ns;
        
        -- Add stimulus here
        in_1 <= "00000000000000000000000000000011"; -- Example input
        in_2 <= "00000000000000000000000000000001"; -- Example input

        -- Wait for result
        WAIT FOR 10 ns;
      
       

        WAIT; -- will wait forever
    END PROCESS test1;

END;
