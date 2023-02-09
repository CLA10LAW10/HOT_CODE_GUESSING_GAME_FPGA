LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY number_guess IS
    PORT (
        clk : IN STD_LOGIC;                             -- Input clock
        rst : IN STD_LOGIC;                             -- Input rst, used to reset the game
        show : IN STD_LOGIC;                            -- Input show to SHOW the answer to the player
        enter : IN STD_LOGIC;                           -- Input enter, used to indicate a guessing value.
        switches : IN STD_LOGIC_VECTOR (3 DOWNTO 0);    -- Input switches, used to guess the secret number
        leds : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);       -- Output LEDS, used when having the number shows
        red_led : OUT STD_LOGIC;                        -- Output RED LED, used to indicate a high number
        blue_led : OUT STD_LOGIC;                       -- Output BLUE LED, used to indicate a low nubmer
        green_led : OUT STD_LOGIC                       -- Output GREEN LED, used to inidcate the correct number
    );
END number_guess;

ARCHITECTURE Behavioral OF number_guess IS

    COMPONENT debounce IS
        GENERIC (
            clk_freq : INTEGER := 125_000_000;      --system clock frequency in Hz
            stable_time : INTEGER := 10);           --time button must remain stable in ms
        PORT (
            clk : IN STD_LOGIC;                     --input clock
            rst : IN STD_LOGIC;                     --asynchronous active high reset
            button : IN STD_LOGIC;                  --input signal to be debounced
            result : OUT STD_LOGIC);                --debounced signal
    END COMPONENT debounce;

    COMPONENT rand_gen IS
        PORT (
            clk, rst : IN STD_LOGIC;                    -- Input clock and reset
            seed : IN STD_LOGIC_VECTOR(7 DOWNTO 0);     -- Input Seed for initial value
            output : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)  -- Output Random generated value
        );
    END COMPONENT rand_gen;

    CONSTANT clk_freq : INTEGER := 50_000_000;  -- Consant system clock frequency in Hz
    CONSTANT stable_time : INTEGER := 10;       -- Constant 10 ms stable button time.
    CONSTANT stable_led : INTEGER := 1;         -- Constant 1 Second stable time

    SIGNAL secret_number : STD_LOGIC_VECTOR (3 DOWNTO 0);   -- Signal to pass secret number
    --SIGNAL seed : STD_LOGIC_VECTOR (3 DOWNTO 0); -- Signal to 
    --SIGNAL rst_db : STD_LOGIC;
    SIGNAL show_db : STD_LOGIC;                             -- Signal to hold debounced show button value
    SIGNAL enter_db : STD_LOGIC;                            -- Signal to hold debounced enter button value
    SIGNAL flash : STD_LOGIC;                               -- Signal to indicate when to flash the green LED

    -- Procedure used as a delay to flash the green LED
    PROCEDURE delay(                        
        CONSTANT clk_freq : INTEGER;        -- Consant system clock frequency in Hz
        CONSTANT stable_led : INTEGER;      -- Constant 1 Second stable time
        VARIABLE toggle : OUT BOOLEAN;      -- Boolean toggle to indicate when to toggle
        VARIABLE count : OUT INTEGER) IS    -- Variable count from 0 to stable time as a delay
    BEGIN

        IF count = clk_freq / stable_led / 2 THEN   -- If 0.5 Hz, 1s Period is met
            toggle := NOT toggle;                   -- Toggle to initiate LED toggle
            count := 0;                             -- Reset counter to begin again
        ELSE                                        -- Not yet at 0.5Hz to meet a 1s period, keep counting.
            count := count + 1;                     -- Count and continue delaying
        END IF;
    END PROCEDURE;

BEGIN

    -- Debounce show button input
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

    -- Debounce enter button input
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

    -- Generate a random number with a seed of 0x4f
    scrt_num : rand_gen
    PORT MAP(
        clk => clk,
        rst => rst,
        seed => "01001111",
        output => secret_number
    );

    -- Play the game!!
    game : PROCESS (clk, show_db, rst, enter_db)
    BEGIN
        IF rst = '1' THEN
            flash <= '0';
            blue_led <= '0';
            red_led <= '0';
            leds <= (OTHERS => '0');
        ELSE
            IF rising_edge(clk) THEN
                IF show_db = '1' THEN
                    leds <= secret_number;
                ELSIF enter = '1' THEN
                    IF switches = secret_number THEN
                        blue_led <= '0';
                        red_led <= '0';
                        flash <= '1';
                    ELSIF switches < secret_number THEN
                        blue_led <= '1';
                        red_led <= '0';
                        flash <= '0';
                    ELSIF switches > secret_number THEN
                        blue_led <= '0';
                        red_led <= '1';
                        flash <= '0';
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- You win! Flash the green light! (Or did you hit show and enter the correct value ;)
    flash_green : PROCESS (flash, clk)
        VARIABLE count : INTEGER RANGE 0 TO stable_led := 0;
        VARIABLE toggle : BOOLEAN := true;
    BEGIN
        IF flash = '0' THEN
            green_led <= '0';
        ELSE
            IF rising_edge(clk) THEN
                IF toggle THEN
                    green_led <= '1';
                    delay(clk_freq, stable_led, toggle, count);
                ELSE
                    green_led <= '0';
                    delay(clk_freq, stable_led, toggle, count);
                END IF;
            END IF;
        END IF;
    END PROCESS;

END Behavioral;