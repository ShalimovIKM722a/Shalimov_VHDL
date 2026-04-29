---------------------------------------------------------
-- Lab Work #5: Searcher full scheme 
---------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity search_x is 
	port (
		CLK    : in  STD_LOGIC;
		RST    : in  STD_LOGIC;
		R      : in  STD_LOGIC;
		Y_F    : in  STD_LOGIC_VECTOR (3 downto 0);
		START  : in  STD_LOGIC;
		X_F    : out STD_LOGIC_VECTOR (3 downto 0);
		FINISH : out STD_LOGIC;
		ERROR  : out STD_LOGIC
	);
end search_x;

architecture search_x_arch of search_x is
	signal Y_buf : STD_LOGIC_VECTOR (3 downto 0);
	signal X_buf : STD_LOGIC_VECTOR (3 downto 0);
begin
	-- components (direct use, without preliminary declaration)
	Kxx_unit: entity work.kxx_rom
	port map (
	    R => R,	  
	    F => '1', 
		X => X_buf,
		Y => Y_buf
	);
	FSM_unit: entity work.fsm_search_x
	port map (
		CLK => CLK,
		RST => RST,
		Y_S => Y_buf,
		Y_F => Y_F,
		STR => START,
		X_S => X_buf,
		FIN => FINISH,
		ERR => ERROR
	);
	-- X output expression
	X_F <= X_buf;
end search_x_arch;