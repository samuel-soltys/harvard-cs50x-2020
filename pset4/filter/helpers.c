#include "helpers.h"
#include <math.h>
#include <stdio.h>


// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    int average;
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            average = round((image[i][j].rgbtRed + image[i][j].rgbtGreen + image[i][j].rgbtBlue) / 3.0);
            image[i][j].rgbtRed = average;
            image[i][j].rgbtGreen = average;
            image[i][j].rgbtBlue = average;
        }
    }
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE temp;
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < round(width / 2) ; j++)
        {
            temp.rgbtRed = image[i][j].rgbtRed;
            temp.rgbtGreen = image[i][j].rgbtGreen;
            temp.rgbtBlue = image[i][j].rgbtBlue;
            //
            image[i][j].rgbtRed = image[i][width - j - 1].rgbtRed;
            image[i][j].rgbtGreen = image[i][width - j - 1].rgbtGreen;
            image[i][j].rgbtBlue = image[i][width - j - 1].rgbtBlue;

            image[i][width - j - 1].rgbtRed = temp.rgbtRed;
            image[i][width - j - 1].rgbtGreen = temp.rgbtGreen;
            image[i][width - j - 1].rgbtBlue = temp.rgbtBlue;
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    // copying image
    RGBTRIPLE copy[height][width];
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            copy[i][j] = image[i][j];
        }
    }
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            if (i == 0 || i == height - 1 || j == 0 || j == width - 1)                      // egdes nad corners
            {
                if (i == 0 && j == 0)                                                       // corners
                {
                    copy[i][j].rgbtRed = round((image[i][j].rgbtRed + image[i][j + 1].rgbtRed +
                                                image[i + 1][j].rgbtRed + image[i + 1][j + 1].rgbtRed) / 4.0);
                    copy[i][j].rgbtGreen = round((image[i][j].rgbtGreen + image[i][j + 1].rgbtGreen +
                                                  image[i + 1][j].rgbtGreen + image[i + 1][j + 1].rgbtGreen) / 4.0);
                    copy[i][j].rgbtBlue = round((image[i][j].rgbtBlue + image[i][j + 1].rgbtBlue +
                                                 image[i + 1][j].rgbtBlue + image[i + 1][j + 1].rgbtBlue) / 4.0);
                }
                else if (i == height - 1 && j == 0)
                {
                    copy[i][j].rgbtRed = round((image[i][j].rgbtRed + image[i][j + 1].rgbtRed
                                                + image[i - 1][j].rgbtRed + image[i - 1][j + 1].rgbtRed) / 4.0);
                    copy[i][j].rgbtGreen = round((image[i][j].rgbtGreen + image[i][j + 1].rgbtGreen
                                                  + image[i - 1][j].rgbtGreen + image[i - 1][j + 1].rgbtGreen) / 4.0);
                    copy[i][j].rgbtBlue = round((image[i][j].rgbtBlue + image[i][j + 1].rgbtBlue
                                                 + image[i - 1][j].rgbtBlue + image[i - 1][j + 1].rgbtBlue) / 4.0);
                }
                else if (i == 0 && j == width - 1)
                {
                    // upper right corner
                    copy[i][j].rgbtRed = round((image[i][j].rgbtRed + image[i][j - 1].rgbtRed
                                                + image[i + 1][j].rgbtRed + image[i + 1][j - 1].rgbtRed) / 4.0);
                    copy[i][j].rgbtGreen = round((image[i][j].rgbtGreen + image[i][j - 1].rgbtGreen
                                                  + image[i + 1][j].rgbtGreen + image[i + 1][j - 1].rgbtGreen) / 4.0);
                    copy[i][j].rgbtBlue = round((image[i][j].rgbtBlue + image[i][j - 1].rgbtBlue
                                                 + image[i + 1][j].rgbtBlue + image[i + 1][j - 1].rgbtBlue) / 4.0);
                }
                //above are not done
                else if (i == height - 1 && j == width - 1)
                {
                    // right bottom corner
                    copy[i][j].rgbtRed = round((image[i][j].rgbtRed + image[i][j - 1].rgbtRed
                                                + image[i - 1][j].rgbtRed + image[i - 1][j - 1].rgbtRed) / 4.0);
                    copy[i][j].rgbtGreen = round((image[i][j].rgbtGreen + image[i][j - 1].rgbtGreen
                                                  + image[i - 1][j].rgbtGreen + image[i - 1][j - 1].rgbtGreen) / 4.0);
                    copy[i][j].rgbtBlue = round((image[i][j].rgbtBlue + image[i][j - 1].rgbtBlue
                                                 + image[i - 1][j].rgbtBlue + image[i - 1][j - 1].rgbtBlue) / 4.0);
                }
                else                                            // edges
                {
                    if (j == 0)     // left edge done
                    {
                        copy[i][j].rgbtRed = round((image[i][j].rgbtRed + image[i][j + 1].rgbtRed + image[i - 1][j].rgbtRed
                                                    + image[i + 1][j].rgbtRed + image[i - 1][j + 1].rgbtRed + image[i + 1][j + 1].rgbtRed) / 6.0);
                        copy[i][j].rgbtGreen = round((image[i][j].rgbtGreen + image[i][j + 1].rgbtGreen + image[i - 1][j].rgbtGreen
                                                      + image[i + 1][j].rgbtGreen + image[i - 1][j + 1].rgbtGreen + image[i + 1][j + 1].rgbtGreen) / 6.0);
                        copy[i][j].rgbtBlue = round((image[i][j].rgbtBlue + image[i][j + 1].rgbtBlue + image[i - 1][j].rgbtBlue
                                                     + image[i + 1][j].rgbtBlue + image[i - 1][j + 1].rgbtBlue + image[i + 1][j + 1].rgbtBlue) / 6.0);
                    }
                    if (j == width - 1)     // right edge done
                    {
                        copy[i][j].rgbtRed = round((image[i][j].rgbtRed + image[i][j - 1].rgbtRed + image[i - 1][j].rgbtRed
                                                    + image[i + 1][j].rgbtRed + image[i - 1][j - 1].rgbtRed + image[i + 1][j - 1].rgbtRed) / 6.0);
                        copy[i][j].rgbtGreen = round((image[i][j].rgbtGreen + image[i][j - 1].rgbtGreen + image[i - 1][j].rgbtGreen
                                                      + image[i + 1][j].rgbtGreen + image[i - 1][j - 1].rgbtGreen + image[i + 1][j - 1].rgbtGreen) / 6.0);
                        copy[i][j].rgbtBlue = round((image[i][j].rgbtBlue + image[i][j - 1].rgbtBlue + image[i - 1][j].rgbtBlue
                                                     + image[i + 1][j].rgbtBlue + image[i - 1][j - 1].rgbtBlue + image[i + 1][j - 1].rgbtBlue) / 6.0);
                    }
                    if (i == 0)     // top edge done
                    {
                        copy[i][j].rgbtRed = round((image[i][j].rgbtRed + image[i][j + 1].rgbtRed + image[i][j - 1].rgbtRed
                                                    + image[i + 1][j].rgbtRed + image[i + 1][j - 1].rgbtRed + image[i + 1][j + 1].rgbtRed) / 6.0);
                        copy[i][j].rgbtGreen = round((image[i][j].rgbtGreen + image[i][j + 1].rgbtGreen + image[i][j - 1].rgbtGreen
                                                      + image[i + 1][j].rgbtGreen + image[i + 1][j - 1].rgbtGreen + image[i + 1][j + 1].rgbtGreen) / 6.0);
                        copy[i][j].rgbtBlue = round((image[i][j].rgbtBlue + image[i][j + 1].rgbtBlue + image[i][j - 1].rgbtBlue
                                                     + image[i + 1][j].rgbtBlue + image[i + 1][j - 1].rgbtBlue + image[i + 1][j + 1].rgbtBlue) / 6.0);
                    }
                    if (i == height - 1)     // bottom edge
                    {
                        copy[i][j].rgbtRed = round((image[i][j].rgbtRed + image[i][j + 1].rgbtRed + image[i][j - 1].rgbtRed
                                                    + image[i - 1][j].rgbtRed + image[i - 1][j + 1].rgbtRed + image[i - 1][j - 1].rgbtRed) / 6.0);
                        copy[i][j].rgbtGreen = round((image[i][j].rgbtGreen + image[i][j + 1].rgbtGreen + image[i][j - 1].rgbtGreen
                                                      + image[i - 1][j].rgbtGreen + image[i - 1][j + 1].rgbtGreen + image[i - 1][j - 1].rgbtGreen) / 6.0);
                        copy[i][j].rgbtBlue = round((image[i][j].rgbtBlue + image[i][j + 1].rgbtBlue + image[i][j - 1].rgbtBlue
                                                     + image[i - 1][j].rgbtBlue + image[i - 1][j + 1].rgbtBlue + image[i - 1][j - 1].rgbtBlue) / 6.0);
                    }
                }
            }
            else
            {
                copy[i][j].rgbtRed = round((image[i][j].rgbtRed + image[i][j - 1].rgbtRed + image[i][j + 1].rgbtRed + image[i - 1][j].rgbtRed
                                            + image[i + 1][j].rgbtRed + image[i - 1][j - 1].rgbtRed + image[i - 1][j + 1].rgbtRed + image[i + 1][j - 1].rgbtRed
                                            + image[i + 1][j + 1].rgbtRed) / 9.0);
                copy[i][j].rgbtGreen = round((image[i][j].rgbtGreen + image[i][j - 1].rgbtGreen + image[i][j + 1].rgbtGreen
                                              + image[i - 1][j].rgbtGreen + image[i + 1][j].rgbtGreen + image[i - 1][j - 1].rgbtGreen + image[i - 1][j + 1].rgbtGreen
                                              + image[i + 1][j - 1].rgbtGreen + image[i + 1][j + 1].rgbtGreen) / 9.0);
                copy[i][j].rgbtBlue = round((image[i][j].rgbtBlue + image[i][j - 1].rgbtBlue + image[i][j + 1].rgbtBlue + image[i - 1][j].rgbtBlue
                                             + image[i + 1][j].rgbtBlue + image[i - 1][j - 1].rgbtBlue + image[i - 1][j + 1].rgbtBlue + image[i + 1][j - 1].rgbtBlue
                                             + image[i + 1][j + 1].rgbtBlue) / 9.0);
            }
        }
    }
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image[i][j] = copy[i][j];
        }
    }
    return;
}

