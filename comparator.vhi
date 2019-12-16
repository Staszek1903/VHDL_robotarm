
-- VHDL Instantiation Created from source file comparator.vhd -- 18:49:23 12/11/2019
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT comparator
	PORT(
		a : IN std_logic;
		b : IN std_logic;          
		ls : OUT std_logic;
		eq : OUT std_logic;
		gt : OUT std_logic
		);
	END COMPONENT;

	Inst_comparator: comparator PORT MAP(
		a => ,
		b => ,
		ls => ,
		eq => ,
		gt => 
	);


