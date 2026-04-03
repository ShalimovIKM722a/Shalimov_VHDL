library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bf4_test_tb is
end bf4_test_tb;

architecture bf4_test_tb of bf4_test_tb is
	
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal X : STD_LOGIC_VECTOR(3 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Y_conc_CA   : STD_LOGIC_VECTOR(3 downto 0);
	signal Y_conc_WS   : STD_LOGIC_VECTOR(3 downto 0);
	signal Y_const     : STD_LOGIC_VECTOR(3 downto 0);
	signal Y_logic     : STD_LOGIC_VECTOR(3 downto 0);
	signal Y_proc_IF   : STD_LOGIC_VECTOR(3 downto 0);
	signal Y_proc_CASE : STD_LOGIC_VECTOR(3 downto 0);
	-- simulation parameters
	constant p_delay : time := 10 ns; 
	signal index : integer;
	type VRF_TYPE is (OK, ERROR);
	signal VERIF_STATE : VRF_TYPE := OK;
	type TST_TYPE is (ETV, UTV, DONE);
	signal TEST_PHASE : TST_TYPE;
	type TV_TYPE is array (natural range <>) of STD_LOGIC_VECTOR(3 downto 0);
	constant EXPECTED_TEST_VECTORS : TV_TYPE(0 to 15) :=
    ("0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111",
     "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111");
  
	 constant UNEXP_TEST_VECTORS : TV_TYPE(0 to 15) :=
	("X000", "0X00", "00X0", "000X", "U000", "0U00", "00U0", "000U",
	 "H000", "0H00", "00H0", "000H", "L000", "0L00", "00L0", "000L");
	  
	 constant EXPECTED_RESPONSES : TV_TYPE(0 to 15) :=
	 (x"1", x"D", x"2", x"9", x"7", x"A", x"6", x"0",
	 x"8", x"C", x"4", x"5", x"F", x"3", x"B", x"E");
begin
	
	-- Units Under Test port map
	UUT1: entity work.bf4_conc_ca(bf4_conc_ca)
	port map (
		X => X,
		Y => Y_conc_CA
	); 
	
	UUT2: entity work.bf4_conc_ws(bf4_conc_ws)
	port map (
		X => X,
		Y => Y_conc_WS
	);
	
	UUT3: entity work.bf4_const(bf4_const)
	port map (
		X => X,
		Y => Y_const
	);
	
	UUT4: entity work.bf4_logic(bf4_logic)
	port map (
		X => X,
		Y => Y_logic
	);
	
	UUT5: entity work.bf4_proc_IF(bf4_proc_IF)
	port map (
		X => X,
		Y => Y_proc_IF
	);
	
	UUT6: entity work.bf4_proc_CASE(bf4_proc_CASE)
	port map (
		X => X,
		Y => Y_proc_CASE
	);
	
	-- Applying stimulus
	stim_gen: process
	begin
		-- applying expected values
		TEST_PHASE <= ETV;
		for i in 0 to EXPECTED_TEST_VECTORS'LENGTH-1 loop
			X <= EXPECTED_TEST_VECTORS(i);
			index <= i;
			wait for p_delay;	
		end loop;
		
		-- applying unexpected values
		TEST_PHASE <= UTV;
		for i in 0 to UNEXP_TEST_VECTORS'LENGTH-1 loop
			X <= UNEXP_TEST_VECTORS(i);
			wait for p_delay;	
		end loop;
		
		-- testing is done
		TEST_PHASE <= DONE;
		wait;
	end process; 
	
	-- verify responses
	output_verify: process	
		function slv_to_string ( slv: std_logic_vector) return string is
			variable str : string (slv'length downto 1) := (others => NUL);
		begin
			for i in slv'length downto 1 loop
				str(i) := std_logic'image(slv((i-1)))(2);
			end loop;
			return str;
		end function;
	begin
		wait on Y_logic;
		report "at " & time'IMAGE(now) & " all Ys changed";
		wait for p_delay/2;
		if TEST_PHASE = ETV then
			assert Y_logic = EXPECTED_RESPONSES(index) report "error in block bf4_logic when X = " & slv_to_string(X) severity ERROR;
			assert Y_conc_CA = EXPECTED_RESPONSES(index) report "error in block bf4_conc_CA when X = " & slv_to_string(X) severity ERROR;
			assert Y_conc_WS = EXPECTED_RESPONSES(index) report "error in block bf4_conc_WS when X = " & slv_to_string(X) severity ERROR;
			assert Y_const = EXPECTED_RESPONSES(index) report "error in block bf4_const when X = " & slv_to_string(X) severity ERROR;
			assert Y_proc_IF = EXPECTED_RESPONSES(index) report "error in block bf4_proc_IF when X = " & slv_to_string(X) severity ERROR;
			assert Y_proc_CASE = EXPECTED_RESPONSES(index) report "error in block bf4_proc_CASE when X = " & slv_to_string(X) severity ERROR;
			if (Y_logic /= EXPECTED_RESPONSES(index) or 
				Y_conc_CA /= EXPECTED_RESPONSES(index) or 
				Y_conc_WS /= EXPECTED_RESPONSES(index) or 
				Y_const /= EXPECTED_RESPONSES(index) or 
				Y_proc_IF /= EXPECTED_RESPONSES(index) or 
				Y_proc_CASE /= EXPECTED_RESPONSES(index)) 
			then
				VERIF_STATE <= ERROR;
			else
				VERIF_STATE <= OK;
			end if;
		elsif TEST_PHASE = UTV then	
			assert Y_logic = "ZZZZ" report "not safe response in block bf4_logic when X = " & slv_to_string(X) severity ERROR;	
			assert Y_conc_CA = "ZZZZ" report "not safe response in block bf4_conc_CA when X = " & slv_to_string(X) severity ERROR;
			assert Y_conc_WS = "ZZZZ" report "not safe response in block bf4_conc_WS when X = " & slv_to_string(X) severity ERROR;
			assert Y_const = "ZZZZ" report "not safe response in block bf4_const when X = " & slv_to_string(X) severity ERROR;
			assert Y_proc_IF = "ZZZZ" report "not safe response in block bf4_proc_IF when X = " & slv_to_string(X) severity ERROR;
			assert Y_proc_CASE = "ZZZZ" report "not safe response in block bf4_proc_CASE when X = " & slv_to_string(X) severity ERROR;
			if (Y_logic /= "ZZZZ" or 
				Y_conc_CA /= "ZZZZ" or 
				Y_conc_WS /= "ZZZZ" or 
				Y_const /= "ZZZZ" or 
				Y_proc_IF /= "ZZZZ" or 
				Y_proc_CASE /= "ZZZZ") 
			then
				VERIF_STATE <= ERROR;
			else
				VERIF_STATE <= OK;
			end if;
		end if;
			
	end process;

end bf4_test_tb;