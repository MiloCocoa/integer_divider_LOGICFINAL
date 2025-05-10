-- Author(s):     Nuttanon Pongpunlux 6538050421
--                Siraphop Wannasanmethar 6538213421
--                Supadet Udomgewganchana 6538205421
--
-- Date:          10 May 2025
--
-- Description
--    Logic Design (2147307) Final Project
--    Testbench for n-bit integer divider V2

-- Library declarations
LIBRARY IEEE;                         -- Standard IEEE library
USE IEEE.STD_LOGIC_1164.ALL;          -- Standard logic types
USE IEEE.NUMERIC_STD.ALL;             -- Numeric operations and conversions

-- Testbench entity declaration (has no ports)
ENTITY integer_divider_tb IS
END ENTITY integer_divider_tb;

-- Testbench architecture
ARCHITECTURE Behavior OF integer_divider_tb IS
    -- Constants
    CONSTANT N : INTEGER := 8;        -- Bit width for inputs/outputs (8-bit)

    -- Testbench signals (inputs to UUT)
    SIGNAL Clock  : STD_LOGIC := '0'; -- Test clock (initialized to 0)
    SIGNAL Resetn : STD_LOGIC := '1'; -- Active-low reset (initialized to 1/inactive)
    SIGNAL s      : STD_LOGIC := '0'; -- Start signal (initialized to 0/inactive)
    
    -- Data inputs
    SIGNAL A      : STD_LOGIC_VECTOR(N-1 DOWNTO 0) := (OTHERS => '0'); -- Dividend
    SIGNAL B      : STD_LOGIC_VECTOR(N-1 DOWNTO 0) := (OTHERS => '0'); -- Divisor
    
    -- Outputs from UUT
    SIGNAL Q      : STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Quotient result
    SIGNAL R      : STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Remainder result
    SIGNAL Done   : STD_LOGIC;                      -- Completion flag
    SIGNAL Err    : STD_LOGIC;                      -- Error flag (division by zero)

    -- Clock timing
    CONSTANT clk_period : TIME := 10 ns; -- 100 MHz clock (10ns period)

