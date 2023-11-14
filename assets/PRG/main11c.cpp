#include <iostream>
using namespace std;

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

int main() {
    while(true) {
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
    return 0;
}
