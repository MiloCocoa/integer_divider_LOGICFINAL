-- Author(s):     Nuttanon Pongpunlux 6538050421
--                Siraphop Wannasanmethar 6538213421
--                Supadet Udomgewganchana 6538205421
--
-- Date:          10 May 2025
--
-- Description:
--    Logic Design (2147307) Final Project
--    n-bit is_zero component
--    This module checks whether all bits of the input vector are 0 and outputs a flag accordingly.

-- Import IEEE standard logic libraries
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_misc.ALL;  -- Provides OR_REDUCE and other logic utilities

-- Entity declaration for is_zero
ENTITY is_zero IS
    GENERIC (
        N: INTEGER := 4  -- Size of the input vector (default: 4 bits)
    );
    PORT (
        D      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);  -- Input vector to be checked for zero
        Resetn : IN  STD_LOGIC;                       -- Active-low reset signal
        ISZERO : OUT STD_LOGIC                        -- Output flag: '1' if D is all zeros and not in reset
    );
END ENTITY is_zero;

-- Behavioral architecture
ARCHITECTURE Behavior OF is_zero IS
BEGIN
    -- OR_REDUCE(D) returns '1' if any bit in D is '1'; otherwise '0'
    -- NOT OR_REDUCE(D) is '1' only if all bits in D are '0'
    -- Combine with Resetn: output is '1' only if input is all zero and Resetn is active ('1')
    ISZERO <= (NOT OR_REDUCE(D)) AND Resetn;
END ARCHITECTURE Behavior;
