-- Author(s):     Nuttanon Pongpunlux 6538050421
--                Siraphop Wannasanmethar 6538213421
--                Supadet Udomgewganchana 6538205421
--
-- Date:          10 May 2025
--
-- Description:
--    Logic Design (2147307) Final Project
--    n-bit 2-to-1 multiplexer component
--    Selects between two input vectors based on a control signal (SEL).

-- Include IEEE standard logic library for digital signal types
LIBRARY IEEE;                          -- Import IEEE library
USE IEEE.STD_LOGIC_1164.ALL;           -- Use standard logic types like STD_LOGIC and STD_LOGIC_VECTOR

-- Entity declaration for n-bit multiplexer
ENTITY mux IS
    GENERIC (
        N: INTEGER := 4                -- Generic parameter for vector width (default 4 bits)
    );
    PORT (
        SEL : IN  STD_LOGIC;                      -- Selector input (1-bit) to choose between D0 and D1
        D0  : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- First input vector (N-bit)
        D1  : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Second input vector (N-bit)
        X   : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)  -- Output vector (N-bit), result of selection
    );
END ENTITY mux;

-- Architecture defining the behavior of the mux
ARCHITECTURE Behavior OF mux IS       -- Begin behavioral architecture
BEGIN
    -- Concurrent signal assignment:
    -- If SEL = '1', assign D1 to output X
    -- If SEL = '0', assign D0 to output X
    X <= D1 WHEN (SEL = '1') ELSE D0; -- Ternary conditional logic for mux behavior
END ARCHITECTURE Behavior;            -- End of architecture
