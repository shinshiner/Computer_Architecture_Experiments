--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:09:59 04/05/2017
-- Design Name:   
-- Module Name:   E:/codes/lab3/test_for_Ctr.vhd
-- Project Name:  lab3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Ctr
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
 
ENTITY test_for_Ctr IS
END test_for_Ctr;
 
ARCHITECTURE behavior OF test_for_Ctr IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Ctr
    PORT(
         opCode : IN  std_logic_vector(5 downto 0);
         regDst : OUT  std_logic;
         aluSrc : OUT  std_logic;
         memToReg : OUT  std_logic;
         regWrite : OUT  std_logic;
         memRead : OUT  std_logic;
         memWrite : OUT  std_logic;
         branch : OUT  std_logic;
         aluOp : OUT  std_logic_vector(1 downto 0);
         jump : OUT  std_logic
        );
    END COMPONENT;
    
	 initial begin
		opCode = 0;
		
		#100;
		
		#100 opCode = 6'000010;

   --Inputs
   signal opCode : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal regDst : std_logic;
   signal aluSrc : std_logic;
   signal memToReg : std_logic;
   signal regWrite : std_logic;
   signal memRead : std_logic;
   signal memWrite : std_logic;
   signal branch : std_logic;
   signal aluOp : std_logic_vector(1 downto 0);
   signal jump : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Ctr PORT MAP (
          opCode => opCode,
          regDst => regDst,
          aluSrc => aluSrc,
          memToReg => memToReg,
          regWrite => regWrite,
          memRead => memRead,
          memWrite => memWrite,
          branch => branch,
          aluOp => aluOp,
          jump => jump
        );

   -- Clock process definitions
   <clock>_process :process
   begin
		<clock> <= '0';
		wait for <clock>_period/2;
		<clock> <= '1';
		wait for <clock>_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
