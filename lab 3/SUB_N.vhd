---------------------------------------
-- Lab Work #3: generic module SUB
---------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SUB_N is
    generic (
        N : integer := 4 -- default operand and result bus width
    );
    port (
        A   : in  std_logic_vector(N-1 downto 0);
        B   : in  std_logic_vector(N-1 downto 0);
        SUB : out std_logic_vector(N-1 downto 0);
        BOR : out std_logic
    );
end entity;

architecture SUB_N_beh of SUB_N is

    signal sub_buf : signed(N downto 0);

begin

    sub_buf <= signed(A(A'high) & A) - signed(B(B'high) & B);
    SUB     <= std_logic_vector(sub_buf(N-1 downto 0));
    BOR     <= sub_buf(N);

end architecture;