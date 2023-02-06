LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY single_pulse_detector IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        input_signal : IN STD_LOGIC;
        output_pulse : OUT STD_LOGIC);
END single_pulse_detector;

ARCHITECTURE Behavioral OF single_pulse_detector IS

    SIGNAL ff1 : STD_LOGIC;
    SIGNAL ff2 : STD_LOGIC;

BEGIN

    PROCESS (clk, rst)
    BEGIN

        IF rst = '1' THEN
            ff1 <= '0';
            ff2 <= '0';
        ELSIF rising_edge(clk) THEN
            ff1 <= input_signal;
            ff2 <= ff1;
        END IF;

    END PROCESS;

    output_pulse <= ff1 AND NOT ff2;

END Behavioral;