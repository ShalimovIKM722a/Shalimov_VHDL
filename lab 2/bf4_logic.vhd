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
begin
	Y(3) <= (not X(3) and not X(2) and not X(1) and X(0)) or
		(not X(3) and not X(2) and X(1) and X(0)) or
		(not X(3) and X(2) and not X(1) and X(0)) or
		(X(3) and not X(2) and not X(1) and not X(0)) or
		(X(3) and not X(2) and not X(1) and X(0)) or
		(X(3) and X(2) and not X(1) and not X(0)) or
		(X(3) and X(2) and X(1) and not X(0)) or
		(X(3) and X(2) and X(1) and X(0));

	Y(2) <= (not X(3) and not X(2) and not X(1) and X(0)) or
		(not X(3) and X(2) and not X(1) and not X(0)) or
		(not X(3) and X(2) and X(1) and not X(0)) or
		(X(3) and not X(2) and not X(1) and X(0)) or
		(X(3) and not X(2) and X(1) and not X(0)) or
		(X(3) and not X(2) and X(1) and X(0)) or
		(X(3) and X(2) and not X(1) and not X(0)) or
		(X(3) and X(2) and X(1) and X(0));

	Y(1) <= (not X(3) and not X(2) and X(1) and not X(0)) or
		(not X(3) and X(2) and not X(1) and not X(0)) or
		(not X(3) and X(2) and not X(1) and X(0)) or
		(not X(3) and X(2) and X(1) and not X(0)) or
		(X(3) and X(2) and not X(1) and not X(0)) or
		(X(3) and X(2) and not X(1) and X(0)) or
		(X(3) and X(2) and X(1) and not X(0)) or
		(X(3) and X(2) and X(1) and X(0));

	Y(0) <= (not X(3) and not X(2) and not X(1) and not X(0)) or
		(not X(3) and not X(2) and not X(1) and X(0)) or
		(not X(3) and not X(2) and X(1) and X(0)) or
		(not X(3) and X(2) and not X(1) and not X(0)) or
		(X(3) and not X(2) and X(1) and X(0)) or
		(X(3) and X(2) and not X(1) and not X(0)) or
		(X(3) and X(2) and not X(1) and X(0)) or
		(X(3) and X(2) and X(1) and not X(0));
end bf4_logic;