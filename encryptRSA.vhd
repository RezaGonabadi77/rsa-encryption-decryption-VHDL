-- Reza Gonabadi
-- 9629843
-- 1398
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.MATH_REAL.all;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity encryptRSA is
	port(
		clk	:in	std_logic;
		en		:in	std_logic;
		err	:out	std_logic; 
		p_in	   :in	std_logic_vector(15 downto 0);
		q_in	   :in	std_logic_vector(15 downto 0);
		public_key : in std_logic_vector(31 downto 0);
		private_key : out std_logic_vector(31 downto 0);
		din 		:in std_logic_vector(15 downto 0);
		encryptdata: out std_logic_vector(31 downto 0)
	);
end encryptRSA;

architecture Behavioral of encryptRSA is
signal encryptReady : std_logic := '0';
signal power_result	:	std_logic_vector(255 downto 0)	:= "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
signal rem_result	:	std_logic_vector(31 downto 0)	:= "00000000000000000000000000000000";
--------------

--------------
begin

	process(clk,en)
	variable cnt : integer := 0;
	variable index : integer := 1;
	variable mul_n	:	std_logic_vector(31 downto 0)	:=(others => '0');
	variable mul_m	:	std_logic_vector(31 downto 0)	:=(others => '0');
	variable reg_p	:	std_logic_vector(15 downto 0)	:=(others => '0');
	variable reg_q	:	std_logic_vector(15 downto 0)	:=(others => '0');
	variable acc	:	std_logic_vector(31 downto 0)	:=(others => '0');
	variable acc2	:	std_logic_vector(31 downto 0)	:=(others => '0');
   variable acc3	:	std_logic_vector(31 downto 0)	:=(others => '0');
	begin
		if(rising_edge(clk) and en ='1')then
			-----------------------calculate n=pq and m=(p-1)(q-1)--------------------------
			reg_p := p_in - "0000000000000001";
			reg_q := q_in - "0000000000000001";
			mul_n := std_logic_vector(to_unsigned( to_integer(unsigned(p_in))* to_integer(unsigned(q_in)),32));
			mul_m := std_logic_vector(to_unsigned( to_integer(unsigned(reg_p))* to_integer(unsigned(reg_q)),32));
			-----------------------checking public key(e) as prime number-------------------
			acc  	:= std_logic_vector(to_unsigned( (to_integer(unsigned(reg_p))* to_integer(unsigned(reg_q))) rem to_integer(unsigned(public_key)),32));
			if (acc = X"0000000000000000") then
				err <= '1';
			else 
				err <= '0';
			end if;
			-------------------------------encrypt data-------------------------------------
			if (cnt < conv_integer(public_key)) then 
				power_result <= std_logic_vector(to_unsigned( to_integer(unsigned(power_result))* to_integer(unsigned(din)),256));

				cnt := cnt + 1 ;
			elsif (cnt = conv_integer(public_key)) then
				cnt := 0;
				encryptdata <= std_logic_vector(to_unsigned( to_integer(unsigned(power_result)) rem to_integer(unsigned(mul_n)),32));
				power_result <= "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
				encryptReady <= '1';
			end if;
			
			---------------------------calculate private key(d)----------------------------------------
			if (encryptReady = '1') then 
				acc2 := std_logic_vector(to_unsigned( (index* to_integer(unsigned(public_key))),32));
				acc3 := std_logic_vector(to_unsigned(to_integer(unsigned(acc2) rem to_integer(unsigned(mul_m))),32));
				if (to_integer(unsigned(acc3)) = 1) then 
					private_key <= std_logic_vector(to_unsigned(index ,32));
					index := 1;
				else 
					index := index + 1;
				end if;
			end if;
			----------------------------------------------------
		end if;
	end process;



end Behavioral;

