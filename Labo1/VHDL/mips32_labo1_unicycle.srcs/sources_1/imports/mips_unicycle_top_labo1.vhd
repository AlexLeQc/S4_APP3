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
use ieee.numeric_std.all;


entity mips_unicycle_top is
Port ( 
	clk 			: in std_logic;
	reset 			: in std_logic;
	o_pc 			: out std_logic_vector (31 downto 0)
	);
end mips_unicycle_top;

architecture Behavioral of mips_unicycle_top is

component controleur is
Port (
    i_Op        : in std_logic_vector(5 downto 0);
    i_funct_field : in std_logic_vector (5 downto 0);
    
    o_RegDst    : out std_logic;
    o_Branch    : out std_logic;
    o_MemRead   : out std_logic;
    o_MemtoReg  : out std_logic;
    o_AluFunct  : out std_logic_vector (3 downto 0);
    o_MemWrite  : out std_logic;
    o_ALUSrc    : out std_logic;
    o_RegWrite  : out std_logic;
	
	-- Sorties supp. vs 4.17
	o_SignExtend : out std_logic
    );
end component;

component mips_datapath_unicycle is
Port ( 
	clk 			: in std_logic;
	reset 			: in std_logic;

	i_alu_funct   	: in std_logic_vector(3 downto 0);
	i_RegWrite    	: in std_logic;
	i_RegDst      	: in std_logic;
	i_MemtoReg    	: in std_logic;
	i_branch      	: in std_logic;
	i_ALUSrc      	: in std_logic;
	i_MemWrite	  	: in std_logic;
	
	i_SignExtend 	: in std_logic;

	o_Instruction 	: out std_logic_vector (31 downto 0);
	o_PC		 	: out std_logic_vector (31 downto 0)
);
end component;

    signal s_alu_funct      : std_logic_vector(3 downto 0);
    signal s_RegWrite       : std_logic;
	signal s_RegDst         : std_logic;
    signal s_MemtoReg       : std_logic;
	signal s_branch         : std_logic;
    signal s_ALUSrc         : std_logic;
	signal s_MemWrite	    : std_logic;
	signal s_SignExtend     : std_logic;

	
    signal s_Instruction    : std_logic_vector(31 downto 0);
    -- champs du registre d'instructions
    signal s_instr_funct     : std_logic_vector(5 downto 0);
    signal s_opcode          : std_logic_vector(5 downto 0);

begin

s_opcode		<= s_Instruction(31 downto 26);
s_instr_funct	<= s_Instruction( 5 downto  0);

-- Contrôles
inst_Controleur: controleur
Port map(
    i_Op            => s_opcode,
    i_funct_field   => s_instr_funct,
    
    o_RegDst    	=> s_RegDst,
    o_Branch    	=> s_branch,
    o_MemRead   	=> open,
    o_MemtoReg  	=> s_MemtoReg,
    o_AluFunct  	=> s_alu_funct,
    o_MemWrite  	=> s_MemWrite,
    o_ALUSrc    	=> s_ALUSrc,
    o_RegWrite  	=> s_RegWrite,
	
	o_SignExtend 	=> s_SignExtend
    );
	
	
-- Chemin de données
inst_Datapath :  mips_datapath_unicycle
Port map( 
	clk 			=> clk,
	reset 			=> reset,

	i_alu_funct   	=> s_alu_funct,
	i_RegWrite    	=> s_RegWrite,
	i_RegDst      	=> s_RegDst,
	i_MemtoReg    	=> s_MemtoReg,
	i_branch      	=> s_branch,
	i_ALUSrc      	=> s_ALUSrc,
	i_MemWrite	  	=> s_MemWrite,
	i_SignExtend 	=> s_SignExtend,
	o_Instruction 	=> s_Instruction,
	o_PC			=> o_PC
);	

end Behavioral;
