----------------------------------------------------
-- Lab Work #3: testbench for ALU module testing
----------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.math_real.all; -- for stimulus random generation

entity dpu_tb is
end entity;

architecture dpu_tb_arch of dpu_tb is

    -- Stimulus signals
    signal TEST_A   : STD_LOGIC_VECTOR(3 downto 0);
    signal TEST_B   : STD_LOGIC_VECTOR(3 downto 0);
    signal TEST_CMD : STD_LOGIC_VECTOR(3 downto 0);

    -- Observed signals
    signal RES_bh : STD_LOGIC_VECTOR(7 downto 0);
    signal FLC_bh, AGB_bh, AEB_bh, ALB_bh : STD_LOGIC;
    
    signal RES_st : STD_LOGIC_VECTOR(7 downto 0);
    signal FLC_st, AGB_st, AEB_st, ALB_st : STD_LOGIC;

    type TV_TYPE is array (0 to 15) of STD_LOGIC_VECTOR(3 downto 0);
    
    constant TEST_VECTORS : TV_TYPE := (
        "0000", "0001", "0010", "0011", 
        "0100", "0101", "0110", "0111", 
        "1000", "1001", "1010", "1011", 
        "1100", "1101", "1110", "1111"
    );

begin

    -- Units Under Test port map
    UUT1 : entity work.dpu_behav(dpu_behav_arch)
        port map (
            OP_A => TEST_A,
            OP_B => TEST_B,
            CMD  => TEST_CMD,
            RES  => RES_bh,
            FLC  => FLC_bh,
            AGB  => AGB_bh,
            AEB  => AEB_bh,
            ALB  => ALB_bh
        );

    UUT2 : entity work.dpu_struct(dpu_struct_arch)
        port map (
            OP_A => TEST_A,
            OP_B => TEST_B,
            CMD  => TEST_CMD,
            RES  => RES_st,
            FLC  => FLC_st,
            AGB  => AGB_st,
            AEB  => AEB_st,
            ALB  => ALB_st
        );

    -- stimulus expressions
    stim_gen: process
        variable seed1 : positive := 16; -- USE YOUR ACADEMIC GROUP ID NUMBER
        variable seed2 : positive := 42;
        variable rand  : real;
        variable idx_a, idx_b : integer;

        procedure apply_test(cmd_val : STD_LOGIC_VECTOR(3 downto 0)) is
        begin
            TEST_CMD <= cmd_val;
            wait for 10 ns;
        end procedure;

    begin
        ------------------------------------------------------------------
        -- 1. RANDOM TESTS: inputs A, B are direct
        ------------------------------------------------------------------
        for op in 0 to 3 loop -- 4 operations
            for i in 0 to 3 loop -- 4 test vectors
                uniform(seed1, seed2, rand);
                idx_a := integer(rand * 15.0);
                
                uniform(seed1, seed2, rand);
                idx_b := integer(rand * 15.0);
                
                TEST_A <= TEST_VECTORS(idx_a);
                TEST_B <= TEST_VECTORS(idx_b);

                case op is
                    when 0      => apply_test("0000"); -- ADD
                    when 1      => apply_test("0001"); -- SUB
                    when 2      => apply_test("0010"); -- XOR
                    when 3      => apply_test("0011"); -- MUL
                    when others => null;
                end case;
            end loop;
        end loop;

        ------------------------------------------------------------------
        -- 2. FULL TESTS: A is direct, B - through sbox
        ------------------------------------------------------------------
        for op in 0 to 3 loop
            for i in 0 to 15 loop
                TEST_A <= TEST_VECTORS(i);
                TEST_B <= TEST_VECTORS(i);

                case op is
                    when 0      => apply_test("0100"); -- ADD, inv B
                    when 1      => apply_test("0101"); -- SUB
                    when 2      => apply_test("0110"); -- XOR
                    when 3      => apply_test("0111"); -- MUL
                    when others => null;
                end case;
            end loop;
        end loop;

        ------------------------------------------------------------------
        -- 3. FULL TESTS: A and B - through sbox
        ------------------------------------------------------------------
        for op in 0 to 3 loop
            for i in 0 to 15 loop
                TEST_A <= TEST_VECTORS(i);
                TEST_B <= TEST_VECTORS(15-i);

                case op is
                    when 0      => apply_test("1100"); -- ADD
                    when 1      => apply_test("1101"); -- SUB
                    when 2      => apply_test("1110"); -- XOR
                    when 3      => apply_test("1111"); -- MUL
                    when others => null;
                end case;
            end loop;
        end loop;

        wait;
    end process;

end architecture;