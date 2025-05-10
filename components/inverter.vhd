-- Author(s):     Nuttanon Pongpunlux 6538050421
--                Siraphop Wannasanmethar 6538213421
--                Supadet Udomgewganchana 6538205421
--
-- Date:          10 May 2025
--
-- Description:
--    Logic Design (2147307) Final Project
--    n-bit inverter component
--    This module takes an N-bit input vector and produces its bitwise inverse as output.

-- Import IEEE standard logic library
LIBRARY IEEE;                        -- Include the IEEE library which contains standard logic definitions
USE IEEE.STD_LOGIC_1164.ALL;         -- Use the standard logic package for std_logic and std_logic_vector types

-- Entity declaration for the inverter
ENTITY inverter IS
    GENERIC (
        N : INTEGER := 4             -- Define a generic parameter N for the bit-width (default is 4)
    );
    PORT (
        A : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);  -- Input vector of N bits to be inverted
        Y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)   -- Output vector representing bitwise NOT of input A
    );
END ENTITY inverter;

-- Behavioral architecture for the inverter
ARCHITECTURE Behavior OF inverter IS  -- Begin the behavioral description of the inverter
BEGIN
    -- Assign output Y as the bitwise NOT of input A
    -- This inverts each bit of the input vector individually
    Y <= NOT A;                        -- Apply the NOT operation to each bit in vector A and assign result to Y
END ARCHITECTURE Behavior;            -- End of behavioral architecture
