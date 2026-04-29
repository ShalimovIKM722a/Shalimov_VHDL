--------------------------------------------------------
--  Lab Work #4: shift register - receiver
--------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity sr_r is
	port (
		CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
		IDV : in STD_LOGIC;
		SDI : in STD_LOGIC;
		PDO : out STD_LOGIC_VECTOR(3 downto 0);
		RDY : out STD_LOGIC
	);
end sr_r;

architecture sr_r_arc of sr_r is  
	signal shift_reg : STD_LOGIC_VECTOR(3 downto 0); 
	signal counter : integer range 0 to 4;
begin
	-- implementation
	shifting_in: process(CLK, RST)
	begin
		if CLK'event and CLK='1' then 
			if RST='1' then                               -- reset signal is active
				shift_reg <= (others => '0');             -- SR is filled with default value
				RDY <= '0';                               -- reset "data is ready" flag
				counter <= 0;                             -- reset received bits counter
				PDO <= (others => '0');                   -- reset received data output register
			elsif IDV='1' and counter < 4 then            -- RCV in progress, bit is being received 
				shift_reg <= shift_reg(2 downto 0) & SDI; -- put this bit into SR
				RDY <= '0';                               -- data is not ready yet - keep flag in off-state
				counter <= counter + 1;                   -- increment received bits counter
			elsif counter = 4 then                        -- last bit is being received (RCV complete)
				PDO <= shift_reg;                         -- put SR contents into output register
				RDY <= '1';                               -- raise "data is ready" flag
				counter <= 0;                             -- reset received bits counter
			else                                          -- "no transmitting" branch (idle state)
				shift_reg <= (others => '0');             -- fill SR with zeros 
				RDY <= '0';                               -- reset "data is ready" flag
				counter <= 0;                             -- reset received bits counter
			end if;
		end if;
	end process;
end sr_r_arc;
