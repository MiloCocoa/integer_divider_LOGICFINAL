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

--===========================================================
-- Architecture 1: LogicFunc — basic logic equation method
--===========================================================
ARCHITECTURE LogicFunc OF full_adder IS
BEGIN
    -- Compute sum using XOR of all three inputs
    s    <= x XOR y XOR Cin AFTER tpd_x_s;

    -- Compute carry-out using standard carry logic (majority function)
    Cout <= (x AND y) OR (Cin AND x) OR (Cin AND y) AFTER tpd_x_cout;
END ARCHITECTURE LogicFunc;

--===========================================================
-- Architecture 2: HalfAdders — build full adder from 2 half adders
--===========================================================
ARCHITECTURE HalfAdders OF full_adder IS
    SIGNAL sum1, carry1, carry2 : STD_LOGIC;  -- Intermediate results
BEGIN
    -- First half adder: x and y
    sum1   <= x XOR y AFTER tpd_x_s;
    carry1 <= x AND y AFTER tpd_x_cout;

    -- Second half adder: sum1 and Cin
    s      <= sum1 XOR Cin AFTER tpd_cin_s;
    carry2 <= sum1 AND Cin AFTER tpd_cin_cout;

    -- Final carry-out: OR of carries from both half adders
    Cout   <= carry1 OR carry2 AFTER 0.5 ns;
END ARCHITECTURE HalfAdders;

--===========================================================
-- Architecture 3: Optimized — use MUX logic for carry-out
--===========================================================
ARCHITECTURE Optimized OF full_adder IS
BEGIN
    -- Sum remains as XOR of all inputs
    s <= x XOR y XOR Cin AFTER tpd_x_s;

    -- Carry-out: use MUX logic; if x = y, output x, else Cin
    Cout <= x WHEN (x = y) ELSE Cin AFTER tpd_x_cout;
END ARCHITECTURE Optimized;

--===========================================================
-- Architecture 4: Numeric — model using integer value
--===========================================================
ARCHITECTURE Numeric OF full_adder IS
    SIGNAL temp_sum : INTEGER RANGE 0 TO 3;  -- Holds total of x+y+Cin
BEGIN
    -- Encode sum of inputs into integer
    temp_sum <= 0 WHEN x = '0' AND y = '0' AND Cin = '0' ELSE
                1 WHEN (x = '1' AND y = '0' AND Cin = '0') OR
                      (x = '0' AND y = '1' AND Cin = '0') OR
                      (x = '0' AND y = '0' AND Cin = '1') ELSE
                2 WHEN (x = '1' AND y = '1' AND Cin = '0') OR
                      (x = '1' AND y = '0' AND Cin = '1') OR
                      (x = '0' AND y = '1' AND Cin = '1') ELSE
                3;

    -- Output sum bit: '1' if total = 1 or 3
    s    <= '1' WHEN (temp_sum = 1) OR (temp_sum = 3) ELSE '0' AFTER tpd_x_s;

    -- Output carry: '1' if total >= 2
    Cout <= '1' WHEN (temp_sum >= 2) ELSE '0' AFTER tpd_x_cout;
END ARCHITECTURE Numeric;
