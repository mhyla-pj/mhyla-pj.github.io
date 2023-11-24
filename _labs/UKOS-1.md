---
layout: lab
course: UKOS
type: [ niestacjonarne, stacjonarne ]
lab_nr: 01
subject: Wstęp do systemu Linux i CLI
description: Mysz to nie wszystko. Jest jeszcze klawiatura!
---
Na tym przedmiocie zajmować się będziemy możliwościami, jakie daje znajomość i płynna obsługa CLI, czyli Command-Line Interface. CLI to tekstowy interfejs systemu. Zdecydowana większość użytkowników komputerów na świecie korzysta z interfejsu graficznego, w większości windowsowego lub macOS-owego. Wykorzystujemy go do porozumiewania się z komputerem (w zasadzie to z systemem operacyjnym), pozwala na tworzenie plików i katalogów, organizację ich, przechodzenie między nimi oraz na uruchamianie plików i aplikacji.

Dokładnie ten sam efekt, ale w zupełnie inny sposób, bez użycia urządzenia wskazującego (myszy) możemy osiągnąć korzystając z interfejsu tekstowego. Tutaj z komputerem porozumiewać się będziemy za pomocą komend. Do podstawowych akcji, które możemy za pomocą CLI wykonać należą
- polecenia systemowe - kopiowanie, tworzenie katalogów, przenoszenie itp.
- uruchamianie plików wykonywalnych - aplikacje zarówno interfejsu tekstowego jak i graficznego
- uruchamianie skryptów - jako skrypt rozumiemy odpowiednio wysterowaną listę poleceń systemowych

Wszystkie systemu operacyjne udostępniają swój własny interfejs wiersza poleceń. Windows ma CMD i PowerShella, Linuxy mają np. Basha. Korzystać będziemy z Linuxa ze względu na to, że jest on w informatyce najszerzej wykorzystywany i daje w porównaniu z PowerShellem przynajmniej porównywalne, jeśli nie większe możliwości, mając równocześnie znacznie mniejszy próg wejścia

## To tyle wstępu, przechodzimy do praktyki
W systemie operacyjnym Linux - jeśli pracujemy na dystrybucji z GUI - terminal uruchomimy albo z menu aplikacji, albo kombinacją klawiszy `Alt` + `Ctrl` + `T`. Z poziomu tego terminala jesteśmy w stanie zarządać systemem operacyjnym w stopniu bardzo zaawansowanym, włączając w to całkowite jego rozwalenie. Ale zanim zabijemy nasz komputer ustalić należy, co my w zasadzie widzimy.
```bash
michal@MacBook-Air ~ %
```
Jest to tak zwany prompt. Będzie on nam towarzyszył zawsze, gdy będziemy pracować na terminalu, znajdować się będzie na początku linii, oznaczając, że terminal oczekuje na wpisanie polecenia. 
- `michal` to nazwa użytkownika
- `@` czyli znak 'at' wskazuje nam hosta
- `MacBook-Air` to nazwa rzeczonego hosta
- `~` to nasza bieżąca lokalizacja - katalog, w którym się znajdujemy
- `%` (dla powłoki *zsh*, dla *bash* będzie to `$`) oznacza, że jesteśmy zwykłym użytkownikiem

Zacząć należy od ustalenia, gdzie my właściwie jesteśmy, `~` jednak niewiele nam mówi. Wpiszmy zatem polecenie 
```bash
michal@MacBook-Air ~ % pwd
```
Powinniśmy zobaczy coś takiego: 
```bash
michal@MacBook-Air ~ % pwd
/Users/michal
```
polecenie `<pwd>`, czyli w rozwinięciu *print working directory* zwróci informację o naszym bieżącym katalogu roboczym. Spróbujemy teraz ustalić, co się w tym katalogu znajduje. Posłuży do tego polecenie `ls`. Posłuży ono do zwrócenia informacji o nieukrytej zawartości katalogu, na którym to polecenie zostało wykonane. W efekcie jego działania powinniśmy zobaczyć coś takiego:

