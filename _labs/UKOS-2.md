---
layout: lab
course: UKOS
type: [ niestacjonarne, stacjonarne ]
lab_nr: 2
subject: Linux, część druga
description: Pliki tekstowe, wyszukiwanie
---
Na pierwszych zajęciach poznaliśmy totalne podstawy posługiwania się wierszem poleceń, przenosiliśmy pliki, ogarnęliśmy ścieżki, kopiowanie i różne takie. Tych, którzy zapomnieli odsyłam do skryptu z laboratorium 1.
Na dzisiejszych zajęciach zajmiemy się bardziej zaawansowanymi metodami pracy z terminalem, nadamy katalogom i plikom uprawnienia, zastosujemy filtry i popracujemy trochę z tekstem.

## Wildcards, czyli znaki specjalne
Czasem może zdarzyć się sytuacja, w której potrzebujemy wykonać operację na wielu plikach, które mają jakiś element wspólny. Takimi plikami mogą być na przykład logi aplikacji, przepisy na lasagne, czy pliki o określonym rozszerzeniu. Tutaj z pomocą przychodzą nam tzw. wildcards. W uproszczeniu zastępują one jeden lub wiele znaków. Na przykład:
```bash
ls *.txt
```
Wyszuka nam wszystkie pliki txt w katalogu, w którym wykonamy polecenie.

Podstawowymi znakami specjalnymi są:
- ```*``` - zastępuje dowolny ciąg dowolnych znaków
- ```?``` - zastępuje jeden dowolny znak
- ```[]``` - umieszczony wewnątrz zakres znaków

Dla przykładu, aby znaleźć wszystkie pliki z PJATK w nazwie, w naszym katalogu z przepisami użyjemy polecenia
```bash
ls Pjatk*
```

to polecenie zwrócić nam może np.
- Katalog Pjatk
- plik Pjatk.txt
- plik Pjatk.png

Pamiętając jednak, że Linux jest case-sensitive, wiemy, że mogą być tu jakieś pliki, które nie wpadają w filtr. 

```bash
ls ?jatk*
```
takie polecenie odszuka również
- katalog pjatk
- plik pjatk.txt

Pamiętać jednak należy, że ```?``` zastępuje dowolny znak. Jeśli zależy nam tylko na literach P i p, to prawdopodobnie powinniśmy podać ciąg dopuszczalnych na pierwszej pozycji znaków:

```bash
ls [pP]jatk*
```

Pozostaje nam zastosowanie ostatniego wildcarda, nawiasów kwadratowych []. W tym nawiasie możemy określić znaki, bądź ich zakres.

```bash
ls [jkm]*
```
wyszuka nam pliki, których nazwa zaczynać się będzie od liter j, k lub m.

```bash
ls *[0-5]*
```
wyszuka nam pliki i katalogi, które zawierać będą cyfrę od 0 do 5;

```bash
ls [^h-n]*
```
wyszuka nam pliki i katalogi, które NIE ZACZYNAJĄ się od litery w zakresie od h do n. Za odwrócenie takiego ciągu odpowiada znak ^

Ważna uwaga: wildcardy są częścią powłoki, nie poleceń, bądź programu. Możemy ich w ten sposób używać w terminalu dla dowolnego polecenia. Dla przykładu życiowego zastosowania, przeniesiemy teraz wszystkie przepisy na lasagne z katalogu Obiady do katalogu Przepis

```bash
mv Obiady/?asagne* Przepisy
```

### Zadanie na rozgrzewkę

Utwórz dwa katalogi o dowolnych nazwach. Dla potrzeb tego ćwiczenia nazwę je Katalog1 i Katalog 2. W Katalogu1 wykonaj polecenie

```bash
touch list.txt lost last.txt tost.txt ticket.txt post.txt
```

Twoim zadaniem jest przekopiować (cp) pliki list.txt, lost oraz tost.txt do drugiego katalogu używając tylko jednego polecenia.

