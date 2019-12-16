
-- VHDL Instantiation Created from source file arm_steering.vhd -- 20:46:41 12/16/2019
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT arm_steering
	PORT(
		clk : IN std_logic;
		input_data : IN std_logic_vector(7 downto 0);
		new_data : IN std_logic;          
		d_state : OUT std_logic_vector(2 downto 0);
		data_out : OUT std_logic_vector(11 downto 0);
		adr : OUT std_logic_vector(1 downto 0);
		data_read : OUT std_logic;
		wr_out : OUT std_logic
		);
	END COMPONENT;

	Inst_arm_steering: arm_steering PORT MAP(
		clk => ,
		input_data => ,
		new_data => ,
		d_state => ,
		data_out => ,
		adr => ,
		data_read => ,
		wr_out => 
	);


