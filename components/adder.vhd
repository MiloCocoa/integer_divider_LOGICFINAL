-- Author(s):     Nuttanon Pongpunlux 6538050421
--                Siraphop Wannasanmethar 6538213421
--                Supadet Udomgewganchana 6538205421
--
-- Date:          10 May 2025
--
-- Description
--    Logic Design (2147307) Final Project
--    n-bit ripple carry adder component

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Entity Declaration for a Generic n-bit Ripple Carry Adder
ENTITY adder IS
    GENERIC (N: INTEGER := 4); -- Data width (number of bits)
    PORT (
        Cin    : IN  STD_LOGIC;                          -- Initial carry-in
        A      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);     -- First operand
        B      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);     -- Second operand
        Result : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);     -- Sum output
        Cout   : OUT STD_LOGIC                           -- Final carry-out
    );
END ENTITY adder;

ARCHITECTURE Behavior OF adder IS

    -- Declaration of the full adder component to be used in the ripple structure
    COMPONENT full_adder
        PORT (
            Cin  : IN  STD_LOGIC; -- Carry-in
            x    : IN  STD_LOGIC; -- First input bit
            y    : IN  STD_LOGIC; -- Second input bit
            s    : OUT STD_LOGIC; -- Sum output
            Cout : OUT STD_LOGIC  -- Carry-out
        );
    END COMPONENT full_adder;

    -- Internal signal to hold carry values between stages
    SIGNAL carry: STD_LOGIC_VECTOR(N DOWNTO 0);

BEGIN

    -- Set initial carry to input Cin
    carry(0) <= Cin;

    -- Generate block for connecting N full adders in a ripple carry structure
    FA_array: FOR i IN 0 TO N-1 GENERATE
        FA: full_adder 
            PORT MAP (
                Cin  => carry(i),     -- Carry-in from previous stage
                x    => A(i),         -- A operand bit i
                y    => B(i),         -- B operand bit i
                s    => Result(i),    -- Sum output bit i
                Cout => carry(i+1)    -- Carry-out to next stage
            );
    END GENERATE FA_array;

    -- Assign final carry-out
    Cout <= carry(N);

END ARCHITECTURE Behavior;
