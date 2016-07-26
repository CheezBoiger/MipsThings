	# Simulates a car test.
	.data 0x10000000
	.asciiz	"mph"	
	.asciiz	"\n"	# + 4 
	.asciiz "\n\n"	# + 6
	.asciiz "\ncar acel\n" # + 9
	.asciiz "\ncar brak\n" # + 20
	.asciiz "\ncar crash\n" # + 31
	.asciiz "Airbag no deploy\n" # + 43
	.asciiz "Airbags deployed\n" # + 61
	.asciiz "Airbags deploy Ambulance no alert\n" # + 79
	.asciiz "Airbags deploy Ambulance alerted!\n" # + 114
	.asciiz "S" # + 149
	.asciiz "Welcome to Car simulator.\n" # + 151 
	.globl main
	.text

# Start the main function.
main:
	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 151
	syscall

	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 20
	syscall

	# Our speed.
	ori	$s1, $0, 0

	# Our acceleration. mph^2
	ori	$s2, $0, 1

	# Our decceleration. mph^2
	ori	$s3, $0, 1
	
polk:
	lui	$s0, 0xffff
	lw	$t0, 0($s0)
	andi	$t0, $t0, 0x0001
	ori	$t9, $0, 0
	beq	$t0, $t9, polk
	lw	$t1, 4($s0)
	andi	$t1, $t1, 0x00ff

	addi	$t5, $0, 65
	addi	$t6, $0, 97

	beq	$t1, $t6, accel
	bne	$t1, $t5, cont1

accel:	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 9
	syscall

	add	$s1, $s1, $s2
	j	polm
cont1:	addi	$t5, $0, 66
	addi	$t6, $0, 98

	beq	$t1, $t5, brake
	bne	$t1, $t6, cont2

brake:	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 20
	syscall

	beq	$s1, $0, polm
	sub	$s1, $s1, $s2
	j	polm

cont2:	addi	$t5, $0, 83
	addi	$t6, $0, 115

	beq	$t1, $t5, speed
	bne	$t1, $t6, cont3

speed:	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 4
	syscall
	
	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 149
	syscall

	addi	$v0, $0, 1
	addi	$a0, $s1, 0
	syscall

	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 149
	syscall
	
	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 4
	syscall
	j 	polm
	
cont3:	addi	$t5, $0, 67
	addi	$t6, $0, 99

	beq	$t1, $t5, crash
	bne	$t1, $t6, polm

crash:	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 31
	syscall

	slti	$t7, $s1, 16
	beq	$t7, $0, check_danger1

	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 43
	syscall
	j	polm

check_danger1:
	slti	$t7, $s1, 45
	beq	$t7, $0, check_danger2

	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 4
	syscall
	
	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 61
	syscall
	
	j	polm

check_danger2:
	j 	polm
	
polm:	lw	$t0, 8($s0)
	andi	$t0, $t0, 0x0001
	beq	$t0, $t9, polm
	sw	$t1, 0xc($s0)
	j	polk

	
