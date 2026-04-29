---------------------------------------------------------
-- Lab Work #3: module ALU_BEHAV (SUM,SUB,XOR,MUL,CMP)
---------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU_BEHAV is
    generic (
        N : natural := 4
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

architecture ALU_BEHAV_arch of ALU_BEHAV is

    signal sum, sub : signed(N-1 downto 0);        -- intermediate sum/sub results
    signal sum_buf, sub_buf : signed(N downto 0);  -- result buffers (with carry/borrow)
    signal mul : signed(2*N-1 downto 0);           -- intermediate multiplication result
    signal car, bor : std_logic;
    signal xrd : std_logic_vector(2*N-1 downto 0); -- intermediate xor result
    
    constant ADD_COM : std_logic_vector(1 downto 0) := "00"; -- add opcode
    constant SUB_COM : std_logic_vector(1 downto 0) := "01"; -- sub opcode
    constant XOR_COM : std_logic_vector(1 downto 0) := "10"; -- xor opcode
    constant MUL_COM : std_logic_vector(1 downto 0) := "11"; -- mul opcode

begin

    -- summation circuit:
    sum_buf <= signed(DT_0(DT_0'high) & DT_0) + signed(DT_1(DT_1'high) & DT_1);
    sum     <= sum_buf(N-1 downto 0);
    car     <= sum_buf(N);
    
    -- substraction circuit:
    sub_buf <= signed(DT_0(DT_0'high) & DT_0) - signed(DT_1(DT_1'high) & DT_1);
    sub     <= sub_buf(N-1 downto 0);
    bor     <= sub_buf(N);
    
    -- xor circuit:
    xrd(N-1 downto 0)   <= DT_0 xor DT_1;
    xrd(2*N-1 downto N) <= (others => '0');
    
    -- multiplication circuit:
    mul <= signed(DT_0) * signed(DT_1);
    
    -- result assignments (MUX1 and MUX3):
    RES <= std_logic_vector(resize(sum, 2*N)) when OPSEL = ADD_COM else
           std_logic_vector(resize(sub, 2*N)) when OPSEL = SUB_COM else
           xrd                                when OPSEL = XOR_COM else
           std_logic_vector(mul)              when OPSEL = MUL_COM else
           (others => '0'); -- for unknown opcodes
           
    -- carry/borrow assignments (MUX2):
    CF <= car when OPSEL = ADD_COM else
          bor when OPSEL = SUB_COM else
          '0'; -- for mul and xor opcode and unknown opcodes
          
    -- comparator circuit:
    CMP: process(DT_0, DT_1)
    begin
        AG <= '0';
        AE <= '0';
        AL <= '0';
        
        if signed(DT_0) > signed(DT_1) then
            AG <= '1';
        elsif signed(DT_0) < signed(DT_1) then
            AL <= '1';
        else
            AE <= '1';
        end if;
    end process;

end architecture;