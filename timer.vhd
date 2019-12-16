----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:39:12 10/13/2019 
-- Design Name: 
-- Module Name:    timer - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity timer is
	generic (
		BIT_LENGTH : integer
	);
	
	port (
		--input
		clk : in std_logic;
		top : in std_logic_vector( bit_length-1 downto 0) := (others => '1');
		
		--output
		value_out : out std_logic_vector( bit_length-1 downto 0)
		);
	
end timer;

architecture Behavioral of timer is

	signal timer_reg : unsigned ( bit_length -1 downto 0 ) := (others => '0');

begin

	process(clk)
	begin
		if rising_edge(clk) then
			if timer_reg = unsigned(top) then
				timer_reg <= (others => '0');
			else
				timer_reg <= timer_reg +1;
			end if;
		end if;
	end process;
	
	value_out <= std_logic_vector(timer_reg);

end Behavioral;

