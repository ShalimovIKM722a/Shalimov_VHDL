-------------------------------------------------------------------------------
-- Lab Work 2 - Combinatorial Logic Implementations
-- Example 5: multiply output combinatorial circuit
-- using process with IF statement
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity bf4_proc_IF is
	port(
		X : in STD_LOGIC_VECTOR(3 downto 0);
		Y : out STD_LOGIC_VECTOR(3 downto 0)
		);
end bf4_proc_IF;
architecture bf4_proc_IF of bf4_proc_IF is
begin
	KXX_IF: process(X)
	begin
		if (X = "0000") then Y <= "0001";
		elsif (X = "0001") then Y <= "1101";
		elsif (X = "0010") then Y <= "0010";
		elsif (X = "0011") then Y <= "1001";
		elsif (X = "0100") then Y <= "0111";
		elsif (X = "0101") then Y <= "1010";
		elsif (X = "0110") then Y <= "0110";
		elsif (X = "0111") then Y <= "0000";
		elsif (X = "1000") then Y <= "1000";
		elsif (X = "1001") then Y <= "1100";
		elsif (X = "1010") then Y <= "0100";
		elsif (X = "1011") then Y <= "0101";
		elsif (X = "1100") then Y <= "1111";
		elsif (X = "1101") then Y <= "0011";
		elsif (X = "1110") then Y <= "1011";
		elsif (X = "1111") then Y <= "1110";
		else Y <= "ZZZZ";
		end if;
	end process;
end bf4_proc_IF;