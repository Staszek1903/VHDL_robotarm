----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:19:05 10/13/2019 
-- Design Name: 
-- Module Name:    pwm - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm is
	generic(
		bit_length : integer
		);
	port(
		timer_in : in std_logic_vector( bit_length-1 downto 0);
		compare_val : in std_logic_vector( bit_length-1 downto 0);
		pwm_out : out std_logic
		);
end pwm;

architecture Behavioral of pwm is
begin
	pwm_out <= '1' when (unsigned(timer_in) < unsigned(compare_val)) else '0';
end Behavioral;

