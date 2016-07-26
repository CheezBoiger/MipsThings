	# data files.
	.data 0x10000000
pi:	.double	3.141592653593							# 0x10000000
	.asciiz	"Welcome to this cool program!\n\nChoose an option.\n\n"	# 0x10000008
	.asciiz "1. Calculate Area of a circle.\n"				# + 59
	.asciiz "2. Calculate Circumference of a Circle.\n"			# + 91
	.asciiz "3. Calculate Area of a rectangle.\n"				# + 132 
	.asciiz "4. Calculate Perimeter of a rectangle.\n"			# + 167
	.asciiz "5. Exit Program.\n"						# + 207
	.asciiz	"Input: "							# + 225
	.asciiz "Program has exited!\n"						# + 233
	.asciiz "Returning to menu.\n\n"					# + 254
	.asciiz "Input does not match any options.\n"				# + 275
	.asciiz	"Input radius: "						# + 310
	.asciiz "Area of circle is: "						# + 325
	.asciiz "Input length: "						# + 345
	.asciiz "Input width: "							# + 360
	.asciiz "Circumference of circle is: "					# + 374
	.asciiz "Area of rectangle is: " 					# + 403
	.asciiz "Perimeter of rectangle is: "					# + 426
	.asciiz "\n"								# + 454
	.asciiz "\n\n"								# + 456
	
	.text
main:
	# Welcome Text.
	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 8
	syscall

loop:
	# Display options available to user.
	jal	option_1
	jal	option_2
	jal	option_3
	jal	option_4
	jal	option_5
	jal	get_user_input

	# Start our if statement.
	ori	$t0, $0, 1
	bne	$v0, $t0, check2
	jal	area_circle
	j	final

check2:
	addi	$t0, $t0, 1
	bne	$v0, $t0, check3
	jal	circumference_circle
	j	final

check3:
	addi	$t0, $t0, 1
	bne	$v0, $t0, check4
	jal	area_rectangle
	j	final

check4:
	addi	$t0, $t0, 1
	bne	$v0, $t0, check5
	jal	perimeter_rectangle
	j	final

check5:
	addi	$t0, $t0, 1
	bne	$v0, $t0, check6
	j	exit

check6:
	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 275
	syscall

final:
	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 254
	syscall
	j	loop

	# Just in case something goes wrong.
	j 	exit

# Displays option 1.
option_1:
	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 59
	syscall
	jr	$ra

# Displays option 2.
option_2:
	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 91
	syscall
	jr	$ra

# Display option 3.
option_3:
	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 132
	syscall
	jr	$ra
	
# Display option 4.
option_4:
	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 167
	syscall
	jr	$ra

# Display option 5.
option_5:
	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 207
	syscall
	jr	$ra

# Get the user input.
get_user_input:
	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 225
	syscall
	# Grab user input
	addi	$v0, $0, 5
	syscall
	# User input in $v0
	jr	$ra

# Calculate the Area of a circle.
area_circle:
	add	$t0, $ra, $0
	jal	option_1
	add	$ra, $t0, $0

	# display a request for radius.
	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 310
	syscall

	# Get user input
	addi	$v0, $0, 6
	syscall

	# Get pi.
	lui	$a0, 0x1000
	lwc1	$f2, 0($a0)
	lwc1	$f3, 4($a0)

	# A = pi * r^2
	cvt.d.s	$f0, $f0
	mul.d	$f0, $f0, $f0
	mul.d	$f0, $f0, $f2
	cvt.s.d	$f0, $f0

	# Display answer.
	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 325
	syscall

	addi	$v0, $0, 2
	mov.s	$f12, $f0
	syscall

	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 456
	syscall
	
	jr	$ra

# Calculate the Circumference of a circle.
circumference_circle:
	add	$t0, $ra, $0
	jal	option_2
	add	$ra, $t0, $0

	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 310
	syscall

	addi	$v0, $0, 6
	syscall

	# Get pi.
	lui	$a0, 0x1000
	lwc1	$f2, 0($a0)
	lwc1	$f3, 4($a0)

	# C = 2 * pi * r
	cvt.d.s	$f0, $f0
	add.d	$f0, $f0, $f0
	mul.d	$f0, $f0, $f2
	cvt.s.d	$f0, $f0

	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 374
	syscall

	addi	$v0, $0, 2
	mov.s	$f12, $f0
	syscall

	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 456
	syscall
	
	jr	$ra

# Calculate the Area of a rectangle.
area_rectangle:
	add	$t0, $ra, $0
	jal	option_3
	add	$ra, $t0, $0

	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 345
	syscall
	
	# Grab our double!
	addi	$v0, $0, 7
	syscall

	# length
	mov.d	$f2, $f0

	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 360
	syscall
	
	addi	$v0, $0, 7
	syscall

	# A = l * w
	mul.d	$f0, $f0, $f2

	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 403
	syscall

	addi	$v0, $0, 3
	mov.d	$f12, $f0
	syscall

	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 456
	syscall
	
	jr	$ra

# Calculate the perimeter of a rectangle.
perimeter_rectangle:
	add	$t0, $ra, $0
	jal	option_4
	add	$ra, $t0, $0

	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 345
	syscall

	addi	$v0, $0, 7
	syscall

	# length
	mov.d	$f2, $f0

	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 360
	syscall

	# width
	addi	$v0, $0, 7
	syscall

	# P = 2 * l + 2 * w
	add.d	$f0, $f0, $f0
	add.d	$f2, $f2, $f2
	add.d	$f12, $f0, $f2

	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 374
	syscall

	addi	$v0, $0, 3
	syscall

	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 456
	syscall
	
	jr	$ra

# Exit the program.
exit:
	addi	$v0, $0, 4
	lui	$a0, 0x1000
	addi	$a0, $a0, 233
	syscall
	
	addi	$v0, $0, 10
	syscall
