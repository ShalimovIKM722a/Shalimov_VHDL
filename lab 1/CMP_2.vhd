library IEEE;
use IEEE.std_logic_1164.all;
entity CMP_2 is
	port(
		A : in STD_LOGIC_VECTOR(1 downto 0);
		B : in STD_LOGIC_VECTOR(1 downto 0);
		EQ : out STD_LOGIC
		);
end CMP_2;
-- functional descraption
architecture CMP_2_beh of CMP_2 is
	signal p0, p1, p2, p3 : STD_LOGIC;
begin
	-- MDNF - sum of product terms
	EQ <= p0 or p1 or p2 or p3;
	-- product terms
	p0 <= (not A(1)) and (not B(1)) and (not A(0)) and (not B(0));
	p1 <= (not A(1)) and (not B(1)) and A(0) and B(0);
	p2 <= A(1) and B(1) and (not A(0)) and (not B(0));
	p3 <= A(1) and B(1) and A(0) and B(0);
end CMP_2_beh;
-- structural description
architecture CMP_2_struct of CMP_2 is
	component CMP_1 is
		port(
			a,b : in STD_LOGIC;
			eq : out STD_LOGIC
			);
	end component;
	signal eq_0, eq_1 : STD_LOGIC;
begin
	-- compare least bits
	inst_0: CMP_1 port map (a => A(0), b => B(0), eq => eq_0);
	-- compare most bits
	inst_1: CMP_1 port map (a => A(1), b => B(1), eq => eq_1);
	-- combine result
	EQ <= eq_0 and eq_1;
end CMP_2_struct;