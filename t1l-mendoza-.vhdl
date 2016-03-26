-- Program Description: Programming assignment for CMSC 132

-- extension
library IEEE; 
use IEEE.std_logic_1164.all;

-- input / output for vhdl program
entity robber_buzzer is
	port(
		alarm: 		out std_logic;
		night:  	in std_logic;
		in_buzzer:  in std_logic_vector(2 downto 0);
		out_buzzer: in std_logic_vector(2 downto 0)
	);
end entity robber_buzzer;

-- architecture definition
architecture alarm of robber_buzzer is
begin
	process (night, in_buzzer(2), in_buzzer(1), in_buzzer(0), out_buzzer(2), out_buzzer(1), out_buzzer(0)) is
	begin
		if(night = '0') then
			alarm <= '0';
		else
			if(
				(in_buzzer(0) = '1' or in_buzzer(1) = '1' or in_buzzer(2) = '1')
			) then
				if (out_buzzer(0) = '1' or out_buzzer(1) = '1' or out_buzzer(2) = '1') then
					alarm <= '1';
				else 
					alarm <= '0';
				end if;
			else
				alarm <= '0';
			end if;
		end if;
	end process;
end architecture alarm;
