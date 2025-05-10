-- Author(s):     Nuttanon Pongpunlux 6538050421
--                Siraphop Wannasanmethar 6538213421
--                Supadet Udomgewganchana 6538205421
--
-- Date:          10 May 2025
--
-- Description:
--    Logic Design (2147307) Final Project
--    n-bit register component with asynchronous reset and clock enable

-- Import IEEE standard logic library
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for a generic-width register
ENTITY regn IS
    GENERIC (
        N: INTEGER := 4  -- Number of bits in the register (default: 4 bits)
    );
    PORT (
        R      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);  -- Data input vector
        Resetn : IN  STD_LOGIC;                       -- Active-low asynchronous reset
        E      : IN  STD_LOGIC;                       -- Enable signal
        Clock  : IN  STD_LOGIC;                       -- Clock signal
        Q      : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)   -- Data output vector
    );
END ENTITY regn;

-- Architecture describing the behavior of the register
ARCHITECTURE Behavior OF regn IS
BEGIN
    -- Process sensitive to asynchronous reset and clock
    PROCESS (Resetn, Clock)
    BEGIN
        -- Asynchronous reset: if Resetn = '0', immediately clear output
        IF Resetn = '0' THEN
            Q <= (OTHERS => '0');  -- Clear all bits in the output register

        -- Synchronous operation: on rising edge of clock
        ELSIF rising_edge(Clock) THEN
            -- Only load new data if enable is active
            IF E = '1' THEN
                Q <= R;  -- Store input R into output Q
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE Behavior;
