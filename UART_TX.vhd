----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:55:11 12/03/2019 
-- Design Name: 
-- Module Name:    UART_TX - Behavioral 
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



entity UART_TX is
	generic (
    CLKS_PER_BIT : integer := 115
    );
	 
	port(
		clk: in std_logic;
		data : in std_logic_vector( 7 downto 0); -- byte to send
		start: in std_logic;							  -- start flag, when 1 begins transmision
		
		tx : out std_logic;							  -- transmiter pin
		busy : out std_logic							  -- busy flag, 1 when transmiting
		
		--d_data : out std_logic_vector( 7 downto 0);
		--d_state : out std_logic_vector ( 1 downto 0);
		--d_counter : out integer
	);
end UART_TX;

architecture Behavioral of UART_TX is

signal data_reg : std_logic_vector (7 downto 0) := (others => '0');
signal counter : integer range 0 to CLKS_PER_BIT-1 := 0;
signal trans_en : std_logic := '0'; --indicates transmission enabled
signal trans_done : std_logic := '0';

type Transmission_state is (stateStart, stateData, stateStop, stateCleanup );
signal trans_state : Transmission_state := stateStart;
signal curr_bit_index : integer range 0 to 7 := 0; -- index of bit in data_reg currently transmitted

signal tx_buffer: std_logic := '1'; -- output buffer

begin

	busy <= trans_en;
	tx <= tx_buffer;
	--d_data <= data_reg;
	--d_counter <= counter;
	
	-- proces waiting to initialize and begin transmission
	init : process(clk)
	begin
		if(falling_edge(clk)) then
			if(start = '1' and trans_en = '0') then
				trans_en <= '1';
				data_reg <= data;
			elsif(trans_done = '1') then
				trans_en <= '0';
			end if;
		end if;
	end process;

	
	--comment : if false generate
	transmiting : process(clk) 
	begin
		if(rising_edge(clk)) then
			--d_state <= std_logic_vector(to_unsigned(Transmission_state'POS(trans_state),d_state'length));
			if (trans_en = '1') then
				trans_done <= '0';
				if(counter < CLKS_PER_BIT-1) then
					counter <= counter +1;
				else
					counter <= 0;
					case trans_state is
						when stateStart =>
							tx_buffer <= '0'; --transmitting start bit
							trans_state <= stateData;
						when stateData =>
							tx_buffer <= data_reg(curr_bit_index);	-- transmiting data
							if( curr_bit_index < 7) then
								curr_bit_index <= curr_bit_index + 1;
							else
								curr_bit_index <= 0;
								trans_state <= stateStop;
							end if;
						when stateStop =>
							tx_buffer <= '1'; -- transmiting stop bit
							trans_state <= stateCleanup;
						when stateCleanup =>
							counter <= 0;
							trans_done <= '1';
							trans_state <= stateStart;
						when others =>
							trans_state <= stateStart;
					end case;
				end if;
			else
				counter <= 0;
			end if;
		end if;
	end process;
	--end generate comment;
end Behavioral;

