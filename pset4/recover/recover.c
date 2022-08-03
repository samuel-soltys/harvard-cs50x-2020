#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

typedef uint8_t BYTE;

int main(int argc, char *argv[])
{
    // checking right input
    if (argc != 2)
    {
        printf("Usage: ./recover image\n");
        return 1;
    }
    if (fopen(argv[1], "r") == NULL)
    {
        printf("File failed to open.");
        return 1;
    }

    // opening files for read and write
    FILE *read = fopen(argv[1], "r");
    FILE *img;
    char filename[6];
    //FILE *recover = fopen("recover-test.txt", "a");

    BYTE buffer[512];
    int jpg = 0;
    int active_img = 0;
    // int block_size = fread(read, 1, 512, read);
    while (fread(buffer, 1, 512, read) != 0)    // reading 512 bytes from memory card
    {
        if (buffer[0] == 0xff && buffer[1] == 0xd8 && buffer[2] == 0xff && (buffer[3] & 0xf0) == 0xe0) // if jpg was found by its header
        {
            if (jpg == 0)         // if it is first jpg that was found = start writing into file
            {
                sprintf(filename, "%03i.jpg", jpg);
                img = fopen(filename, "w");
                fwrite(buffer, 512, 1, img);
            }
            else                // if it is not a first jpg that was found and the previous one need to be closed and new one need to be written to new file
            {
                fclose(img);
                sprintf(filename, "%03i.jpg", jpg);
                img = fopen(filename, "w");
                fwrite(buffer, 512, 1, img);
            }
            jpg++;      // jpg founded counter
        }
        else if (jpg > 0)            // if its not a start of jpg
        {
            fwrite(buffer, 512, 1, img);    // continue writing
        }
        /*printf("%02hhX\n", read[i]);
        fread(read, 1, 512, read);
        fwrite(write, 1, 512, recover);*/
    }
}
