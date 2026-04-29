---------------------------------------
-- Lab Work #3: generic module CMP
---------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CMP_N is
    generic (
        N : integer := 4 -- default operand bus width
    );
    port (
        A   : in  std_logic_vector(N-1 downto 0);
        B   : in  std_logic_vector(N-1 downto 0);
        ALB : out std_logic;
        AEB : out std_logic;
        AGB : out std_logic
    );
end entity;

architecture CMP_N_beh of CMP_N is
begin

    ALB <= '1' when signed(A) < signed(B) else '0';
    AEB <= '1' when signed(A) = signed(B) else '0';
    AGB <= '1' when signed(A) > signed(B) else '0';

end architecture;