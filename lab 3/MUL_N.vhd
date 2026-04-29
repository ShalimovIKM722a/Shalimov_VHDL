---------------------------------------
-- Lab Work #3: generic module MUL
---------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MUL_N is
    generic (
        N : integer := 4 -- default operand bus width
    );
    port (
        A   : in  std_logic_vector(N-1 downto 0);
        B   : in  std_logic_vector(N-1 downto 0);
        MUL : out std_logic_vector(2*N-1 downto 0)
    );
end entity;

architecture MUL_N_beh of MUL_N is
begin

    MUL <= std_logic_vector(signed(A) * signed(B));

end architecture;