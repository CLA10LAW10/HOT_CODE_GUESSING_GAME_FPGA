LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY number_guess IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        show : IN STD_LOGIC;
        enter : IN STD_LOGIC;
        switches : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        leds : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        red_led : OUT STD_LOGIC;
        blue_led : OUT STD_LOGIC;
        green_led : OUT STD_LOGIC
    );
END number_guess;

ARCHITECTURE Behavioral OF number_guess IS

    COMPONENT debounce IS
        GENERIC (
            clk_freq : INTEGER := 125_000_000; --system clock frequency in Hz
            stable_time : INTEGER := 10); --time button must remain stable in ms
        PORT (
            clk : IN STD_LOGIC; --input clock
            rst : IN STD_LOGIC; --asynchronous active low reset
            button : IN STD_LOGIC; --input signal to be debounced
            result : OUT STD_LOGIC); --debounced signal
    END COMPONENT debounce;

    COMPONENT debounce_n IS
        GENERIC (
            clk_freq : INTEGER := 125_000_000; --system clock frequency in Hz
            stable_time : INTEGER := 10); --time button must remain stable in ms
        PORT (
            clk : IN STD_LOGIC; --input clock
            rst : IN STD_LOGIC; --asynchronous active low reset
            button : IN STD_LOGIC; --input signal to be debounced
            result : OUT STD_LOGIC); --debounced signal
    END COMPONENT debounce_n;

    COMPONENT rand_gen IS
        PORT (
            clk, rst : IN STD_LOGIC;
            seed : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT rand_gen;

    CONSTANT clk_freq : INTEGER := 125_000_000;
    CONSTANT stable_time : INTEGER := 10;

    SIGNAL secret_number : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL seed : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL rst_db : STD_LOGIC;
    SIGNAL show_db : STD_LOGIC;
    SIGNAL enter_db : STD_LOGIC;

BEGIN

    rst_n_debounce : debounce_n
    GENERIC MAP(
        clk_freq => clk_freq,
        stable_time => stable_time
    )
    PORT MAP(
        clk => clk,
        rst => rst_db,
        button => rst,
        result => rst_db
    );

    show_debounce : debounce
    GENERIC MAP(
        clk_freq => clk_freq,
        stable_time => stable_time
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        button => show,
        result => show_db
    );

    enter_debounce : debounce
    GENERIC MAP(
        clk_freq => clk_freq,
        stable_time => stable_time
    )
    PORT MAP(
        clk => clk,
        rst => rst,
        button => enter,
        result => enter_db
    );

    scrt_num : rand_gen
    PORT MAP(
        clk => clk,
        rst => rst,
        seed => "01001111",
        output => secret_number
    );

    game : PROCESS (clk, show, rst, enter_db)
    BEGIN
        IF rst = '1' THEN
            green_led <= '0';
            blue_led <= '0';
            red_led <= '0';
            leds <= (OTHERS => '0');
        ELSE
            IF rising_edge(clk) THEN
                IF show = '1' THEN
                    leds <= secret_number;
                ELSIF enter = '1' THEN
                    IF switches = secret_number THEN
                        green_led <= '1';
                        blue_led <= '0';
                        red_led <= '0';
                    ELSIF switches < secret_number THEN
                        green_led <= '0';
                        blue_led <= '1';
                        red_led <= '0';
                    ELSIF switches > secret_number THEN
                        green_led <= '0';
                        blue_led <= '0';
                        red_led <= '1';
                        --ELSE
                        --    green_led <= '0';
                        --   blue_led <= '0';
                        --    red_led <= '0';
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;

END Behavioral;