library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

	architecture adv_search_x_arch of adv_search_x is
	    signal Y_buf   : STD_LOGIC_VECTOR (3 downto 0);
	    signal X_buf   : STD_LOGIC_VECTOR (3 downto 0);
	    signal R_buf   : STD_LOGIC;
	    signal Y_used  : STD_LOGIC_VECTOR (3 downto 0);
	begin

    Kxx_unit: entity work.kxx_rom
    port map (
        R => R_buf,
        F => '1',
        X => X_buf,
        Y => Y_buf
    );					 
	
	process(Y_buf, R_buf, X_buf)
        variable idx : integer;
        variable y   : STD_LOGIC_VECTOR(3 downto 0);
    begin
        idx := to_integer(unsigned(R_buf & X_buf));
        y := Y_buf;
								   
        if idx = 3 then         -- R=0 зона
            y := "1111";
        elsif idx = 20 then     -- R=1 зона
            y := "0000";
        end if;

        Y_used <= y;
    end process;

    FSM_unit: entity work.fsm_adv_search_x
    port map (
        CLK => CLK,
        RST => RST,
        Y_F => Y_FIND,
        STR => START,
        Y_S => Y_used,
        X_S => X_buf,
        R_S => R_buf,
        XR0 => X_R0_F,
        XR1 => X_R1_F,
        FIN => FINISH,
        ERR => ERROR
    );

end architecture;