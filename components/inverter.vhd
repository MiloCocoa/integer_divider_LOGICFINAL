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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for the inverter
ENTITY inverter IS
    GENERIC (
        N : INTEGER := 4  -- Size of input/output vector (default: 4 bits)
    );
    PORT (
        A : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);  -- Input vector to be inverted
        Y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)   -- Output vector (bitwise NOT of input)
    );
END ENTITY inverter;

-- Behavioral architecture for the inverter
ARCHITECTURE Behavior OF inverter IS
BEGIN
    -- Assign output Y as the bitwise NOT of input A
    -- This inverts each bit of the input vector individually
    Y <= NOT A;
END ARCHITECTURE Behavior;
