
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY test_decrypt IS
END test_decrypt;
 
ARCHITECTURE behavior OF test_decrypt IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decryption_behav
    PORT(
         clk : IN  std_logic;
         en : IN  std_logic;
         p_in : IN  std_logic_vector(15 downto 0);
         q_in : IN  std_logic_vector(15 downto 0);
         private_key : IN  std_logic_vector(31 downto 0);
         dout : OUT  std_logic_vector(63 downto 0);
         encryptdata : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal en : std_logic := '0';
   signal p_in : std_logic_vector(15 downto 0) := (others => '0');
   signal q_in : std_logic_vector(15 downto 0) := (others => '0');
   signal private_key : std_logic_vector(31 downto 0) := (others => '0');
   signal encryptdata : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal dout : std_logic_vector(63 downto 0);


 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decryption_behav PORT MAP (
          clk => clk,
          en => en,
          p_in => p_in,
          q_in => q_in,
          private_key => private_key,
          dout => dout,
          encryptdata => encryptdata
        );

   clk <= not clk after 50 ns;
	en <= '1' after 150 ns;
	p_in <= "0000000000001011" after 150 ns;
	q_in <= "0000000000001101" after 150 ns;
	encryptdata <= "00000000000000000000000000101111" after 20 ns;
	private_key <= "00000000000000000000000000000101"after 150 ns;
END;
