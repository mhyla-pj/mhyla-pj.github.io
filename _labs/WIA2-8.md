---
layout: lab
course: WIA2
type: stacjonarne
lab_nr: 8
subject: Paint - funkcje, przerwania myszy
description: Ho ho ho, wesołych świąt!
nav-exclude: true
---
Dziś i w następnym tygodniu zajęcia bardzo przyjemne, ponieważ pracować będziemy razem. Celem Tego bloku zajęć jest stworzenie aplikacji do rysowania, tak abyście mogli na koniec przedświątecznych zajęć narysować w własnoręcznie napisanym paincie kartkę świąteczną. Wszystkie nadające się kartki umieszczę w galerii na stronie, jak tylko wyczaję, jak tu zrobić galerię.

## Założenia podstawowe

- Aplikacja ma działać w trybie graficznym [Int 10/AH=00h](http://www.ctyme.com/intr/rb-0069.htm)
- Rysujemy za pomocą myszy [Int 33](http://www.ctyme.com/intr/int-33.htm)
- Kolory zmieniamy wybranym klawiszem [Int 16](http://www.ctyme.com/intr/int-16.htm)
- Rozmiar pędzla zmieniamy innym klawiszem

Ten materiał traktować należy jako podstawowy skrypt, bardziej szczegółowy kod stworzymy na zajęciach

## Zaczynamy
Pierwszą rzeczą, którą musimy zrobić, to włączenie kursora. [Int 33/AX=0001h](http://www.ctyme.com/intr/rb-5957.htm).

```nasm
org 100h
mov AX, 0001h
int 33h


mov AH, 4Ch
int 21h
```

Następnie proponuję napisać pętlę nieskończoną, tak, aby program nie zamykał się od razu po uruchomieniu.

```nasm
main_loop:

jmp main_loop
```

Ta pętla ma jeden zasadniczy problem - nie da się z niej wyjść. Proponuję użyć klawisza ```q```.

```nasm
main_loop:
        mov AH, 00h
        int 16h
        cmp AL, 'q'
je koniec  
jmp main_loop
```

## Tryb graficzny

Na początek, odrobinę teorii i historii (ale mało, obiecuję). W czasach komputera łupanego kluczowym elementem, który pozwalał na wyświetlanie obrazu była karta VGA (Video Graphics Array). To fizyczne urządzenie generowało na podstawie przerwań sygnał wideo, który wyświetlany był na ekranie. Standardowe karty VGA obsługiwały kilka trybów graficznych i tekstowych, zależnych od modelu, z których każde oferowało inną rozdzielczość, paletę kolorów i co najważniejsze: tryb wyświetlania. 

| **Tryb** | **Rozdzielczość** | **Kolory** | **T/G** | **CharBlock** | **AlphaRes** |
|----------|-------------------|------------|---------|---------------|--------------|
| 0,1      | 360x400           | 16         | T       | 9x16          | 40x25        |
| 2,3      | 720x400           | 16         | T       | 9x16          | 80x25        |
| 4,5      | 320x200           | 4          | G       | 8x8           | 40x25        |
| 6        | 640x200           | 2          | G       | 8x8           | 80x25        |
| 7        | 720x400           | mono       | T       | 9x16          | 80x25        |
| D        | 320x200           | 16         | G       | 8x8           | 40x25        |
| E        | 640x200           | 16         | G       | 8x8           | 80x25        |
| F        | 640x350           | mono       | G       | 8x14          | 80x25        |
| 10       | 640x350           | 16         | G       | 8x14          | 80x25        |
| 11       | 640x480           | 2          | G       | 8x16          | 80x30        |
| 12       | 640x480           | 16         | G       | 8x16          | 80x30        |
| 13       | 320x200           | 256        | G       | 8x8           | 40x25        |

[Źródło](https://cs.lmu.edu/~ray/notes/pcvideomodes/)

Nas interesuje tryb graficzny, myślę że 16 kolorów w zupełnośći nam wystarczy, aby stworzyć piękną kartkę, dlatego też proponuję tryb 0x0E, najwyżej potem zmienimy. Skorzystamy z przerwania [Int 10/AH=00h](http://www.ctyme.com/intr/rb-0069.htm)

Na początku programu umieszczam:

```nasm
mov AH, 00h
mov AL, 0Eh
int 10h
```

Przydałoby się również wrócić na koniec programu do domyślnego trybu tekstowego. Oczywiście możemy po prostu odpalić polecenie cls po zakończeniu rysowania, ale wtedy nie tworzylibyśmy profesjonalnego oprogramowania. A przecież tworzymy tutaj poważny program.

## Przechwytywanie kursora

Potrzebne przerwanie to [Int 33/AX=0003h](http://www.ctyme.com/intr/rb-5959.htm). Zwróci ono status przycisków i aktualną pozycję kursora - bieżąca kolumna zwracana jest w rejestrze CX, wiersz natomiast w rejestrze DX.

W pętli głównej programu umieścić musimy instrukcję, która sprawdzać nam będzie, gdzie dokładnie znajduje się kursor:

```nasm
mov AX, 0003h
int 33h
```

Przerwanie to w rejestrach CX i DX zwraca kolumnę i wiersz, w których znajduje się kursor. Narysujemy teraz w tym miejscu piksel przerwaniem [Int 10/AH=0Ch](http://www.ctyme.com/intr/rb-0104.htm). Fartownie, kolumna i wiersz, w których narysowane mają być piksele pobierane są z tych samych rejestrów, w których przed chwilą zostawiło nam je przerwanie 33h. 

```nasm
mov AX, 0003h   ;|
        int 33h         ;|Przechwycenie poz. kursora

        mov AH, 0Ch     ;|
        mov AL, 0Ch     ;|
        mov BH, 0h      ;|
        int 10h         ;|Wydruk piksela na pozycji kursora
```

```
Bitfields for mouse button status:

Bit(s)  Description     (Table 03168)
0      left button pressed if 1
1      right button pressed if 1
2      middle button pressed if 1 (Mouse Systems/Logitech/Genius)
```
