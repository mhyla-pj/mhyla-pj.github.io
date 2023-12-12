---
layout: lab
course: PRG
type: stacjonarne
lab_nr: 14
subject: Wskaźniki
description: Wskazana jest najwyższa czujność
---

Każda zmienna przy inicjalizacji ma przypisywany swój adres w pamięci. Gdy w programie umieścimy definicję:

```c++
int i=200;
```

to tak naprawdę, gdzieś w pamięci RAM umieszczona zostanie wartość 200, a jej adres zostanie zapamiętany. Zawsze, gdy będziemy chcieli się do wartości zlokalizowanej w pamięci odwołać, to kompilator nie będzie widział nazwy tej zmiennej, a jej konkretny adres, nazwa jest tylko dla nas.

Sprawdzić, pod jakim adresem znajduje się konkretna zmienna możemy używając operatora ‘&’ ustawionego przed nazwą zmiennej.

```c++
int i=200;
int j=100;
cout<<i<<" "<<&i<<endl;
cout<<j<<" "<<&j<<endl;
```

Możemy teraz w terminalu zobaczyć, gdzie te zmienne w pamięci wylądowały:

```
200 0x7ff7b47cf6b8
100 0x7ff7b47cf6b4
```

Możemy też zobaczyć, że te zmienne umieszczone zostały obok siebie, jedna po drugiej (konkretnie jedna przed drugą).

**Wskaźnikiem** nazywamy zmienną, której wartością jest adres innej zmiennej. Dokładnie tak samo, jak w wypadku każdej innej zmiennej, najpierw musimy ten wskaźnik **zadeklarować** i dokładnie tak samo jak z każdą inną zmienną, **wskaźnik musi mieć swój typ**.

```c++
int* ptr;
```

Różnica pomiędzy wskaźnikiem a zmienną jest dość spora, ponieważ każdy wskaźnik, mimo że musimy określić jakiego będzie typu, to tak naprawdę zawsze będzie długą liczbą heksadecymalną. Określenie typu służy do określenia, na jakiego typu zmienną taki wskaźnik będzie wskazywał. Dzięki temu kompilator może zweryfikować, czy na pewno operacje na wskaźniku są operacjami dopuszczalnymi na wskazywanej zmiennej. Również dzięki temu inkrementacja wskaźnika zwiększy go o rozmiar danego typu danych.

```c++
int i=200;
int* ptr;
ptr = &i;
cout<<i<<" "<<&i<<endl;
cout<<ptr<<" "<<*ptr<<endl;
```

Do zadeklarowanego wskaźnika przypisywać możemy w zasadzie jedynie adres zmiennej, pamiętając o zgodności typów danych. I teraz ważne. Adres zmiennej uzyskamy stawiając przed nią ‘&’, natomiast wartość zmiennej, której adres przechowuje wskaźnik uzyskamy stawiając przed nim ‘*’.

