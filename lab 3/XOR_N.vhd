---------------------------------------
-- Lab Work #3: generic module XOR
---------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity XOR_N is
    generic (
        N : integer := 4 -- default operand bus width
    );
    port (
        A   : in  std_logic_vector(N-1 downto 0);
        B   : in  std_logic_vector(N-1 downto 0);
        XRD : out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture XOR_N_beh of XOR_N is
begin

    XRD <= A xor B;

end architecture;