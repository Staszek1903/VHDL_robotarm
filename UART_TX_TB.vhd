--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:53:44 12/03/2019
-- Design Name:   
-- Module Name:   E:/programowanie/xilinx_projects/project_SW/UART_TX_TB.vhd
-- Project Name:  project_SW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UART_TX
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
 
ENTITY UART_TX_TB IS
END UART_TX_TB;
 
ARCHITECTURE behavior OF UART_TX_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UART_TX
	 GENERIC(
		CLKS_PER_BIT : integer 
		);
    PORT(
         clk : IN  std_logic;
         data : IN  std_logic_vector(7 downto 0);
         start : IN  std_logic;
         tx : OUT  std_logic;
         busy : OUT std_logic
			
			--d_data : out std_logic_vector( 7 downto 0);
			--d_state : out std_logic_vector ( 1 downto 0);
			--d_counter : out integer
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal data : std_logic_vector(7 downto 0) := (others => '0');
   signal start : std_logic := '0';

 	--Outputs
   signal tx : std_logic;
   signal busy : std_logic;
	
	--signal d_data : std_logic_vector( 7 downto 0);
	--signal d_state : std_logic_vector ( 1 downto 0);
	--signal d_counter : integer;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UART_TX 
	GENERIC MAP(
			CLKS_PER_BIT => 1
		)
	PORT MAP (
          clk => clk,
          data => data,
          start => start,
          tx => tx,
          busy => busy
			 --d_data => d_data,
			 --d_state => d_state,
			 --d_counter => d_counter
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
		
		data <= "01010101";
		wait for 5 ns;
		start <= '1';
		wait for 25 ns;
		start <= '0';
		
		wait for 200 ns;

		data <= "00110011";
		wait for 5 ns;
		start <= '1';
		wait for 25 ns;
		start <= '0';
		
		wait for 200 ns;

		data <= "00111100";
		wait for 5 ns;
		start <= '1';
		wait for 25 ns;
		start <= '0';
		
		wait for 200 ns;		

      wait;
   end process;

END;
