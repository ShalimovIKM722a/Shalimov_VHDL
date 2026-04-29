--------------------------------------------------------
--  Lab Work #4: shift register - transmitter
--------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity sr_t is
	port (
		CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
		IDV : in STD_LOGIC;
		PDI : in STD_LOGIC_VECTOR(3 downto 0);
		SDO : out STD_LOGIC;
		ODV : out STD_LOGIC
	);
end sr_t;

architecture sr_t_arc of sr_t is  
	signal shift_reg : STD_LOGIC_VECTOR(3 downto 0); 
	signal counter : integer range 0 to 3;
begin
	-- implementation
	SDO <= shift_reg(3);                                  -- output most significant bit (MSB) of shift register (SR)
	shifting_out: process(CLK, RST)
	begin
		if CLK'event and CLK='1' then 
			if RST='1' then                               -- reset signal is active
				shift_reg <= (others => '0');             -- SR is filled with default value
				ODV <= '0';                               -- reset output data valid signal
				counter <= 0;                             -- reset bit transmit counter
			elsif IDV='1' then	                          -- data for transmit is ready - begin transmit process
				shift_reg <= PDI;                         -- put data to shift register
				ODV <= '1';                               -- set output data valid signal
				counter <= 3;                             -- prepare bit transmit counter
			elsif counter > 0 then                        -- transmitting in progress
				shift_reg <= shift_reg(2 downto 0) & '0'; -- move value in SR to the left
				counter <= counter - 1;                   -- decrement bit transmit counter
			else                                          -- last bit was transmitted
				shift_reg <= (others => '0');             -- reset SR with default value
				ODV <= '0';                               -- reset output data valid signal
			end if;
		end if;
	end process;
end sr_t_arc;
