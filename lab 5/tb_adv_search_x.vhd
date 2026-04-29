----------------------------------------------------------
-- Lab Work #5: TestBench to verify advanced Search Module
----------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adv_search_x_tb is
end entity;

architecture adv_search_x_tb_arch of adv_search_x_tb is
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK       : STD_LOGIC;
	signal RST       : STD_LOGIC;
	signal Y_TO_FIND : STD_LOGIC_VECTOR(3 downto 0);
	signal START     : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal X_R0_FOUND : STD_LOGIC_VECTOR(3 downto 0);
	signal X_R1_FOUND : STD_LOGIC_VECTOR(3 downto 0);
	signal FINISH     : STD_LOGIC;
	signal ERROR      : STD_LOGIC;
	-- Custom signals and constants
	constant clk_period : time := 10 ns;

begin

	-- Unit Under Test
	UUT : entity work.adv_search_x(adv_search_x_arch)
		port map (
			CLK    => CLK,
			RST    => RST,
			Y_FIND => Y_TO_FIND,
			START  => START,
			X_R0_F => X_R0_FOUND,
			X_R1_F => X_R1_FOUND,
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
		Y_TO_FIND <= (others => '0');	
		START <= '0';
		wait for clk_period*2;
		RST <= '0';
		-- start performing tests
		for i in 0 to 2**Y_TO_FIND'length-1 loop
			Y_TO_FIND <= std_logic_vector(to_unsigned(i,Y_TO_FIND'length));
			START <= '1';
			wait for clk_period;
			START <= '0';
			wait until (FINISH = '1' or ERROR = '1');
			assert ERROR /= '1' report "For Y(" & integer'image(i) & ") there is no value of X - errors in S-Box!";
			wait for clk_period*2;
		end loop;
		wait;
	end process;

end architecture;