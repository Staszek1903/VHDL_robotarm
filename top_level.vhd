----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:09:17 10/13/2019 
-- Design Name: 
-- Module Name:    top_level - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
	port(
	--inputs
		clk : in std_logic;
		--button : in std_logic_vector(2 downto 0);
		--slider : in std_logic_vector(1 downto 0);
		
	--outputs
		led : out std_logic_vector( 7 downto 0 );
		segment : out std_logic_vector ( 7 downto 0 );
		enable : out std_logic_vector ( 2 downto 0 );
		header1 : out std_logic_vector ( 7 downto 0 );
		header6 : out std_logic_vector ( 7 downto 0 );
		
		--d_data : out std_logic_vector ( 7 downto 0);
		
		uart_tx_pin : out std_logic;
		uart_rx_pin : in std_logic
	);
end top_level;

architecture Behavioral of top_level is
	
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
        );
    END COMPONENT;
	 
	 COMPONENT UART_RX
	 GENERIC(
		CLKS_PER_BIT : integer 
		);
    PORT(
         clk : IN  std_logic;
         rx : IN  std_logic;
         rd : IN  std_logic;
         data : OUT  std_logic_vector(7 downto 0);
         new_data : OUT  std_logic
        );
    END COMPONENT;

	COMPONENT display_driver is
	PORT(
		clk : IN std_logic;
		seg0 : IN std_logic_vector(4 downto 0);
		seg1 : IN std_logic_vector(4 downto 0);
		seg2 : IN std_logic_vector(4 downto 0);          
		segment : OUT std_logic_vector(7 downto 0);
		enable : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;
	
	COMPONENT pwm_module
	PORT(
		clk : IN std_logic;
		data_in : IN std_logic_vector(11 downto 0);
		adr : IN std_logic_vector(1 downto 0);
		wr : IN std_logic;          
		pwm_out : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT arm_steering
	PORT(
		clk : IN std_logic;
		input_data : IN std_logic_vector(7 downto 0);
		new_data : IN std_logic;          
		data_out : OUT std_logic_vector(11 downto 0);
		adr : OUT std_logic_vector(1 downto 0);
		data_read : OUT std_logic;
		wr_out : OUT std_logic
		);
	END COMPONENT;
	
--	COMPONENT timer IS
--	generic (
--		bit_length : integer
--	);
--	
--	port (
--		--input
--		clk : in std_logic;
--		top : in std_logic_vector( bit_length-1 downto 0) := (others => '1');
--		
--		--output
--		value_out : out std_logic_vector( bit_length-1 downto 0)
--		);
--	
--	END COMPONENT;
	
	constant F_CLK : integer := 12000000;
	constant BAUD : integer := 9300;
	constant UART_PRESCALER : integer := F_CLK / BAUD;
	
	constant timer_max : integer := 240000;
	constant pwm_max : integer := 28000;
	constant pwm_min : integer := 5000;
	
	signal pwm_val : std_logic_vector (11 downto 0) := "100000000000"; --(14 downto 0) := to_unsigned((pwm_min+pwm_max)/2, 15);
	signal pwm_adr : std_logic_vector(1 downto 0) := "00";
	signal pwm_wr : std_logic;
	--signal pwm2 : unsigned (14 downto 0) := to_unsigned((pwm_min+pwm_max)/2, 15);
	--signal pwm3 : unsigned (14 downto 0) := to_unsigned((pwm_min+pwm_max)/2, 15);
	--signal pwm4 : unsigned (14 downto 0) := to_unsigned(pwm_min, 15);
	
	signal pwm1_seg : std_logic_vector (4 downto 0);
	signal pwm2_seg : std_logic_vector (4 downto 0);
	signal pwm3_seg : std_logic_vector (4 downto 0);
	
	signal uart_data_in : std_logic_vector(7 downto 0);
	signal uart_data_out : std_logic_vector(7 downto 0) := "01000010";
	signal uart_start : std_logic;
	signal uart_busy : std_logic;
	signal uart_read : std_logic := '0';
	signal uart_new_data : std_logic;
	
	signal led_reg: std_logic_vector(7 downto 0) := (others=> '0');
	
	

begin
	
	--d_data <= uart_data_in;
	led <= led_reg;
	uart_data_out <=  led_reg; --std_logic_vector(unsigned(uart_data_in));
	
	tx : UART_TX 
	GENERIC MAP(
			CLKS_PER_BIT => UART_PRESCALER
		)
	PORT MAP (
          clk => clk,
          data => uart_data_out,
          start => uart_start,
          tx => uart_tx_pin,
          busy => uart_busy
        );
		  
	rx: UART_RX 
	GENERIC MAP(
			CLKS_PER_BIT => UART_PRESCALER
		)
	PORT MAP (
          clk => clk,
          rx => uart_rx_pin,
          rd => uart_read,
          data => uart_data_in,
          new_data => uart_new_data
        );
		  
		  
	Inst_arm_steering: arm_steering PORT MAP(
		clk => clk,
		input_data => uart_data_in,
		new_data => uart_new_data,
		data_out => pwm_val,
		adr => pwm_adr,
		data_read => uart_read,
		wr_out => pwm_wr
	);
	
	uart_stimulus : process(clk)
		--variable counter : integer range 0 to F_CLK-1 := 0;
		variable prev_state : std_logic := '0';
	begin
		if(rising_edge(clk)) then
		
			if uart_new_data = '1' and prev_state = '0' then
				led_reg <= uart_data_in;
				uart_start <= '1';
				prev_state := '1';
				
			else
				if uart_new_data = '0' then
					prev_state := '0';
				end if;
				uart_start <= '0';
			end if;
		end if;
	end process;

pwm1_seg <= "0" & pwm_val(3 downto 0);
pwm2_seg <= "0" & pwm_val(7 downto 4);
pwm3_seg <= "0" & pwm_val(11 downto 8);	

--	process(clk)
--		variable counter : integer := 0;
--	begin
--		if(rising_edge(clk)) then
--			if(counter > 10000) then
--				counter := 0;
--				--pwm1
--				if button(0) = '0' then -- and pwm1 < pwm_max then
--					pwm1 <= pwm1 + 1;
--				end if;
--				if button(1) = '0' then -- and pwm1 > pwm_min then
--					pwm1 <= pwm1 - 1;
--				end if;
--				
--				--pwm2
--				if(button(2) = '0' and pwm2 < pwm_max) then
--					pwm2 <= pwm2 + 1;
--				end if;
--				if(button(3) = '0' and pwm2 > pwm_min) then
--					pwm2 <= pwm2 - 1;
--				end if;
--				
--				--PWM3
--				if(button(4) = '0' and pwm3 < pwm_max) then
--					pwm3 <= pwm3 + 1;
--				end if;
--				if(button(5) = '0' and pwm3 > pwm_min) then
--					pwm3 <= pwm3 - 1;
--				end if;
--				
--				--PWM4
--				--if(button(0) = '0' and pwm4 < pwm_max) then
--				--	pwm4 <= pwm4 + 1;
--				--end if;
--				--if(button(1) = '0' and pwm4 > pwm_min) then
--				--	pwm4 <= pwm4 - 1;
--				--end if;
--			else
--				counter := counter +1;
--			end if;
--		end if;
--	end process;
--	
--	
	Inst_display_driver: display_driver PORT MAP(
		segment => segment,
		enable => enable,
		clk => clk,
		seg0 => pwm1_seg,
		seg1 => pwm2_seg,
		seg2 => pwm3_seg
	);
--	
--	Inst_timer : timer
--	generic map (
--		bit_length => 18
--	)
--	port map (
--		clk => clk,
--		top => std_logic_vector(to_unsigned(timer_max, 18)),
--		value_out => timer_out
--	);
--	
--	pwm1_seg <= pwm1(14 downto 10);
--	pwm2_seg <= pwm2(14 downto 10);
--	pwm3_seg <= pwm3(14 downto 10);	
--	
--	header1(0) <= '1' when unsigned(timer_out) < ("000"&pwm1) else '0';
--	header1(1) <= '1' when unsigned(timer_out) < ("000"&pwm2) else '0';
--	header6(0) <= '1' when unsigned(timer_out) < ("000"&pwm3) else '0';
--	--header6(1) <= '1' when unsigned(timer_out) < ("000"&pwm4) else '0';

	Inst_pwm_module: pwm_module PORT MAP(
		clk => clk,
		data_in => pwm_val,
		adr => pwm_adr, --slider(1 downto 0),
		wr => pwm_wr, --not button(2),
		pwm_out => header1(3 downto 0)
	);

	
	header1(7 downto 4) <= (others=>'0');
	header6(7 downto 0) <= (others=>'0');

end Behavioral;