// Detect edges
void edges(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE copy[height][width];
    RGBTRIPLE edge[height + 2][width + 2];
    // setting values to 0
    for (int i = 0; i < height + 2; i++)
    {
        for (int j = 0; j < width + 2; j++)
        {
            edge[i][j].rgbtRed = 0;
            edge[i][j].rgbtGreen = 0;
            edge[i][j].rgbtBlue = 0;
        }
    }
    // copying edge
    for (int i = 1; i < height + 1; i++)
    {
        for (int j = 1; j < width + 1; j++)
        {
            edge[i][j] = image[i - 1][j - 1];
        }
    }
    // copying copy
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            copy[i][j] = image[i][j];
        }
    }
    // code for edging
    int gx_r, gx_g, gx_b;
    int gy_r, gy_g, gy_b;
    for (int i = 1; i < height + 1; i++)
    {
        for (int j = 1; j < width + 1; j++)
        {
            // gx:
            gx_r = edge[i - 1][j - 1].rgbtRed * -1 + edge[i][j - 1].rgbtRed * -2 + edge[i + 1][j - 1].rgbtRed * -1
                   + edge[i][j + 1].rgbtRed * 2 + edge[i - 1][j + 1].rgbtRed + edge[i + 1][j + 1].rgbtRed;
            gx_g = edge[i - 1][j - 1].rgbtGreen * -1 + edge[i][j - 1].rgbtGreen * -2 + edge[i + 1][j - 1].rgbtGreen * -1
                   + edge[i][j + 1].rgbtGreen * 2 + edge[i - 1][j + 1].rgbtGreen + edge[i + 1][j + 1].rgbtGreen;
            gx_b = edge[i - 1][j - 1].rgbtBlue * -1 + edge[i][j - 1].rgbtBlue * -2 + edge[i + 1][j - 1].rgbtBlue * -1
                   + edge[i][j + 1].rgbtBlue * 2 + edge[i - 1][j + 1].rgbtBlue + edge[i + 1][j + 1].rgbtBlue;
            // gy:
            gy_r = edge[i - 1][j - 1].rgbtRed * -1 + edge[i - 1][j].rgbtRed * -2 + edge[i - 1][j + 1].rgbtRed * -1
                   + edge[i + 1][j].rgbtRed * 2 + edge[i + 1][j - 1].rgbtRed + edge[i + 1][j + 1].rgbtRed;
            gy_g = edge[i - 1][j - 1].rgbtGreen * -1 + edge[i - 1][j].rgbtGreen * -2 + edge[i - 1][j + 1].rgbtGreen * -1
                   + edge[i + 1][j].rgbtGreen * 2 + edge[i + 1][j - 1].rgbtGreen + edge[i + 1][j + 1].rgbtGreen;
            gy_b = edge[i - 1][j - 1].rgbtBlue * -1 + edge[i - 1][j].rgbtBlue * -2 + edge[i - 1][j + 1].rgbtBlue * -1
                   + edge[i + 1][j].rgbtBlue * 2 + edge[i + 1][j - 1].rgbtBlue + edge[i + 1][j + 1].rgbtBlue;
            // combining gx and gy:
            int ValueR = round(sqrt((float) pow(gx_r, 2) + pow(gy_r, 2)));
            if (ValueR > 255)
            {
                copy[i - 1][j - 1].rgbtRed = 255;
            }
            else
            {
                copy[i - 1][j - 1].rgbtRed = ValueR;
            }
            //
            int ValueG = round(sqrt((float) pow(gx_g, 2) + pow(gy_g, 2)));
            if (ValueG > 255)
            {
                copy[i - 1][j - 1].rgbtGreen = 255;
            }
            else
            {
                copy[i - 1][j - 1].rgbtGreen = ValueG;
            }
            //
            int ValueB = round(sqrt((float) pow(gx_b, 2) + pow(gy_b, 2)));
            if (ValueB > 255)
            {
                copy[i - 1][j - 1].rgbtBlue = 255;
            }
            else
            {
                copy[i - 1][j - 1].rgbtBlue = ValueB;
            }

        }
    }
    // copying back to image
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image[i][j] = copy[i][j];
        }
    }
    return;
}
