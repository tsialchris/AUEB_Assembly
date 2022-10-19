#Author: Christodoulos Tsialamanis 3160177
#Date: 16/11/2017
#Description: This program will calculate the change from a parking ticket payment
#$a0 -> used to print pre-written messages
#$v0 -> used to read the money of the customer and later to print results
#$t0 -> euros
#$t1 -> cents
#$t2 -> (div)used to find the quantity for each type of euro note
#$t3 -> (sub)used to subtract the amount of change for each note

.data
	msg:.asciiz "--Parking Ticket Payment--" 
	msg1:.asciiz "Fee: 5 euros and 24 cents"
	msg2:.asciiz "Enter Euros (<= 20): "
	msg3:.asciiz "Enter Cents (< 100): "
	msg4:.asciiz "Change"
	msg5:.asciiz " x 10 Euros"
	msg6:.asciiz " x 5 Euros"
	msg7:.asciiz " x 2 Euros"
	msg8:.asciiz " x 1 Euros"
	msg9:.asciiz " x 50 Cents"
	msg10:.asciiz " x 20 Cents"
	msg11:.asciiz " x 10 Cents"
	msg111:.asciiz " x 5 Cents"
	msg112:.asciiz " x 2 Cents"
	msg12:.asciiz " x 1 Cents"
	msg13:.asciiz "Change = 0"
	msg14:.asciiz "\n"
	msg15:.asciiz "Error! Please try again"
	msg16:.asciiz "Not enough money"

.text
.globl main
#initial prints
main:
la $a0,msg
	li $v0,4
syscall
la $a0,msg14 # change line
	
syscall
la $a0,msg14 # change line
	
syscall

la $a0,msg1 # Fee message
	
syscall
la $a0,msg14 # change line
	
syscall
la $a0,msg14 # change line
	
syscall

#control with repetition
repeat1:

la $a0,msg2 #print "enter euros"
	li $v0,4
syscall

li $v0,5 # read euros
syscall
move $t0,$v0
move $a0,$t0

la $a0,msg3 #print "enter cents"
	li $v0,4
	
syscall

li $v0,5 #read cents
syscall
move $t1,$v0
move $a0,$t1

	bgt $t0,20,case1 #if(euros>20)
	bge $t1,100,case1 #if(cents>100)
	j out_of_loop #jump to out_of_loop

case1:la $a0,msg15 #Error message
	li $v0,4
	syscall
	
	la $a0,msg14 # change line
	li $v0,4
	syscall
	
j repeat1 #jump at the beginning

out_of_loop:

la $a0,msg14 # change line
li $v0,4
syscall
#Checks if the money is enough
blt $t0,5,case2 #if(euros<5)
blt $t1,24,case3 #if(cents<24 && euros<5)
j after_check

after_check:
#Checks if change is zero
beq $t0,5,euro_equals_check #checks if euros=5

euro_equals_check_failed:

sub $t0,$t0,5 #subtract 5 euros

bgt $t1,23,cents_greater_than_23

blt $t1,24,cents_less_than_24

after_cent_control:

la $a0,msg4 #Print "Change: "
li $v0,4
syscall
la $a0,msg14 # change line
li $v0,4
syscall

#############################
#Finds the amount of the 10 euro bills
div $t2,$t0,10
move $a0,$t2

#Print the amount of the 10 euro bills
li $v0,1
syscall
#Print the amount of the 10 euro bills
la $a0,msg5 #Print " x 10 Euros"
li $v0,4
syscall


la $a0,msg14 # change line
li $v0,4
syscall

mul $t3,$t2,10
sub $t0,$t0,$t3
#############################

div $t2,$t0,5
move $a0,$t2

#Print the amount of the 5 euro bills
li $v0,1
syscall

la $a0,msg6 #Print " x 5 Euros"
li $v0,4
syscall


la $a0,msg14 # change line
li $v0,4
syscall

mul $t3,$t2,5
sub $t0,$t0,$t3
#############################

div $t2,$t0,2
move $a0,$t2

#Print the amount of the 2 euro bills
li $v0,1
syscall

la $a0,msg7 #Print " x 2 Euros"
li $v0,4
syscall


la $a0,msg14 # change line
li $v0,4
syscall

mul $t3,$t2,2
sub $t0,$t0,$t3
#############################

div $t2,$t0,1
move $a0,$t2

#Print the amount of the 1 euro bills
li $v0,1
syscall

la $a0,msg8 #Print " x 1 Euros"
li $v0,4
syscall


la $a0,msg14 # change line
li $v0,4
syscall

mul $t3,$t2,1
sub $t0,$t0,$t3
#############################

div $t2,$t1,50
move $a0,$t2

#Print the amount of the 50 cents coins
li $v0,1
syscall

la $a0,msg9 #Print " x 50 Cents"
li $v0,4
syscall


la $a0,msg14 # change line
li $v0,4
syscall

mul $t3,$t2,50
sub $t1,$t1,$t3
#############################

div $t2,$t1,20
move $a0,$t2

#Print the amount of the 20 cents coins
li $v0,1
syscall

la $a0,msg10 #Print " x 20 Cents"
li $v0,4
syscall


la $a0,msg14 # change line
li $v0,4
syscall

mul $t3,$t2,20
sub $t1,$t1,$t3
#############################

div $t2,$t1,10
move $a0,$t2

#Print the amount of the 10 cents coins
li $v0,1
syscall

la $a0,msg11 #Print " x 10 Cents"
li $v0,4
syscall


la $a0,msg14 # change line
li $v0,4
syscall

mul $t3,$t2,10
sub $t1,$t1,$t3
#############################

div $t2,$t1,5
move $a0,$t2

#Print the amount of the 5 cents coins
li $v0,1
syscall

la $a0,msg111 #Print " x 5 Cents"
li $v0,4
syscall


la $a0,msg14 # change line
li $v0,4
syscall

mul $t3,$t2,5
sub $t1,$t1,$t3
#############################

div $t2,$t1,2
move $a0,$t2

#Print the amount of the 2 cents coins
li $v0,1
syscall

la $a0,msg112 #Print " x 2 Cents"
li $v0,4
syscall


la $a0,msg14 # change line
li $v0,4
syscall

mul $t3,$t2,2
sub $t1,$t1,$t3
#############################

div $t2,$t1,1
move $a0,$t2

#Print the amount of the 1 cents coins
li $v0,1
syscall

la $a0,msg12 #Print " x 1 Cents"
li $v0,4
syscall


la $a0,msg14 # change line
li $v0,4
syscall

mul $t3,$t2,1
sub $t1,$t1,$t3
#############################

j end0

euro_equals_check:
beq $t1,24,change_equals_test #checks if cents=24
j euro_equals_check_failed

change_equals_test:
	la $a0,msg13 #print change = 0
	li $v0,4
	syscall
	j end0

case2: la $a0,msg16 #Not enough money message
	li $v0,4
	syscall
	la $a0,msg14 # change line
	li $v0,4
	syscall
	j end0

case3:
	beq $t0,5,case4 #if(euros==5)
	j after_check
	
case4: la $a0,msg16 #Not enough money message
	li $v0,4
	syscall
	la $a0,msg14 # change line
	li $v0,4
	syscall
	j end0

cents_greater_than_23:
	sub $t1,$t1,24 #subtract 24 cents
	j after_cent_control
	
cents_less_than_24:
	sub $t1,$t1,24
	add $t1,$t1,100 #cents manipulation
	sub $t0,$t0,1 #subtract 1 euro
	j after_cent_control
	
end0:
	li $v0,10
	syscall