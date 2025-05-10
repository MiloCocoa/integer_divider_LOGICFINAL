-- Author(s):     Nuttanon Pongpunlux 6538050421
--                Siraphop Wannasanmethar 6538213421
--                Supadet Udomgewganchana 6538205421
--
-- Date:          10 May 2025
--
-- Description:
--    Logic Design (2147307) Final Project
--    Package containing component declarations used in the n-bit integer divider

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE project_components IS

    -- Generic N-bit Register with Enable and Asynchronous Reset
    COMPONENT regn
        GENERIC (N: INTEGER := 4); -- Data width
        PORT (
            R      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Input data
            Resetn : IN  STD_LOGIC;                      -- Active-low reset
            E      : IN  STD_LOGIC;                      -- Enable signal
            Clock  : IN  STD_LOGIC;                      -- Clock input
            Q      : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)  -- Output data
        );
    END COMPONENT regn;

    -- Generic N-bit 2-to-1 Multiplexer
    COMPONENT mux
        GENERIC (N: INTEGER := 4); -- Data width
        PORT (
            SEL : IN  STD_LOGIC;                        -- Select line
            D0  : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);   -- Input 0
            D1  : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);   -- Input 1
            X   : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)    -- Output
        );
    END COMPONENT mux;

    -- Generic N-bit Adder with Carry-In and Carry-Out
    COMPONENT adder
        GENERIC (N: INTEGER := 4); -- Data width
        PORT (
            Cin    : IN  STD_LOGIC;                     -- Carry-in
            A      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);-- Operand A
            B      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);-- Operand B
            Result : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);-- Sum output
            Cout   : OUT STD_LOGIC                      -- Carry-out
        );
    END COMPONENT adder;

    -- N-bit Zero Detector
    COMPONENT is_zero
        GENERIC (N: INTEGER := 4); -- Data width
        PORT (
            D       : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);-- Input data
            Resetn  : IN  STD_LOGIC;                      -- Active-low reset
            ISZERO  : OUT STD_LOGIC                       -- '1' if input is zero
        );
    END COMPONENT is_zero;

    -- N-bit Bitwise Inverter
    COMPONENT inverter
        GENERIC (N: INTEGER := 4); -- Data width
        PORT (
            A : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Input data
            Y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)  -- Inverted output
        );
    END COMPONENT inverter;

END PACKAGE project_components;
