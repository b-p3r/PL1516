#include <stdio.h>
#include <string.h>

int main(void)
{
    const char *src = "raining apples training away";
    const char *next = src;
    
    while ((next = strstr(src, "g a")) != NULL) {
        while (src != next)
            putchar(*src++);
        
        putchar('\n');
        
        /* Skip the delimiter */
        src += 3;
    }
    
    /* Handle the last token */
    while (*src != '\0')
        putchar(*src++);
        
    putchar('\n');
    
    return 0;
}
