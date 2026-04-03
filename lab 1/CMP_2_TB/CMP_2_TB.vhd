																		 library ieee;
use ieee.std_logic_1164.all;
entity CMP_2_TB is
end entity;
architecture CMP_2_TB_ARC of CMP_2_TB is
	-- Component declaration of the tested unit
	component cmp_2
		port(
			A, B : in STD_LOGIC_VECTOR(1 downto 0);
			EQ : out STD_LOGIC );
	end component;
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal A : STD_LOGIC_VECTOR(1 downto 0);
	signal B : STD_LOGIC_VECTOR(1 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal EQ_behav, EQ_struct : STD_LOGIC;
begin
	-- Units Under Test (UUT)
	UUT1 : cmp_2 port map ( A => A, B => B, EQ => EQ_behav );
	UUT2 : cmp_2 port map ( A => A, B => B, EQ => EQ_struct );
	-- Stimulus to verify comparators
	stim_gen: process
	begin
		-- test case 1 test equal
		A <= "00"; B <= "00";
		wait for 100 ns;
		assert (EQ_behav = '1') report "UUT1: EQ=0 while A=00 and B=00" severity ERROR;
		assert (EQ_struct = '1') report "UUT2: EQ=0 while A=00 and B=00" severity ERROR;
		-- test case 2 test equal
		A <= "01"; B <= "01";
		wait for 100 ns;
		assert (EQ_behav = '1') report "UUT1: EQ=0 while A=01 and B=01" severity ERROR;
		assert (EQ_struct = '1') report "UUT2: EQ=0 while A=01 and B=01" severity ERROR;
		-- test case 3 test equal
		A <= "10"; B <= "10";
		wait for 100 ns;
		assert (EQ_behav = '1') report "UUT1: EQ=0 while A=10 and B=10" severity ERROR;
		assert (EQ_struct = '1') report "UUT2: EQ=0 while A=10 and B=10" severity ERROR;
		-- test case 4 test equal
		A <= "11"; B <= "11";
		wait for 100 ns;
		assert (EQ_behav = '1') report "UUT1: EQ=0 while A=11 and B=11" severity ERROR;
		assert (EQ_struct = '1') report "UUT2: EQ=0 while A=11 and B=11" severity ERROR;
		-- test case 5: A=00, B=01
		A <= "00"; B <= "01";
		wait for 100 ns;
		assert (EQ_behav = '0') report "UUT1: EQ=1 while A=00 and B=01" severity ERROR;
		assert (EQ_struct = '0') report "UUT2: EQ=1 while A=00 and B=01" severity ERROR;
		
		-- test case 6: A=00, B=10
		A <= "00"; B <= "10";
		wait for 100 ns;
		assert (EQ_behav = '0') report "UUT1: EQ=1 while A=00 and B=10" severity ERROR;
		assert (EQ_struct = '0') report "UUT2: EQ=1 while A=00 and B=10" severity ERROR;
		
		-- test case 7: A=00, B=11
		A <= "00"; B <= "11";
		wait for 100 ns;
		assert (EQ_behav = '0') report "UUT1: EQ=1 while A=00 and B=11" severity ERROR;
		assert (EQ_struct = '0') report "UUT2: EQ=1 while A=00 and B=11" severity ERROR;
		
		-- test case 8: A=01, B=00
		A <= "01"; B <= "00";
		wait for 100 ns;
		assert (EQ_behav = '0') report "UUT1: EQ=1 while A=01 and B=00" severity ERROR;
		assert (EQ_struct = '0') report "UUT2: EQ=1 while A=01 and B=00" severity ERROR;
		
		-- test case 9: A=01, B=10
		A <= "01"; B <= "10";
		wait for 100 ns;
		assert (EQ_behav = '0') report "UUT1: EQ=1 while A=01 and B=10" severity ERROR;
		assert (EQ_struct = '0') report "UUT2: EQ=1 while A=01 and B=10" severity ERROR;
		
		-- test case 10: A=01, B=11
		A <= "01"; B <= "11";
		wait for 100 ns;
		assert (EQ_behav = '0') report "UUT1: EQ=1 while A=01 and B=11" severity ERROR;
		assert (EQ_struct = '0') report "UUT2: EQ=1 while A=01 and B=11" severity ERROR;
		
		-- test case 11: A=10, B=00
		A <= "10"; B <= "00";
		wait for 100 ns;
		assert (EQ_behav = '0') report "UUT1: EQ=1 while A=10 and B=00" severity ERROR;
		assert (EQ_struct = '0') report "UUT2: EQ=1 while A=10 and B=00" severity ERROR;
		
		-- test case 12: A=10, B=01
		A <= "10"; B <= "01";
		wait for 100 ns;
		assert (EQ_behav = '0') report "UUT1: EQ=1 while A=10 and B=01" severity ERROR;
		assert (EQ_struct = '0') report "UUT2: EQ=1 while A=10 and B=01" severity ERROR;
		
		-- test case 13: A=10, B=11
		A <= "10"; B <= "11";
		wait for 100 ns;
		assert (EQ_behav = '0') report "UUT1: EQ=1 while A=10 and B=11" severity ERROR;
		assert (EQ_struct = '0') report "UUT2: EQ=1 while A=10 and B=11" severity ERROR;
		
		-- test case 14: A=11, B=00
		A <= "11"; B <= "00";
		wait for 100 ns;
		assert (EQ_behav = '0') report "UUT1: EQ=1 while A=11 and B=00" severity ERROR;
		assert (EQ_struct = '0') report "UUT2: EQ=1 while A=11 and B=00" severity ERROR;
		
		-- test case 15: A=11, B=01
		A <= "11"; B <= "01";
		wait for 100 ns;
		assert (EQ_behav = '0') report "UUT1: EQ=1 while A=11 and B=01" severity ERROR;
		assert (EQ_struct = '0') report "UUT2: EQ=1 while A=11 and B=01" severity ERROR;
		
		-- test case 16: A=11, B=10
		A <= "11"; B <= "10";
		wait for 100 ns;
		assert (EQ_behav = '0') report "UUT1: EQ=1 while A=11 and B=10" severity ERROR;
		assert (EQ_struct = '0') report "UUT2: EQ=1 while A=11 and B=10" severity ERROR;
		wait;
	end process;
end architecture;
configuration TB_CMP_2_CONF of CMP_2_TB is
	for CMP_2_TB_ARC
		for UUT1 : cmp_2 use entity work.cmp_2(cmp_2_beh); end for;
		for UUT2 : cmp_2 use entity work.cmp_2(cmp_2_struct); end for;
	end for;
end TB_CMP_2_CONF;