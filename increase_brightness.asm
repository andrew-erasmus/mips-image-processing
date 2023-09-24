.data
    image_filename: .asciiz "C:\Users\User\repos\csc2002S-assignment3\mips-image-processing\house_64_in_ascii_crlf.ppm"
    image_content: .space 60000 # reserve 60000 bytes for the image file
    image_max_size: .word 60000
    output_file: .asciiz "C:\Users\User\repos\csc2002S-assignment3\mips-image-processing\increase_image.ppm"
    header_string: .space 200 #header of the file
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
    li $t0, 0 #the number to be incremented - will be set to zero when a new number is read in

    li $t1, 0 #the position counter for string to int

    li $t7, 0 #counter to skip first 3 lines - will increment if equals "\n"


read_file:
    #read file
    li $v0, 14
    move $a0, $s0
    la $a1, image_content
    la $a2, 60000
    syscall
    

    #close file
    li $v0, 16
    move $a0, $s6
    syscall

    j skip_three_lines

skip_three_lines:
    beq $t7, 3, ascii_to_int
    lb $t2, image_content($t1)
   
    beq $t2, 10, incr_skip_counter
    
    addi $t1, $t1, 1
    j skip_three_lines


incr_skip_counter: #skip counter is the one that counts the first 3 lines when equals "\n"
    addi $t7, $t7, 1
    addi $t1, $t1, 1

    li $v0, 1
    move $a0, $t7
    syscall

    j skip_three_lines

ascii_to_int:
    addi $t1, $t1, 1 # incr by one (currently on \n)
    lb $t2, image_content($t1)



incr_by_ten:

int_to_ascii:

add_to_output:

write_to_file:

display_avgs:

#exit the program
exit:

    li $v0, 10
    syscall