```bash
michal@MacBook-Air ~ % ls
Applications	Desktop			Documents
Downloads		Library			Movies
Music			Pictures		Public
michal@MacBook-Air ~ % 
```
Jest to podstawowa lista katalogów i plików znajdujących się we wskazanym w poleceniu katalogu. Jako, że w naszym przykładzie nie wskazaliśmy żadnego innego katalogu, to polecenie wykonało się w katalogu, w którym się aktualnie znajdowaliśmy.

## Argumenty w wierszu poleceń
Prawie wszystkie polecenia mają możliwość dodania do nich argumentów, a niektóre z poleceń bez odpowiednich nawet nie zadziałają. Jako specyficzny rodzaj argumentu możemy też uznać parametr. Ogólnie rzecz ujmując
- Parametry:
  - modyfikują zachowanie programu
  - zaczynają się od `-` lub `--`
  - w 99% przypadków będą jedną literką
- Argumenty:
  - Wartość na której wykonywane jest polecenie
  - może to być plik, katalog, ciąg znaków

Dla przykładu, **parametr** `-l` dla polecenia `ls` wyświetli nam wynik działania w postaci listy plików wraz z dodatkowymi informacjami o plikach i katalogach

```bash
michal@MacBook-Air ~ % ls -l 
total 176
drwxr-xr-x    3 michal  staff     96 14 sty 12:31 Applications
drwx------@   8 michal  staff    256  2 lut 01:09 Desktop
drwx------@  53 michal  staff   1696  6 lut 23:10 Documents
drwx------@ 342 michal  staff  10944  5 lut 22:32 Downloads
drwx------@  89 michal  staff   2848 22 sty 20:13 Library
drwx------    4 michal  staff    128  3 mar  2022 Movies
drwx------+   4 michal  staff    128  3 mar  2022 Music
drwx------+   7 michal  staff    224 27 sty 10:14 Pictures
drwxr-xr-x+   5 michal  staff    160  9 lis 00:33 Public
```
W powyższym przykładzie faktycznie zmienione zostało odrobinę zachowanie programu. Podany parametr `-l` modyfikuje wynik w taki sposób, że pliki i katalogi wyświetlane są w formie listy zawierającej informacje o uprawnieniach dostępu, nazwie właściciela, rozmiarze i dacie utworzenia katalogów. 

**Argumentem** w poleceniu `ls` będzie zazwyczaj katalog, którego zawartość chcemy podejrzeć. Nie musimy zatem za każdym wykonywać przejścia do katalogu i w nim wykonywać polecenie (szczególnie, że nie pokazałem jeszcze jak poruszać się po katalogach). 

```bash
michal@MacBook-Air ~ % ls Music 
Music
```
Parametry i argumenty polecenia mogą występować równocześnie, więc w pełni dopuszczalnym jest poniższe zastosowanie:

```bash
michal@MacBook-Air ~ % ls -l Music 
Music
```

Ważne jest również, że podawać do jednego polecenia możemy więcej niż jeden parametr. opcja `-a` dla polecenia `ls` wyświetla pełną, również ukrytą, zawartość katalogu. Nie musimy podawać do polecenia parametru w postaci
```bash
ls -l -a
```
kiedy w pełni dopuszczalne jest połączenie parametrów w ten sposób:
```bash
ls -la
```
Niemniej, oba rozwiązania zadziałają, pierwsze jest po prostu niepotrzebne.

## Poruszanie się po katalogach
Umiemy już wyświetlić zawartość katalogu, pora na krótką wycieczkę. Poleceniem

```bash
mkdir [nazwa_katalogu]
```

utworzysz nowy katalog. Oczywiście zamiast nawiasu kwadratowego należy umieścić nazwę swojego nowotworzonego katalogu. Dla przykładu, polecenie

