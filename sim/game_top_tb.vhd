LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use std.env.stop;

ENTITY number_guess_tb IS

END number_guess_tb;

ARCHITECTURE Behavioral OF number_guess_tb IS

    COMPONENT number_guess IS
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
    END COMPONENT number_guess;

    SIGNAL clk_tb : STD_LOGIC;
    SIGNAL rst_tb : STD_LOGIC;
    SIGNAL show_tb : STD_LOGIC;
    SIGNAL enter_tb : STD_LOGIC;
    SIGNAL switches_tb : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL leds_tb : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL red_led_tb : STD_LOGIC;
    SIGNAL blue_led_tb : STD_LOGIC;
    SIGNAL green_led_tb : STD_LOGIC;

    CONSTANT CP : TIME := 8ns;

BEGIN

    uut : number_guess
    PORT MAP(
        clk => clk_tb,
        rst => rst_tb,
        show => show_tb,
        enter => enter_tb,
        switches => switches_tb,
        leds => leds_tb,
        red_led => red_led_tb,
        blue_led => blue_led_tb,
        green_led => green_led_tb
    );

    -- Clock generation process
    clk_gen : PROCESS
    BEGIN
        clk_tb <= '0';
        WAIT FOR CP/2;
        clk_tb <= '1';
        WAIT FOR CP/2;
    END PROCESS;

    -- Input vector
    input_gen : PROCESS
    BEGIN
        show_tb <= '0';
        
        rst_tb <= '0';
        WAIT FOR CP;
        rst_tb <= '1';
        WAIT FOR 10000 * CP;
        rst_tb <= '0';
        WAIT FOR 10000 * CP;
        rst_tb <= '1';
        WAIT FOR 2000000 * CP;
        rst_tb <= '0';
        WAIT FOR 2000000 * CP;

        switches_tb <= "0000";
        enter_tb <= '1';
        WAIT FOR 2000000 * CP;
        enter_tb <= '0';
        WAIT FOR 2000000 * CP;

        switches_tb <= "0001";
        enter_tb <= '1';
        WAIT FOR 2000000 * CP;
        enter_tb <= '0';
        WAIT FOR 2000000 * CP;

        switches_tb <= "0010";
        enter_tb <= '1';
        WAIT FOR 2000000 * CP;
        enter_tb <= '0';
        WAIT FOR 2000000 * CP;

        switches_tb <= "0011";
        enter_tb <= '1';
        WAIT FOR 2000000 * CP;
        enter_tb <= '0';
        WAIT FOR 2000000 * CP;

        switches_tb <= "0100";
        enter_tb <= '1';
        WAIT FOR 2000000 * CP;
        enter_tb <= '0';
        WAIT FOR 2000000 * CP;

        switches_tb <= "0101";
        enter_tb <= '1';
        WAIT FOR 2000000 * CP;
        enter_tb <= '0';
        WAIT FOR 2000000 * CP;

        switches_tb <= "0110";
        enter_tb <= '1';
        WAIT FOR 2000000 * CP;
        enter_tb <= '0';
        WAIT FOR 2000000 * CP;

        switches_tb <= "0111";
        enter_tb <= '1';
        WAIT FOR 2000000 * CP;
        enter_tb <= '0';
        WAIT FOR 2000000 * CP;

        switches_tb <= "1000";
        enter_tb <= '1';
        WAIT FOR 2000000 * CP;
        enter_tb <= '0';
        WAIT FOR 2000000 * CP;

        switches_tb <= "1001";
        enter_tb <= '1';
        WAIT FOR 2000000 * CP;
        enter_tb <= '0';
        WAIT FOR 2000000 * CP;

        switches_tb <= "1010";
        enter_tb <= '1';
        WAIT FOR 2000000 * CP;
        enter_tb <= '0';
        WAIT FOR 2000000 * CP;

        switches_tb <= "1011";
        enter_tb <= '1';
        WAIT FOR 2000000 * CP;
        enter_tb <= '0';
        WAIT FOR 2000000 * CP;

        switches_tb <= "1100";
        enter_tb <= '1';
        WAIT FOR 2000000 * CP;
        enter_tb <= '0';
        WAIT FOR 2000000 * CP;

        switches_tb <= "1101";
        enter_tb <= '1';
        WAIT FOR 2000000 * CP;
        enter_tb <= '0';
        WAIT FOR 2000000 * CP;

        switches_tb <= "1110";
        enter_tb <= '1';
        WAIT FOR 2000000 * CP;
        enter_tb <= '0';
        WAIT FOR 2000000 * CP;

        switches_tb <= "1111";
        enter_tb <= '1';
        WAIT FOR 2000000 * CP;
        enter_tb <= '0';
        WAIT FOR 2000000 * CP;

        show_tb <= '1';
        WAIT FOR 2000000 * CP;
        show_tb <= '0';
        WAIT FOR 2000000 * CP;

        rst_tb <= '1';
        WAIT FOR 2000000 * CP;
        rst_tb <= '0';
        WAIT FOR 2000000 * CP;

        show_tb <= '1';
        WAIT FOR 2000000 * CP;
        show_tb <= '0';
        WAIT FOR 4000000 * CP;

        stop;
    END PROCESS;

END Behavioral;