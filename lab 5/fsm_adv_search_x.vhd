-------------------------------------------------------------------
-- Lab Work #5: FSM to search X for given Y in Kxx S-box (advanced) 
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fsm_adv_search_x is 
	port (
		CLK : in STD_LOGIC;						 -- global clocking signal
		RST : in STD_LOGIC;						 -- syncronous reset (active high)
		Y_F : in STD_LOGIC_VECTOR(3 downto 0);	 -- Y to be found in Kxx (user defined)
		STR : in STD_LOGIC;						 -- start search strobe
		Y_S : in STD_LOGIC_VECTOR(3 downto 0);	 -- Kxx output Y for current (X, R) values
		R_S	: out STD_LOGIC;					 -- current value R to Kxx
		X_S : out STD_LOGIC_VECTOR(3 downto 0);  -- current value X to Kxx
		XR0 : out STD_LOGIC_VECTOR(3 downto 0);  -- X for desired Y when R=0
		XR1 : out STD_LOGIC_VECTOR(3 downto 0);  -- X for desired Y when R=1   
		FIN : out STD_LOGIC;					 -- search finish strobe
		ERR : out STD_LOGIC						 -- search error (Y was not found)
	);
end entity;

architecture fsm_adv_search_x_arch of fsm_adv_search_x is
	-- FSM state signal
	type state_type is (idle, SPh1, SPh2);
	signal state : state_type;
 	-- buffer to latch Y_F (Y preset)
	signal Y_buf : STD_LOGIC_VECTOR(3 downto 0) := (others =>'0');
	-- registers for output signals
	signal R_reg : STD_LOGIC := '0';
	signal X_reg : UNSIGNED(3 downto 0) := (others =>'0');	
	signal XR0_reg : UNSIGNED(3 downto 0) := (others =>'0');
	signal XR1_reg : UNSIGNED(3 downto 0) := (others =>'0');
	
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
			R_reg <= '0';
			X_reg <= (others =>'0');
			XR0_reg	<= (others =>'0');
			XR1_reg	<= (others =>'0');
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
						state <= SPh1; -- go to state SPh1 (search)
						Y_buf <= Y_F;    -- lock Y to find
						X_reg <= (others =>'0'); -- reset X
						R_reg <= '0'; -- reset R
						XR0_reg <= (others =>'0'); -- reset search results
						XR1_reg <= (others =>'0');
					end if;
				when SPh1 =>
					if Y_S /= Y_buf then
						if X_reg = "1111" then -- last X and Y wasn't found (does not exist?)
							state <= idle;
							ERR <= '1';
						else
							X_reg <= X_reg + 1;	 -- continue search
						end if;
					else
						state <= SPh2; -- X for R=0 found - goto search for R=1
						XR0_reg <= X_reg;
						R_reg <= '1';
						X_reg <= (others =>'0');
					end if;
				when SPh2 =>
					if Y_S /= Y_buf then
						if X_reg = "1111" then -- last X and Y wasn't found (does not exist?)
							state <= idle;
							ERR <= '1';
						else
							X_reg <= X_reg + 1;	 -- continue search
						end if;
					else
						state <= idle; -- X for R=1 found - finish with success
						XR1_reg <= X_reg;
						FIN <= '1';
					end if;
				when others => -- case clause must have "others" option
					null;
			end case;
		end if;
	end process;
	
	X_S <= std_logic_vector(X_reg);
	R_S <= R_reg;
	XR0 <= std_logic_vector(XR0_reg);
	XR1 <= std_logic_vector(XR1_reg);
	
end architecture;