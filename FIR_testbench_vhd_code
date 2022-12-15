
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;


 
ENTITY FIR_testbench IS
END FIR_testbench;
 
ARCHITECTURE behavior OF FIR_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FIR_module is 
	 generic(input_bits 	: integer :=8 ;
				output_bits : integer :=16 ;
				coeff_bits  : integer :=8 ;
				order	  		: integer :=11 );
    PORT(
         in_data : IN  std_logic_vector(input_bits-1 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         out_data : OUT  std_logic_vector(output_bits-1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_data : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal out_data : std_logic_vector(15 downto 0) := (others => '0');

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FIR_module 
	generic map( input_bits  => 8,
					 output_bits => 16,
					 coeff_bits  => 8,
					 order	    => 11)
	PORT MAP (
          in_data => in_data,
          clk => clk,
          reset => reset,
          out_data => out_data
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	

		
		in_data <= "00000000";
		wait for 180 ns;
		
		in_data <= "00000001";
		wait for 20 ns;
		
		in_data <= "00000010";
		wait for 20 ns;
		
		in_data <= "00000011";
		wait for 20 ns;
		
		in_data <= "00000100";
		wait for 20 ns;
		
		in_data <= "00000101";
		wait for 20 ns;
		
		in_data <= "00000110";
		wait for 20 ns;
		
		in_data <= "00000111";
		wait for 20 ns;
		
		in_data <= "00001000";
		wait for 20 ns;
		
		in_data <= "00001001";
		wait for 20 ns;

		in_data <= "00001010";
		wait for 20 ns;
		
		wait;
		
		

   end process;

END;
