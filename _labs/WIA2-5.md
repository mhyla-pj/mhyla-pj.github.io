---
layout: lab
course: WIA2
type: [ niestacjonarne, stacjonarne ]
lab_nr: 5
subject: Arytmetyka
description: Niby proste, ale system zawiesić potrafi
---
Dzisiaj zaczniemy od dodawania i odejmowania, potem przejdziemy do dzielenia i mnożenia. Zaczniemy od utworzenia sobie labeli ze zmiennymi a, b oraz c. Wynik przechowamy sobie w y. Dzisiejsze zadania będziemy realizować na tych trzech „zmiennych”.

```nasm 
a dw 0x05
b dw 0x3B
c dw 0x4C
y dw 0x0
```

Pamiętać należy o tym, że w takie sposób:
```nasm
MOV AX, a
```
przypiszemy do rejestru AX adres z pamięci etykiety a. Jeśli chcemy umieścić tam wartość z pamięci, to tę etykietę wziąć musimy w nawias kwadratowy:

```nasm
MOV AX, [a]
```
## Instrukcje
Od najprostszych zaczynając: DEC i INC - instrukcje dekrementujące i inkrementujące. Przyjmują jeden argument - rejestr lub adres w pamięci - i zmniejszą lub zwiększą podaną wartość o 1.

```nasm
INC AX
DEC [b]
```

Dalej czeka nas dodawanie i odejmowanie. ADD i SUB są rownież bardzo proste - przyjmują dwa argumenty, z czego pierwszy musi być rejestrem lub adresem z pamięci, drugi natomiast może być rejestrem, adresem z pamięci lub sztywną wartością - podanie jako obu argumentów adresów z pamięci nie jest możliwe. Wynik operacji przechowywany będzie w pierwszym podanym argumencie.

```nasm
ADD AX, 5h      ;AX=AX+5
SUB AX, 10h     ;AX=AX-10h
```

Najtrudniejszymi operacjami będą MUL i DIV - obie te operacje przyjmują tylko jeden argument, natomiast drugi argument determinowany będzie na podstawie rozmiaru tego podanego. 

Jeśli do MUL podany argument będzie rozmiaru *byte*, to przemnożony zostanie rejestr AL, wynik umieszczony w AX. Jeśli podany argument będzie miał rozmiar *word*, to przemnożony przez niego zostanie rejestr AX, a wynik przechowany będzie na parze DX:AX

```nasm
MUL DL      ;AX=AL*DL
```

Jeśli do DIV podany argument będzie rozmiaru *byte*, to podzielony zostanie rejestr AX, wynik umieszczony w AL, reszta w AH. Jeśli podany argument będzie miał rozmiar *word*, to podzielona przez niego zostanie liczba zapisana na parze DX:AX, wynik przechowany będzie w AX, reszta w DX.

```nasm
DIV DL      ;AL=AX/DL
```


