---------------------------------------------------------
-- Lab Work #5: FSM to search X for given Y in Kxx S-box 
---------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity fsm_search_x is 
	port (
		CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
		Y_S : in STD_LOGIC_VECTOR (3 downto 0);
		Y_F : in STD_LOGIC_VECTOR (3 downto 0);
		STR : in STD_LOGIC;
		X_S : out STD_LOGIC_VECTOR (3 downto 0);
		FIN : out STD_LOGIC;
		ERR : out STD_LOGIC
	);
end fsm_search_x;

architecture fsm_search_x_arch of fsm_search_x is
	-- FSM state signal
	type state_type is (idle, search);
	signal state : state_type;
 	-- buffer to latch Y_F (Y preset)
	signal Y_buf : STD_LOGIC_VECTOR (3 downto 0) := (others =>'0');
	signal X_buf : STD_LOGIC_VECTOR (3 downto 0) := (others =>'0');
begin
	----------------------------------------------------------------------
	-- Finite State Machine (FSM) : fsm_search_x
	----------------------------------------------------------------------
	search_machine: process (CLK)
	begin
		if RST='1' then
			-- Set default values for outputs, signals and variables
			state <= idle;
			Y_buf <= (others =>'0');
			X_buf <= (others =>'0');
			FIN <= '0';
			ERR	<= '0';
		elsif CLK'event and CLK = '1' then
			-- Set default values for outputs, signals and variables
			-- ...
			case state is
				when idle =>
					FIN <= '0';
					ERR <= '0';
					if STR = '1' then  -- start searching
						state <= search; -- go to next state
						Y_buf <= Y_F;    -- lock Y to find
						X_buf <= (others =>'0'); -- reset X
					end if;
				when search =>
						if Y_S /= Y_buf then
							if X_buf = "1111" then -- last X and Y wasn't found (does not exist?)
								state <= idle;
								ERR <= '1';
							else
								X_buf <= X_buf + 1;	 -- continue search
							end if;
						else
							state <= idle; -- current X is what we've been searching
							FIN <= '1';
						end if;
				when others => -- case clause must have "others" option
					null;
			end case;
		end if;
	end process;
	
	X_S <= X_buf;
	
end fsm_search_x_arch;