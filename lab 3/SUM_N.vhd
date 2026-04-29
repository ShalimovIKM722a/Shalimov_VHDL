---------------------------------------
-- Lab Work #3: generic module SUM
---------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SUM_N is
    generic (
        N : integer := 4 -- default operand and result bus width
    );
    port (
        A   : in  std_logic_vector(N-1 downto 0);
        B   : in  std_logic_vector(N-1 downto 0);
        SUM : out std_logic_vector(N-1 downto 0);
        CAR : out std_logic
    );
end entity;

architecture SUM_N_beh of SUM_N is

    signal sum_buf : signed(N downto 0);

begin

    sum_buf <= signed(A(A'high) & A) + signed(B(B'high) & B);
    SUM     <= std_logic_vector(sum_buf(N-1 downto 0));
    CAR     <= sum_buf(N);

end architecture;