LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY rand_gen IS
    PORT (
        clk, rst : IN STD_LOGIC;
        seed : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        output : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
END rand_gen;

ARCHITECTURE Behavioral OF rand_gen IS

    SIGNAL currstate : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL nextstate : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL feedback : STD_LOGIC;

BEGIN

    stateReg : PROCESS (clk, seed, rst)
        VARIABLE seed_check : NATURAL RANGE 0 TO 1 := 0;
    BEGIN
        IF rst = '0' AND seed_check = 0 THEN
            currstate <= seed;
            seed_check := 1;
        ELSIF (rising_edge (clk)) THEN
            currstate <= nextstate;
            IF rst = '1' THEN
                seed_check := 0;
                output <= currstate(7 DOWNTO 4);
            END IF;
        END IF;
    END PROCESS;

    feedback <= currstate(4) XOR currstate(3) XOR currstate(2) XOR currstate(0);
    nextstate <= feedback & currstate(7 DOWNTO 1);

END Behavioral;