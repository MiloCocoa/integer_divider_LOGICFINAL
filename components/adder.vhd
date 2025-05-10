-- Author(s):     Nuttanon Pongpunlux 6538050421
--                Siraphop Wannasanmethar 6538213421
--                Supadet Udomgewganchana 6538205421
--
-- Date:          10 May 2025
--
-- Description
--    Logic Design (2147307) Final Project
--    n-bit ripple carry adder component

LIBRARY IEEE;                         -- Import the IEEE library
USE IEEE.STD_LOGIC_1164.ALL;          -- Use standard logic types (e.g., std_logic, std_logic_vector)

-- Entity Declaration for a Generic n-bit Ripple Carry Adder
ENTITY adder IS
    GENERIC (N: INTEGER := 4);        -- Define a generic parameter N for the bit-width, default is 4 bits
    PORT (
        Cin    : IN  STD_LOGIC;                          -- Initial carry-in input
        A      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);     -- First input operand of N bits
        B      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);     -- Second input operand of N bits
        Result : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);     -- Output sum of N bits
        Cout   : OUT STD_LOGIC                           -- Final carry-out bit
    );
END ENTITY adder;

ARCHITECTURE Behavior OF adder IS     -- Define the architecture named "Behavior" for the adder entity

    -- Declaration of the full adder component to be used in the ripple structure
    COMPONENT full_adder
        PORT (
            Cin  : IN  STD_LOGIC; -- Carry-in input for a single bit
            x    : IN  STD_LOGIC; -- First operand bit
            y    : IN  STD_LOGIC; -- Second operand bit
            s    : OUT STD_LOGIC; -- Sum output for a single bit
            Cout : OUT STD_LOGIC  -- Carry-out to next bit
        );
    END COMPONENT full_adder;

    -- Internal signal to hold carry values between stages
    SIGNAL carry: STD_LOGIC_VECTOR(N DOWNTO 0); -- Vector of N+1 bits to store carry at each stage

BEGIN

    -- Set initial carry to input Cin
    carry(0) <= Cin; -- Initialize the first carry value using the external carry-in input

    -- Generate block for connecting N full adders in a ripple carry structure
    FA_array: FOR i IN 0 TO N-1 GENERATE -- Generate N instances of full_adder
        FA: full_adder 
            PORT MAP (
                Cin  => carry(i),     -- Connect carry-in from previous stage
                x    => A(i),         -- Connect A operand bit at index i
                y    => B(i),         -- Connect B operand bit at index i
                s    => Result(i),    -- Output sum bit at index i
                Cout => carry(i+1)    -- Carry-out to the next stage
            );
    END GENERATE FA_array;

    -- Assign final carry-out
    Cout <= carry(N); -- Assign the last carry-out as the final output carry

END ARCHITECTURE Behavior;
