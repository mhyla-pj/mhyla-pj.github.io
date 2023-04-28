---
layout: exercise
course: SOP
type: stacjonarne
lab_nr: 8
topic: Whoop, whoop, That's the sound of the police!
---

1. Obsługę sygnałów możemy bez problemu przerejestrować. Napisz program, który przy pierwszym wywołaniu SIGINT wejdzie do funkcji, jak w przykładzie z zajęć, ale przy następnym wywołaniu już wywoła SIG_DFL.
2. Napisz programik, który po otrzymaniu od użytkownika jakiegoś inputu o długości 5 (np. stringa ‘jajco’) wyśle sygnał USR1 do handlera, który zapisze go do pliku. W przeciwnym wypadku główna funkcja zapisze input do innego pliku.
3. Napisz program, który zlicza, ile razy otrzymał sygnał SIGINT, a następnie wypisuje tę wartość na ekranie po otrzymaniu sygnału SIGTERM.
4. Napisz programik, który będzie się wykonywał w pętli, a w momencie otrzymania SIGUSR1 wydrukuje na terminalu potwierdzenie i zabije się
5. Tu użyjemy wiadomości z kilku wcześniejszych zajęć. Napisz program, który się sforkuje, a następnie rodzic zabije dziecko. Przyda się polecenie kill() – w nim możemy podać konkretny PID, który chcemy ubić.