## Uprawnienia
Z różnymi poziomami uprawnień spotkać się możemy na co dzień korzystając z komputera, chociażby na sprzęcie uczelnianym, gdzie nikt nie ma praw do niczego. W systemie Linux rozróżniamy trzy rodzaje uprawnień, które możemy nadać trzem grupom użytkowników. Polecenie
```bash
ls -la
```

wypisze nam listę plików. Pierwsze 10 znaków w wierszu oznaczają właśnie uprawnienia. Teraz je odczytamy.

```bash
drwxr-xr-x@  3 michal  staff       96 18 mar  2023 scripts
-rw-r--r--   1 michal  staff       58 17 mar  2023 skrypt
-rw-r--r--@  1 michal  staff     1093  5 lip 23:52 sop-egz.csv
```

Pierwszy znak sygnalizuje, czy mamy do czynienia z katalogiem, czy plikiem. d oznacza katalog (directory), ‘-‘ oznacza plik. Dalej następuje ciąg 9 znaków, rozkodujemy go teraz.
1. **r**ead – uprawnienia do odczytywania pliku
2. **w**rite – uprawnienia do zmiany zawartości pliku
3. e**x**ecute – uprawnienia do wykonania pliku

Dla każdego pliku określamy trzy grupy użytkowników:
1. **u**ser – właściciel, zwykle osoba, która utworzyła plik, choć niekoniecznie
2. **g**roup – grupa
3. **o**ther – pozostali
znaki odczytujemy standardowo, od lewej strony. Pierwszy znak określa nam czy mamy do czynienia z katalogiem czy plikiem, kolejne 3 znaki to uprawnienia, które posiada właściciel, kolejne 3 to uprawnienia grupy, a 3 ostatnie to uprawnienia pozostałych.

## Nadawanie i odbieranie uprawnień
Do zmiany uprawnień pliku/katalogu służy polecenie
```bash
chmod [uprawnienia][ścieżka]
```

argumenty uprawnień składają się natomiast z 3 kolejnych elementów:
1. Komu zmieniamy uprawnienia? [ugoa] (user, group, others, all)
2. Nadajemy, czy zabieramy uprawnienia: (+) nadaje, (-) odbiera
3. Jakie uprawnienia zmieniamy? [rwx]

Tak więc, aby nadać uprawnienia do zapisu pliku obiady.txt pozostałym użytkownikom użyjemy polecenia

```bash
chmod o+w obiad.txt
```

Po wykonaniu polecenia możemy poleceniem ls sprawdzić, czy faktycznie uprawnienia zostały zmienione

## Filtrowanie
Czym w ogóle są filtry? W linii poleceń linuxa możemy określić je jako programy, które pobierają tekst oraz transformują go w zadany sposób. Podstawowymi filtrami są:

```bash
head [-liczba linii do wyświetlenia] [ścieżka]
```

Wyświeli nam on pierwsze x linii w pliku. Domyślna ilość linii do wyświetlenia to 10;

```bash
tail [-liczba linii do wyświetlenia] [ścieżka]
```

To zupełne przeciwieństwo polecenia head. Wyświetla ostatnich x linii;



```bash
sort [-opcje] [ścieżka]
```

Domyślnie posortuje nam zawartość pliku alfabetycznie, ale zachęcam do sprawdzenia manuala, opcji jest multum;
```bash
nl [-opcje] [ścieżka]
```

ponumeruje linie;
Powyższe to tylko przykłady, ponieważ opcji sortowania jest naprawdę sporo, jak chociażby sed, cut, uniq czy tac. Odsyłam do manuala, aby poznać ich dokładne zastosowanie, przyda się do zadania.

## Zadanie 2

Utwórz plik z listą zakupów w formacie
[Sklep] [produkt] [ilość]
Czyli dla przykładu:
```bash
Lidl ogórki 7
Lidl jajka 10
Auchan Coca-Cola 12
E.Leclerc Browar 128
```
Niech tych pozycji będzie co najmniej 15. Następnie spróbuj wyświetlić tylko zakupy, które zrobić trzeba w Lidlu. Jeszcze raz: odsyłam do manuala!


