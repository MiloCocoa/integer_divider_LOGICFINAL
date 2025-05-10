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

-- Include IEEE standard logic library
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for n-bit multiplexer
ENTITY mux IS
    GENERIC (
        N: INTEGER := 4  -- Defines width of input and output vectors (default: 4 bits)
    );
    PORT (
        SEL : IN  STD_LOGIC;                      -- Selector input (1-bit)
        D0  : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Input vector 0
        D1  : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Input vector 1
        X   : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)  -- Output vector
    );
END ENTITY mux;

-- Architecture defining the behavior of the mux
ARCHITECTURE Behavior OF mux IS
BEGIN
    -- When SEL is '1', output X gets value of D1
    -- When SEL is '0', output X gets value of D0
    X <= D1 WHEN (SEL = '1') ELSE D0;
END ARCHITECTURE Behavior;
