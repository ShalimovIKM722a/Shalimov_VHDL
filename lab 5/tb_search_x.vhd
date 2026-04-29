---------------------------------------------------------
-- Lab Work #5: TestBench to verify default Search Module
---------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity search_x_tb is
end search_x_tb;

architecture search_x_tb_arch of search_x_tb is
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK    : STD_LOGIC;
	signal RST    : STD_LOGIC;
	signal R      : STD_LOGIC;
	signal Y_FIND : STD_LOGIC_VECTOR(3 downto 0);
	signal START  : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal X_FOUND : STD_LOGIC_VECTOR(3 downto 0);
	signal FINISH  : STD_LOGIC;
	signal ERROR   : STD_LOGIC;
	-- Custom signals and constants
	constant clk_period : time := 10 ns;
	type slv_array is array (0 to 15) of STD_LOGIC_VECTOR(3 downto 0);
	constant y_variants_r0 : slv_array := (x"4", x"d", x"3", x"9", x"a", x"e", x"7", x"1", x"f", x"2", x"5", x"b", x"c", x"8", x"6", x"0");
	constant y_variants_r1 : slv_array := (x"f", x"7", x"9", x"2", x"0", x"a", x"e", x"6", x"d", x"3", x"4", x"b", x"c", x"1", x"5", x"8");		 

begin

	-- Unit Under Test
	UUT : entity work.search_x
		port map (
			CLK    => CLK,
			RST    => RST,
			R      => R,
			Y_F    => Y_FIND,
			START  => START,
			X_F    => X_FOUND,
			FINISH => FINISH,
			ERROR  => ERROR
		);

	clk_gen: process
	begin
		CLK <= '0';
		wait for clk_period/2;
		CLK <= '1';
		wait for clk_period/2;
	end process;  
	
	stim_gen: process
	begin
		-- peform reset actions (for 2 clk_period)
		RST <= '1';
		R <= '0';
		Y_FIND <= (others => '0');	
		START <= '0';
		wait for clk_period*2;
		RST <= '0';
		-- start performing tests
		for i in y_variants_r0'range(1) loop
			Y_FIND <= y_variants_r0(i);
			START <= '1';
			wait for clk_period;
			START <= '0';
			wait until (FINISH = '1' or ERROR = '1');
			assert ERROR /= '1' report "For Y(" & integer'image(i) & ") there is no value of X - errors in S-Box!";
			wait for clk_period*2;
		end loop;
		R <= '1';
		for i in y_variants_r1'range(1) loop
			Y_FIND <= y_variants_r1(i);
			START <= '1';
			wait for clk_period;
			START <= '0';
			wait until (FINISH = '1' or ERROR = '1');
			assert ERROR /= '1' report "For Y(" & integer'image(i) & ") there is no value of X - errors in S-Box!";
			wait for clk_period*2;
		end loop;
		wait;
	end process;

end search_x_tb_arch;