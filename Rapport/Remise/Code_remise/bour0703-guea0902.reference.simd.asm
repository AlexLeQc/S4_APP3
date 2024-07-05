# ReferenceStandard_ProduitMatrice.asm
# Code pour calculer une performance de référence.
# M-A Tétrault Mars 2023
# Dept. GE & GI U. de S. 
#
# Problématique/Rapport
#
# Fonction: 
# Execution: 
#
# Ce code contient certaines instructions �  adressage non supporté, que MARS développe en plusieurs instructions..
# Il y en a trois, lesquelles?
.data 0x10010000

vec_entree: .word 1,2,3,4
vec_sortie: .word 0,0,0,0
vec_temp: .word 0,0,0,0
mat_A: .word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
            
               
.text 0x400000
.eqv N 4

main:
    # pas de fonctions, donc pas de protection des registres
    li $s0, 0               # i = 0
    li $s1, N
    
    lwv $s2, vec_entree
    lwv $s3, vec_sortie
    lwv $s5, vec_temp

boucle_externe:
    beq  $s0, $s1, finBoucleExterne
    
    # Chargement d'une ligne de la matrice A
    sll $t4, $s0, 2
    lwv $s4, mat_A($t4)
    
    
    # Multiplication vectorielle
    mulv $t4($s5), $s2, $s4
    
    # Addition vectorielle
    addv $s3, $s3, $s5
    
    # Stockage de la ligne de Y
    swv $s3, vec_sortie($t4)
    
    sw $zero, $t4($s5)
    
    # Incr�mentation du compteur de ligne
    addi $s0, $s0, 1

    j boucle_externe
    
finBoucleExterne:
    addi $v0, $zero, 10     # fin du programme
    syscall
