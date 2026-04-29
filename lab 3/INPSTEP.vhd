---------------------------------------------------------
-- Lab Work #3: module INPSEL (using bf4_conc_CA as Kxx)
---------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
entity INPSEL is
	port (
		OP_A : in std_logic_vector(3 downto 0);
		OP_B : in std_logic_vector(3 downto 0);
		CMD : in std_logic_vector(1 downto 0);
		OP1 : out std_logic_vector(3 downto 0);
		OP2 : out std_logic_vector(3 downto 0)
		);
end entity;
architecture INPSEL_arch of INPSEL is
signal Y0, Y1 : std_logic_vector(3 downto 0);
begin
-- Kxx components
kbox1: entity work.bf4_logic(bf4_logic)
port map (
	X => OP_A,
	Y => Y0
	);
kbox2: entity work.bf4_logic(bf4_logic)
port map (
	X => OP_B,
	Y => Y1
	);
-- output multiplexers
OP1 <= OP_A when CMD(0) = '0' else Y0;
OP2 <= OP_B when CMD(1) = '0' else Y1;

end architecture;