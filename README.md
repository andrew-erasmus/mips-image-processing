# mips-image-processing

A MIPS assembly program that will take in an image from a PPM file (storing in ASCII format) and manipulate it.

This will increase the brightness of all pixels by 10 in one case and will turn the image into greyscale on the other hand. 

This will then save the new image information to a file and record the result

Instructions for use:
1. Specify which file you want to read from by inserting its absolute path in line 2 - I tested on a windows system so make sure to use the CRLF files. Eg. "C:/Users/User/repos/csc2002S-assignment3/mips-image-processing/jet_64_in_ascii_crlf.ppm" - specifies my absolute filepath

2. Create an output file in the directory that the output will be written to. Eg. increase_image.ppm (Which is seen in the directory)

3. Use the output file name that you just used and specify it as a string using the absolute filepath in line 6 - Eg. "C:/Users/User/repos/csc2002S-assignment3/mips-image-processing/increase_image.ppm"

4. Before running in a simulator like QTSpim - ensure the output file you created is empty. After that, you can run it and it will write to the output file you created

5. Open QTSpim and run so that the output file can be written to