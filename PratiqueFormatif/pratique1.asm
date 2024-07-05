.data 

arr: .word 3,2,1,1,7,5,0
ARRAY_size: .word 7


.text 
.globl main

main:
	
la $a0, arr
la $a1, ARRAY_size

jal bubbleSort

li, $v0, 1		#Impression dun entier	
    la, $t0, arr		
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
	
li      $v0     10
syscall 	


swap:

lw $t4, 0($a0)
lw $t5, 4($a0)
sw $t4, 4($a0)
sw $t5, 0($a0)     
jr $ra  




bubbleSort:

	subiu $sp, $sp, 24
	sw $ra, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s0, 16($sp)
	sw $s5, 20($sp)
	
	addi $s0, $zero, 0	#i
	lw $s3, 0($a1)		#n
	subi $s3, $s3, 1	#n -1	
	
boucle1bubble:

	blt $s3, $s0, boucle1fin
	
	blt $zero, $s0, recommence
	addi $s1, $zero, 0	#j
	move $s2, $a0		#arr[j]
				#arr[j+1]
	
	
	addiu $s0, $s0, 1	#i++
	
	
boucle2bubble:

	sub $s4, $s3, $s0	#n-i-1
	blt $s4, $s1, boucle1bubble
	
	lw $t1, 0($a0)		#arr[j]
	lw $t2, 4($a0)
	
	blt $t2, $t1, condition
	
	addi $s1, $s1, 1	#j++
	
	addiu $a0, $a0, 4	
	
	jal boucle2bubble

condition:
	
	jal swap
	
	addi $s1, $s1, 1	#j++
	
	addiu $a0, $a0, 4
	
	jal boucle2bubble


boucle1fin:
	lw $s5, 20($sp)
	lw $s0, 16($sp)
	lw $s3, 12($sp)
	lw $s2, 8($sp)
	lw $s1, 4($sp)
	lw $ra, 0($sp)
	addiu, $sp, $sp, 24
	jr $ra
	
recommence:
	
	sll $t4, $s1, 2
	subu $a0, $a0, $t4
	addi $s1, $zero 0	#j
	move $s2, $a0		#arr[j]
				#arr[j+1]
	
	
	addiu $s0, $s0, 1	#i++
	jal boucle2bubble
	
	
	
	







