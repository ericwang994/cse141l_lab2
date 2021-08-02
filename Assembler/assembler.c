#include "stdio.h"
#include "stdlib.h"

int assembler(char* aCode) {
    FILE *aCode_file, *mCode_file;
    char temp_string[10];
    unsigned int mCode = 0;
    int i = 0;
    char temp, temp2;
    aCode_file = fopen(aCode,"r");
    mCode_file = fopen("machine_code", "w");
    
    
    while((temp_string[i] = getc(aCode_file)) != EOF) {
        //printf("%c",temp_string[i]);
        for(int j = 1; j < 10;j++) temp_string[j] = ' ';
        i++;
        while((temp_string[i] = getc(aCode_file)) != ' ') {
            //printf("%c", temp_string[i]);
            i++;
        }
        
        
        // create
        if(temp_string[0] == 'c' && temp_string[1] == 'r' && temp_string[2] == 'e' && temp_string[3] == 'a' && temp_string[4] == 't' && temp_string[5] == 'e') {
            putc('1', mCode_file);
            while(getc(aCode_file) != 'x') i++;           
            while((temp = getc(aCode_file)) != '\n') {
                if(temp < '0' || (temp > '9' && temp < 'A') || temp > 'F') break;
                if(temp >= 'A') {
                    temp = temp - 7;
                }
                if(temp >= '8') {
                    putc('1', mCode_file);
                    temp = temp - 8;
                } else {
                    putc('0', mCode_file);
                }
                
                if(temp >= '4') {
                    putc('1', mCode_file);
                    temp = temp - 4;
                } else {
                    putc('0', mCode_file);
                }
                
                if(temp >= '2') {
                    putc('1', mCode_file);
                    temp = temp - 2;
                } else {
                    putc('0', mCode_file);
                }
                
                if(temp >= '1') {
                    putc('1', mCode_file);
                    temp = temp - 1;
                } else {
                    putc('0', mCode_file);
                }
            }
            if(temp != '\n') {
                while(getc(aCode_file) != '\n');
                putc('\n', mCode_file);
            } else {
                putc(temp, mCode_file);
            }
        
        // load
        } else if(temp_string[0] == 'l' && temp_string[1] == 'o' && temp_string[2] == 'a' && temp_string[3] == 'd' ) {
            while(getc(aCode_file) != 'r') i++;
            fprintf(mCode_file,"00000");
            temp = getc(aCode_file);
            temp2 = getc(aCode_file);
            if((temp == '1') && (temp2 <= '9') && (temp2 >= '0')) {
                temp = temp2 + 10;
            }
            if(temp >= '8') {
                putc('1', mCode_file);
                temp = temp - 8;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '4') {
                putc('1', mCode_file);
                temp = temp - 4;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '2') {
                putc('1', mCode_file);
                temp = temp - 2;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '1') {
                putc('1', mCode_file);
                temp = temp - 1;
            } else {
                putc('0', mCode_file);
            }
            if(temp2 != '\n'){
                while(getc(aCode_file) != '\n');
                putc('\n', mCode_file);
            } else {
                putc(temp2, mCode_file);
            }
        // mov
        } else if(temp_string[0] == 'm' && temp_string[1] == 'o' && temp_string[2] == 'v') {
            while(getc(aCode_file) != 'r') i++;
            fprintf(mCode_file,"00001");
            temp = getc(aCode_file);
            temp2 = getc(aCode_file);
            if((temp == '1') && (temp2 <= '9') && (temp2 >= '0')) {
                temp = temp2 + 10;
            }
            if(temp >= '8') {
                putc('1', mCode_file);
                temp = temp - 8;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '4') {
                putc('1', mCode_file);
                temp = temp - 4;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '2') {
                putc('1', mCode_file);
                temp = temp - 2;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '1') {
                putc('1', mCode_file);
                temp = temp - 1;
            } else {
                putc('0', mCode_file);
            }
            if(temp2 != '\n'){
                while(getc(aCode_file) != '\n');
                putc('\n', mCode_file);
            } else {
                putc(temp2, mCode_file);
            }
        // pull
        } else if(temp_string[0] == 'p' && temp_string[1] == 'u' && temp_string[2] == 'l' && temp_string[3] == 'l') {
            while(getc(aCode_file) != 'r') i++;
            fprintf(mCode_file,"00010");
            temp = getc(aCode_file);
            temp2 = getc(aCode_file);
            if((temp == '1') && (temp2 <= '9') && (temp2 >= '0')) {
                temp = temp2 + 10;
            }
            if(temp >= '8') {
                putc('1', mCode_file);
                temp = temp - 8;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '4') {
                putc('1', mCode_file);
                temp = temp - 4;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '2') {
                putc('1', mCode_file);
                temp = temp - 2;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '1') {
                putc('1', mCode_file);
                temp = temp - 1;
            } else {
                putc('0', mCode_file);
            }
            if(temp2 != '\n'){
                while(getc(aCode_file) != '\n');
                putc('\n', mCode_file);
            } else {
                putc(temp2, mCode_file);
            }

        // store
        } else if(temp_string[0] == 's' && temp_string[1] == 't' && temp_string[2] == 'o' && temp_string[3] == 'r' && temp_string[4] == 'e') {
            while(getc(aCode_file) != 'r') i++;
            fprintf(mCode_file,"00011");
            temp = getc(aCode_file);
            temp2 = getc(aCode_file);
            if((temp == '1') && (temp2 <= '9') && (temp2 >= '0')) {
                temp = temp2 + 10;
            }
            if(temp >= '8') {
                putc('1', mCode_file);
                temp = temp - 8;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '4') {
                putc('1', mCode_file);
                temp = temp - 4;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '2') {
                putc('1', mCode_file);
                temp = temp - 2;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '1') {
                putc('1', mCode_file);
                temp = temp - 1;
            } else {
                putc('0', mCode_file);
            }
            if(temp2 != '\n'){
                while(getc(aCode_file) != '\n');
                putc('\n', mCode_file);
            } else {
                putc(temp2, mCode_file);
            }
        
        // shift left
        } else if(temp_string[0] == 's' && temp_string[1] == 'l' ) {
            while(getc(aCode_file) != 'r') i++;
            fprintf(mCode_file,"00100");
            temp = getc(aCode_file);
            temp2 = getc(aCode_file);
            if((temp == '1') && (temp2 <= '9') && (temp2 >= '0')) {
                temp = temp2 + 10;
            }
            if(temp >= '8') {
                putc('1', mCode_file);
                temp = temp - 8;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '4') {
                putc('1', mCode_file);
                temp = temp - 4;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '2') {
                putc('1', mCode_file);
                temp = temp - 2;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '1') {
                putc('1', mCode_file);
                temp = temp - 1;
            } else {
                putc('0', mCode_file);
            }
            if(temp2 != '\n'){
                while(getc(aCode_file) != '\n');
                putc('\n', mCode_file);
            } else {
                putc(temp2, mCode_file);
            }

        // shift right 
        } else if(temp_string[0] == 's' && temp_string[1] == 'r' ) {
            while(getc(aCode_file) != 'r') i++;
            fprintf(mCode_file,"00101");
            temp = getc(aCode_file);
            temp2 = getc(aCode_file);
            if((temp == '1') && (temp2 <= '9') && (temp2 >= '0')) {
                temp = temp2 + 10;
            }
            if(temp >= '8') {
                putc('1', mCode_file);
                temp = temp - 8;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '4') {
                putc('1', mCode_file);
                temp = temp - 4;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '2') {
                putc('1', mCode_file);
                temp = temp - 2;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '1') {
                putc('1', mCode_file);
                temp = temp - 1;
            } else {
                putc('0', mCode_file);
            }
            if(temp2 != '\n'){
                while(getc(aCode_file) != '\n');
                putc('\n', mCode_file);
            } else {
                putc(temp2, mCode_file);
            }

        // add
        } else if(temp_string[0] == 'a' && temp_string[1] == 'd' && temp_string[2] == 'd' && temp_string[3] == ' ') {
            while(getc(aCode_file) != 'r') i++;
            fprintf(mCode_file,"00110");
            temp = getc(aCode_file);
            temp2 = getc(aCode_file);
            if((temp == '1') && (temp2 <= '9') && (temp2 >= '0')) {
                temp = temp2 + 10;
            }
            if(temp >= '8') {
                putc('1', mCode_file);
                temp = temp - 8;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '4') {
                putc('1', mCode_file);
                temp = temp - 4;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '2') {
                putc('1', mCode_file);
                temp = temp - 2;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '1') {
                putc('1', mCode_file);
                temp = temp - 1;
            } else {
                putc('0', mCode_file);
            }
            if(temp2 != '\n'){
                while(getc(aCode_file) != '\n');
                putc('\n', mCode_file);
            } else {
                putc(temp2, mCode_file);
            }

        // add carry 
        } else if(temp_string[0] == 'a' && temp_string[1] == 'd' && temp_string[2] == 'd' && temp_string[3] == 'c') {
            while(getc(aCode_file) != 'r') i++;
            fprintf(mCode_file,"00111");
            temp = getc(aCode_file);
            temp2 = getc(aCode_file);
            if((temp == '1') && (temp2 <= '9') && (temp2 >= '0')) {
                temp = temp2 + 10;
            }
            if(temp >= '8') {
                putc('1', mCode_file);
                temp = temp - 8;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '4') {
                putc('1', mCode_file);
                temp = temp - 4;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '2') {
                putc('1', mCode_file);
                temp = temp - 2;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '1') {
                putc('1', mCode_file);
                temp = temp - 1;
            } else {
                putc('0', mCode_file);
            }
            if(temp2 != '\n'){
                while(getc(aCode_file) != '\n');
                putc('\n', mCode_file);
            } else {
                putc(temp2, mCode_file);
            }

        // sub 
        } else if(temp_string[0] == 's' && temp_string[1] == 'u' && temp_string[2] == 'b' && temp_string[3] == ' ') {
            while(getc(aCode_file) != 'r') i++;
            fprintf(mCode_file,"01000");
            temp = getc(aCode_file);
            temp2 = getc(aCode_file);
            if((temp == '1') && (temp2 <= '9') && (temp2 >= '0')) {
                temp = temp2 + 10;
            }
            if(temp >= '8') {
                putc('1', mCode_file);
                temp = temp - 8;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '4') {
                putc('1', mCode_file);
                temp = temp - 4;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '2') {
                putc('1', mCode_file);
                temp = temp - 2;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '1') {
                putc('1', mCode_file);
                temp = temp - 1;
            } else {
                putc('0', mCode_file);
            }
            if(temp2 != '\n'){
                while(getc(aCode_file) != '\n');
                putc('\n', mCode_file);
            } else {
                putc(temp2, mCode_file);
            }

        // sub carry 
        } else if(temp_string[0] == 's' && temp_string[1] == 'u' && temp_string[2] == 'b' && temp_string[3] == 'c') {
            while(getc(aCode_file) != 'r') i++;
            fprintf(mCode_file,"01001");
            temp = getc(aCode_file);
            temp2 = getc(aCode_file);
            if((temp == '1') && (temp2 <= '9') && (temp2 >= '0')) {
                temp = temp2 + 10;
            }
            if(temp >= '8') {
                putc('1', mCode_file);
                temp = temp - 8;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '4') {
                putc('1', mCode_file);
                temp = temp - 4;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '2') {
                putc('1', mCode_file);
                temp = temp - 2;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '1') {
                putc('1', mCode_file);
                temp = temp - 1;
            } else {
                putc('0', mCode_file);
            }
            if(temp2 != '\n'){
                while(getc(aCode_file) != '\n');
                putc('\n', mCode_file);
            } else {
                putc(temp2, mCode_file);
            }

        // beq
        } else if(temp_string[0] == 'b' && temp_string[1] == 'e' && temp_string[2] == 'q') {
            while(getc(aCode_file) != 'r') i++;
            fprintf(mCode_file,"01010");
            temp = getc(aCode_file);
            temp2 = getc(aCode_file);
            if((temp == '1') && (temp2 <= '9') && (temp2 >= '0')) {
                temp = temp2 + 10;
            }
            if(temp >= '8') {
                putc('1', mCode_file);
                temp = temp - 8;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '4') {
                putc('1', mCode_file);
                temp = temp - 4;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '2') {
                putc('1', mCode_file);
                temp = temp - 2;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '1') {
                putc('1', mCode_file);
                temp = temp - 1;
            } else {
                putc('0', mCode_file);
            }
            if(temp2 != '\n'){
                while(getc(aCode_file) != '\n');
                putc('\n', mCode_file);
            } else {
               
                putc(temp2, mCode_file);
            }

        // btr 
        } else if(temp_string[0] == 'b' && temp_string[1] == 't' && temp_string[2] == 'r') {
            while(getc(aCode_file) != 'r') i++;
            fprintf(mCode_file,"01011");
            temp = getc(aCode_file);
            temp2 = getc(aCode_file);
            if((temp == '1') && (temp2 <= '9') && (temp2 >= '0')) {
                temp = temp2 + 10;
            }
            if(temp >= '8') {
                putc('1', mCode_file);
                temp = temp - 8;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '4') {
                putc('1', mCode_file);
                temp = temp - 4;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '2') {
                putc('1', mCode_file);
                temp = temp - 2;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '1') {
                putc('1', mCode_file);
                temp = temp - 1;
            } else {
                putc('0', mCode_file);
            }
            if(temp2 != '\n'){
                while(getc(aCode_file) != '\n');
                putc('\n', mCode_file);
            } else {
                putc(temp2, mCode_file);
            }

        // greater than 
        } else if(temp_string[0] == 'g' && temp_string[1] == 't') {
            while(getc(aCode_file) != 'r') i++;
            fprintf(mCode_file,"01100");
            temp = getc(aCode_file);
            temp2 = getc(aCode_file);
            if((temp == '1') && (temp2 <= '9') && (temp2 >= '0')) {
                temp = temp2 + 10;
            }
            if(temp >= '8') {
                putc('1', mCode_file);
                temp = temp - 8;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '4') {
                putc('1', mCode_file);
                temp = temp - 4;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '2') {
                putc('1', mCode_file);
                temp = temp - 2;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '1') {
                putc('1', mCode_file);
                temp = temp - 1;
            } else {
                putc('0', mCode_file);
            }
            if(temp2 != '\n'){
                while(getc(aCode_file) != '\n');
                putc('\n', mCode_file);
            } else {
                putc(temp2, mCode_file);
            }

        // first bit
        } else if(temp_string[0] == 'f' && temp_string[1] == 'b' && temp_string[2] == 'i' && temp_string[3] == 't') {
            while(getc(aCode_file) != 'r') i++;
            fprintf(mCode_file,"01101");
            temp = getc(aCode_file);
            temp2 = getc(aCode_file);
            if((temp == '1') && (temp2 <= '9') && (temp2 >= '0')) {
                temp = temp2 + 10;
            }
            if(temp >= '8') {
                putc('1', mCode_file);
                temp = temp - 8;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '4') {
                putc('1', mCode_file);
                temp = temp - 4;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '2') {
                putc('1', mCode_file);
                temp = temp - 2;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '1') {
                putc('1', mCode_file);
                temp = temp - 1;
            } else {
                putc('0', mCode_file);
            }
            if(temp2 != '\n'){
                while(getc(aCode_file) != '\n');
                putc('\n', mCode_file);
            } else {
                putc(temp2, mCode_file);
            }

        // last bit
        } else if(temp_string[0] == 'l' && temp_string[1] == 'b' && temp_string[2] == 'i' && temp_string[3] == 't') {
            while(getc(aCode_file) != 'r') i++;
            fprintf(mCode_file,"01110");
            temp = getc(aCode_file);
            temp2 = getc(aCode_file);
            if((temp == '1') && (temp2 <= '9') && (temp2 >= '0')) {
                temp = temp2 + 10;
            }
            if(temp >= '8') {
                putc('1', mCode_file);
                temp = temp - 8;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '4') {
                putc('1', mCode_file);
                temp = temp - 4;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '2') {
                putc('1', mCode_file);
                temp = temp - 2;
            } else {
                putc('0', mCode_file);
            }
            
            if(temp >= '1') {
                putc('1', mCode_file);
                temp = temp - 1;
            } else {
                putc('0', mCode_file);
            }
            if(temp2 != '\n'){
                while(getc(aCode_file) != '\n');
                putc('\n', mCode_file);
            } else {
                putc(temp2, mCode_file);
            }

        // halt 
        } else if(temp_string[0] == 'h' && temp_string[1] == 'a' && temp_string[2] == 'l' && temp_string[3] == 't') {
            
            fprintf(mCode_file,"011111111");
            fprintf(mCode_file, "\n");
            
        // default to load $r0
        } else {
            putc('\n', mCode_file);
        }
        //printf("%c\n", temp2);
        i = 0;
        temp = 0;
        temp2 = 0;
    }

    fclose(aCode_file);
    fclose(mCode_file);
    return 0;
}