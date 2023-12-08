---
layout: lab
course: SOP
type: stacjonarne
lab_nr: 07
subject: I/O, pliki
description: The file is a lie
---

Pliki mogą być używane do przechowywania danych, niespodzianka. Plik reprezentuje sekwencję bajtów, niezależnie od tego, czy jest to plik tekstowy, czy binarny. Pliki są również bezpiecznym miejscem przechowywania danych, nawet w wypadku jakiejś nagłej awarii, wywalenia programu, prądu, whatever, dane w plikach nie znikną. Język C dostarcza całkiem sporo narzędzi do obsługi plików.

## Otwieranie plików

Do tego użyjemy funkcji fopen(). Jest ona w stanie zarówno otworzyć plik oraz stworzyć go (i otworzyć), jeśli wcześniej nie istniał. To wywołanie inicjalizuje obiekt typu FILE, który będzie zawierał informacje potrzebne do obsługi strumienia.

```c
FILE *fopen( const char * filename, const char * mode );
```

filename jest tutaj stringiem z nazwą pliku (i jego lokalizacją). Mode natomiast oznacza jeden z trybów dostępu:

- r - Otwiera plik w trybie do odczytu
- w - Otwiera plik w trybie do zapisu. Jeśli plik nie istnieje, jest tworzony, jeśli istnieje i ma
zawartość, zostanie ona usunięta
- a - Otwiera plik w trybie „append”. Dane będą dopisywane na końcu, . Operacje
pozycjonowania (fseek, fsetpos) są ignorowane
- r+ - Otwiera plik w trybie odczytu/zapisu. Plik musi istnieć
- w+ - Otwiera plik w trybie odczytu/zapisu. Jeśli plik nie istnieje, jest tworzony, jeśli istnieje i ma
zawartość, zostanie ona usunięta
- a+ - Otwiera plik w trybie odczytu/zapisu. Dane będą dopisywane na końcu. Operacje
pozycjonowania (fseek, fsetpos) działają

```c
#include <stdio.h>

int main() {
    FILE *plik;
    char slowo[100];

    plik = fopen("nazwa_pliku.txt", "r"); // otwieranie pliku do odczytu

    if (plik == NULL) {
        printf("Nie udalo sie otworzyc pliku\n");
        return 1;
    }

    while (fscanf(plik, "%s", slowo) != EOF) { // odczyt slowo po slowie
        printf("%s ", slowo); // wyswietlenie
    }

    fclose(plik); // zamkniecie pliku
    return 0;
}
```

```c
#include <stdio.h>

int main() {
    FILE *plik;
    char slowo[100] = "Hello, world!";

    plik = fopen("nazwa_pliku.txt", "w"); // otwieranie pliku do zapisu

    if (plik == NULL) {
        printf("Nie udalo sie otworzyc pliku\n");
        return 1;
    }

    fprintf(plik, "%s", slowo); // zapisywanie slowa do pliku

    fclose(plik); // zamkniecie pliku
    return 0;
}
```

Pamiętać należy, że plik zawsze może się z jakiegoś powodu nie otworzyć, bo np. nie istnieje, a chcieliśmy go otworzyć w trybie „r”. W takim wypadku fopen zwróci NULL – a to już możemy wykorzystać z jakimś ifem, żeby wydrukować info o błędzie.
Do odczytu pliku możemy użyc funkcji fgetc() – odczytuje ona znak z miejsca wskazywanego przez wskaźnik i, gdy z sukcesem odczyta znak, przesuwa wskaźnik dalej. W momencie, w którym wskaźnik dotrze na koniec pliku, ta funkcja zwraca EOF (od End of File).

## Odczyt i zapis stringów
`fgets()` i `fputs()` to dwie z podstawowych funkcji wejścia/wyjścia w języku C, które służą do odczytu i zapisu danych z/do plików tekstowych. 

Funkcja `fgets()` służy do odczytu wiersza tekstu z pliku. Jej sygnatura wygląda następująco:

```c
char *fgets(char *str, int num, FILE *stream);
```

Argument `str` wskazuje na bufor, do którego zostanie zapisany odczytany wiersz tekstu. Argument `num` określa maksymalną ilość znaków, jakie mogą być odczytane (uwzględniając miejsce na znak końca wiersza). Argument `stream` to wskaźnik na plik, z którego ma być odczytany tekst. 

Funkcja `fputs()` służy do zapisu wiersza tekstu do pliku. Jej sygnatura wygląda następująco:

```c
int fputs(const char *str, FILE *stream);
```

Argument `str` wskazuje na napis, który ma być zapisany do pliku. Argument `stream` to wskaźnik na plik, do którego ma być zapisany tekst. 

Obie funkcje zwracają wartość różną od zera w przypadku sukcesu, a zero w przypadku błędu.