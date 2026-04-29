architecture kxx_rom_arc of kxx_rom is

    signal inp_addr : STD_LOGIC_VECTOR(4 downto 0);

    type sbox_array is array (0 to 31) of STD_LOGIC_VECTOR(3 downto 0);

    constant kxx : sbox_array := (
        x"1", x"D", x"2", x"9", x"7", x"A", x"6", x"0",
        x"8", x"C", x"4", x"5", x"F", x"3", x"B", x"E",

        x"7", x"0", x"2", x"D", x"A", x"B", x"6", x"4",
        x"8", x"3", x"5", x"E", x"9", x"1", x"F", x"C"
    );

begin

    inp_addr <= R & X;

    process(inp_addr, F)
        variable idx : integer;
        variable val : STD_LOGIC_VECTOR(3 downto 0);
    begin

        idx := to_integer(unsigned(inp_addr));
        val := kxx(idx);

        if F /= '1' then					 

            if idx < 16 then
                val := not val;  
            else
                val := not val;  
            end if;

        end if;

        Y <= val;

    end process;

end architecture;