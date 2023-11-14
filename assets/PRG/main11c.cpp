#include <iostream>
#include <windows.h>
#include <conio.h>
using namespace std;
#define KEY_UP 72
#define KEY_DOWN 80
#define KEY_LEFT 75
#define KEY_RIGHT 77



void set_cursor(int,int);
void printArr(int sudoku[][9]);
int main() {
    int sudoku[9][9]={
            {1,2,3,4,5,6,7,8,9},
            {1,2,3,4,5,6,7,8,9},
            {1,2,3,4,5,6,7,8,9},
            {1,2,3,4,5,6,7,8,9},
            {1,2,3,4,5,6,7,8,9},
            {1,2,3,4,5,6,7,8,9},
            {1,2,3,4,5,6,7,8,9},
            {1,2,3,4,5,6,7,8,9},
            {1,2,3,4,5,6,7,8,9},
    };
    int x=1, y=1;
    printArr(sudoku);
    while(true) {
        set_cursor(x,y);
        int c;
        switch (c=getch()){
            case KEY_UP:
                if(y>1) y-=2; break;
            case KEY_DOWN:
                if(y<17) y+=2; break;
            case KEY_LEFT:
                if(x>1) x-=2; break;
            case KEY_RIGHT:
                if(x<17) x+=2; break;
            default:
                if (c>48 && c<58) {
                    c-=48;
                    cout<<c;
                    sudoku[(y-1)/2][(x-1)/2]=c;
                }
        }
    }
    return 0;
}

void printArr(int sudoku[][9]){
    for (int i = 0; i <= 18; i++) {
        for (int j = 0; j <= 18; j++) {
            if (i % 6 == 0) cout << char(205);
            else if (j % 6 == 0) cout << char(186);
            else if (j % 2 == 0) cout << char(179);
            else if (i % 2 == 0) cout << char(196);
            else cout << sudoku[(i-1)/2][(j-1)/2];
        }
        cout << endl;
    }
}

void set_cursor(int x = 0 , int y = 0)
{
    HANDLE handle;
    COORD coordinates;
    handle = GetStdHandle(STD_OUTPUT_HANDLE);
    coordinates.X = x;
    coordinates.Y = y;
    SetConsoleCursorPosition ( handle , coordinates );
}