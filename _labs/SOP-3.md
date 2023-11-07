---
layout: lab
course: SOP
type: stacjonarne
lab_nr: 3
subject: Czas, backupy i inne czary-mary
description: Cron jest super, obiecuję
---
Myślę, że bezpiecznie możemy założyć, że jesteście wszyscy już na tyle biegli w obsłudze skryptów basha, że dzisiejsze zajęcia będą szybkie, proste i przyjemne

## Czas
UNIX Time to format powszechnie używany w informatyce. Liczy on sekundy, które upłynęły od północy 1 stycznia 1970 roku. po stronie systemu operacyjnego do obsługi i wyświetlenia czasu używać będziemy polecenia ```date``` - z tym w miarę zapoznani powinni być wszyscy, którzy mieli ze mną UKOS. 

```bash
michal@MacBook-Air ~ % date
ptk 17 mar 09:49:41 2023 CET
```
Jednak powyższy format nie musi być akurat najprzydatniejszym. Czasem zdarzyć się może sytuacja, w której potrzebna będzie nam data i czas zapisane w innym formacie, na przykład, żeby dopisać ją do pliku. W tym celu używamy opcji formatowania stringa z datą:

```bash
michal@MacBook-Air~ % date +"%d.%m.%y"
17.03.23
```

Wszystko, co znajduje się w stringu zadeklarowanym po plusie zostanie z powrotem na stdout,  wyjątkiem znaków specjalnych, zaczynających się od %.

- %d - dzień miesiąca
- %m - miesiąc 
- %y - ostatnie dwie cyfry roku
- %Y - pełny rok
- %H - godzina (24h)
- %M - minuta

Opcji jest zdecydowanie więcej, wliczając w to niepoprawnie odmienione wersje tekstowe po polsku - znajdziecie je w manualu polecenia date (```man date```) lub [tutaj](https://man7.org/linux/man-pages/man1/date.1.html).

## Backupy
Pakowanie całego katalogu do pliku wraz z zawartością jest mechanizmem każdemu znanym i oczywistym. Na linuksie używać do tego celu będziemy polecenia ```tar```. Sam program ma swoją genezę w Bell Laboratories na początku lat 70. XX w w Bell Laboratories, gdzie opracowany został do obsługi taśm magnetycznych w przenoszeniu danych i ich archiwizacji. Obecnie z programu funkcjonalność obsługi taśm magnetycznych została wycięta, ale nadal używany jest szeroko do archiwizacji danych. Tar posiada kilka flag, których musimy użyć, jeśli chcemy osiągnąć konkretny cel.

```bash
tar -cf file.tar ~/Documents
```
Opcje:
- -c - tworzy archiwum
- -x - rozpakowuje archiwum
- -u - zaktualizuje archiwum o podane pliki/katalogi
- -f - służy do określenia nazwy i ścieżki do pliku, do którego ma być zapisane lub z którego ma być odczytane archiwum.

Opcja ```-f``` oraz jedna z opcji pakowania i rozpakowania musi się w poleceniu pojawić. Pozostałe:
- -z - obsłuży kompresję przy użyciu gzipa
- -v - *verbose* - standardowa opcja, zwracająca informacje o tym, co akurat robi program w trakcie wykonywania

## Cron
Cron to program w systemach operacyjnych Unix i Linux, który służy do planowania i automatyzowania wykonywania określonych zadań w określonych czasach. Cron jest skrótowcem od "chronos", co oznacza po grecku czas.

Cron umożliwia wykonywanie różnych zadań, takich jak wykonywanie skryptów, aktualizowanie baz danych, wysyłanie raportów, czy też zapisywanie kopii zapasowych plików. Zadania te mogą być uruchamiane regularnie, np. co minutę, godzinę, dzień, tydzień, itd.

Cron działa w oparciu o plik konfiguracyjny "crontab", który zawiera listę zadań do wykonania. Każde zadanie jest zapisywane w osobnej linii i składa się z pięciu lub sześciu elementów, które określają czas uruchomienia zadania oraz polecenie, które ma zostać wykonane.

Elementy te to:

1. minut(a) (0-59)
2. godzina (0-23)
3. dzień miesiąca (1-31)
4. miesiąc (1-12 lub skrót nazwy)
5. dzień tygodnia (0-7, gdzie 0 i 7 to niedziela lub skrót nazwy) - to zależy od systemu, niekiedy 0-6, gdzie 0 to niedziela

Aby stworzyć zadanie do regularnego wykonania uruchomić należy polecenie

```bash
crontab -e
```

Uruchomi ono pustego vim-a, w którym umieścić musimy odpowiednie zestaw instrukcji. Aby wejść w *INSERT MODE* należy wcisnąć ```i```. Na przykład, instrukcja 
```bash
37 21 * * 2 cd ~/Documents/scripts ./skrypt.sh
```
Utworzy zadanie do wykonania 37 minut po godzinie 21 w każdy wtorek każdego miesiąca. Cron ma również opcje daily, weekly i inne, polecam się zapoznać. Do generowania wpisów w crontabie w przyjemniejszy sposób skorzystać można z narzędzia [crontab.guru](https://crontab.guru).

Tu też ważna uwaga - cron sam w sobie nie ma żadnej możliwości poinformowania nas, czy skrypt się wykonał ani nie daje żadnej zwrotki o failu. W tym celu dobrym pomysłem jest umieszczenie w skrypcie (lub najlepiej bezpośrednio w crontabie) przekierowania stderr do pliku z logami. Standardem, z którym się spotkałem jest plik ```~/.logs/cronerr.log```.