```bash
mkdir PJATK
```
utworzy w naszej bieżącej lokalizacji katalog PJATK. Tworząc katalog zwróć uwagę, że rozdzielenie wyrazów spacją stworzy kilka katalogów o nazwach, które kolejno zostały wpisane. Co za tym idzie, polecenie

```bash
mkdir Polsko Japońska Akademia Technik Komputerowych
```
Spowoduje powstanie pięciu katalogów: `Polsko`, `Japońska`, `Akademia` itd. Dzieje się tak dlatego, że do jednego polecenia możemy podać kilka argumentów. Wszystkie parametry zaczynają się od znaku `-`, natomiast jeśli podany do polecenia ciąg takiego znaku nie będzie posiadał, to potraktowany jest jako argument. Powyższe polecenie spowodowało zatem wykonanie instrukcji `mkdir` na pięciu oddzielnych argumentach. Możliwość niekiedy przydatna, aczkolwiek w tym wypadku niepożądana. Jeśli nadal pragniemy mieć białe znaki w nazwie katalogu, wystarczy zamiast spacji użyć underscore’a `_`, alternatywnie wziąć całą nazwę katalogu w apostrofy.
```bash
mkdir 'Polsko Japońska Akademia Technik Komputerowych'
```
Aby usunąć katalog (lub katalogi!) należy skorzystać z polecenia `rmdir` podając katalogi, które chcemy usunąć jako argumenty. Ja wiem, że wizja pisania całego ciągu znaków może być przerażająca, dlatego w systemie linux mamy parę opcji, które pozwolą nam przyspieszyć sobie pracę. Klawiszami `↑` i `↓` możemy poruszać się w historii naszych poleceń wstecz i naprzód. Jeśli zaczniemy pisać nazwę katalogu i wciśniemy klawisz `Tab`, to nazwa ta zostanie automatycznie uzupełniona, jeśli jest jednoznaczna. Jeśli natomiast mamy katalogi `Desktop` i `Downloads`, a po wpisaniu `ls -la D` naciśniemy tab, to nazwa nie zostanie uzupełniona, bo system, nie wie, o który z katalogów nam chodzi. Możemy wówczas nacisnąć jeszcze raz `Tab`, any dowiedzieć się, jakie katalogi lub pliki pasują do tego przez nas podanego. Wystarczy dopisać kilka liter z nazwy wybranego przez nas katalog i jeszcze raz spróbować autodopełniania, wtedy zadziała.

Poleceniem `ls` upewnić się możemy, czy faktycznie utworzyliśmy katalog "PJATK" i usunęliśmy efekty naszego wcześniejszego błędu. Jeśli faktycznie ten katalog istnieje, to poleceniem `cd` z jego nazwą jako argumentem możemy do niego przejść

```bash
michal@MacBook-Air ~ % cd PJATK
michal@MacBook-Air PJATK % 
```

Zwrócić należy uwagę, że po nazwie hosta zmieniła się nasza bieżąca lokalizacja. Liczona jest ona zawsze od katalogu domowego (`~`). Powyższy zapis oznacza zatem, że znajdujemy się w katalogu PJATK, który znajduje się w katalogu domowym. Upewnić się możemy poleceniem `pwd`
```bash
michal@MacBook-Air PJATK % pwd
/Users/michal/PJATK
```

