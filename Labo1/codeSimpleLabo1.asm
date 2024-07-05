# calculs_de_base.asm
# Programme servant d'exemple pour organisation avec instructions R seules
# M.-A. T�trault
# Dept. GE & GI U. de S. 
#
# Reference laboratoire No 1 APP 4 S4 g. info 2021
#
# Programme servant � valider la proc�dure d'encodage en langage machine et 
# comme comportement initial au processeur simplifi�.
# 
# Il n'y a pas d'objectifs particulier, autre que changer les valeurs
# dans le banc de registres.
# 
# Code limit� aux instruction support�es au laboratoire 1:
# and
# or
# nor
# add
# sll
# srl
#

# Debut de la section code
.text
.globl main
main:
    # Initialisation sans instructions imm�dates
    nor $t0, $zero, $zero # mettre $t0 � 0xFFFF_FFFF

    
    li $v0, 10
    syscall             # fin du programme
