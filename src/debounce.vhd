LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY debounce IS
    GENERIC (
        clk_freq : INTEGER := 125_000_000; --system clock frequency in Hz
        stable_time : INTEGER := 10); --time button must remain stable in ms
    PORT (
        clk : IN STD_LOGIC; --input clock
        rst : IN STD_LOGIC; --asynchronous active low reset
        button : IN STD_LOGIC; --input signal to be debounced
        result : OUT STD_LOGIC); --debounced signal
END debounce;

ARCHITECTURE Behavioral OF debounce IS

    SIGNAL flipflops : STD_LOGIC_VECTOR (1 DOWNTO 0); -- Input flip-flop
    SIGNAL counter_set : STD_LOGIC; -- Sync reset to zero

BEGIN

    counter_set <= flipflops(0) XOR flipflops(1); -- Determine when to start/reset counter.

    PROCESS (clk, rst)
        VARIABLE count : INTEGER RANGE 0 TO clk_freq * stable_time/1000;
    BEGIN
        IF rst = '1' THEN -- Should this be 0 or 1
            flipflops <= (OTHERS => '0'); -- Clear input flipflops.
            result <= '0'; -- Clear result register.
        ELSIF rising_edge (clk) THEN
            flipflops(0) <= button; -- Store button value in 1st ff.
            flipflops(1) <= flipflops(0); -- Store 1st ff value in 2nd ff.

            IF counter_set = '1' THEN
                count := 0;
            ELSIF (count < clk_freq * stable_time / 1000) THEN
                count := count + 1;
            ELSE -- Stable input is met.
                result <= flipflops(1); -- Output the stable value.
            END IF;
        END IF;

    END PROCESS;

END Behavioral;