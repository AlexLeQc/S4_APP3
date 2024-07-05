#guea0902
#2024-02-11
#Devoir App3

.data #Declare le segment de donnees

#Metriques trouvees dans le code fourni
metrique: .word 4, 3, 3, 2,   0, 3, 5, 4,   4, 3, 3, 2,   2, 5, 3, 2 

#Survivant en entree
si: .word 0, 0, 0, 0
#Survivant en sortie
so: .word 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff


.text #Annonce le segment d instruction
.globl main #Pour que le main soit visible dans d autre fichier assembleur

#Fonction main
main:
#Chargement des parametres
    la, $a0, metrique
    la, $a1, si
    la, $a2, so
    
    jal acs		#Appel de la fonction ACS
   
    #fin du main
    li      $v0     10
    syscall 

#Fonction acs qui regroupe la fonction calcul survivant avec les instructions SIMD
acs: 	
	addi $t0, $zero, 0	#j
	addi $t1, $zero, 4	#N
	
	lwv $s1, 0($a0)		#si
#Boucle de la fonction acs
boucle_acs:
	lwv $s0, 0($a0)			#metrique
	
	addu $s2, $s0, $s1		#temp = met[j] + sinput[j]
	
	miv $t2, $s0			#NOUVELLE INSTRUCTION (nous n'avons pas penser � la mettre dans notre plan de v�rification formatif, on va le rajouter pour la valide)
					#On prend la valeur la plus petite dans le vecteur 
	
	sw $t5, 0($a2)			#*soutput = temp
	

	addiu $a0, $a0, 16		#Pour etre compatible avec le met[i]
	addiu $a2, $a2, 4		#Pour etre compatible avec le soutput[i]
	addiu $t0, $t0, 1		# i++
	
	blt $t0, $t1, boucle_acs	#on refait la boucle si i < N
	
	jr $ra				#fin de la fonction
	

	


