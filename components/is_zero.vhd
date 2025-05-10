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
LIBRARY IEEE;                            -- Include the IEEE library for standard logic types
USE IEEE.STD_LOGIC_1164.ALL;             -- Use standard logic types like std_logic and std_logic_vector
USE IEEE.std_logic_misc.ALL;             -- Import miscellaneous logic utilities such as OR_REDUCE

-- Entity declaration for is_zero
ENTITY is_zero IS
    GENERIC (
        N: INTEGER := 4                  -- Define generic parameter N for bit-width of input vector (default is 4)
    );
    PORT (
        D      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);  -- Input vector to be checked for all zeros
        Resetn : IN  STD_LOGIC;                       -- Active-low reset input (when '0', output is forced inactive)
        ISZERO : OUT STD_LOGIC                        -- Output flag: '1' if D is all zeros and Resetn is high
    );
END ENTITY is_zero;

-- Behavioral architecture
ARCHITECTURE Behavior OF is_zero IS      -- Begin behavioral architecture definition
BEGIN
    -- OR_REDUCE(D) = '1' if any bit of D is '1', else '0'
    -- NOT OR_REDUCE(D) = '1' only when all bits in D are '0'
    -- The output ISZERO is set to '1' only if all bits are zero AND Resetn is active ('1')
    ISZERO <= (NOT OR_REDUCE(D)) AND Resetn;  -- Perform logic and assign to ISZERO
END ARCHITECTURE Behavior;              -- End of architecture
