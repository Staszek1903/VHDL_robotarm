--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:10:39 12/04/2019
-- Design Name:   
-- Module Name:   E:/programowanie/xilinx_projects/project_SW/UART_TB.vhd
-- Project Name:  project_SW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UART_RX
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
 
ENTITY UART_TB IS
END UART_TB;
 
ARCHITECTURE behavior OF UART_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UART_RX
	 GENERIC(
		CLKS_PER_BIT : integer 
		);
    PORT(
         --d_counter : OUT integer;
         --d_state : OUT  std_logic_vector(1 downto 0);
         --d_data_reg : OUT  std_logic_vector(7 downto 0);
         --d_trans_en : OUT  std_logic;
         clk : IN  std_logic;
         rx : IN  std_logic;
         rd : IN  std_logic;
         data : OUT  std_logic_vector(7 downto 0);
         new_data : OUT  std_logic
        );
    END COMPONENT;
	 
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
   signal transmission_wire : std_logic := '0';
   signal rd : std_logic := '0';
	signal start : std_logic := '0';

 	--Outputs
   signal data_in : std_logic_vector(7 downto 0);
	signal data_out : std_logic_vector(7 downto 0);
	
   signal new_data : std_logic;
	signal busy : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	constant clk_per_bit : integer := 1;
	constant bit_period : time := clk_period * clk_per_bit;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
  uut1: UART_RX 
	GENERIC MAP(
			CLKS_PER_BIT => clk_per_bit
		)
	PORT MAP (
          --d_counter => d_counter,
          --d_state => d_state,
          --d_data_reg => d_data_reg,
          --d_trans_en => d_trans_en,
          clk => clk,
          rx => transmission_wire,
          rd => rd,
          data => data_out,
          new_data => new_data
        );
		  
	uut2: UART_TX 
	GENERIC MAP(
			CLKS_PER_BIT => clk_per_bit
		)
	PORT MAP (
          clk => clk,
          data => data_in,
          start => start,
          tx => transmission_wire,
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
      wait for 2*bit_period;	
		-- insert stimulus here 
		
		data_in <= "10101010";
		start <= '1';
		wait for bit_period;
		start <= '0';
		wait for 200 ns;
		rd <= '1';
		wait for bit_period;
		rd <= '0';
		
		data_in <= "01010101";
		start <= '1';
		wait for bit_period;
		start <= '0';
		wait for 200 ns;
		rd <= '1';
		wait for bit_period;
		rd <= '0';
		
		data_in <= "01101001";
		start <= '1';
		wait for bit_period;
		start <= '0';
		wait for 200 ns;
		rd <= '1';
		wait for bit_period;
		rd <= '0';
		
		data_in <= "11101000";
		start <= '1';
		wait for bit_period;
		start <= '0';
		wait for 200 ns;
		rd <= '1';
		wait for bit_period;
		rd <= '0';
		

      wait;
   end process;

END;
