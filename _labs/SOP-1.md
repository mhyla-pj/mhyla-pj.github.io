---
layout: lab
course: SOP
type: stacjonarne
lab_nr: 1
subject: Bash - przypomnienie
description: niby to co było na UKOS, ale nie do końca
---
W pierwszym semestrze, na przedmioche UKOS zajmowaliśmy się obsługą systemów operacyjnych od strony praktycznej, na tym przedmiocie postaramy się ugryźć temat systemów operacyjnych od strony technicznej. Niemniej, zaczniemy od przypomnienia i wyrównania poziomu.

Powłoka systemowa, z ang. *shell* to specjalny program, który pośredniczy pomiędzy systemem operacyjnym a użytkownikiem. Powłoka przyjmuje polecenia od użytkowanika, przekazuje je do programów i (opcjonalnie) zwraca wynik działania programu. Powłok systemowych jest mnóstwo, jednak tymi nabardziej znanymi są 
- bash - Bourne-Again Shell - standardowa powłoka UNIX
- cmd.exe - Windows 2000 i nowsze
- fish - friendly interactive shell
- zsh - UNIX/macOS

Powyższe są powłokami tekstowymi, ale to nie jest jedyny rodzaj powłoki systemowej, te same zadania bowiem spełnić mogą powłoki graficzne, jak
- Windows Explorer
- finder
- GNOME Shell

## Zmienne

W systemach unixowych zmienne programowe(ew. lokalne – dla nas po prostu zmienne), czyli takie, które są wykorzystywane wewnątrz skryptu, nie są dostępne dla innych programów. Przechowywane są w formie klucz:wartość. Zwykle zapisujemy je małymi literami, chociaż nie jest to wymagane

```bash
zmienna=jajco
zmienna=10
zmienna = SOP to super przedmiot #błąd 
```

W powyższym przykładzie wkradł się błąd - dlaczego takie rozwiązanie jest błędne? Pownieważ takie polecenie bash zrozumie jako próbę uruchomienia programu *zmienna* z argumentami *=*, *SOP*, *to* itd. Jeśli chcelibyśmy takiego zawierającego spacje stringa przypisać do zmienej, to powinniśmy zamknąć go w cudzysłów.

```bash
zmienna="SOP to super przedmiot"
```

Odwoływać się do zmiennej w bashu można poprzez postawienie przed jej nazwą znaku $. Odwoływać się do zmiennej można właściwie wszędzie, tak długo, jak będzie to w obrębie tej samej instacji powłoki, ponieważ zwykłe zmienne są niedostępne poza nim - tak jak zmienne lokalne wewnątrz jakiegoś programu. 

```bash
michal@MacBook-Air ~ % zmienna=10
michal@MacBook-Air ~ % echo 'Pożycz no $zmienna złotych'
Pożycz no $zmienna złotych
michal@MacBook-Air ~ % echo "Pożycz no $zmienna złotych"
Pożycz no 10 złotych
```

Powyższy przykład prezentuje różnicę pomiędzy interpretacją zmiennej zamkniętej w apostrofy, a zamkniętą w cudzysłów. To dość ważny mechanizm, nie jeden student już na tym poległ, więc warto pamiętać.

### Zmienne środowiskowe
Specjalnym rodzajem zmiennych są zmienne środowiskowe. Zmienne programowe są widoczne tylko w bieżącej instancji powłoki, tj. w aktualnie wykonywanym skrypcie, terminalu. Zmienne środowiskowe natomiast będą widoczne w obrębie całej powłoki. Te zapisujemy zwykle wielkimi literami

```bash
export SOP="super przedmiot"
```
Do takiej zmiennej uzyskujemy dostęp w dokładnie taki sam sposób jak do zwykłej, stawiając przed jej nazwą znak $. Do listy wszystkich zadeklarowanych zmiennych środowiskowych uzyskamy dostęp przy użyciu polecenia 
```bash
printenv
```

## Skrypty
Skrypty basha pozwala nam wykonać serię akcji (poleceń) terminala, nie wymagając od nas równocześnie wchodzenia w ogóle w terminal. Podstawowa zasada jest taka: wszystko, co możemy odpalić z terminala, możemy również wykonać przy użyciu skryptu. Odwrotnie też działa: wszystko co możemy zrobić w skrypcie, zadziała również w terminalu. 

```bash
#!/bin/bash
echo podaj liczbę
read zmienna

echo podałeś $zmienna

expr $zmienna + 10
```

ten umiarkowanie ambitny skrypt odczyta od użytkownika liczbę do zmiennej, wydrukuje ją oraz wypisze wynik dodania jej do 10. 

```bash
podaj liczbę
10
podałeś 10
20
``` 
## Strumienie
Każdy proces w systemach UNIX działa według tego samego schematu - pobiera dane ze standardowego wejścia, wynik działania wysyłają na standardowe wyjście, błędy przekierowują na standardowe wyjście błędów.
- stdin (domyślnie klawiatura) - strumień wejściowy
- stdout (domyślnie terminal) - strumień wyjściowy
- stderr (domyślnie terminal) - strumień wyjściowy błędów

Możemy jednak tymi strumieniami bez problemów zarządzań i przekierowywać je w inne miejsca, np. zapisać strumień wyjściowy do pliku, przekazać go do innego polecenia, albo wysłać do *sinka* (/dev/null/). 
- ```<``` pozwoli na przekierowanie strumienia wejściowego. 
  ```bash
  less jajco.txt
  ```
  to to samo co
  ```bash
  less < jajco.txt
  ```
- ```>``` pozwala na przekierowanie stdout do pliku. W tym przypadku, jeśli plik istnieje, to jego zawartość zostanie zastąpiona przyjętym strumieniem
- ```>>``` również pozwoli na przekierowanie stdout do pliku, z tą różnicą, że w tym wypadku przyjęty strumień nie zastąpi zawartości pliku, a zostanie dopisany na jego końcu
- ```|``` pozwala na przesłanie stdout jednego polecenia na stdin kolejnego, np.
  ```bash
  sort przyklad.txt | nl
  ```
- ```2>``` i ```2>>``` analogicznie jak przekierowania stdout, jednak w tym przypadku przekierowywany będzie stderr

## Przydatne polecenia
Większość z nich pojawiła się już na UKOS - przynajmniej na moich, ale dla przypomnienia
- Pliki i katalogi
  - ```cd``` - zmiana katalogu roboczego
  - ```ls``` wyświetlenie listy plików i katalogów
  - ```mkdir``` - tworzenie nowego katalogu
  - ```touch``` - tworzenie nowego pustego pliku
  - ```rm``` - usuwanie pliku
  - ```rmdir``` - usuwanie katalogu
  - ```cp``` - kopiowanie
  - ```mv``` - przenoszenie
  - ```tree``` - drzewko plików i katalogów
- Praca na tekście
  - ```sort``` - sortowanie wierszy
  - ```nl``` - numerowanie wierszy
  - ```wc``` - zliczanie wierszy, słów i znaków
  - ```head``` - wyświetlenie pierwszych *n* linii pliku
  - ```tail``` - wyświetlenie ostatnich *n* linii pliku
  - ```grep``` - wyszukiwanie patternów (regex)
  
