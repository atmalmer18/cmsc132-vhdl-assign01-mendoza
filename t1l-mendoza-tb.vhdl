library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity robber_buzzer_tb is
	constant MAX_COMB: integer := 16;
	constant DELAY: time := 10 ns;
end entity robber_buzzer_tb;

architecture tb of robber_buzzer_tb is
	signal alarm: std_logic;
	signal night: std_logic;
	signal in_buzzer: std_logic_vector(2 downto 0);
	signal out_buzzer: std_logic_vector(2 downto 0);

	component robber_buzzer is
		port(
			alarm: 		out std_logic;
			night:  	in std_logic;
			in_buzzer:  in std_logic_vector(2 downto 0);
			out_buzzer: in std_logic_vector(2 downto 0)
		);
	end component robber_buzzer;
	
begin
	UUT: component robber_buzzer port map(alarm, night, in_buzzer, out_buzzer);
	
	main: process is
		variable temp: unsigned(5 downto 0);
		variable tempTime: unsigned(0 downto 0);
		variable expected_alarm: std_logic;
		variable error_count: integer := 0;
		
	begin 
		report "Start simulation.";
		
		for count in 0 to 63 loop
			temp := TO_UNSIGNED(count, 6);
			in_buzzer(2) <= std_logic(temp(0));
			in_buzzer(1) <= std_logic(temp(1));				
			in_buzzer(0) <= std_logic(temp(2));
			out_buzzer(2) <= std_logic(temp(3));
			out_buzzer(1) <= std_logic(temp(4));				
			out_buzzer(0) <= std_logic(temp(5));
			
			tempTime := TO_UNSIGNED(count, 1);
			night <= std_logic(temp(5));

			if(
				in_buzzer = "000" or
				out_buzzer = "000" or
				night = '0'
			) then
				expected_alarm := '0';
			elsif(night = '1') then
				expected_alarm := '1';
			else
				expected_alarm := '1';
			end if;
			
			wait for DELAY;
			
			assert(expected_alarm /= alarm)
				report "ERROR: Expected alarm " &
					std_logic'image(expected_alarm) & 
					" and instead got " &
					std_logic'image(expected_alarm) &
					" at time " & time'image(now);
					
			if(expected_alarm/=alarm) then
			    error_count := error_count + 1;
			end if;
		end loop;
		
		wait for DELAY;
		
		assert (error_count=0)
			report "ERROR: There were " & 
				integer'image(error_count) & " errors!";
				
		if(error_count=0) then
			report "Simulation completed with NO errors.";
		end if;
		
		wait;
	end process;
end architecture tb;
