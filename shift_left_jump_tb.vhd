library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shift_left_jump_tb is
-- Testbench entities do not have ports
end shift_left_jump_tb;

architecture behavior of shift_left_jump_tb is 
    -- Component Declaration for the Unit Under Test (UUT)
    component shift_left_jump
    Port (
         input_26bits : in  STD_LOGIC_VECTOR (25 downto 0);
         output_28bits : out  STD_LOGIC_VECTOR (27 downto 0)
        );
    end component;

   --Inputs
   signal input_26bits : STD_LOGIC_VECTOR (25 downto 0) := (others => '0');

   --Outputs
   signal output_28bits : STD_LOGIC_VECTOR (27 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;

begin

	-- Instantiate the Unit Under Test (UUT)
   uut: shift_left_jump Port Map (
          input_26bits => input_26bits,
          output_28bits => output_28bits
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      input_26bits <= "00000000000000000000000001";
      wait for 100 ns;
      
      input_26bits <= "00000000000000000000000010";
      wait for 100 ns;

      input_26bits <= "00000000000000000000000100";
      wait for 100 ns;

      -- Add more test vectors here

      -- Wait for a while to see the last output
      wait for 500 ns;

      wait;
   end process;

end behavior;
