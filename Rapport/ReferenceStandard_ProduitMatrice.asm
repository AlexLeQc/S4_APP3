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
# Ce code contient certaines instructions à adressage non supporté, que MARS développe en plusieurs instructions..
# Il y en a trois, lesquelles?
.data 0x10010000

vec_entree: .word 1,2,3,4
vec_sortie: .word 0,0,0,0
mat_A: .word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
            
               
.text 0x400000
.eqv N 4

main:
    # pas de fonctions, donc pas de protection des registres
    li $s0, 0               # i = 0
    li $s2, N

boucle_externe:
    beq  $s0, $s2, finBoucleExterne
    add  $t0, $zero, $zero  # y[i] = 0
    li   $s1, 0             # j = 0

    boucle_interne:
        beq $s1, $s2, finBoucleInterne # for j < 4
        sll $t4, $s1, 2          # décalage pour adresse en mots
        lw  $t1, vec_entree($t4) # lecture de x[j]
        
        # Lecture de A[i][j]
        #       indice == i + j*N et N == 4
        sll $t4, $s0, 2     # i*4
        add $t4, $t4, $s1   # i*4+j
        sll $t4, $t4, 2     # décalage [i*4+j] (adresse en mots)
        lw  $t2, mat_A($t4) # lecture de A[i][j]
        
        multu $t1, $t2      # A[i][j] * x[j]
        mflo $t1            # récupération des 32 1ers bits
        
        add $t0, $t0, $t1   # y[i] = y[i] + A[i][j] * x[j]
        addi $s1, $s1, 1    # j++
        j boucle_interne    # 
    
finBoucleInterne:
    sll $t1, $s0, 2         # décalage en octets de y[i]
    sw $t0, vec_sortie($t1) # écriture de y[i]
    addi $s0, $s0, 1        # i++
    j boucle_externe  
    
finBoucleExterne:
    addi $v0, $zero, 10     # fin du programme
    syscall
    
    
    




