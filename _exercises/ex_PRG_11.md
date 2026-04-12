---
layout: exercise
course: PRG
type: stacjonarne
lab_nr: 11
topic: Szlifujemy swoje umiejętności (do 28.11)
---
1. Napisz program, który zbada, czy wczytana z klawiatury liczba jest liczbą doskonałą. Liczba doskonała to taka, dla której suma jej dzielników jest równa tej liczbie. Program powinniśmy być w stanie wykonać wielokrotnie bez wracania do edytora.
2. Napisz program, który sprawdzi, czy wczytany ciąg znaków (do tablicy charów) jest palindromem, czyli czytany od początku do końca będzie taki sam. Załóżmy, że można wczytać max 30 znaków.
3. W oparciu o poniższy pseudokod napisz program, który dla zadanej tabeli będzie realizował sortowanie bąbelkowe.
```
procedure bubblesort(A : lista elementów do posortowania, n : liczba_elementów(A))
n = liczba_elementów(A) 
do
    for (i = 0; i < n-1; i++) 
        do: 
            if A[i] > A[i+1] then
                swap(A[i], A[i+1]) end if
    end for
    n = n-1 
while n > 1
end procedure
```
4. Napisz program, który dla wygenerowanej losowo tabeli liczb (1-1000) będzie realizował algorytm sortowania quicksort. Oceń szybkość działania algorytmu. Czyli, w funkcji głównej main, przy wywołaniu funkcji z algorytmem, użyj funkcji GetTickCount() i ocenić działanie algorytmu dla wypełnionej (losowymi wartościami) tabeli o trzech rozmiarach n = 25; 50; 100. Uzyskane wyniki porównaj z wynikami otrzymanymi dla funkcji z punktu 4.