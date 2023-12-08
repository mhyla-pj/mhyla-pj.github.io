---
layout: lab
course: UKOS
type: [ niestacjonarne, stacjonarne ]
lab_nr: 7
subject: Midnigt Commander, FTP
description: Przydatne narzędzia, z których za cholerę nie da się zrobić zadań
---

Dzisiaj na zajęciach poznamy Midnight Commandera – inspirowany legendarnym dosowskim Norton Commanderem. Jest to dostępne na zasadniczo wszystkich dystrybucjach narzędzie, które upraszcza pracę z plikami i katalogami. Znaczy to, czy upraszcza, to się jeszcze co prawda okaże, bo nie każdemu przypadnie do gustu, ale trzeba MC oddać, potężnym narzędziem jest. W systemach z GUI może się okazać bezużyteczny, gdyż wszystko, co możemy w nim zrobić przy pomocy klawiatury, możemy zrobić dwoma kliknięciami w interfejsie graficznym, ale przypomnę, że nie zawsze mamy komfort pracy z GUI.
Narzędzie powinno być wbudowane w większość popularnych dystrybucji, więc uruchomimy je poleceniem
```bash
mc
```
![MC-Default](../assets/UKOS/Zrzut%20ekranu%202023-11-27%20o%2011.00.55.png)

Domyślnie program jest podzielony na dwa okna i niech tak pozostanie. W każdym z tych okien znajdziemy listę plików i katalogów – poruszamy się po nich strzałkami w górę i w dół. Aby wykonać plik lub wejść do katalogu – Enter.
U góry znajduje się menu programu, na dole natomiast zestaw podstawowych komend. I teraz ważna rzecz: używamy ich przy użyciu klawiszy funkcyjnych, tzn. aby uruchomić podgląd zaznaczonego pliku użyjemy klawisza F3. Aby przełączyć się pomiędzy oknami użyjemy klawisza Tab. Wtedy belka podświetlająca pliki przeskoczy na drugą stronę.

Midnight Commander pozwala na bezpośredni podgląd oraz edycję plików. Aby podejrzeć plik należy go podświetlić i wcisnąć F3. Żeby plik natomiast edytować użyjemy F4.

![MC Editor](../assets/UKOS/Zrzut%20ekranu%202023-11-27%20o%2011.03.44.png)

Zwrócić należy uwagę, że na belce u dołu zmieniły się opcje. Pod F1 co prawda zawsze znajduje się pomoc, F9 nadal jest opisane jako enigmatyczne „w dół” a pod F10 jest wyjście, ale już wszystkie pozostałe klawisze robią nam coś innego. Kopiowanie, przenoszenie i wyszukiwanie są najważniejsze. Radzę uważać z kopiowaniem, można ostro naśmiecić. Tu przyda się pewnie wyjaśnienie, czym jest to głupie „WDół”, które mamy pod F9. Coś może wyjaśnić fakt, że w wersji angielskiej opcja ta nazywana jest pulldn – wyciągnie nam ona z góry pasek opcji. Coś jak wstążka w Wordzie. Mamy tutaj opcje plik, Edycja, wyszukaj itd. Poruszać się możemy po nich klasycznie, strzałkami, ale możemy też skorzystać ze skrótów klawiszowych. Warto zwrócić uwagę, że każda z opcji ma jedną literkę podświetloną na żółto – wciśnięcie odpowiedniego klawisza pozwoli nam poruszać się znacznie szybciej po menu.

![MD options](../assets/UKOS/Zrzut%20ekranu%202023-11-27%20o%2011.07.19.png)

Tutaj zakładam scenariusz, w którym naśmieciliśmy nieumiejętnie używając opcji kopiowania, więc interesować nas szczególnie będzie opcja cofnij. Widzimy przy okazji, że możemy ją znaleźć pod skrótem Ctrl+u. Do zapamiętania na przyszłość. Tu też warto zwrócić uwagę na opcje kopiowania, wklejania itd. Opcje domyślne nie korzystają ze schowka. Proponuję tym, którzy tego jeszcze nie zrobili zaznaczyć jakiś tekst (shift+strzałki lub F3 + strzałki, ale F3 nie trzeba trzymać) i po jego znaznaczeniu wcisnąć F5. W miejscu, w którym znajdował się kursor wkleił się zaznaczony tekst. Takie połączenie Ctrl+C, Ctrl+V. Podobnie będzie z opcją przeniesienia, czyli F6, ale w tym wypadku wykona się połączenie Ctrl+X, Ctrl+V. Jeśli chcielibyśmy skorzystać ze schowka, tak jak to się dzieje wszędzie na Windowsie to skorzystać musimy z tych poleceń:

![MC options2](../assets/UKOS/Zrzut%20ekranu%202023-11-27%20o%2011.08.31.png)

C w tej kombinacji oznacza Ctrl, natomiast S to shift. Zapisywanie pliku w miarę intuicyjne, schowane pod klawiszem F2. Jeżeli chcielibyśmy zapisać zmiany do nowego pliku, czyli klasyczne „zapisz jako...”, to ta opcja nie jest wyświetlona, ale jak możemy sprawdzić w menu plik znajduje się ona pod klawiszem F12. Zakończmy na ten moment prace nad tym plikiem i wróćmy do podstawowego widoku, bo w zasadzie pokazałem edycję pliku zakładając, że każdy z was ma już jakiś plik tekstowy. A tworzenie plików w MC nie jest takie proste jak by się mogło wydawać. Mamy co prawda schowaną pod F7 opcję tworzenia katalogu, ale z plikami już tak różowo nie jest. Właściwie, to z poziomu tego głównego menu takiej opcji za bardzo w interfejsie nie znajdziemy, dopiero po uruchomieniu jakiegoś pliku w edytorze w menu plik znajduje się taka możliwość, ale takie rozwiązanie generuje niepotrzebne zupełnie skakanie po oknach.

