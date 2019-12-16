
-- VHDL Instantiation Created from source file pwm_module.vhd -- 20:02:44 12/11/2019
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT pwm_module
	PORT(
		clk : IN std_logic;
		data_in : IN std_logic_vector(11 downto 0);
		adr : IN std_logic_vector(1 downto 0);
		wr : IN std_logic;          
		pwm_out : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;

	Inst_pwm_module: pwm_module PORT MAP(
		clk => ,
		data_in => ,
		adr => ,
		wr => ,
		pwm_out => 
	);


