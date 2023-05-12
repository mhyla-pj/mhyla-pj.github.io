---
layout: exercise
course: SOP
type: stacjonarne
lab_nr: 9
topic: Wątki
---
1. Napisz programik, który w nieskończonej pętli będzie równolegle drukował w wątku „jestem wątkiem” a w mainie „jestem mainem”. Zaobserwuj co się dzieje. Potem dopisz do tych pętli usleep() (uśpienie w μs) o różnych wartościach, np. 500 i 2500. Co się zmieniło?
2. Napisz programik, który współbieżnie wykona 10 razy printa w jednym wątku i 10 razy printa w mainie, a gdy wszystko się zakończy wydrukuje informację że się zakończyło.
3. [OSTROŻNIE] Napisz program, który będzie działał jako prosty licznik czasu. Główny wątek będzie odpowiedzialny za obsługę interakcji z użytkownikiem i oczekiwanie na polecenie rozpoczęcia zliczania czasu. Po otrzymaniu takiego polecenia, program utworzy wątek, który będzie zliczał czas w tle. Główny wątek będzie nadal aktywny, pozwalając użytkownikowi na wydawanie poleceń, takich jak zatrzymanie lub zresetowanie licznika czasu.