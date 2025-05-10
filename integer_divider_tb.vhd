-- Author(s):     Nuttanon Pongpunlux 6538050421
--                Siraphop Wannasanmethar 6538213421
--                Supadet Udomgewganchana 6538205421
--
-- Date:          10 May 2025  -- Date of creation/modification
--
-- Description
--    Logic Design (2147307) Final Project
--    Testbench for n-bit integer divider V2  -- Describes purpose of the code

-- Library declarations
LIBRARY IEEE;                         -- Import IEEE standard libraries
USE IEEE.STD_LOGIC_1164.ALL;          -- Import standard logic types (e.g., std_logic)
USE IEEE.NUMERIC_STD.ALL;             -- Import numeric operations (e.g., to_unsigned)

-- Testbench entity declaration (has no ports)
ENTITY integer_divider_tb IS         -- Testbench entity has no external interface
END ENTITY integer_divider_tb;

-- Testbench architecture
ARCHITECTURE Behavior OF integer_divider_tb IS  -- Defines architecture behavior

    -- Constants
    CONSTANT N : INTEGER := 8;        -- Bit width for inputs/outputs (8-bit)

    -- Testbench signals (inputs to UUT)
    SIGNAL Clock  : STD_LOGIC := '0'; -- Clock signal initialized to 0
    SIGNAL Resetn : STD_LOGIC := '1'; -- Active-low reset, initially inactive
    SIGNAL s      : STD_LOGIC := '0'; -- Start signal, initially inactive
    
    -- Data inputs
    SIGNAL A      : STD_LOGIC_VECTOR(N-1 DOWNTO 0) := (OTHERS => '0'); -- Dividend initialized to 0
    SIGNAL B      : STD_LOGIC_VECTOR(N-1 DOWNTO 0) := (OTHERS => '0'); -- Divisor initialized to 0
    
    -- Outputs from UUT
    SIGNAL Q      : STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Quotient output
    SIGNAL R      : STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Remainder output
    SIGNAL Done   : STD_LOGIC;                      -- Done flag from divider
    SIGNAL Err    : STD_LOGIC;                      -- Error flag for divide-by-zero

    -- Clock timing
    CONSTANT clk_period : TIME := 10 ns; -- Clock period of 10 ns (100 MHz)

