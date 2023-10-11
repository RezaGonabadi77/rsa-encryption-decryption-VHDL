--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:38:07 01/31/2020
-- Design Name:   
-- Module Name:   E:/uni/term 5/FPGA/project/RSA_virtex/test_rsa.vhd
-- Project Name:  RSA_virtex
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: encryptRSA
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_rsa IS
END test_rsa;
 
ARCHITECTURE behavior OF test_rsa IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT encryptRSA
    PORT(
         clk : IN  std_logic;
         en : IN  std_logic;
         err : OUT  std_logic;
         p_in : IN  std_logic_vector(15 downto 0);
         q_in : IN  std_logic_vector(15 downto 0);
         public_key : IN  std_logic_vector(31 downto 0);
         private_key : OUT  std_logic_vector(31 downto 0);
         din : IN  std_logic_vector(15 downto 0);
         encryptdata : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal en : std_logic := '0';
   signal p_in : std_logic_vector(15 downto 0) := (others => '0');
   signal q_in : std_logic_vector(15 downto 0) := (others => '0');
   signal public_key : std_logic_vector(31 downto 0) := (others => '0');
   signal din : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal err : std_logic;
   signal private_key : std_logic_vector(31 downto 0);
   signal encryptdata : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: encryptRSA PORT MAP (
          clk => clk,
          en => en,
          err => err,
          p_in => p_in,
          q_in => q_in,
          public_key => public_key,
          private_key => private_key,
          din => din,
          encryptdata => encryptdata
        );

   -- Clock process definitions
   clk <= not clk after 50 ns;
	en <= '1' after 150 ns;
	p_in <= "0000000000001011" after 150 ns;
	q_in <= "0000000000001101" after 150 ns;
	public_key <= "00000000000000000000000000000111" after 20 ns ;
	din <= "0000000000000111" after 20 ns ;

END;
