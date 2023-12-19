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

```nasm
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

## Tablice

Śmieszna sprawa, wyobraźcie sobie, bo powiązanie wskaźników z tablicami jest dość silne. Na przykład, wskaźnikiem wskazującym na początek tablicy możemy manipulować i w ten sposób uzyskiwać dostęp do kolejnych elementów tablicy nie używając standardowych indeksów:

```c++
int arr[]={2, 1, 37};
int *ptr = arr;
for(int i=0; i<sizeof(arr)/sizeof(*ptr);i++){
     cout<<"Wartość zmiennej pod adresem:"<<ptr+i
     <<": "<<*(ptr+i)<<endl;
}
```

Wykonanie powyższego kodu wydrukuje nam wszystkie elementy tablicy wraz z ich adresami. Można tu zauważyć ciekawą właściwość wskaźników, bowiem w sytuacji, gdy ptr mawartość0x7ff7ba4ae6b0, toptr+1niebędziemiałowartości...e6b1,a...e6b4,czyli zwiększenie wskaźnika o 1 tak naprawdę zwiększyło go o 4. Bierze się to z tego, że inkrementując wskaźnik nie zwiększamy zawartego w nim adresu o 1, a o rozmiar typu danego wskaźnika. W powyższym wypadku typem jest int, który ma rozmiar 4 bajtów, dlatego wskaźnik zwiększany jest o 4.

## Funkcje

Gdy przekazujemy do funkcji jakąś zmienną, przy założeniu nie jest ona globalna, to przy wywołaniu tej funkcji stworzona zostanie kopia tejże zmiennej, więc zmienna podana w wywołaniu nie jest w żaden sposób modyfikowana, wewnątrz funkcji pracujemy bowiem na jej kopii.

```c++
void test(int param);
int main (){
    int a=10;
    test(a);
    cout<<a;
    return 0;
}
void test(int param){
    param=param+8;
}
```

W powyższym, raczej głupim, przykładzie wywołamy funkcję test na zmiennej a, ale jeśli sprawdzimy sobie adresy zmiennych a i param, to okaże się, że są to zupełnie inne zmienne,
znajdujące się w różnych lokalizacjach, a jedynie z takimi samymi wartościami. Co za tym idzie,modyfikujączmiennąparam nietykamyzmienneja.
Inaczej mieć się będzie sytuacja, w której do funkcji podany zostanie wskaźnik.

```c++
void test(int *param);
int main (){
    int a=10;
    test(&a);
    cout<<&a<<" "<<a;
    return 0;
}
void test(int *param){
    cout<<param<<" "<<*param<<endl;
    *param=*param+8;
}
```

## Tablice dynamiczne

Na pewno spotkać się mogliście w swojej dotychczasowej karierze programistycznej z sytuacją, w której chcieliście stworzyć tablicę, ale chcieliście, aby jej rozmiar był determinowany w trakcie działania programu. Taki problem rozwiązują tablice dynamiczne.

```c++
int *dynamicznaTablica2 = new int[5];
```

takie rozwiązanie stworzy nam tablicę o rozmiarze 5. Kluczowy jest tu operator ```new```, który zaalokuje nam odpowiedni blok pamięci. Najważniejsze jest jednak to, że dzięki temu mechanizmowi możemy stworzyć tablicę, na którą pamięć, w przeciwieństwie do tablicy statycznej, zostanie zarezerwowana w momencie wywołania:

```c++
int rozmiar = 10;
int *dynamicznaTablica = new int[rozmiar];
```

 Pamiętać należy o usunięciu takiego dynamicznego elementu w momencie, w którym wiemy już, że nie będziemy go potrzebowali:

```c++
delete[] dynamicznaTablica;
```
