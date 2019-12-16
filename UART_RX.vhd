----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:54:33 12/04/2019 
-- Design Name: 
-- Module Name:    UART_RX - Behavioral 
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

entity UART_RX is
	generic(
		CLKS_PER_BIT : integer := 115
	);
	port(
		--d_counter : out integer;
		--d_state : out std_logic_vector(1 downto 0);
		--d_data_reg : out std_logic_vector(7 downto 0);
		--d_trans_en : out std_logic;
		
		clk : in std_logic;
		rx : in std_logic; -- reciever pin
		rd : in std_logic;  -- read data_signal
		
		data : out std_logic_vector(7 downto 0);
		new_data : out std_logic -- received new data flag
	);
end UART_RX;

architecture Behavioral of UART_RX is

signal counter : integer range 0 to CLKS_PER_BIT-1:= 0;
signal curr_bit_index : integer := 0;

signal data_reg : std_logic_vector(7 downto 0) := (others=>'0');
signal data_buffer : std_logic_vector(7 downto 0) := (others=>'0');

type Transmission_state is (stateData, stateStop );
signal trans_state : Transmission_state := stateData;

signal trans_en : std_logic := '0'; --transmission enabled flag
signal new_data_flag :std_logic := '0';

begin
	data <= data_buffer;
	new_data <= new_data_flag;
	
	receiving : process(clk)
	begin	
		if(rising_edge(clk)) then
			-- DEBUG DATA ASSIGNS
			--d_counter <= counter;
			--d_state <= std_logic_vector(to_unsigned(Transmission_state'POS(trans_state),d_state'length));
			--d_data_reg <= data_reg;
			--d_trans_en <= trans_en;	
		
			if(rd ='1') then
				new_data_flag <= '0';
			end if;
		
			--checking for transmission start (every clock cycle)
			if(rx ='0' and trans_en = '0') then
				trans_en <= '1';
			end if;
			
			-- state mashine (prescaled clock cycle)
			if(trans_en ='1') then
				if(counter < CLKS_PER_BIT-1) then
					counter <= counter +1;
				else
					counter <= 0;
					case trans_state is
						--when stateStart =>
						--	trans_state <= stateData;
						when stateData =>
							data_reg(curr_bit_index) <= rx;
							if(curr_bit_index < 7) then
								curr_bit_index <= curr_bit_index + 1;
							else
								curr_bit_index <= 0;
								trans_state <= stateStop;
							end if;
						when stateStop =>
							trans_en <= '0';
							counter <= 0;
							data_buffer <= data_reg;
							data_reg <= (others => '0');
							new_data_flag <= '1';
							trans_state <= stateData;
					end case;
		
				end if;
			end if;
		end if;
	end process;

end Behavioral;

