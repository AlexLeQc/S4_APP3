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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.MIPS32_package.all;

entity controleur is
Port (
    i_Op         	: in std_logic_vector(5 downto 0);
    i_funct_field	: in std_logic_vector (5 downto 0);
		
    o_RegDst     	: out std_logic;
    o_Branch     	: out std_logic;
    o_MemRead    	: out std_logic;
    o_MemtoReg   	: out std_logic;
    o_AluFunct   	: out std_logic_vector (3 downto 0);
    o_MemWrite   	: out std_logic;
    o_ALUSrc     	: out std_logic;
    o_RegWrite   	: out std_logic;
	
	-- Sorties non montrées dans la figure 4.17
	o_SignExtend 	: out std_logic
    );
end controleur;

architecture Behavioral of controleur is

    signal s_R_funct_decode   : std_logic_vector(3 downto 0);

begin

    -- Contrôles pour les différents types d'instructions
    -- Actuellement, seulement les instructions "R"
    process( i_Op, s_R_funct_decode )
    begin
        
        case i_Op is
			-- pour tous les types R
            when OP_Rtype => 
                o_AluFunct <= s_R_funct_decode;
				
			-- pour les autres instructions (I/J)...
             when OP_ADDI =>
				o_AluFunct <= s_R_funct_decode;
				
				
            when others =>
                o_AluFunct <= (others => '0');
        end case;
    end process; 
    
    -- Commande à l'ALU pour les instructions "R"
    process(i_funct_field)
    begin
        case i_funct_field is
            when ALUF_AND => 
                s_R_funct_decode <= ALU_AND;
            when ALUF_OR => 
                s_R_funct_decode <= ALU_OR;
            when ALUF_NOR =>
                s_R_funct_decode <= ALU_NOR;
            when ALUF_ADD => 
                s_R_funct_decode <= ALU_ADD;
            when ALUF_SUB => 
                s_R_funct_decode <= ALU_SUB;                
            when ALUF_SLL => 
                s_R_funct_decode <= ALU_SLL;  
            when ALUF_SRL => 
                s_R_funct_decode <= ALU_SRL; 
            when ALUF_ADDU => 
                s_R_funct_decode <= ALU_ADD;
            when ALUF_SLT => 
                s_R_funct_decode <= ALU_SLT; 
            when ALUF_SLTU => 
                s_R_funct_decode <= ALU_SLTU; 
            when ALUF_ADDI =>
                s_R_funct_decode <= ALU_ADDI;
            -- à compléter au besoin avec d'autres instructions
            when others =>
                s_R_funct_decode <= ALU_NULL;
         end case;
     end process;
	
	o_RegWrite		<= '1' when i_Op = OP_Rtype 
						else '0';
	
	o_RegDst <= '0';
	o_ALUSrc <= '0';
	o_Branch <= '0';
	o_MemRead <= '0';
	o_MemWrite <= '0';
	o_MemtoReg <= '0';
	o_SignExtend	<= '0';
	o_SignExtend	<= '1' when i_OP = OP_ADDI 
	                       else '0';
    

end Behavioral;
