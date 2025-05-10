-- Author(s):     Nuttanon Pongpunlux 6538050421
--                Siraphop Wannasanmethar 6538213421
--                Supadet Udomgewganchana 6538205421

-- Date:          10 May 2025

-- Description:
--    Logic Design (2147307) Final Project
--    Package containing component declarations used in the n-bit integer divider

LIBRARY IEEE;  -- Import standard IEEE library
USE IEEE.STD_LOGIC_1164.ALL;  -- Use standard logic types and operations

PACKAGE project_components IS  -- Begin declaration of a package named 'project_components'

    -- Generic N-bit Register with Enable and Asynchronous Reset
    COMPONENT regn  -- Declare component 'regn'
        GENERIC (N: INTEGER := 4); -- Define generic parameter N (data width), default 4 bits
        PORT (
            R      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Input data vector (N bits)
            Resetn : IN  STD_LOGIC;                      -- Active-low reset input
            E      : IN  STD_LOGIC;                      -- Enable signal input
            Clock  : IN  STD_LOGIC;                      -- Clock signal input
            Q      : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)  -- Output data vector (N bits)
        );
    END COMPONENT regn;  -- End of component declaration

    -- Generic N-bit 2-to-1 Multiplexer
    COMPONENT mux  -- Declare component 'mux'
        GENERIC (N: INTEGER := 4); -- Define generic parameter N (data width), default 4 bits
        PORT (
            SEL : IN  STD_LOGIC;                        -- Selector input (1 bit)
            D0  : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);   -- First input data vector (N bits)
            D1  : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);   -- Second input data vector (N bits)
            X   : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)    -- Output data vector (N bits)
        );
    END COMPONENT mux;  -- End of component declaration

    -- Generic N-bit Adder with Carry-In and Carry-Out
    COMPONENT adder  -- Declare component 'adder'
        GENERIC (N: INTEGER := 4); -- Define generic parameter N (data width), default 4 bits
        PORT (
            Cin    : IN  STD_LOGIC;                      -- Carry-in input (1 bit)
            A      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- First operand input (N bits)
            B      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Second operand input (N bits)
            Result : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Sum output vector (N bits)
            Cout   : OUT STD_LOGIC                       -- Carry-out output (1 bit)
        );
    END COMPONENT adder;  -- End of component declaration

    -- N-bit Zero Detector
    COMPONENT is_zero  -- Declare component 'is_zero'
        GENERIC (N: INTEGER := 4); -- Define generic parameter N (data width), default 4 bits
        PORT (
            D       : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Input data vector (N bits)
            Resetn  : IN  STD_LOGIC;                       -- Active-low reset input
            ISZERO  : OUT STD_LOGIC                        -- Output is '1' if D is zero
        );
    END COMPONENT is_zero;  -- End of component declaration

    -- N-bit Bitwise Inverter
    COMPONENT inverter  -- Declare component 'inverter'
        GENERIC (N: INTEGER := 4); -- Define generic parameter N (data width), default 4 bits
        PORT (
            A : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Input data vector (N bits)
            Y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)  -- Output inverted vector (bitwise NOT)
        );
    END COMPONENT inverter;  -- End of component declaration

END PACKAGE project_components;  -- End of package definition
