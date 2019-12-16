----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:46:28 12/11/2019 
-- Design Name: 
-- Module Name:    pwm_module - Behavioral 
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

entity pwm_module is
	port(
		clk : in std_logic;
		data_in : in std_logic_vector(11 downto 0);
		adr : in std_logic_vector (1 downto 0);
		wr : in std_logic;
		
		--data_out : out std_logic_vector (11 downto 0);
		pwm_out :out std_logic_vector (3 downto 0)
	);
end pwm_module;

architecture Behavioral of pwm_module is
	COMPONENT comparator
	GENERIC (
		BIT_LENGTH : integer
	);
	PORT(
		a : IN std_logic_vector( bit_length-1 downto 0);
		b : IN std_logic_vector( bit_length-1 downto 0);      
		ls : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT timer
	GENERIC (
		BIT_LENGTH : integer
	);
	PORT(
		clk : IN std_logic;
		top : IN std_logic_vector( bit_length-1 downto 0);        
		value_out : out std_logic_vector( bit_length-1 downto 0)
		);
	END COMPONENT;
	
	constant PWM_MIN : unsigned(17 downto 0) := to_unsigned(11620, 18);
	--constant PWM_MEAN : integer (
	constant BIT_LENGTH : integer := 18;
	constant timer_max : integer := 240000;
	
	signal x_reg : unsigned(11 downto 0) := (others=>'0');
	signal y_reg : unsigned(11 downto 0) := (others=>'0');
	signal z_reg : unsigned(11 downto 0) := (others=>'0');
	signal w_reg : unsigned(11 downto 0) := (others=>'0');
	
	signal x_pwm : std_logic_vector( bit_length-1 downto 0);
	signal y_pwm : std_logic_vector( bit_length-1 downto 0);
	signal z_pwm : std_logic_vector( bit_length-1 downto 0);
	signal w_pwm : std_logic_vector( bit_length-1 downto 0);
	
	
	signal timer_value : std_logic_vector( bit_length-1 downto 0);
	
begin
	x_pwm <= std_logic_vector(("0000"&x_reg&"00")+PWM_MIN);
	y_pwm <= std_logic_vector(("0000"&y_reg&"00")+PWM_MIN);
	z_pwm <= std_logic_vector(("0000"&z_reg&"00")+PWM_MIN);
	w_pwm <= std_logic_vector(("0000"&w_reg&"00")+PWM_MIN);

	inst_timer: timer GENERIC MAP(
		BIT_LENGTH => BIT_LENGTH
	)PORT MAP(
		clk => clk,
		top => std_logic_vector(to_unsigned(timer_max, BIT_LENGTH)),
		value_out => timer_value
	);

	inst_pwm_x: comparator GENERIC MAP(
		BIT_LENGTH => 18
	)PORT MAP(
		a => timer_value,
		b => x_pwm,
		ls => pwm_out(0)
	);

	inst_pwm_y: comparator GENERIC MAP(
		BIT_LENGTH => BIT_LENGTH
	)PORT MAP(
		a => timer_value,
		b => y_pwm,
		ls => pwm_out(1)
	);

	inst_pwm_z: comparator GENERIC MAP(
		BIT_LENGTH => BIT_LENGTH
	)PORT MAP(
		a => timer_value,
		b => z_pwm,
		ls => pwm_out(2)
	);
	
	inst_pwm_w: comparator GENERIC MAP(
		BIT_LENGTH => BIT_LENGTH
	)PORT MAP(
		a => timer_value,
		b => w_pwm,
		ls => pwm_out(3)
	);
	
	process(clk) begin
		if rising_edge(clk) and wr = '1' then
			case adr is
				when "00" =>
					x_reg <= unsigned(data_in);
				when "01" =>
					y_reg <= unsigned(data_in);
				when "10" =>
					z_reg <= unsigned(data_in);
				when "11" =>
					w_reg <= unsigned(data_in);
				when others => null;
			end case;
		end if;
	end process;
	
end Behavioral;

