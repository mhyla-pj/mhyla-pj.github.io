#include <iostream>
#include <windows.h>
#include <conio.h>
using namespace std;
#define KEY_UP 72
#define KEY_DOWN 80
#define KEY_LEFT 75
#define KEY_RIGHT 77


void printArray(int sudoku[][9]);
void set_cursor(int,int);
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
    int a;
    system("chcp 437");
    system("cls");
    printArray(sudoku);
    int x=1 , y=1;
    int c;
    while (true){
        set_cursor(x,y);
        switch(c=getch()){
            case KEY_UP:
                if(y>1) y-=2; break;
            case KEY_DOWN:
                if(y<=15) y+=2; break;
            case KEY_LEFT:
                if(x>1) x-=2; break;
            case KEY_RIGHT:
                if(x<=15) x+=2; break;
            default:
                if (isdigit(c)) {
                    cout<<char(c);
                    sudoku[(y-1)/2][(x-1)/2]=c;
                }

        }
    }
}

void printArray(int sudoku[][9]){
    for (int i=0; i<=18;i++){
        for (int j=0;j<=18;j++){
            if (i==0 && j==0) cout<<char(201);
            else if (i==0 && j==18) cout<<char(187);
            else if (i==18 && j==0) cout<<char(200);
            else if (i==18 && j==18) cout<<char(188);
            else if (j%6==0){
                if (i%6==0) cout<<char(206);
                else cout<<char(186);
            }
            else if(i%6==0) cout<<char(205);
            else if(i%2==0 && j%2==0) cout<<char(197);
            else if (i%2==0 && i%3!=0) cout<<char(196);
            else if (j%2==0 && j%3!=0) cout<<char(179);
            else cout<<sudoku[(i-1)/2][(j-1)/2];
        }
        cout<<endl;
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


