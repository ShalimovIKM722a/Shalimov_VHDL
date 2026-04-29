--------------------------------------------------------
-- Lab Work #3: structural description of module ALU
--------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU_STRUCT is
    generic (
        N : integer := 4
    );
    port (
        DT_0  : in  std_logic_vector(N-1 downto 0);
        DT_1  : in  std_logic_vector(N-1 downto 0);
        OPSEL : in  std_logic_vector(1 downto 0);
        RES   : out std_logic_vector(2*N-1 downto 0);
        CF    : out std_logic;
        AG    : out std_logic;
        AE    : out std_logic;
        AL    : out std_logic
    );
end entity;

architecture ALU_STRUCT_arch of ALU_STRUCT is

    component SUM_N
        generic (
            N : integer
        );
        port (
            A   : in  std_logic_vector(N-1 downto 0);
            B   : in  std_logic_vector(N-1 downto 0);
            SUM : out std_logic_vector(N-1 downto 0);
            CAR : out std_logic
        );
    end component;

    component SUB_N
        generic (
            N : integer
        );
        port (
            A   : in  std_logic_vector(N-1 downto 0);
            B   : in  std_logic_vector(N-1 downto 0);
            SUB : out std_logic_vector(N-1 downto 0);
            BOR : out std_logic
        );
    end component;

    component MUL_N
        generic (
            N : integer
        );
        port (
            A   : in  std_logic_vector(N-1 downto 0);
            B   : in  std_logic_vector(N-1 downto 0);
            MUL : out std_logic_vector(2*N-1 downto 0)
        );
    end component;

    component XOR_N
        generic (
            N : integer
        );
        port (
            A   : in  std_logic_vector(N-1 downto 0);
            B   : in  std_logic_vector(N-1 downto 0);
            XRD : out std_logic_vector(N-1 downto 0)
        );
    end component;

    component CMP_N
        generic (
            N : integer
        );
        port (
            A   : in  std_logic_vector(N-1 downto 0);
            B   : in  std_logic_vector(N-1 downto 0);
            ALB : out std_logic;
            AEB : out std_logic;
            AGB : out std_logic
        );
    end component;

    component MUX_N
        generic (
            N : integer
        );
        port (
            IN0 : in  std_logic_vector(N-1 downto 0);
            IN1 : in  std_logic_vector(N-1 downto 0);
            IN2 : in  std_logic_vector(N-1 downto 0);
            IN3 : in  std_logic_vector(N-1 downto 0);
            SEL : in  std_logic_vector(1 downto 0);
            MXO : out std_logic_vector(N-1 downto 0)
        );
    end component;

    signal sum_s, sub_s, xrd_s : std_logic_vector(N-1 downto 0);
    signal car_s, bor_s        : std_logic;
    signal mul_s               : std_logic_vector(2*N-1 downto 0);
    signal mul_low_s, mul_high_s : std_logic_vector(N-1 downto 0);
    
    constant ALL_ZEROS_N : std_logic_vector(N-1 downto 0) := (others => '0');

begin

    sum_inst: SUM_N
        generic map (
            N => N
        )
        port map (
            A   => DT_0,
            B   => DT_1,
            SUM => sum_s,
            CAR => car_s
        );

    sub_inst: SUB_N
        generic map (
            N => N
        )
        port map (
            A   => DT_0,
            B   => DT_1,
            SUB => sub_s,
            BOR => bor_s
        );

    xor_inst: XOR_N
        generic map (
            N => N
        )
        port map (
            A   => DT_0,
            B   => DT_1,
            XRD => xrd_s
        );

    mul_inst: MUL_N
        generic map (
            N => N
        )
        port map (
            A   => DT_0,
            B   => DT_1,
            MUL => mul_s
        );

    mul_low_s  <= mul_s(N-1 downto 0);
    mul_high_s <= mul_s(2*N-1 downto N);

    cmp_inst: CMP_N
        generic map (
            N => N
        )
        port map (
            A   => DT_0,
            B   => DT_1,
            ALB => AL,
            AEB => AE,
            AGB => AG
        );

    mux_1: MUX_N
        generic map (
            N => N
        )
        port map (
            IN0 => sum_s,
            IN1 => sub_s,
            IN2 => xrd_s,
            IN3 => mul_low_s,
            SEL => OPSEL,
            MXO => RES(N-1 downto 0)
        );

    mux_3: MUX_N
        generic map (
            N => N
        )
        port map (
            IN0 => ALL_ZEROS_N,
            IN1 => ALL_ZEROS_N,
            IN2 => ALL_ZEROS_N,
            IN3 => mul_high_s,
            SEL => OPSEL,
            MXO => RES(2*N-1 downto N)
        );

    mux_2: MUX_N
        generic map (
            N => 1
        )
        port map (
            IN0(0) => car_s, -- formal name should be
            IN1(0) => bor_s, -- followed by (0) to match
            IN2(0) => '0',   -- type of connected signal
            IN3(0) => '0',
            SEL    => OPSEL,
            MXO(0) => CF
        );

end architecture;