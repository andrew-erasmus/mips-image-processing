.data
    image_filename: .asciiz "C:\Users\User\repos\csc2002S-assignment3\mips-image-processing\house_64_in_ascii_cr.ppm"
    image_content: .space 60000 # reserve 60000 bytes for the image file
    line: .space 100

.text   

main:

#Input the file - load and read
    li $v0, 13
    la $a0, image_file
    li $a1, 0
    syscall

    bltz $v0, exit # error has occured with reading

read_loop:

#ASCII to integer conversion

#Increase RGB by 10

#Integer to string conversion

#Write to output file

#Calculate and display averages

#exit the program
exit:
    li $v0, 10
    syscall