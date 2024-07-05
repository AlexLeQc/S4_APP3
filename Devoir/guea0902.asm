#guea0902
#2024-02-11
#Devoir App3

.data #Declare le segment de donnees

#Metriques trouvees dans le code fourni
metrique1: .word 4, 3, 3, 2,   0, 3, 5, 4,   4, 3, 3, 2,   2, 5, 3, 2 

metrique2: .word 3, 4, 2, 3,   5, 2, 2, 3,   3, 4, 2, 3,   3, 0, 4, 5

metrique3: .word 4, 5, 3, 0,   2, 3, 3, 4,   2, 3, 5, 2,   2, 3, 3, 4  

#Survivant en entree
si: .word 0, 0, 0, 0
si1: .word 2, 0, 2, 2
si2: .word 4, 2, 4, 0
#Survivant en sortie
so: .word 0, 0, 0, 0


.text #Annonce le segment d instruction
.globl main #Pour que le main soit visible dans d autre fichier assembleur

#Fonction main
main:
#Chargement des parametres
    la, $a0, metrique1
    la, $a1, si
    la, $a2, so

    jal CalculSurvivants             #Appel de la fonction CalculSurvivant
    
    #Test unitaire
    #Selon le code fournis, so devrait etre 2,0,2,2
    
    jal CalculSurvivants             #Appel de la fonction CalculSurvivant
    #affiche des donnees pour les comparer avec celles prevues
    li, $v0, 1		#Impression dun entier	
    la, $t0, so		
    lw, $a0, 0($t0)	
    syscall		#print so[0]
    li, $v0, 11
    li, $a0, 32		#espace
    syscall
    li, $v0, 1
    lw, $a0, 4($t0)
    syscall		#print so[1]
    li, $v0, 11
    li, $a0, 32		#espace
    syscall
    li, $v0, 1
    lw, $a0, 8($t0)
    syscall		#print so[2]
    li, $v0, 11
    li, $a0, 32		#espace
    syscall
    li, $v0, 1
    lw, $a0, 12($t0)
    syscall		#print so[3]
    li, $v0, 11
    li, $a0, 10		#\n
    syscall
    
    #La prochaine valeur de so devrait etre 4,2,4,0, en utilisant si1 et metrique2
    #Chargement des parametres
    la, $a0, metrique2
    la, $a1, si1
    la, $a2, so
    
    jal CalculSurvivants
    #affiche des donnees pour les comparer avec celle prevues
    li, $v0, 1
    la, $t0, so
    lw, $a0, 0($t0)
    syscall
    li, $v0, 11
    li, $a0, 32		#espace
    syscall
    li, $v0, 1
    lw, $a0, 4($t0)
    syscall
    li, $v0, 11
    li, $a0, 32		#espace
    syscall
    li, $v0, 1
    lw, $a0, 8($t0)
    syscall
    li, $v0, 11
    li, $a0, 32		#espace
    syscall
    li, $v0, 1
    lw, $a0, 12($t0)
    syscall
    li, $v0, 11
    li, $a0, 10		#\n
    syscall
    
    #La prochaine valeur de so devrait etre 0,4,2,4 en utilisant si2 et metrique3
    #Chargement des parametres
    la, $a0, metrique3
    la, $a1, si2
    la, $a2, so
    
    jal CalculSurvivants
    #affiche des donnees pour les comparer avec celles prevues
    li, $v0, 1
    la, $t0, so
    lw, $a0, 0($t0)
    syscall
    li, $v0, 11
    li, $a0, 32		#espace
    syscall
    li, $v0, 1
    lw, $a0, 4($t0)
    syscall
    li, $v0, 11
    li, $a0, 32		#espace
    syscall
    li, $v0, 1
    lw, $a0, 8($t0)
    syscall
    li, $v0, 11
    li, $a0, 32		#espace
    syscall
    li, $v0, 1
    lw, $a0, 12($t0)
    syscall
    li, $v0, 11
    li, $a0, 10		#\n
    syscall

    #fin du main
    li      $v0     10
    syscall 

#Fonction acs
acs: 	
	addi $t0, $zero, 0	#j
	addi $t1, $zero, 4	#N
#Boucle de la fonction acs
boucle_acs:
	lw $t2, 0($a0)			#metrique
	lw $t3, 0($a1)			#si
	lw $t4, 0($a2)			#so
	
	addu $t5, $t2, $t3		#temp = met[j] + sinput[j]
	
	bleu $t4, $t5, acs_next		#if soutput < temp , on saute la prochaine ligne
	sw $t5, 0($a2)			#*soutput = temp
				
acs_next:
	addiu $a0, $a0, 4		#Pour etre compatible avec le met[j]
	addiu $a1, $a1, 4		#Pour etre compatible avec le sinput[j]
	addiu $t0, $t0, 1		# j++
	
	blt $t0, $t1, boucle_acs	#on refait la boucle si j < N
	
	jr $ra				#fin de la fonction
	

#Fonction CalculSurvivants
CalculSurvivants:
	addi $t0, $zero, 0	#i
	addi $t1, $zero, 4	#N
	
	move $t4, $a0 		#assigner les valeurs a des registres
	move $t5, $a1
	move $t6, $a2 
	
boucle_CS:
	
	addi $t2, $zero, 250	#on garde en memoire la valeur 250
	sw $t2, 0($t6)		#soutput[i] = 250
	
	move    $t2     $t4 
	
	sll $t3, $t0, 4		#i * N
	addu $a0,$t2, $t3 	#met[i*N]
	
	#Pile pour lutilisation des donnees
	subiu $sp, $sp, 24	#reserver de lespace sur la pile
	sw, $t0, 0($sp)
    	sw, $t1, 4($sp)
    	sw, $ra, 8($sp)
    	sw, $t4, 12($sp)
    	sw, $t5, 16($sp)
   	sw, $t6, 20($sp)
		
	move, $a1, $t5		#sinput
    	move, $a2, $t6 		#souput

	jal acs 		#fonction asc
	
	lw, $t6, 20($sp)
    	lw, $t5, 16($sp)
   	lw, $t4, 12($sp)
    	lw, $ra, 8($sp)
    	lw, $t1, 4($sp)
    	lw, $t0, 0($sp)
    	addiu, $sp, $sp, 24 
	
	addiu $t6, $t6, 4 	#Pour etre compatible avec le souput[i]
	
	addiu $t0, $t0, 1	#i++
	
	blt $t0, $t1, boucle_CS	#on refait la boucle si i < N
	jr $ra			#fin de la fonction	
