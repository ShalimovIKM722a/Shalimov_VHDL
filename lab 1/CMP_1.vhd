library IEEE;
use IEEE.std_logic_1164.all;
entity CMP_1 is
	port(
		a,b : in STD_LOGIC;
		eq : out STD_LOGIC
		);
end CMP_1;
architecture CMP_1_beh of CMP_1 is
begin
	eq <= ((not a) and (not b)) or (a and b);
end CMP_1_beh;