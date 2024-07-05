---------------------------------------------------------------------------------------------
--
--	Université de Sherbrooke 
--  Département de génie électrique et génie informatique
--
--	S4i - APP4 
--	
--
--	Auteur: 		Marc-André Tétrault
--					Daniel Dalle
--					Sébastien Roy
-- 
---------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MIPS32_package.all;

entity alu is
Port ( 
	i_a          : in std_logic_vector (127 downto 0);
	i_b          : in std_logic_vector (127 downto 0);
	i_alu_funct  : in std_logic_vector (3 downto 0);
	i_shamt      : in std_logic_vector (4 downto 0);
	o_result     : out std_logic_vector (127 downto 0);
	o_multRes    : out std_logic_vector (255 downto 0);
	o_zero       : out std_logic
	);
end alu;

architecture comport of alu is
    
    signal decale 			: unsigned( 4 downto 0);
    signal s_result 		: std_logic_vector (127 downto 0);
    signal s_multRes 		: std_logic_vector (255 downto 0);
    signal s_unsupported    : std_logic;
	
begin
    -- conversion de type
    decale <= unsigned(i_shamt);
    
    -- decodage et exécution de l'opération
    process(i_alu_funct, i_a, i_b, decale)
    begin
        s_unsupported <= '0';
        case i_alu_funct is
            when ALU_AND => 
                s_result <= i_a and i_b;
            when ALU_OR => 
                s_result <= i_a or i_b;
            when ALU_NOR => 
                s_result <= i_a nor i_b;
            when ALU_ADD => 
                s_result <= std_logic_vector(signed(i_a) + signed(i_b));
            when ALU_SUB => 
                s_result <= std_logic_vector(signed(i_a) - signed(i_b));
            when ALU_SLL => 
                s_result <= std_logic_vector(signed(i_b) sll to_integer( decale ));  
            when ALU_SRL => 
                s_result <= std_logic_vector(signed(i_b) srl to_integer( decale )); 
			when ALU_SLL16 =>
				s_result <= std_logic_vector(signed(i_b) sll 16 ); 
            when ALU_SLT => 
                if(signed(i_a) < signed(i_b)) then
                    s_result <= X"00000000000000000000000000000001";      
                else
                    s_result <= X"00000000000000000000000000000000";
                end if;
            when ALU_SLTU => 
                if(unsigned(i_a) < unsigned(i_b)) then
                    s_result <= X"00000000000000000000000000000001";      
                else
                    s_result <= X"00000000000000000000000000000000";
                end if;
            when ALU_MULTU =>
                s_multRes <= std_logic_vector(unsigned(i_a) * unsigned(i_b));
            when ALU_NULL => 
				s_result <= (others => '0');
			when ALU_MIV =>
			    s_result <= i_b;
			     for i in 0 to 3 loop
			         --Compare les valeurs du vecteurs avec la valeur de départ et prend la plus petites d'entre elle
			         if unsigned(i_a(i*32+31 downto i*32)) < unsigned(s_result) then
			             s_result(31 downto 0) <= i_a(i*32+31 downto i*32);
			         end if;
			     end loop;
			when ALU_ADDV =>
			     for i in 0 to 3 loop
                    -- Itere au travers des 4 entiers et on les additionne
                    s_result(i*32+31 downto i*32) <= std_logic_vector(unsigned(i_a(i*32+31 downto i*32)) + unsigned(i_b(i*32+31 downto i*32)));
                    
                    -- Cas ou il y a un overflow, on met la valeur max qui est 127
                    if s_result(i*32+31) = '1' then
                        s_result(i*32+31 downto i*32) <= "01111111111111111111111111111111";
                    end if;
                end loop;
            when others =>
                s_result <= i_a and i_b;
                s_unsupported <= '1';
         end case;
     end process;
     
     -- sorties spéciales, utiles pour certaines instructions
     o_zero <= '1' when (signed(s_result) = 0) else '0';
	 o_result <= s_result;
	 o_multRes <= s_multRes;
            
end comport;
