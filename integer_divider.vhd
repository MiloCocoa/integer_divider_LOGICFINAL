-- Author(s):        Nuttanon Pongpunlux 6538050421
--                   Siraphop Wannasanmethar 6538213421
--                   Supadet Udomgewganchana 6538205421
--
-- Date:             10 May 2025
--
-- Description:
--      Logic Design (2147307) Final Project
--      n-bit integer divider using sequential logic and datapath components

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE WORK.project_components.ALL; -- Custom component library for datapath elements

-- Entity Declaration
ENTITY integer_divider IS
    GENERIC (N: INTEGER := 4); -- Width of input operands
    PORT (
        Clock  : IN  STD_LOGIC;                         -- Clock signal
        Resetn : IN  STD_LOGIC;                         -- Active-low reset
        s      : IN  STD_LOGIC;                         -- Start signal
        A      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);    -- Dividend input
        B      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);    -- Divisor input
        R      : BUFFER STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Remainder output
        Q      : BUFFER STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Quotient output
        Err    : OUT STD_LOGIC;                         -- Error flag (e.g. divide by zero)
        Done   : OUT STD_LOGIC                          -- Done flag
    );
END ENTITY integer_divider;

-- Architecture: Behavior
ARCHITECTURE Behavior OF integer_divider IS
    -- State definitions for FSM
    TYPE State_type IS (S0, S1, S2);
    SIGNAL y : State_type;

    -- Datapath intermediate signals
    SIGNAL QA, QB, NQB, DR, DQ, Diff, Sum, One, Zeros : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    SIGNAL z, RgtB, Rsel, Qsel, ER, EQ, Cout          : STD_LOGIC;

BEGIN
    -- FSM for controlling the datapath
    FSM_transitions: PROCESS(Resetn, Clock)
    BEGIN
        IF Resetn = '0' THEN
            y <= S0; -- Reset to initial state
        ELSIF (Clock'EVENT AND Clock = '1') THEN
            CASE y IS
                WHEN S0 => -- Wait for start signal
                    IF (s = '1' AND z = '0') THEN 
                        y <= S1; -- Valid inputs, start division
                    ELSIF (s = '1' AND z = '1') THEN 
                        y <= S2; -- Error: divide by zero
                    ELSE 
                        y <= S0; 
                    END IF;

                WHEN S1 => -- Division in progress
                    IF RgtB = '0' THEN 
                        y <= S2; -- Division complete
                    ELSE 
                        y <= S1; -- Continue dividing
                    END IF;

                WHEN S2 => -- Final state, wait for reset
                    IF s = '0' THEN 
                        y <= S0;
                    ELSE 
                        y <= S2; 
                    END IF;
            END CASE;
        END IF;
    END PROCESS;

    -- Output logic depending on state
    FSM_outputs: PROCESS(y, s, z, RgtB)
    BEGIN
        -- Default values
        Rsel <= '0'; 
        Qsel <= '0'; 
        Done <= '0';

        CASE y IS
            WHEN S0 => -- Initialization
                Rsel <= '0'; 
                Qsel <= '0'; 
                Done <= '0';
                IF (s = '1' AND z = '1') THEN
                    Err <= '1'; -- Error if B is zero
                ELSE
                    Err <= '0';
                    ER  <= '1'; -- Enable R register
                    EQ  <= '1'; -- Enable Q register
                END IF;

            WHEN S1 => -- Perform subtraction and quotient update
                Rsel <= '1'; 
                Qsel <= '1';
                IF (RgtB = '1') THEN
                    ER <= '1';
                    EQ <= '1';
                ELSE
                    ER <= '0';
                    EQ <= '0';
                END IF;

            WHEN S2 => -- Signal done
                Done <= '1';
        END CASE;
    END PROCESS;

    -- Datapath Logic
    One   <= (0 => '1', OTHERS => '0'); -- Constant 1 for Q increment
    Zeros <= (OTHERS => '0');          -- Constant 0 vector

    -- Register to store dividend A
    RegA: regn 
        GENERIC MAP (N => N)
        PORT MAP (A, Resetn, '1', Clock, QA);

    -- Register to store divisor B
    RegB: regn 
        GENERIC MAP (N => N)
        PORT MAP (B, Resetn, '1', Clock, QB);

    -- Register to store Remainder
    RegR: regn 
        GENERIC MAP (N => N)
        PORT MAP (DR, Resetn, ER, Clock, R);

    -- Register to store Quotient
    RegQ: regn 
        GENERIC MAP (N => N)
        PORT MAP (DQ, Resetn, EQ, Clock, Q);

    -- Check if divisor B is zero
    IsZero: is_zero 
        GENERIC MAP (N => N)
        PORT MAP (QB, Resetn, z);

    -- Bitwise inverter for 2's complement
    NotB: inverter 
        GENERIC MAP (N => N)
        PORT MAP (QB, NQB);

    -- Subtraction: R - B using adder with carry-in = 1 (2's complement)
    Subtractor: adder 
        GENERIC MAP (N => N)
        PORT MAP ('1', R, NQB, Diff, RgtB); -- RgtB = borrow output

    -- Increment Quotient by 1
    QAdder: adder 
        GENERIC MAP (N => N)
        PORT MAP ('0', One, Q, Sum, Cout);

    -- R MUX: select between A and R - B
    RMux: mux 
        GENERIC MAP (N => N)
        PORT MAP (Rsel, QA, Diff, DR);

    -- Q MUX: select between 0 and Q + 1
    QMux: mux 
        GENERIC MAP (N => N)
        PORT MAP (Qsel, Zeros, Sum, DQ);

END ARCHITECTURE Behavior;
