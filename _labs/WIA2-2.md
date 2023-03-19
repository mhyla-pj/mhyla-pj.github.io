---
layout: lab
course: WIA2
type: [ niestacjonarne, stacjonarne ]
lab_nr: 2
subject: Wstęp do asemblera, przerwania
description: Programowanie ery krzemu łupanego
---
Na tym przedmiocie zajmować się będziemy w pełni asemblerem architektury x86. Programy napisane w assemblerze są zazwyczaj bardziej wydajne i zajmują mniej miejsca niż programy napisane w językach wysokiego poziomu, na przykład C/C++, a zawsze będą wydajniejsze od Javy. Niezależnie od tego, asembler nie jest językiem łatwym, a napisanie nawet podstawowego programu wymagać będzie od programisty podstawowego zrozumienia architektury komputera.

## Środowisko
Pracować będziemy na procesorze 80486, konkretnie jego zemulowanej wersji, którą uruchomimy w środowisku DOSBox. Instrukcja instalacji i konfiguracji środowiska [tutaj](../wia2-dosbox)

## Architektura x86
Pamięcią i tym, jak dokładnie współpracuje ona z procesorem zajmiemy się w nieodległej przyszłości, na ten moment wystarczy nam wiedza, że program wraz z danymi wczytywany jest z pamięci instrukcja po instrukcji. 
1. Transferowe:
   1. MOV - instrukcja przyjmująca 2 argumenty. Pierwszy z nich będzie miejscem docelowym, drugi źródłowym
   ```asm
   MOV AX, 10h
   ```
   2. PUSH - instrukcja zapisująca podany argument na stosie
   3. POP - instrukcja zdejmująca podany argument ze stosu
2. Arytmetyczne
   1. ADD
   2. SUB
   3. MUL
   4. DIV
3. Pozostałe:
   1. INT - wywołuje podane jako argument przerwanie

## Przerwania
Aby zapewnić interakcję między procesorem a innymi elementami systemu, w tym zewnętrznymi urządzeniami i oprogramowaniem, procesor wykorzystuje mechanizm przerwań. Idea jest taka, że procesor nie powinien cały czas kontrolować, co dzieje się na urządzeniach I/O. Robi to dopiero w momencie, w którym dostanie odpowiedni sygnał - przerwanie. Jest to sygnał, który jest wysyłany do procesora przez urządzenie zewnętrzne lub przez oprogramowanie systemowe, aby przerwać wykonywanie aktualnej instrukcji przez procesor i zwrócić kontrolę do systemu operacyjnego lub innego programu. Przerwania procesora są istotnym elementem działania systemu operacyjnego i pozwalają na interakcję z zewnętrznymi urządzeniami oraz na kontrolę i zarządzanie zasobami systemowymi.

W momencie, w którym procesor otrzyma instrukcję przerwania, wykona procedurę obsługi przerwania. Procedura ta może wykonać różne czynności, takie jak przetworzenie danych z urządzenia zewnętrznego, aktualizacja systemowego timera, czy też obsługa błędów sprzętowych.

Jest bardzo dużo kategorii przerwań, ale korzystać będziemy z trzech podstawowych.
1. [21h](http://www.ctyme.com/intr/int-21.htm) - przerwanie systemu DOS. Zawiera procedury systemowe, jak wyświetlanie oraz odczytywanie znaków i stringów, tworzenie katalogów i wiele innych
2. [16h](http://www.ctyme.com/intr/int-16.htm) - zestaw przerwań klawiatury. Odczyty klawiszy, nie znaków.
3. [10h](http://www.ctyme.com/intr/int-10.htm) - przerwania wideo, pozwalające na bezpośrednią kontrolę karty graficznej, wyświetlania pikseli i znaków, kursora i innych.

Koncept przerwania może się wydawać bardzo skomplikowany, ale taki nie jest. Najważniejszym jest, aby wiedzieć, że pojedyncze przerwanie nie będzie pojedynczą funkcją, a zestawem tych funkcji. W momencie, w którym wywołamy przerwanie, sprawdzi ono, co znajduje się na rejestrze AX i wykona odpowiednią procedurę. 

```asm
mov AH, 02h
mov DL, 'H'
int 21h
```

Powyższy kod najpierw zapisze w rejestrze AH wartość 02h, następnie w rejestrze DL kod ASCII litery "H", czyli 48h. Następnie wywołane przerwanie 21h sprawdzi, co znajduje się na rejestrze AH, zobaczy tam 02h i uruchomi procedurę drukującą na ekranie literę, której kod ASCII znajdzie w rejestrze DL. 

Nie ma szans, żeby spamiętać wszystkie przerwania, dlatego konieczne będzie posługiwanie się dokumentacją


## Rejestry
Rejestry ogólnego przeznaczenia (AX, BX, CX, DX) - służą do przechowywania danych i wykonywania różnych operacji arytmetycznych. Każdy z tych rejestrów składa się z dwóch 8-bitowych rejestrów (AH, AL, BH, BL, CH, CL, DH, DL), które mogą być używane osobno lub łącznie.
1. Rejestr stosu (SP) - wskazuje na bieżącą pozycję na stosie. Przy wykonywaniu operacji PUSH lub POP, wartość rejestru SP jest automatycznie zmieniana.
2. Rejestr bazowy (BP) - służy do adresowania pamięci stosu. Jest to drugi rejestr stosu, który może być używany do adresowania elementów stosu, ale jego wartość nie ulega zmianie podczas wykonywania operacji PUSH i POP.
3. Rejestr indeksowy (SI, DI) - służą do adresowania danych w pamięci operacyjnej. SI jest często używany do adresowania źródła danych, a DI do adresowania celu.
4. Rejestr flagowy (FLAGS) - zawiera różne flagi, które informują procesor o wyniku ostatnio wykonanej operacji. Na przykład flaga ZF (Zero Flag) ustawia się na 1, jeśli wynik ostatniej operacji był równy zero, a flaga CF (Carry Flag) ustawia się na 1, jeśli wynik operacji przekroczył maksymalną wartość, jaką można przechować w rejestrze.
Oprócz tych rejestrów, w 16-bitowym procesorze x86 istnieją również rejestr IP (Instruction Pointer), który wskazuje na bieżącą instrukcję w programie, oraz rejestr CS (Code Segment), który wskazuje na segment kodu programu.

## Obsługa po stronie DOS
Kompilatorem, a właściwie asemblerem, którego będziemy używać będzie nasm. Aby zasemblować program do formy wykonywalnego pliku .COM należy wprowadzić polecenie
```
nasm plik_asm.asm -o wynik.com
```
Uruchomienie programu nastąpi po wpisaniu w terminal i zatwierdzeniu jego nazwy

Programy uruchomić można również w debuggerze insight poleceniem

```
insight wynik.com
```
Wewnątrz insighta przejście do następnej instrukcji wykonać będzie można poprzez wciśnięcie klawisza ```F8```

