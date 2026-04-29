										   -----------------------------------------------------------
-- Lab Work #3: module DPU_STRUCT (Top-Level Module #2)
-----------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity DPU_STRUCT is
    port (
        OP_A : in  std_logic_vector(3 downto 0);
        OP_B : in  std_logic_vector(3 downto 0);
        CMD  : in  std_logic_vector(3 downto 0);
        RES  : out std_logic_vector(7 downto 0);
        FLC  : out std_logic;
        AGB  : out std_logic;
        AEB  : out std_logic;
        ALB  : out std_logic
    );
end entity;

architecture DPU_STRUCT_arch of DPU_STRUCT is

    component ALU_STRUCT
        generic (
            N : natural
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
    end component;

    component INPSEL
        port (
            OP_A : in  std_logic_vector(3 downto 0);
            OP_B : in  std_logic_vector(3 downto 0);
            CMD  : in  std_logic_vector(1 downto 0);
            OP1  : out std_logic_vector(3 downto 0);
            OP2  : out std_logic_vector(3 downto 0)
        );
    end component;

    signal OP1_s : std_logic_vector(3 downto 0);
    signal OP2_s : std_logic_vector(3 downto 0);

begin

    INPPSEL_inst: INPSEL
        port map (
            OP_A => OP_A,
            OP_B => OP_B,
            CMD  => CMD(3 downto 2),
            OP1  => OP1_s,
            OP2  => OP2_s
        );

    ALU_inst: ALU_STRUCT
        generic map (
            N => 4
        )
        port map (
            DT_0  => OP1_s,
            DT_1  => OP2_s,
            OPSEL => CMD(1 downto 0),
            RES   => RES,
            CF    => FLC,
            AG    => AGB,
            AE    => AEB,
            AL    => ALB
        );

end architecture;