BEGIN
    -- Clock generation process (creates 50% duty cycle clock)
    clock_process: PROCESS
    BEGIN
        Clock <= '0';                -- Set clock low
        WAIT FOR clk_period/2;       -- Wait half clock period
        Clock <= '1';                -- Set clock high
        WAIT FOR clk_period/2;       -- Wait other half clock period
    END PROCESS;

    -- Instantiate Unit Under Test (UUT)
    uut: ENTITY work.integer_divider      -- Reference to the divider module
        GENERIC MAP (N => N)              -- Map generic width parameter to N
        PORT MAP (
            Clock  => Clock,              -- Connect testbench Clock
            Resetn => Resetn,            -- Connect active-low Reset
            s      => s,                 -- Connect start signal
            A      => A,                 -- Connect dividend
            B      => B,                 -- Connect divisor
            R      => R,                 -- Connect remainder output
            Q      => Q,                 -- Connect quotient output
            Err    => Err,               -- Connect error output
            Done   => Done               -- Connect done flag
        );

    -- Stimulus process (applies test cases)
    stim_proc: PROCESS
    BEGIN
        -- Test 1: Apply reset
        Resetn <= '0';               -- Assert reset
        WAIT FOR clk_period;         -- Hold reset for one cycle
        Resetn <= '1';               -- Deassert reset
        
        -- Test 2: 24 / 6 = 4 remainder 0
        A <= std_logic_vector(to_unsigned(24, N));  -- Load 24
        B <= std_logic_vector(to_unsigned(6, N));   -- Load 6
        WAIT FOR clk_period;
        s <= '1';                    -- Trigger start
        
        WAIT UNTIL Done'EVENT;       -- Wait for Done signal change
        IF Q /= "00000100" THEN 
            REPORT "Test 1 failed: Quotient should be 4" SEVERITY error;
        ELSE 
            REPORT "Test 1 passed: Correct quotient (4)"; 
        END IF;
        IF R /= "00000000" THEN 
            REPORT "Test 1 failed: Remainder should be 0" SEVERITY error;
        ELSE 
            REPORT "Test 1 passed: Correct remainder (0)"; 
        END IF;
        WAIT FOR clk_period;
        s <= '0';                    -- Clear start

        -- Test 3: 3 / 8 = 0 remainder 3
        A <= std_logic_vector(to_unsigned(3, N));
        B <= std_logic_vector(to_unsigned(8, N));
        WAIT FOR clk_period;
        s <= '1';

        WAIT UNTIL Done'EVENT;
        IF Q /= "00000000" THEN 
            REPORT "Test 2 failed: Quotient should be 0" SEVERITY error;
        ELSE 
            REPORT "Test 2 passed: Correct quotient (0)"; 
        END IF;
        IF R /= "00000011" THEN 
            REPORT "Test 2 failed: Remainder should be 3" SEVERITY error;
        ELSE 
            REPORT "Test 2 passed: Correct remainder (3)"; 
        END IF;
        WAIT FOR clk_period;
        s <= '0';

        -- Test 4: 42 / 0 (should raise error)
        A <= std_logic_vector(to_unsigned(42, N));
        B <= std_logic_vector(to_unsigned(0, N));
        WAIT FOR clk_period;
        s <= '1';

        WAIT UNTIL Done'EVENT;
        IF Err /= '1' THEN 
            REPORT "Test 3 failed: Should raise division by zero error" SEVERITY error;
        ELSE 
            REPORT "Test 3 passed: Correctly detected division by zero"; 
        END IF;
        WAIT FOR clk_period;
        s <= '0';

        -- Test 5: 200 / 25 = 8 remainder 0
        A <= std_logic_vector(to_unsigned(200, N));
        B <= std_logic_vector(to_unsigned(25, N));
        WAIT FOR clk_period;
        s <= '1';

        WAIT UNTIL Done'EVENT;
        IF Q /= "00001000" THEN 
            REPORT "Test 4 failed: Quotient should be 8" SEVERITY error;
        ELSE 
            REPORT "Test 4 passed: Correct quotient (8)"; 
        END IF;
        IF R /= "00000000" THEN 
            REPORT "Test 4 failed: Remainder should be 0" SEVERITY error;
        ELSE 
            REPORT "Test 4 passed: Correct remainder (0)"; 
        END IF;
        WAIT FOR clk_period;
        s <= '0';

        -- Test 6: 53 / 7 = 7 remainder 4
        A <= std_logic_vector(to_unsigned(53, N));
        B <= std_logic_vector(to_unsigned(7, N));
        WAIT FOR clk_period;
        s <= '1';

        WAIT UNTIL Done'EVENT;
        IF Q /= "00000111" THEN 
            REPORT "Test 5 failed: Quotient should be 7" SEVERITY error;
        ELSE 
            REPORT "Test 5 passed: Correct quotient (7)"; 
        END IF;
        IF R /= "00000100" THEN 
            REPORT "Test 5 failed: Remainder should be 4" SEVERITY error;
        ELSE 
            REPORT "Test 5 passed: Correct remainder (4)"; 
        END IF;
        WAIT FOR clk_period;
        s <= '0';

        -- Test 7: 255 / 255 = 1 remainder 0
        A <= std_logic_vector(to_unsigned(255, N));
        B <= std_logic_vector(to_unsigned(255, N));
        WAIT FOR clk_period;
        s <= '1';

        WAIT UNTIL Done'EVENT;
        IF Q /= "00000001" THEN 
            REPORT "Test 6 failed: Quotient should be 1" SEVERITY error;
        ELSE 
            REPORT "Test 6 passed: Correct quotient (1)"; 
        END IF;
        IF R /= "00000000" THEN 
            REPORT "Test 6 failed: Remainder should be 0" SEVERITY error;
        ELSE 
            REPORT "Test 6 passed: Correct remainder (0)"; 
        END IF;
        WAIT FOR clk_period;
        s <= '0';

        -- Test 8: 101 / 13 = 7 remainder 10
        A <= std_logic_vector(to_unsigned(101, N));
        B <= std_logic_vector(to_unsigned(13, N));
        WAIT FOR clk_period;
        s <= '1';

        WAIT UNTIL Done'EVENT;
        IF Q /= "00000111" THEN 
            REPORT "Test 7 failed: Quotient should be 7" SEVERITY error;
        ELSE 
            REPORT "Test 7 passed: Correct quotient (7)"; 
        END IF;
        IF R /= "00001010" THEN 
            REPORT "Test 7 failed: Remainder should be 10" SEVERITY error;
        ELSE 
            REPORT "Test 7 passed: Correct remainder (10)"; 
        END IF;

        -- End simulation
        WAIT; -- Wait forever to stop simulation
    END PROCESS;

END ARCHITECTURE Behavior;
