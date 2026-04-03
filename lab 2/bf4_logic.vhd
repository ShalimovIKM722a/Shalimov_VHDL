-------------------------------------------------------------------------------
-- Lab Work 2 - Combinatorial Logic Implementations
-- Example 1: multiply output combinatorial circuit
-- using logic operators (2 variants)
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity bf4_logic is
	port(
		X : in STD_LOGIC_VECTOR(3 downto 0);
		Y : out STD_LOGIC_VECTOR(3 downto 0)
		);
end bf4_logic;

architecture bf4_logic of bf4_logic is	
	signal P : STD_LOGIC_VECTOR(14 downto 0); -- .p 12
begin														   
	P(0)  <= not X(2) and not X(1) and X(0);         -- -001
	P(1)  <= not X(3) and not X(1) and X(0);         -- 0-01
	P(2)  <= not X(3) and not X(2) and X(0);         -- 00-1
	P(3)  <= X(3) and not X(0);                      -- 1--0
	P(4)  <= X(3) and X(2) and X(1);                 -- 111-
	P(5)  <= not X(3) and X(2) and not X(0);         -- 01-0
	P(6)  <= X(3) and X(1) and X(0);                 -- 1-11
	P(7)  <= X(2) and not X(1) and not X(0);         -- -100
	P(8)  <= X(1) and not X(0);                      -- --10
	P(9)  <= X(2) and not X(1);                      -- -10-
	P(10) <= X(3) and X(2);                          -- 11--
	P(11) <= not X(3) and not X(1) and not X(0);     -- 0-00
	P(12) <= X(3) and X(2) and not X(0);             -- 11-0
	P(13) <= not X(2) and X(1) and X(0);             -- -011
	P(14) <= X(3) and X(2) and not X(1);             -- 110-
	
	Y(3)  <= P(0) or P(1) or P(2) or P(3) or P(4);
	Y(2)  <= P(5) or P(0) or P(6) or P(7);
	Y(1)  <= P(8) or P(9) or P(10);
	Y(0)  <= P(2) or P(11) or P(12) or P(13) or P(14);
end bf4_logic;