.data
    image_filename: .asciiz "C:\Users\User\repos\csc2002S-assignment3\mips-image-processing\house_64_in_ascii_crlf.ppm"
    image_content_count: .space 60000 #space for image content used for counting length
    image_content: .space 60000 # reserve 60000 bytes for the image file
    image_max_size: .word 60000
    output_file: .asciiz "C:\Users\User\repos\csc2002S-assignment3\mips-image-processing\increase_image.ppm"
    header_string: .space 200 #header of the file

    temp_string: .space 6 # temp string for each line when reverse
    output_string: .space 60000

.text   

main:

#Input the file - load and read
    li $v0, 13
    la $a0, image_filename
    li $a1, 0
    li $a2, 0
    syscall
    move $s0, $v0 # save the file name

    #open file for writing
    li $v0, 13
    la $a0, output_file
    li $a1, 1
    syscall
    move $s1, $v0
 
    li $t0, 0 #the number to be incremented - will be set to zero when a new number is read in
    li $t1, 0 #the position counter for string to int

    li $t3, 0 # current pos for length loop
    li $t4, 0 # counter for the length of output_string

    li $t5, 0 # the digit counter of the temp string
    li $t6, 0 # the position counter for the int to string
    li $t7, 0 #counter to skip first 3 lines - will increment if equals "\n"

    li $t8, 0 #sum of the averages before increase
    li $t9, 0 #sum of averages after increase

    li $s6, 0 #counter for output purposes


read_file:
    #read file
    li $v0, 14
    move $a0, $s0
    la $a1, image_content
    la $a2, 60000
    syscall
    

    #close file
    li $v0, 16
    move $a0, $s0
    syscall

    j skip_three_lines

skip_three_lines:
    beq $t7, 3, ascii_to_int
    lb $t2, image_content($t1)

    beq $t2, 51, change_p3_to_p2 #checks if it is equal to '3'

    sb $t2, output_string($t6) # will add to output string but skip over for brightness processing
    addi $t6, $t6, 1
    
    beq $t2, 10, incr_skip_counter
    
    addi $t1, $t1, 1
    j skip_three_lines

change_p3_to_p2:
    li $t2, 50
    sb $t2, output_string($t6) # will add to output string but skip over for brightness processing
    addi $t6, $t6, 1

    addi $t1, $t1, 1
    j skip_three_lines


incr_skip_counter: #skip counter is the one that counts the first 3 lines when equals "\n"

    addi $t7, $t7, 1
    addi $t1, $t1, 1
    j skip_three_lines


ascii_to_int:
    
    beq $t2, 10, check_end # Checks if it is a CR to then check if it is a LF
    lb $t2, image_content($t1)
    beq $t2, 10, incr_by_ten # if the line is finished, continue process of adding to the integer 

    #operations to convert to int
    sub $t2, $t2, 48
    mul $t0, $t0, 10
    add $t0, $t0, $t2

    addi $t1, $t1, 1 # incr by one (currently on \n)
    j ascii_to_int

 check_end:
    addi $t1, $t1, 1
    lb $t2, image_content($t1)
    beq $t2, 13, count_output_string
    addi $t1, $t1, -1
    j ascii_to_int
    
incr_by_ten:
    add $t8, $t8, $t0 # add $t0 to the sum of the pixels
    li $s7, 255
    addi $t0, $t0, 10 #increase by 10
    bge $t0, $s7, skip_add_ten #skip increment by 10 if its at the 255 limit
    add $t9, $t9, $t0 # add $t0 to the sum of the pixels after the increase
    j int_to_ascii

skip_add_ten:
    li $t0, 255 #if will go over then set it to 255
    add $t9, $t9, $t0 # add $t0 to the sum of the pixels after the increase
    j int_to_ascii
    

int_to_ascii:
    #divide by 10 to get the unit
    div $t0, $t0, 10
    mfhi $t3 #store the remainder in t3, i.e the unit

    addi $t3, $t3, 48 #convert to ascii (by adding a 0 - 48 in ascii)
    sb $t3, temp_string($t5)

    
    beqz $t0, reverse_int_ascii # reverse order 
    addi $t5, $t5, 1

    j int_to_ascii



reverse_int_ascii: #reverse the string to ascii since the division takes the last digit first
    
    lb $t3, temp_string($t5)
    sb $t3, output_string($t6)

    addi $t6, $t6, 1
    addi $t5, $t5, -1

    beq $t5, -1, end_int_to_ascii 

    j reverse_int_ascii


end_int_to_ascii:
    li $t3, 10 # add newline character
    sb $t3, output_string($t6)
    addi $t6, $t6, 1

    li $t0, 0
    li $t5, 0
    addi $t1, $t1, 1
    j ascii_to_int

count_output_string:
    lb $t2, output_string($s6)
    beqz $t2, finish_off

    addi $s6, $s6, 1
    addi $t4, $t4, 1 
    j count_output_string

finish_off:
    li $t2, 0 #counter for the position of the byte in the output
    j write_to_file

write_to_file:
    
    li $v0, 13
    la $a0, output_file
    li $a1, 1
    syscall
    move $s1, $v0


    li $v0, 15
    move $a0, $s1
    la $a1, output_string
    move $a2, $t4
    syscall 

    #close file
    li $v0, 16
    move $a0, $s7
    syscall

#exit the program
exit:

    li $v0, 10
    syscall
