--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:38:24 12/07/2019
-- Design Name:   
-- Module Name:   E:/programowanie/xilinx_projects/project_SW/top_level_tb.vhd
-- Project Name:  project_SW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_level
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
 
ENTITY top_level_tb IS
END top_level_tb;
 
ARCHITECTURE behavior OF top_level_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_level
    PORT(
         clk : IN  std_logic;
         button : IN  std_logic_vector(5 downto 0);
         led : OUT  std_logic_vector(7 downto 0);
         segment : OUT  std_logic_vector(7 downto 0);
         enable : OUT  std_logic_vector(2 downto 0);
         header1 : OUT  std_logic_vector(7 downto 0);
         header6 : OUT  std_logic_vector(7 downto 0);
			
			--d_data : out std_logic_vector ( 7 downto 0);
			
			uart_tx_pin : out std_logic;
			uart_rx_pin : in std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal button : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal led : std_logic_vector(7 downto 0);
   signal segment : std_logic_vector(7 downto 0);
   signal enable : std_logic_vector(2 downto 0);
   signal header1 : std_logic_vector(7 downto 0);
   signal header6 : std_logic_vector(7 downto 0);
	
	signal uart_tx_pin : std_logic;
	signal uart_rx_pin : std_logic := '1';
	
	--signal d_data : std_logic_vector ( 7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 83.4 ns;
	constant bit_period : time := 104 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_level PORT MAP (
          clk => clk,
          button => button,
          led => led,
          segment => segment,
          enable => enable,
          header1 => header1,
          header6 => header6,
			 uart_tx_pin => uart_tx_pin,
			 uart_rx_pin => uart_rx_pin
			-- d_data  => d_data
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
		
		uart_rx_pin <= '1';
      wait for 100 ns;	
      -- insert stimulus here 
		
		uart_rx_pin <= '0';
		wait for bit_period;
		uart_rx_pin <= '1';
		wait for bit_period;
		uart_rx_pin <= '0';
		wait for bit_period;
		uart_rx_pin <= '1';
		wait for bit_period;
		uart_rx_pin <= '0';
		wait for bit_period;
		uart_rx_pin <= '1';
		wait for bit_period;
		uart_rx_pin <= '0';
		wait for bit_period;
		uart_rx_pin <= '1';
		wait for bit_period;
		uart_rx_pin <= '0';
		wait for bit_period;
		uart_rx_pin <= '1';
		
		wait for 3*bit_period;
		
		uart_rx_pin <= '0';
		wait for bit_period;
		uart_rx_pin <= '1';
		wait for bit_period;
		uart_rx_pin <= '1';
		wait for bit_period;
		uart_rx_pin <= '1';
		wait for bit_period;
		uart_rx_pin <= '0';
		wait for bit_period;
		uart_rx_pin <= '1';
		wait for bit_period;
		uart_rx_pin <= '0';
		wait for bit_period;
		uart_rx_pin <= '0';
		wait for bit_period;
		uart_rx_pin <= '0';
		wait for bit_period;
		uart_rx_pin <= '1';
		
		wait for 3*bit_period;
		
		uart_rx_pin <= '0';
		wait for bit_period;
		uart_rx_pin <= '0';
		wait for bit_period;
		uart_rx_pin <= '1';
		wait for bit_period;
		uart_rx_pin <= '1';
		wait for bit_period;
		uart_rx_pin <= '1';
		wait for bit_period;
		uart_rx_pin <= '0';
		wait for bit_period;
		uart_rx_pin <= '0';
		wait for bit_period;
		uart_rx_pin <= '0';
		wait for bit_period;
		uart_rx_pin <= '1';
		wait for bit_period;
		uart_rx_pin <= '1';
		
		--wait for 2*bit_period;

      wait;
   end process;

END;
