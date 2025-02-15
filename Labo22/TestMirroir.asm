# TestProcesseurs.asm
# Code pour tester les architectures mips
# M-A Tétrault Mars 2020
# Dept. GE & GI U. de S. 
#
# Reference laboratoire No 1 APP 4 S4 g. info 2020 b
#
# Fonction: 
# Execution: 
#
# Ce code contient les pseudo instructions déjà développées en instructions normales


.data 0x10010000
TableDonnees:  .word 0x12345678, 0x87654321, 0xBAD0FACE, 1, 2, 3, 4, 5, 6, 0x5555CCCC, 0, 0, 0, 0, 0, 0

.text 0x400000

.globl main

main: 
    addi $s0, $zero, 0x24
    lui $at, 0x1001         # lw $a0, TableDonnees($s0) décomposé
    addu $at, $at, $s0
    lw $a0, 0($at)
    add $t9, $zero, $a0     # pour voir bulle avec winmips64

    jal miroir32
    j end

miroir32:                   # fonction renverser $a0 - > $v0
                            # renverser l'ordre des bits
                            # de $a0. (32 bits)
                            # résultat dans $v0
    add $t2, $a0, $0        # valeur a renverser dans $t2
    add $v0, $0, $0         # resultat a construire dans $v0
    addi $t4, $0, -1        # cste -1
    # li $t3, 0x80000000    # (pseudo instruction, changement manuel)
    ori $t3, $zero, 0x8000
    sll $t3, $t3, 16
    addi $t1, $0, 32        # compteur = N-1
bclerv32:                   # boucle k = 1 a N (k implicite)
    beq $t1, $zero, finMirroir32
    srl $v0, $v0, 1
    and $t0, $t2, $t3       # masque du bit parvenu a position 2**N
    or $v0, $v0, $t0        # place le bit dans le résultat
    sll $t2, $t2, 1         # decalage gauche k position: 1, 2,... N
    addi $t1, $t1, -1       # compteur--
    j bclerv32
finMirroir32:
    jr $ra # fin miroir
    
    
end:
    add $a1, $v0, $zero	    # move
    addi $s0, $s0, 4        # case mémoire suivante
    lui $at, 0x1001          # sw $v0, TableDonnees($s0) décomposé
    addu $at, $at, $16        #
    sw $v0, 0($at)            #
    addi $v0, $zero, 10     # fin du programme
    syscall
