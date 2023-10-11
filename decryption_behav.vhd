
-- Reza Gonabadi
-- 9629843
-- 1398
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.MATH_REAL.all;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity decryption_behav is
	port(
		clk	:in	std_logic;
		en		:in	std_logic; 
		p_in	   :in	std_logic_vector(15 downto 0);
		q_in	   :in	std_logic_vector(15 downto 0);
		private_key : in std_logic_vector(31 downto 0);
		dout 		:out std_logic_vector(63 downto 0);
		encryptdata: in std_logic_vector(31 downto 0)
	);
end decryption_behav;

architecture Behavioral of decryption_behav is
signal power_result	:	std_logic_vector(255 downto 0)	:= "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";

begin

	process(clk,en)
	variable cnt : integer := 0;
	variable mul_n	:	std_logic_vector(31 downto 0)	:=(others => '0');

	begin
		if(rising_edge(clk) and en ='1')then
			-----------------------calculate n=pq --------------------------
			mul_n := std_logic_vector(to_unsigned( to_integer(unsigned(p_in))* to_integer(unsigned(q_in)),32));
			-------------------------------deccrypt data-------------------------------------
			if (cnt < conv_integer(private_key)) then 
				power_result <= std_logic_vector(to_unsigned( to_integer(unsigned(power_result))* to_integer(unsigned(encryptdata)),256));
				cnt := cnt + 1 ;
			elsif (cnt = conv_integer(private_key)) then
				cnt := 0;
				dout <= std_logic_vector(to_unsigned( to_integer(unsigned(power_result)) rem to_integer(unsigned(mul_n)),64));
				power_result <= "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
			end if;
			----------------------------------------------------
		end if;
	end process;

end Behavioral;

