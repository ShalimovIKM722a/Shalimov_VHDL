--------------------------------------------------------
--  Lab Work #4: SR R-T testbench
--------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity sr_rt_tb is
	generic (
		fault_value : STD_LOGIC := '0'; -- type of error: stuck-at-0 or stuck-at-1
		fault_position : natural := 3   -- 0 = no errors, 1-4 = error in subsequent position
	);
end sr_rt_tb;

architecture sr_rt_tb_arc of sr_rt_tb is
	-- components of testbench
	component sr_r
		port(
			CLK : in STD_LOGIC;
			RST : in STD_LOGIC;
			IDV : in STD_LOGIC;
			SDI : in STD_LOGIC;
			PDO : out STD_LOGIC_VECTOR(3 downto 0);
			RDY : out STD_LOGIC 
		);
	end component;
	component sr_t
		port(
			CLK : in STD_LOGIC;
			RST : in STD_LOGIC;
			IDV : in STD_LOGIC;
			PDI : in STD_LOGIC_VECTOR(3 downto 0);
			SDO : out STD_LOGIC;
			ODV : out STD_LOGIC 
		);
	end component;
	component kxx_rom
		port (
			CLK : in STD_LOGIC;
			RST : in STD_LOGIC;
			OE  : in STD_LOGIC;
			R : in  STD_LOGIC;
			X : in  STD_LOGIC_VECTOR(3 downto 0);
			Y : out STD_LOGIC_VECTOR(3 downto 0);
			OV : out STD_LOGIC
		);
	end component;
	-- general signals
	signal CLK : STD_LOGIC;
	signal RST : STD_LOGIC;
	-- input stimulation signals
	signal R_test : STD_LOGIC; 
	signal X_test : STD_LOGIC_VECTOR(3 downto 0);
	signal nR_test : STD_LOGIC;
	signal OE_test : STD_LOGIC;
	-- internal signals
	signal pdt_test : STD_LOGIC_VECTOR(3 downto 0);
	signal sdt_test : STD_LOGIC;
	signal sdt_v_test : STD_LOGIC;
	signal pdr_test : STD_LOGIC_VECTOR(3 downto 0);
	signal pdr_test_modified : STD_LOGIC_VECTOR(3 downto 0);
	signal pdr_v_test : STD_LOGIC; 
	signal ov_t_test : STD_LOGIC; 
	-- observed signals
	signal Y_test : STD_LOGIC_VECTOR(3 downto 0);
	signal OV_test : STD_LOGIC;
	-- timing and clock parameters
	constant clk_period : time := 10 ns; 
	-- file declarations:
	-- file with stimulus (should exist before simulation is being started)
	file file_VECTORS : text; 
	-- file for simulation results (will be created or overwritten if exists)
	file file_RESULTS : text; 
	
begin -- architecture

	-- transmitter part
	kxx_for_transmit : kxx_rom
		port map (
			CLK => CLK,
			RST => RST,
			OE => OE_test,
			R => R_test,
			X => X_test,
			Y => pdt_test,
			OV => ov_t_test
		);
	transmitter_item : sr_t
		port map (
			CLK => CLK,
			RST => RST,
			IDV => ov_t_test,
			PDI => pdt_test,
			SDO => sdt_test,
			ODV => sdt_v_test
		);
	 -- receiver part
	 kxx_for_receive: kxx_rom
	 	port map (
			CLK => CLK,
			RST => RST,
			OE => pdr_v_test,
			R => nR_test,
			X => pdr_test_modified,
			Y => Y_test, 
			OV => OV_test
		);
	receiver_item : sr_r
		port map (
			CLK => CLK,
			RST => RST,
			IDV => sdt_v_test,
			SDI => sdt_test,
			PDO => pdr_test,
			RDY => pdr_v_test
		);
	
	-- clock signal generator
	clk_gen: process
	begin
		CLK <= '0';
		wait for clk_period/2;
		CLK <= '1';
		wait for clk_period/2;
	end process; 
	
	-- concurrent assignments
	nR_test <= not R_test; 
	
	-- injecting fault (if needed)
	pdr_test_modified <= 
		fault_value & pdr_test(2 downto 0) when fault_position = 4 else
		pdr_test(3) & fault_value & pdr_test(1 downto 0) when fault_position = 3 else
		pdr_test(3 downto 2) & fault_value & pdr_test(0) when fault_position = 2 else
		pdr_test(3 downto 1) & fault_value when fault_position = 1 else
		pdr_test;
		
	-- main stimulation process
	stim_apply: process
		variable ILINE_v : line;
		variable OLINE_v : line;
		variable SPACE_v : character;
		variable X_v     : std_logic_vector(3 downto 0);
		variable R_v     : std_logic;
	begin 
		-- opening files and preparing to write results
		file_open(file_VECTORS, "tst_vectors.txt",  read_mode);
		file_open(file_RESULTS, "sim_results.txt", write_mode);
		write(OLINE_v, "# LW#4 testbench results file", right);
		writeline(file_RESULTS, OLINE_v);
		write(OLINE_v, "# variant: 16, student: Shalimov Oleksandr, IKM-722a", right);
		writeline(file_RESULTS, OLINE_v); 
		write(OLINE_v, "# Legend:", right);
		writeline(file_RESULTS, OLINE_v);	
		write(OLINE_v, "# sim_time R X_t  Y_t  Result", right);
		writeline(file_RESULTS, OLINE_v);
		write(OLINE_v, "#-----------------------------", right);
		writeline(file_RESULTS, OLINE_v);
		
		-- initial reset
		RST <= '1';
		R_test <= '0';
		X_test <= (others => '0');
		OE_test <= '0';
		wait for clk_period;
		RST <= '0';
		wait for clk_period*10;
		
		-- applying stimulus
		stim_loop: while not endfile(file_VECTORS) loop
			readline(file_VECTORS, ILINE_v);      -- read line from file
			next stim_loop when ILINE_v(1) = '#'; -- current line is comment - skip it
			read(ILINE_v, R_v);                   -- read stim value for R_test
			read(ILINE_v, SPACE_v);               -- read in the space character
			read(ILINE_v, X_v);                   -- read stim value for X_test

			-- pass values of variables to signals
			R_test <= R_v;
			X_test <= X_v;
			OE_test <= '1';
			wait for clk_period;
			OE_test <= '0';
			
			-- wait until transmittion ends
			-- wait until Y_test'active; -- not good variant
			wait until OV_test = '1'; -- this is much better
	
			write(OLINE_v, now, right, 10, ns); -- log current simulation time
			write(OLINE_v, R_test, right, 2);   -- log R_test value (input)
			write(OLINE_v, X_test, right, 5);   -- log X_test value (input)
			write(OLINE_v, Y_test, right, 5);   -- log Y_test value (output)
			if Y_test = X_test then
				write(OLINE_v, " OK", left); -- log "OK" if this transmission completed successfully
			else
				write(OLINE_v, " ERROR", left); -- log "ERROR" if this transmission failed
			end if;
			writeline(file_RESULTS, OLINE_v); -- write log string to file
			wait for clk_period/2;
		end loop;
	
		-- finalizing simulation
		file_close(file_VECTORS);
		file_close(file_RESULTS);
		wait;
	end process;

end sr_rt_tb_arc;
