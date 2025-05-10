-- Author(s):     Nuttanon Pongpunlux 6538050421
--                Siraphop Wannasanmethar 6538213421
--                Supadet Udomgewganchana 6538205421
--
-- Date:          10 May 2025
--
-- Description:
--    Logic Design (2147307) Final Project
--    n-bit register component with asynchronous reset and clock enable

-- Import IEEE standard logic library for digital signal definitions
LIBRARY IEEE;                          -- Reference to IEEE standard library
USE IEEE.STD_LOGIC_1164.ALL;           -- Use standard logic types (STD_LOGIC, STD_LOGIC_VECTOR)

-- Entity declaration for a generic n-bit register
ENTITY regn IS
    GENERIC (
        N: INTEGER := 4               -- Width of the register (default: 4 bits)
    );
    PORT (
        R      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);  -- Data input vector
        Resetn : IN  STD_LOGIC;                       -- Active-low reset signal
        E      : IN  STD_LOGIC;                       -- Clock enable signal
        Clock  : IN  STD_LOGIC;                       -- Clock input signal
        Q      : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)   -- Data output vector
    );
END ENTITY regn;

-- Behavioral architecture that describes register logic
ARCHITECTURE Behavior OF regn IS
BEGIN
    -- Process block reacts to changes in Resetn or Clock
    PROCESS (Resetn, Clock)
    BEGIN
        -- Asynchronous reset: output is cleared immediately when Resetn is '0'
        IF Resetn = '0' THEN
            Q <= (OTHERS => '0');  -- Set all output bits of Q to '0'

        -- Synchronous operation triggered on rising clock edge
        ELSIF rising_edge(Clock) THEN
            -- Only update the register if enable signal E is active
            IF E = '1' THEN
                Q <= R;  -- Load input data R into output register Q
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE Behavior;
