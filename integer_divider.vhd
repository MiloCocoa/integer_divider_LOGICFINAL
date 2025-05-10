-- Author(s):     Nuttanon Pongpunlux 6538050421
--                Siraphop Wannasanmethar 6538213421
--                Supadet Udomgewganchana 6538205421

-- Date:          10 May 2025

-- Description:
--      Logic Design (2147307) Final Project
--      n-bit integer divider using sequential logic and datapath components

LIBRARY IEEE;  -- Import standard IEEE library
USE IEEE.STD_LOGIC_1164.ALL;  -- Use standard logic types
USE WORK.project_components.ALL; -- Import all components declared in project_components package

-- Entity Declaration
ENTITY integer_divider IS
    GENERIC (N: INTEGER := 4); -- Declare generic N as data width
    PORT (
        Clock  : IN  STD_LOGIC;                         -- Clock input
        Resetn : IN  STD_LOGIC;                         -- Active-low asynchronous reset
        s      : IN  STD_LOGIC;                         -- Start control signal
        A      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);    -- Dividend input vector
        B      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);    -- Divisor input vector
        R      : BUFFER STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Remainder output vector
        Q      : BUFFER STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Quotient output vector
        Err    : OUT STD_LOGIC;                         -- Error flag output (e.g. divide by zero)
        Done   : OUT STD_LOGIC                          -- Done signal output
    );
END ENTITY integer_divider;

-- Architecture: Behavior
ARCHITECTURE Behavior OF integer_divider IS
    -- State definitions for FSM
    TYPE State_type IS (S0, S1, S2);  -- Define FSM states: Init, Compute, Done
    SIGNAL y : State_type;  -- Current state signal

    -- Datapath intermediate signals
    SIGNAL QA, QB, NQB, DR, DQ, Diff, Sum, One, Zeros : STD_LOGIC_VECTOR(N-1 DOWNTO 0);  -- Data vectors
    SIGNAL z, RgtB, Rsel, Qsel, ER, EQ, Cout          : STD_LOGIC;  -- Control and status signals

BEGIN
    -- FSM for controlling the datapath
    FSM_transitions: PROCESS(Resetn, Clock)  -- Synchronous process for state transition
    BEGIN
        IF Resetn = '0' THEN
            y <= S0; -- Reset to initial state
        ELSIF (Clock'EVENT AND Clock = '1') THEN  -- Rising edge of clock
            CASE y IS
                WHEN S0 => -- Wait for start signal
                    IF (s = '1' AND z = '0') THEN 
                        y <= S1; -- Valid input, begin division
                    ELSIF (s = '1' AND z = '1') THEN 
                        y <= S2; -- Invalid input (divisor is zero), go to error state
                    ELSE 
                        y <= S0; -- Stay in initial state
                    END IF;

                WHEN S1 => -- Division in progress
                    IF RgtB = '0' THEN 
                        y <= S2; -- Division complete
                    ELSE 
                        y <= S1; -- Continue dividing
                    END IF;

                WHEN S2 => -- Final state (idle/wait for reset)
                    IF s = '0' THEN 
                        y <= S0; -- Wait for reset to return to S0
                    ELSE 
                        y <= S2; -- Stay in done state
                    END IF;
            END CASE;
        END IF;
    END PROCESS;

    -- Output logic depending on state
    FSM_outputs: PROCESS(y, s, z, RgtB)
    BEGIN
        -- Default values for control signals
        Rsel <= '0'; 
        Qsel <= '0'; 
        Done <= '0';

        CASE y IS
            WHEN S0 => -- Initialization phase
                Rsel <= '0'; 
                Qsel <= '0'; 
                Done <= '0';
                IF (s = '1' AND z = '1') THEN
                    Err <= '1'; -- Set error if divisor is zero
                ELSE
                    Err <= '0'; -- Clear error
                    ER  <= '1'; -- Enable R register to load A
                    EQ  <= '1'; -- Enable Q register to load 0
                END IF;

            WHEN S1 => -- Division in progress
                Rsel <= '1';  -- Select R - B for next R
                Qsel <= '1';  -- Select Q + 1 for next Q
                IF (RgtB = '1') THEN
                    ER <= '1'; -- Update R register if borrow exists
                    EQ <= '1'; -- Update Q register
                ELSE
                    ER <= '0'; -- Hold current R
                    EQ <= '0'; -- Hold current Q
                END IF;

            WHEN S2 => -- Final state: signal completion
                Done <= '1'; -- Assert done signal
        END CASE;
    END PROCESS;

    -- Datapath Logic
    One   <= (0 => '1', OTHERS => '0'); -- Constant vector with only LSB = '1' (value = 1)
    Zeros <= (OTHERS => '0');          -- Constant vector of all zeros

    -- Register to store dividend A
    RegA: regn 
        GENERIC MAP (N => N)  -- Set data width
        PORT MAP (A, Resetn, '1', Clock, QA); -- Load A into QA register on reset

    -- Register to store divisor B
    RegB: regn 
        GENERIC MAP (N => N)
        PORT MAP (B, Resetn, '1', Clock, QB); -- Load B into QB register

    -- Register to store Remainder
    RegR: regn 
        GENERIC MAP (N => N)
        PORT MAP (DR, Resetn, ER, Clock, R); -- DR input goes into R when ER is enabled

    -- Register to store Quotient
    RegQ: regn 
        GENERIC MAP (N => N)
        PORT MAP (DQ, Resetn, EQ, Clock, Q); -- DQ input goes into Q when EQ is enabled

    -- Check if divisor B is zero
    IsZero: is_zero 
        GENERIC MAP (N => N)
        PORT MAP (QB, Resetn, z); -- Set z = '1' if QB = 0

    -- Bitwise inverter for 2's complement
    NotB: inverter 
        GENERIC MAP (N => N)
        PORT MAP (QB, NQB); -- NQB is bitwise NOT of QB

    -- Subtraction: R - B using 2’s complement (R + NOT B + 1)
    Subtractor: adder 
        GENERIC MAP (N => N)
        PORT MAP ('1', R, NQB, Diff, RgtB); -- Subtract B from R; RgtB = borrow

    -- Increment Quotient by 1
    QAdder: adder 
        GENERIC MAP (N => N)
        PORT MAP ('0', One, Q, Sum, Cout); -- Q + 1 => Sum, ignore Cout

    -- R MUX: select between A (initial load) and R - B (during division)
    RMux: mux 
        GENERIC MAP (N => N)
        PORT MAP (Rsel, QA, Diff, DR); -- DR = QA if Rsel='0'; DR = Diff if Rsel='1'

    -- Q MUX: select between 0 (initial load) and Q + 1 (during division)
    QMux: mux 
        GENERIC MAP (N => N)
        PORT MAP (Qsel, Zeros, Sum, DQ); -- DQ = 0 if Qsel='0'; DQ = Sum if Qsel='1'

END ARCHITECTURE Behavior;
