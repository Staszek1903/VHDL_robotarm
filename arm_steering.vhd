----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:55:53 12/11/2019 
-- Design Name: 
-- Module Name:    arm_steering - Behavioral 
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

entity arm_steering is
	port(
		clk : in std_logic;
		input_data : in std_logic_vector(7 downto 0);
		new_data : in std_logic;
		
		d_state : out std_logic_vector (2 downto 0);
		
		data_out : out std_logic_vector(11 downto 0);
		adr : out std_logic_vector(1 downto 0);
		data_read : out std_logic;
		wr_out : out std_logic
	);
end arm_steering;

architecture Behavioral of arm_steering is
	type statetype is (sadr, sd1, sd2, swr);
	signal state : statetype := sadr;
	
	signal data 		: std_logic_vector(5 downto 0);
	signal control 	: std_logic_vector(1 downto 0);
	
	signal adr_reg 	: std_logic_vector(1 downto 0) := "00";
	signal data_reg 	: std_logic_vector(11 downto 0) := (others=>'0');
	
begin
	data <= input_data(5 downto 0);
	control <= input_data(7 downto 6);
	adr <= adr_reg;
	d_state <= std_logic_vector(to_unsigned(statetype'pos(state), d_state'length));
	data_out <= data_reg;

	process(clk) 
	variable prev_new_data : std_logic := '0';
	begin
		if rising_edge(clk) then
			case state is
				when sadr =>
					if prev_new_data = '0' and new_data = '1' then
						if control = "00" then
							adr_reg <= data(1 downto 0);
							state <= sd1;
						end if;
					end if;
					wr_out<='0';
				when sd1 =>
					if prev_new_data = '0' and new_data = '1' then
						if control = "01" then
							data_reg(5 downto 0) <= data;
							state <= sd2;
						else
							state <= sadr;
						end if;
					end if;
					wr_out<='0';
				when sd2 =>
					if prev_new_data = '0' and new_data = '1' then
						if control = "10" then
							data_reg(11 downto 6) <= data;
							state <= swr;
						else
							state <= sadr;
						end if;
					end if;
					wr_out<='0';
				when swr =>
					wr_out<='1';
					state <= sadr;
				when others =>
				null;
			end case;
			
			prev_new_data := new_data;
			data_read <= new_data;
		end if;
	end process;
end Behavioral;

