----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:43:24 12/11/2019 
-- Design Name: 
-- Module Name:    comparator - Behavioral 
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

entity comparator is
	generic(
			BIT_LENGTH : integer
			);
		port(
			a : in std_logic_vector( bit_length-1 downto 0);
			b : in std_logic_vector( bit_length-1 downto 0);
			
			ls: out std_logic;
			eq: out std_logic;
			gt: out std_logic
			);
end comparator;

architecture Behavioral of comparator is
begin
	ls <= '1' when unsigned(a) < unsigned(b) else '0';
	eq <= '1' when unsigned(a) = unsigned(b) else '0';
	gt <= '1' when unsigned(a) > unsigned(b) else '0';
end Behavioral;