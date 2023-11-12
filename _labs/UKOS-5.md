---
layout: lab
course: UKOS
type: [ niestacjonarne, stacjonarne ]
lab_nr: 5
subject: Skrypty basha pt.2
description: 
---

Na poprzednich zajęciach poznaliśmy podstawy skryptowania. Dzisiaj poznamy dalsze podstawy skryptowania, czyli funkcje, pętle i może zrobimy kilka bardziej życiowych zadanek

## Pętle while
W języku C mogliście mieć już pętle while, do while i for. W skryptach basha są one całkiem podobne, ale - jak już zdążyliśmy się przyzwyczaić - z dziwną składnią. Poniższa pętla wykonuje się tak długo, jak warunek jest spełniony. Więc na przykład pętla ```while [ true ]``` będzie się wykonywać w
nieskończoność. 

```bash
while [ warunek ]
do
    cośtam
done
```

dla przykładu:

```bash
#!/bin/bash
licznik=10
while [ $licznik -gt 0 ]
do
    echo obejscie petli nr. $licznik
    ((licznik--))
done
```
Krótka analiza poniższego wyniku wskazać może, że nasz kod nie ma zbyt wiele sensu.

```bash
obejscie petli nr. 10
obejscie petli nr. 9
obejscie petli nr. 8
obejscie petli nr. 7
obejscie petli nr. 6
obejscie petli nr. 5
obejscie petli nr. 4
obejscie petli nr. 3
obejscie petli nr. 2
obejscie petli nr. 1
```

### Zadanie na 30 sekund
Popraw kod, żeby obejscia pętli liczyły się od 1 do 10

## Pętla until

Składniowo identyczna do pętli while, ale wykonuje się tak długo, jak warunek nie jest spełniony. Aby najprościej zobrazować: 
```bash
#!/bin/bash
licznik=10
until [ $licznik -le 0 ]
do
    echo obejscie petli nr. $licznik
    ((licznik--))
done
```

oraz:

```bash
#!/bin/bash
licznik=10
while [ $licznik -gt 0 ]
do
    echo obejscie petli nr. $licznik
    ((licznik--))
done
```

dają identyczne wyniki.

## Pętle for

Pętla for w bashu działać może już zupełnie inaczej niż znana z C, a bardziej jak wykorzystywany w nowszych wersjach C++pętla foreach. Tutaj pętli podajemy serię argumentów, a ona wykonuje się nam tyle razy, ile podamy jej elementów. 

```bash
for <var> in $zmienna
do
    cokolwiek
done
```

```bash
#!/bin/bash

lista="mango pineapple papaya"
for owoc in $lista
do
        echo Owoc: $owoc
done
```
i wynik powyższego, godnego inżyniera kawałka kodu:

```bash
michal@MacBook-Air-3 skrypty % ./s1.sh   
Owoc: mango
Owoc: pineapple
Owoc: papaya
```

W razie czego, niespokojnych uspokoję, znana nam wszystkim pętla for również działa:

```bash
#!/bin/bash

for ((i=0;i<10;i++))
do
	echo obejscie: $i
done
```

Ważna uwaga: w wypadku pętli for-each (tego fora, którego omawialiśmy jako pierwszego) pętla będzie wykonywać się na dowolnej podanej liście, więc możemy na przykład podać tam wynik polecenia find, albo ```$@```, pętla również zadziała.

## Case
Porównanie case do znanego z C switcha jest nieuniknione:

```bash
case $zmienna in
    przypadek1) instrukcja;;
    przypadek2 | przypadek3) instrukcja;;
    *) instrukcja dla każdego innego przypadku;;
esac
```

Warto zwrócić uwagę na trzecią linię powyższego przykładu. Takie zastosowanie pozwala nam na wykorzystanie jednej instrukcji dla kilku przypadków.

## Funkcje

```bash
#!/bin/bash

nazwa_funkcji(){
        #zawartość_funkcji
}
nazwa_funkcji   #wywołanie funkcji
```

Do funkcji możemy podawać również argumenty. Działa to dokładnie w ten sam sposób, w jaki podawanie argumentów do skryptu, z tą różnicą, że argumenty podawane są po wywołaniu wewnątrz skryptu, nie z wiersza poleceń:

```bash
#!/bin/bash
funkcja(){
        echo Podano argument: $1
}

funkcja 123
```