BEGIN
    -- Clock generation process (creates 50% duty cycle clock)
    clock_process: PROCESS
    BEGIN
        Clock <= '0';                -- Set clock low
        WAIT FOR clk_period/2;       -- Hold for half period
        Clock <= '1';                -- Set clock high
        WAIT FOR clk_period/2;       -- Hold for half period
    END PROCESS;

    -- Instantiate Unit Under Test (integer divider)
    uut: ENTITY work.integer_divider
        GENERIC MAP (N => N)         -- Map generic parameter
        PORT MAP (
            Clock  => Clock,         -- Connect testbench clock
            Resetn => Resetn,        -- Connect reset signal
            s      => s,             -- Connect start signal
            A      => A,             -- Connect dividend input
            B      => B,             -- Connect divisor input
            R      => R,             -- Connect remainder output
            Q      => Q,             -- Connect quotient output
            Err    => Err,           -- Connect error flag
            Done   => Done           -- Connect completion flag
        );

    -- Stimulus process (test cases)
    stim_proc: PROCESS
    BEGIN
        -- Test 1: Initial reset
        Resetn <= '0';               -- Assert reset (active low)
        WAIT FOR clk_period;         -- Hold reset for one clock cycle
        Resetn <= '1';               -- Deassert reset
        
        -- Test 2: Normal division (24 / 6)
        A <= std_logic_vector(to_unsigned(24, N));  -- Set dividend to 24
        B <= std_logic_vector(to_unsigned(6, N));   -- Set divisor to 6
        WAIT FOR clk_period;         -- Wait for signal propagation
        s <= '1';                    -- Start division operation
        
        -- Wait for completion and verify results
        WAIT UNTIL Done'EVENT;       -- Wait for done flag to change
        -- Verify quotient (should be 4)
        IF Q /= "00000100" THEN 
            REPORT "Test 1 failed: Quotient should be 4" SEVERITY error;
        ELSE 
            REPORT "Test 1 passed: Correct quotient (4)"; 
        END IF;
        -- Verify remainder (should be 0)
        IF R /= "00000000" THEN 
            REPORT "Test 1 failed: Remainder should be 0" SEVERITY error;
        ELSE 
            REPORT "Test 1 passed: Correct remainder (0)"; 
        END IF;
        
        WAIT FOR clk_period;         -- Wait before next test
        s <= '0';                    -- Clear start signal
        
        -- Test 3: Division where divisor > dividend (3 / 8)
        A <= std_logic_vector(to_unsigned(3, N));   -- Dividend = 3
        B <= std_logic_vector(to_unsigned(8, N));   -- Divisor = 8
        WAIT FOR clk_period;
        s <= '1';                    -- Start operation
        
        WAIT UNTIL Done'EVENT;
        -- Verify quotient (should be 0)
        IF Q /= "00000000" THEN 
            REPORT "Test 2 failed: Quotient should be 0" SEVERITY error;
        ELSE 
            REPORT "Test 2 passed: Correct quotient (0)"; 
        END IF;
        -- Verify remainder (should be 3)
        IF R /= "00000011" THEN 
            REPORT "Test 2 failed: Remainder should be 3" SEVERITY error;
        ELSE 
            REPORT "Test 2 passed: Correct remainder (3)"; 
        END IF;
        
        WAIT FOR clk_period;
        s <= '0';
        
        -- Test 4: Division by zero (42 / 0)
        A <= std_logic_vector(to_unsigned(42, N));  -- Dividend = 42
        B <= std_logic_vector(to_unsigned(0, N));   -- Divisor = 0 (invalid)
        WAIT FOR clk_period;
        s <= '1';                    -- Start operation
        
        WAIT UNTIL Done'EVENT;
        -- Verify error flag (should be 1)
        IF Err /= '1' THEN 
            REPORT "Test 3 failed: Should raise division by zero error" SEVERITY error;
        ELSE 
            REPORT "Test 3 passed: Correctly detected division by zero"; 
        END IF;
        
        WAIT FOR clk_period;
        s <= '0';
        
        -- Test 5: Large number division (200 / 25)
        A <= std_logic_vector(to_unsigned(200, N)); -- Large dividend
        B <= std_logic_vector(to_unsigned(25, N));  -- Divisor = 25
        WAIT FOR clk_period;
        s <= '1';                    -- Start operation
        
        WAIT UNTIL Done'EVENT;
        -- Verify quotient (should be 8)
        IF Q /= "00001000" THEN 
            REPORT "Test 4 failed: Quotient should be 8" SEVERITY error;
        ELSE 
            REPORT "Test 4 passed: Correct quotient (8)"; 
        END IF;
        -- Verify remainder (should be 0)
        IF R /= "00000000" THEN 
            REPORT "Test 4 failed: Remainder should be 0" SEVERITY error;
        ELSE 
            REPORT "Test 4 passed: Correct remainder (0)"; 
        END IF;
        
        WAIT FOR clk_period;
        s <= '0';
        
        -- Test 6: Arbitrary division (53 / 7)
        A <= std_logic_vector(to_unsigned(53, N));  -- Dividend = 53
        B <= std_logic_vector(to_unsigned(7, N));   -- Divisor = 7
        WAIT FOR clk_period;
        s <= '1';                    -- Start operation
        
        WAIT UNTIL Done'EVENT;
        -- Verify quotient (should be 7)
        IF Q /= "00000111" THEN 
            REPORT "Test 5 failed: Quotient should be 7" SEVERITY error;
        ELSE 
            REPORT "Test 5 passed: Correct quotient (7)"; 
        END IF;
        -- Verify remainder (should be 4)
        IF R /= "00000100" THEN 
            REPORT "Test 5 failed: Remainder should be 4" SEVERITY error;
        ELSE 
            REPORT "Test 5 passed: Correct remainder (4)"; 
        END IF;
        
        WAIT FOR clk_period;
        s <= '0';
        
        -- Test 7: Maximum value division (255 / 255)
        A <= std_logic_vector(to_unsigned(255, N)); -- Max 8-bit value
        B <= std_logic_vector(to_unsigned(255, N)); -- Max 8-bit value
        WAIT FOR clk_period;
        s <= '1';                    -- Start operation
        
        WAIT UNTIL Done'EVENT;
        -- Verify quotient (should be 1)
        IF Q /= "00000001" THEN 
            REPORT "Test 6 failed: Quotient should be 1" SEVERITY error;
        ELSE 
            REPORT "Test 6 passed: Correct quotient (1)"; 
        END IF;
        -- Verify remainder (should be 0)
        IF R /= "00000000" THEN 
            REPORT "Test 6 failed: Remainder should be 0" SEVERITY error;
        ELSE 
            REPORT "Test 6 passed: Correct remainder (0)"; 
        END IF;
        
        WAIT FOR clk_period;
        s <= '0';
        
        -- Test 8: Prime number division (101 / 13)
        A <= std_logic_vector(to_unsigned(101, N)); -- Prime dividend
        B <= std_logic_vector(to_unsigned(13, N));  -- Prime divisor
        WAIT FOR clk_period;
        s <= '1';                    -- Start operation
        
        WAIT UNTIL Done'EVENT;
        -- Verify quotient (should be 7)
        IF Q /= "00000111" THEN 
            REPORT "Test 7 failed: Quotient should be 7" SEVERITY error;
        ELSE 
            REPORT "Test 7 passed: Correct quotient (7)"; 
        END IF;
        -- Verify remainder (should be 10)
        IF R /= "00001010" THEN 
            REPORT "Test 7 failed: Remainder should be 10" SEVERITY error;
        ELSE 
            REPORT "Test 7 passed: Correct remainder (10)"; 
        END IF;
        
        -- End simulation
        WAIT;                       -- Infinite wait to stop simulation
    END PROCESS;

END ARCHITECTURE Behavior;