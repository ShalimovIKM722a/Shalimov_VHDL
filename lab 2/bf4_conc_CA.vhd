-------------------------------------------------------------------------------
-- Lab Work 2 - Combinatorial Logic Implementations
-- Example 2: multiply output combinatorial circuit
-- using concurrent conditional assignment
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity bf4_conc_CA is
	port(
		X : in STD_LOGIC_VECTOR(3 downto 0);
		Y : out STD_LOGIC_VECTOR(3 downto 0)
		);
end bf4_conc_CA;
architecture bf4_conc_CA of bf4_conc_CA is
begin
Y <= "0001" when X="0000" else
     "1101" when X="0001" else
     "0010" when X="0010" else
     "1001" when X="0011" else
     "0111" when X="0100" else
     "1010" when X="0101" else
     "0110" when X="0110" else
     "0000" when X="0111" else
     "1000" when X="1000" else
     "1100" when X="1001" else
     "0100" when X="1010" else
     "0101" when X="1011" else
     "1111" when X="1100" else
     "0011" when X="1101" else
     "1011" when X="1110" else
     "1110" when X="1111" else
     "ZZZZ";
end bf4_conc_CA;