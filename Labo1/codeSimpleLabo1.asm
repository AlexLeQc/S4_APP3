# calculs_de_base.asm
# Programme servant d'exemple pour organisation avec instructions R seules
# M.-A. Tétrault
# Dept. GE & GI U. de S. 
#
# Reference laboratoire No 1 APP 4 S4 g. info 2021
#
# Programme servant à valider la procédure d'encodage en langage machine et 
# comme comportement initial au processeur simplifié.
# 
# Il n'y a pas d'objectifs particulier, autre que changer les valeurs
# dans le banc de registres.
# 
# Code limité aux instruction supportées au laboratoire 1:
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
    # Initialisation sans instructions immédates
    nor $t0, $zero, $zero # mettre $t0 à 0xFFFF_FFFF

    
    li $v0, 10
    syscall             # fin du programme