Rozwiązanie jest absurdalnie proste – należy użyć terminala. W MC między innymi dlatego musimy korzystać ze skrótów i klawiszy funkcyjnych, bo wszystkie znaki alfanumeryczne muszą być wolne, abyśmy w każdym momencie mogli użyć znajdującego się na dole, zaraz nad podstawowymi opcjami terminala. Nie trzeba się nigdzie przełączać, wystarczy zacząć pisać. Więc jeśli chcemy utworzyć nowy plik, to zdecydowanie nie warto męczyć się z klawiszami funkcyjnymi, otwieraniem edytora itd. Wystarczy w dowolnym momencie wpisać

```bash
touch jajco.txt
```
## Pliki i katalogi, czyli Lewy i Prawy

To jest w MC naprawdę przyjemne i nawet dość intuicyjne. Najpierw w jednym oknie znajdźmy sobie plik/katalog, który chcemy skopiować, a w drugim miejsce docelowe. Następnie wracamy do pierwszego okna, upewniamy się, że belka znajduje się na dobrym pliku i wciskamy F5.

![mc copy](../assets/UKOS/Zrzut%20ekranu%202023-11-27%20o%2011.10.13.png)

Jeśli przenosimy (F6) lub kopiujemy (F5) pojedynczy plik, to wystarczy się upewnić, że miejsce docelowe jest dobre i wybieramy OK. Jeśli natomiast kopiujemy katalog, to możemy jeszcze wprowadzić odpowiednią maskę, czyli np. ustawić ją na *.json co spowoduje przekopiowanie katalogu, ale równocześnie odfiltruje pliki w formacie innym niż JSON. Wiem, że jest też opcja zaznaczenia wielu plików lub katalogów, ale do zaznaczania wielu plików służy w MC klawisz insert, którego nie mam na tej klawiaturze.
Jednakże podział na prawe i lewe okno pozwala na wiele, wiele więcej. Zachowania i ewentualne zależności między oknami możemy modyfikować w opcjach Lewy i Prawy. F9, przypominam.

![MC pulldn](../assets/UKOS/Zrzut%20ekranu%202023-11-27%20o%2011.11.10.png)

Kilka bardzo przydatnych możliwości mamy na samej górze. Domyślnym widokiem, z którego przed chwilą korzystaliśmy jest lista plików, ale nie zawsze są nam potrzebne dwa okna z plikami. Opcją, której osobiście używam najczęściej jest szybki widok. Sprawia ona, że w jednym okien pokaże nam się to, co zaznaczymy w drugim, przy założeniu, że da się to wyświetlić w formie tekstowej. Ciekawą opcją jest również drzewo, które wygląda podobnie do tego, co robiliśmy na zajęciach. Po drzewku poruszamy się strzałkami, co znacznie ułatwia zrozumienie, co się dzieje w systemie.
Jeżeli chodzi o podstawy, to właściwie wszystko omówiliśmy. Zachęcam do wypróbowania wyszukiwarki. Rozpoczęcie wysukiwania w ~ pozwoli na znalezienie wszystkich pasujących na filtra plików. Można nawet szukać po zawartości.

![MC search](../assets/UKOS/Zrzut%20ekranu%202023-11-27%20o%2011.11.48.png)

W opcjach kolumn można również zastosować filtry, np. tak, aby wyświetlały nam się tylko pliki html będziemy musieli podać *.html jako filtr. W jednym z okien możemy się również podłączyć do FTP, również bardzo przydatna i przyjemna opcja.

## A zatem: FTP.

FTP to bardzo wiekowy, ponad pięćdziesięcioletni protokół komunikacyjny, wykorzystywany do dwukierunkowego transferowania plików pomiędzy komputerem-klientem a serwerem. 
Każdy student PJATK ma dostęp do serwera FTP (konkretnie SFTP) umieszczonego na naszej szuflandii.  

Uzyskać połączenie można na wiele sposobów, natomiast zawsze logować się będziemy jako 
```bash
[user]@szuflandia.pjwstk.edu.pl
```

przy użyciu protokołu SFTP. Czyli w moim wypadku:
```bash
mhyla@szuflandia.pjwstk.edu.pl
```

Dzięki temu połączeniu możemy pobierać pliki z uczelnianych komputerów na swój prywatny. Wybór klienta FTP pozostawiam wam, sam korzystam z Filezilli, ale Midnight Commander też jest opcją. 

## VIM
Kontrowersyjny, ale potężny edytor tekstu pozwalający na pracę bezpośrednio w terminalu, bez konieczności korzystania z trybów graficznych. Ze względu na swoje złożone opcje edycji tekstu ma bardzo wielu zwolenników, jednak to ze względu na nieintuicyjny sposób poruszania się po edytorze zyskał sławę. Poniżej znajdziecie link do naprawdę fajnego tutoriala online, który pokrywa wszelkie podstawy, serdecznie zachęcam do skorzystania.
[https://www.openvim.com](https://www.openvim.com)