-- Author(s):     Nuttanon Pongpunlux 6538050421
--                Siraphop Wannasanmethar 6538213421
--                Supadet Udomgewganchana 6538205421
--
-- Date:          10 May 2025
--
-- Description:
--    Logic Design (2147307) Final Project
--    Full Adder component implemented with multiple architectures:
--    1. Logic equations
--    2. Half adder-based
--    3. Multiplexer-based
--    4. Numeric-based (for synthesis readability)

-- Include necessary IEEE libraries for logic and timing
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;        -- Basic logic types
USE IEEE.std_logic_misc.ALL;        -- Misc logic functions (not used here directly)
USE IEEE.vital_timing.ALL;          -- Timing modeling

-- Entity declaration for full adder
ENTITY full_adder IS
    GENERIC (
        -- Delay parameters for simulating propagation delay
        tpd_x_s       : TIME := 1 ns;  -- x to sum delay
        tpd_y_s       : TIME := 1 ns;  -- y to sum delay
        tpd_cin_s     : TIME := 1 ns;  -- Cin to sum delay
        tpd_x_cout    : TIME := 1 ns;  -- x to Cout delay
        tpd_y_cout    : TIME := 1 ns;  -- y to Cout delay
        tpd_cin_cout  : TIME := 1 ns   -- Cin to Cout delay
    );
    PORT (
        Cin   : IN  STD_LOGIC;  -- Carry input
        x     : IN  STD_LOGIC;  -- First operand
        y     : IN  STD_LOGIC;  -- Second operand
        s     : OUT STD_LOGIC;  -- Sum output
        Cout  : OUT STD_LOGIC   -- Carry output
    );

    -- Full adder behavior:
    -- Adds x, y, and Cin to produce a binary sum (s) and carry-out (Cout)
    -- Example:
    --   x y Cin | s Cout
    --   0 0 0   | 0  0
    --   0 0 1   | 1  0
    --   0 1 0   | 1  0
    --   0 1 1   | 0  1
    --   1 0 0   | 1  0
    --   1 0 1   | 0  1
    --   1 1 0   | 0  1
    --   1 1 1   | 1  1
END ENTITY full_adder;

ARCHITECTURE LogicFunc OF full_adder IS
BEGIN
    -- Sum remains as XOR of all inputs
    s <= x XOR y XOR Cin AFTER tpd_x_s;

    -- Carry-out: use MUX logic; if x = y, output x, else Cin
    Cout <= x WHEN (x = y) ELSE Cin AFTER tpd_x_cout;
END ARCHITECTURE LogicFunc;

