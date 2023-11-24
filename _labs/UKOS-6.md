---
layout: lab
course: UKOS
type: [ niestacjonarne, stacjonarne ]
lab_nr: 06
subject: Pakowanie, data, czas
description: Niby skryptowanie, ale nie tylko
---
Celem dzisiejszych zajęć będzie napisanie skryptu, który wykona backup całego katalogu /home do pliku user_home_databackupu.tar.gz i zapisze go w katalogu /tmp/backup. Jak ktoś wie jak to zrobić to do roboty, jak nie, to na zajęciach przejdziemy przez wszystkie elementy składowe takiego skryptu, a waszym zadaniem będzie poskładanie tego do kupy.

## Pakowanie katalogu
Korzystać będziemy z programu tar. Jego nazwa pochodzi od Tape Archiver – głównie ze względu na to, że niegdyś służył do umieszczania plików na taśmach magnetycznych. Żyjemy jednak w relatywnie cywilizowanych czasach, więc zastosowanie tara się trochę zmieniło, teraz po prostu służy do pakowania wielu plików do jednego zbiorczego, tzw. archiwum. Tar pozwala przy okazji skompresować pakowane pliki przy użyciu konkretnych opcji.

```bash
tar [-opcje] ścieżka_docelowa źródła
```

Samo wywołanie polecenia tar nic nam niestety nie da. Musimy użyć konkretnych opcji, w przeciwnym wypadku zobaczymy coś takiego:

![Opcje tar](../assets/UKOS/Zrzut%20ekranu%202023-11-20%20o%2011.07.14.png)


I w zasadzie te informacje powinny nam wystarczyć.

```bash
-f – określa nazwę pliku tar 
-c – tworzy plik tar
-x – rozpakowuje plik tar
-v – listuje użyte pliki
-z – kompresuje pliki gzipem do formatu tar.gz 
-t – wyświetla zawartość archiwum
```

Osobiście korzystam w 90% z kombinacji -xvzf oraz -cvzf. I tak nikt nigdy tego nie pamięta

![XKCD Tar](https://imgs.xkcd.com/comics/tar.png)

## Nazwa użytkownika
Generalnie to nie jest żadna filozofia, bo nazwę użytkownik zwróci nam polecenie

```bash
whoami
```

Ale już bardziej skomplikowanym trikiem może być stworzenie pliku, który będzie zawierał naszą nazwę użytkownika. Najrozsądniejszym wydaje się przypisanie naszej nazwy użytkownika do zmiennej. Wtedy taka kombinacja poleceń

```bash
user=`whoami`
touch $user
```

Faktycznie zwróci nam to, czego oczekiwaliśmy, czyli stworzy plik o naszej nazwie użytkownika. Ale chcielibyśmy, żeby nasz plik nazywał się np. ```michal_home_12-11-2021```. W takim wypadku polecenie

```bash
touch $user_home_jakastamdata
```

nie ma sensu, bo shell będzie oczekiwał zmiennej $user_home_jakastamdata. W takiej sytuacji możemy zamknąć nazwę zmiennej w nawiasy klamrowe. To jest tzw. Parameter Expansion - zupełnie niepowiązane z tym tematem, zaawansowana wiedza, której nigdy w życiu nie wykorzystałem. Na nasze potrzeby wystarczy wiedzieć, że zamknięcie zmiennej w klamerki pozwoli nam utworzyć ze zmiennej fragment stringa

```bash
touch ${user}_jajco
```
stworzy nam plik michal_jajco.

## Data

Zaczniemy od polecenia cal. Pokazuje datę. Znaczy ma wiele opcji, ale koncept jest dość prosty i nie po to tu dziś przyszliśmy. Nasz plik ma posiadać datę utworzenia backupu, czyli potrzebujemy raczej daty w formie zmiennych. I do tego posłuży nam polecenie date. Ono służy do wyświetlania bądź ustawiania czasu.

```bash
date +%Y
```
zwróci bieżący rok. Znak + oznacza zastosowanie formatu wypisu daty, w którym pod konkretnymi kodami znajdują się konkretne informacje. Używamy standardu ISO 8601, a konkretne elementy daty zastępowane są odpowiednimi tokenami. 

Tokeny możemy łączyć w stringi zasadniczo dowolnie, dla przykładu:

```bash
 date '+Dziś jest %d dzień miesiąca %B roku pańskiego %Y'
```
```bash
Dziś jest 20 dzień miesiąca listopada roku pańskiego 2023
```

Po wszystkie możliwe opcje dotyczące formatu zapraszam do manuala ```man date```

## Śmietnik
W linuksach jest takie magiczne miejsce, które jest czarną dziurą. Przyjmie wszystko, zwróci nic. Nazywany różnie, sink, czarna dziura, Dave Null, służy do jednego – przemielenia i usunięcia wszystkiego, co się do niego wrzuci. Może służyć np. jako generator pustej zawartości dla plików, a zwykle, jako genialni deweloperzy przekierowujemy do niego STDERR. Przecież wiemy, że działa, nie?

```bash
2> /dev/null
```

