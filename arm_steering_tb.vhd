--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:24:59 12/16/2019
-- Design Name:   
-- Module Name:   E:/programowanie/xilinx_projects/project_SW/arm_steering_tb.vhd
-- Project Name:  project_SW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: arm_steering
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY arm_steering_tb IS
END arm_steering_tb;
 
ARCHITECTURE behavior OF arm_steering_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT arm_steering
    PORT(
         clk : IN  std_logic;
         input_data : IN  std_logic_vector(7 downto 0);
         new_data : IN  std_logic;
         d_state : OUT  std_logic_vector(2 downto 0);
         data_out : OUT  std_logic_vector(11 downto 0);
         adr : OUT  std_logic_vector(1 downto 0);
			data_read : out std_logic;
         wr_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal input_data : std_logic_vector(7 downto 0) := (others => '0');
   signal new_data : std_logic := '0';

 	--Outputs
   signal d_state : std_logic_vector(2 downto 0);
   signal data_out : std_logic_vector(11 downto 0);
   signal adr : std_logic_vector(1 downto 0);
   signal wr_out : std_logic;
	signal data_read : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: arm_steering PORT MAP (
          clk => clk,
          input_data => input_data,
          new_data => new_data,
          d_state => d_state,
          data_out => data_out,
          adr => adr,
			 data_read => data_read,
          wr_out => wr_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		input_data <= "00000001";
		wait for 100 ns;
		new_data <= '1';
		wait for 100 ns;
		new_data <= '0';
		wait for 100 ns;
		
		input_data <= "01111111";
		wait for 100 ns;
		new_data <= '1';
		wait for 100 ns;
		new_data <= '0';
		wait for 100 ns;
		
		input_data <= "10101010";
		wait for 100 ns;
		new_data <= '1';
		wait for 100 ns;
		new_data <= '0';
		wait for 100 ns;
		
		input_data <= "00000011";
		wait for 100 ns;
		new_data <= '1';
		wait for 100 ns;
		new_data <= '0';
		wait for 100 ns;
		
		input_data <= "10111111";
		wait for 100 ns;
		new_data <= '1';
		wait for 100 ns;
		new_data <= '0';
		wait for 100 ns;
		
		input_data <= "00000010";
		wait for 100 ns;
		new_data <= '1';
		wait for 100 ns;
		new_data <= '0';
		wait for 100 ns;
		
		input_data <= "01101010";
		wait for 100 ns;
		new_data <= '1';
		wait for 100 ns;
		new_data <= '0';
		wait for 100 ns;
		
		input_data <= "10111111";
		wait for 100 ns;
		new_data <= '1';
		wait for 100 ns;
		new_data <= '0';
		wait for 100 ns;
		
		input_data <= "10000000";
		wait for 100 ns;
		new_data <= '1';
		wait for 100 ns;
		new_data <= '0';
		wait for 100 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
