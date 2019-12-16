
-- VHDL Instantiation Created from source file timer.vhd -- 18:52:27 12/11/2019
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT timer
	PORT(
		clk : IN std_logic;
		top : IN std_logic;          
		value_out : OUT std_logic
		);
	END COMPONENT;

	Inst_timer: timer PORT MAP(
		clk => ,
		top => ,
		value_out => 
	);


