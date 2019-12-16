--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:47:32 12/11/2019
-- Design Name:   
-- Module Name:   E:/programowanie/xilinx_projects/project_SW/pwm_module_tb.vhd
-- Project Name:  project_SW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pwm_module
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
 
ENTITY pwm_module_tb IS
END pwm_module_tb;
 
ARCHITECTURE behavior OF pwm_module_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pwm_module
    PORT(
         clk : IN  std_logic;
         data_in : IN  std_logic_vector(11 downto 0);
         adr : IN  std_logic_vector(1 downto 0);
         wr : IN  std_logic;
         pwm_out : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal data_in : std_logic_vector(11 downto 0) := (others => '0');
   signal adr : std_logic_vector(1 downto 0) := (others => '0');
   signal wr : std_logic := '0';

 	--Outputs
   signal pwm_out : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clk_period : time := 83.3 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pwm_module PORT MAP (
          clk => clk,
          data_in => data_in,
          adr => adr,
          wr => wr,
          pwm_out => pwm_out
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
      wait for 100 ms;	

      data_in <= "000000100000";
		adr <= "00";
		wait for 1 ms;
		wr <= '1';
		wait for 1 ms;
		wr <= '0';
		wait for 1 ms;
		data_in <= "100000000000";
		adr <= "01";
		wait for 1 ms;
		wr <= '1';
		wait for 1 ms;
		wr <= '0';
		wait for 1 ms;
		data_in <= "111111111111";
		adr <= "10";
		wait for 1 ms;
		wr <= '1';
		wait for 1 ms;
		wr <= '0';
		wait for 1 ms;
      wait for 100 ms;

      wait;
   end process;

END;
