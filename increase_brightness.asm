.data
    image_filename: .asciiz "C:\Users\User\repos\csc2002S-assignment3\mips-image-processing\house_64_in_ascii_crlf.ppm"
    image_content: .space 60000 # reserve 60000 bytes for the image file
    image_max_size: .word 60000
    output_file: .asciiz "C:\Users\User\repos\csc2002S-assignment3\mips-image-processing\increase_image.ppm"
    

.text   

main:

#Input the file - load and read
    li $v0, 13
    la $a0, image_filename
    li $a1, 0
    li $a2, 0
    syscall
    move $s0, $v0 # save the file name


read_file:
    #open file
    li $v0, 14
    move $a0, $s0
    la $a1, image_content
    la $a2, 60000
    syscall
    
    
    li $v0, 4
    la $a0, image_content
    syscall

    #close file
    li $v0, 16
    move $a0, $s6
    syscall

# Write to output file
# output:
#     li $v0, 13
#     la $a0, output_file
#     li $a1, 1
#     li $a2, 0
#     syscall
#     move $s7, $v0 # The file

#     li $v0, 15
#     move $a0, $s7
#     la $a1, image_content
#     lw $a2, image_max_size
#     syscall


#exit the program
exit:

    li $v0, 10
    syscall