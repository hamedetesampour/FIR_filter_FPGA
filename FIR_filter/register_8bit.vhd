
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity shiftReg8 is
	
	--declaring number of input bits
generic (input_bits : integer :=8);
port( in_reg : in std_logic_vector (input_bits-1 downto 0);
		reset, clk	: in std_logic;
		out_reg	: out std_logic_vector (input_bits-1 downto 0));
end shiftReg8;


architecture Behavioral of shiftReg8 is
	--function of the sub-module
begin
process(clk)
begin
	if rising_edge(clk) then
	out_reg <= in_reg;
		if (reset='1') then 
		out_reg <= (others => '0');
		end if;
	end if;
	
end process;
end Behavioral;
