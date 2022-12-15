----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:50:39 06/09/2022 
-- Design Name: 
-- Module Name:    FIR_module - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity FIR_module is

--constant value of filter

generic (input_bits	: integer := 8;
			output_bits	: integer := 16;
			coeff_bits	: integer := 8;
			order			: integer := 11);

--input & output declaration

port( in_data : in std_logic_vector (input_bits-1 downto 0);
		clk	  : in std_logic;
		reset	  : in std_logic;
		out_data: out std_logic_vector (output_bits-1 downto 0));

end FIR_module;


architecture Behavioral of FIR_module is

--store input data using 8-bit register
component shiftReg8
	generic(input_bits : integer :=8 );
	port( in_reg		: in std_logic_vector (input_bits-1 downto 0);
		   reset : in std_logic;
		   clk	  : in std_logic;
		   out_reg	: out std_logic_vector(input_bits-1 downto 0));
end component;

--declaring system variables for desired filter
--coefficients of SINC function in order of 11(function used for the filter)
type coeff_type is array (1 to order) of std_logic_vector(coeff_bits-1 downto 0);
constant coeffs: coeff_type :=	(X"F1",
											 X"F3",
											 X"07",
											 X"26",
											 X"42",
											 X"4E",
											 X"42",
											 X"26",
											 X"07",
											 X"F3",
											 X"F1");

--for filter multiply coeffs to previous inputs and adds them together:
--so we need a shift register because of previose datas
--and we need a mulplier register
--and we neea a addign register

type shift_reg_type is array (0 to order-1) of std_logic_vector (input_bits-1 downto 0);
signal shift_reg : shift_reg_type;

type multp_reg_type is array (0 to order-1) of std_logic_vector (input_bits + coeff_bits -1 downto 0);
signal multp_reg : multp_reg_type;

type add_reg_type is array (0 to order-1) of std_logic_vector (input_bits + coeff_bits -1 downto 0);
signal add_reg : add_reg_type;

--main architecture function

begin

--initial values of above registers:
shift_reg(0) <= in_data;
multp_reg(0) <= in_data * coeffs(1);
add_reg(0) <= in_data * coeffs(1);

function_fir: for i in 0 to order-2 generate
	begin

--portmap of shift register 8 bit

	shiftReg8_comp : shiftReg8 generic map (input_bits => 8)
		port map( clk => clk,
					 reset => reset,
					 in_reg => shift_reg(i),
					 out_reg => shift_reg(i+1));
					 
--equation of multiplection function register:
multp_reg(i+1) <= shift_reg (i+1) * coeffs(i+2);

--equation of add functino register:
add_reg(i+1) <= add_reg(i)+ multp_reg(i+1);
end generate function_fir;

--send data to ouput
out_data <= add_reg(order-1);

end Behavioral;