## Ścieżki
W systemach Unixowych rozróżniamy dwa rodzaje ścieżek dostępu, absolutną oraz względną. **Ścieżkę absolutną** (bezwględną) podajemy zawsze od *roota*, czyli korzenia naszego drzewa katalogów. Ścieżka absolutna ma format 
```bash
/Users/michal/PJATK
```
Pierwszy *slash* `/` to właśnie ten korzeń. **Ścieżka względna** wymaga odrobinę więcej skupienia. Jej kształt zależy zawsze od naszego położenia. w tym wypadku `..` są odnośnikiem do katalogu nadrzędnego, a `.` do katalogu bieżącego. 
Załóżmy, że znajdujemy się w katalogu /home/michal/PJATK, a chcemy utworzyć nowy katalog o nazwie "Przepisy" w naszym katalogu z dokumentami. Komenda
```bash
mkdir Przepisy
```
utworzy nam katalog o ścieżce absolutnej
```bash
/Users/michal/PJATK/Przepisy
```
a tego nie chcieliśmy. Rozwiązać ten problem możemy na kilka sposobów:
1. Całkowity powrót do nadrzędnego katalogu, przejście do katalogu Dokumenty, utworzenie katalogu Przepisy, powrót do katalogu nadrzędnego, przejście do katalogu PJATK. Metoda co prawda najprostsza, ale przy trochę bardziej złożonym drzewie katalogów może się okazać niezwykle czasochłonna i wymagać będzie od nas powrotu do pierwotnej lokalizacji, aby kontynuować pracę. 
```bash
michal@MacBook-Air PJATK % pwd
/Users/michal/PJATK
michal@MacBook-Air PJATK % cd ..
michal@MacBook-Air ~ % cd Documents 
michal@MacBook-Air Documents % mkdir Przepisy
michal@MacBook-Air Documents % cd ..
michal@MacBook-Air ~ % cd PJATK 
michal@MacBook-Air PJATK % 
```

2. Skorzystanie ze ścieżki względnej - relatywnej do naszego katalogu
```bash
michal@MacBook-Air PJATK % pwd
/Users/michal/PJATK
michal@MacBook-Air PJATK % mkdir ../Documents/Przepisy
```
3. Skorzystanie ze ścieżki bezwzględnej - rozpoczynamy ścieżkę od roota (`/`) lub od katalogu domowego `~`
```bash
michal@MacBook-Air PJATK % pwd
/Users/michal/PJATK
michal@MacBook-Air PJATK % mkdir ~/Documents/Przepisy
```

## Więcej o plikach
W katalogu PJATK utworzymy teraz plik o wdzięcznej nazwie `UKOS`. Zwrócić należy uwagę, że plik nie musi posiadać rozszerzenia. W naszym wypadku zapełnimy go tekstem. Aby utworzyć pusty plik skorzystać należy z polecenia 
```bash
touch UKOS
```
oczywiście przy założeniu, że znajdujemy się w katalogu PJATK. Jeśli jesteśmy gdziekolwiek indziej, to należy podać pełną ścieżkę do nowotworzonego pliku. poleceniem `ls` podejrzymy, czy taki plik faktycznie powstał. Jeśli wykonamy to polecenie z odpowiednią opcją, to rpzekonamy się również, że plik waży 0 bajtów, czyli jest pusty. Aby podejrzeć zawartość pliku, pozostając nadal w terminalu, należy skorzystać z polecenia
```bash
cat UKOS
```
w celu edycji takiego pliku musimy uruchomić jakiś edytor tekstu. Dla hardkorów polecam vima
```bash
vi UKOS
```
Wszystkim użytkownikom, którzy mają jednak resztki szacunku do swojego czasu, układu nerwowego i pozostałych szaruch komórek polecam skorzystanie z nano
```bash
nano UKOS
```
### Kopiowanie i przenoszenie
Kopiowanie plików jest bajecznie proste. Musimy wiedzieć jaki plik chcemy przekopiować, oraz znać miejsce, do którego chcemy go przekopiować. Do kopiowania użīwać będziemy polecenia `cp`, które przyjmuje w domyślnym trybie dwa argumenty, pierwszy będący plikiem lub katalogiem, który chcemy skopiować, drugi argument stanowić będzie lokalizację docelową
```bash
cp ~/Desktop/UKOS ~/Documents/PJATK
```
polecenie cp polecam wykonywać z opcją `-v`, czyli *verbose* - wydrukuje ona na terminalu wszystko, co akurat robi.

W identyczny sposób działać będzie przenoszenie plików, z tą różnicą, że polecenie nazywa się `mv`.