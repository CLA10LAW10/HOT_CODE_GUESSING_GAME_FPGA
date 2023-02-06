library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use std.env.stop;

entity rand_gen_tb is
end rand_gen_tb;

architecture Behavioral of rand_gen_tb is

component rand_gen IS
    PORT (
        clk, rst : IN STD_LOGIC;
        seed : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        output : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
END component rand_gen;

signal clk_tb : STD_LOGIC;
signal rst_tb : STD_LOGIC;
signal seed_tb : STD_LOGIC_VECTOR (7 DOWNTO 0);
signal output_tb : STD_LOGIC_VECTOR (3 DOWNTO 0);

constant CP : time := 10ns;

begin

uut : rand_gen 
    port map (
        clk => clk_tb,
        rst => rst_tb,
        seed => seed_tb,
        output => output_tb
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
    input_gen : process
    BEGIN

        wait for CP;
        seed_tb <= "01001111";
        wait for CP;
        rst_tb <= '1';
        wait for 5 * CP;
        rst_tb <= '0';
        wait for 5 * CP;
        stop;
    end process;

end Behavioral;