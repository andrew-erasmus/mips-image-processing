.data
    image_file: .asciiz "/mips-image-processing/house_64_in_ascii_cr.ppm"
    header: .space 50
    comment: .space 50


.text

main:

#Input the file - load and read
    li $v0, 13
    la $a0, image_file
    li $a1, 0
    syscall

#ASCII to integer conversion

#Increase RGB by 10

#Integer to string conversion

#Write to output file

#Calculate and display averages