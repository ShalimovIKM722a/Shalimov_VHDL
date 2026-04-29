										 ---------------------------------------
-- Lab Work #3: generic module MUX
---------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity MUX_N is
    generic (
        N : integer := 4 -- default input and output bus width
    );
    port (
        IN0 : in  std_logic_vector(N-1 downto 0);
        IN1 : in  std_logic_vector(N-1 downto 0);
        IN2 : in  std_logic_vector(N-1 downto 0);
        IN3 : in  std_logic_vector(N-1 downto 0);
        SEL : in  std_logic_vector(1 downto 0);
        MXO : out std_logic_vector(N-1 downto 0)
    );
end MUX_N;

architecture MUX_N_beh of MUX_N is
begin

    MXO <= IN0 when SEL = "00" else
           IN1 when SEL = "01" else
           IN2 when SEL = "10" else
           IN3 when SEL = "11" else
           (others => '0');

end architecture;