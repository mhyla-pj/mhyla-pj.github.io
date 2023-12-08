---
layout: exercise
course: SOP
type: stacjonarne
lab_nr: 06
topic: C czyste jak łza
---
1. Napisz program, który tworzy trzy procesy potomne. Procesy te powinny wypisać na ekranie swoje identyfikatory PID i PPID, a następnie zakończyć swoje działanie. Proces rodzica powinien poczekać na zakończenie wszystkich trzech procesów potomnych i wyświetlić komunikat o zakończeniu ich działania.
2. Napisz program, który tworzy proces potomny. Proces potomny powinien wywołać funkcję getpid() i wyświetlić na ekranie swój identyfikator PID oraz identyfikator PPID. Następnie powinien zakończyć swoje działanie. Proces rodzica powinien poczekać na zakończenie procesu potomnego i wyświetlić na ekranie komunikat o jego zakończeniu.
3. Napisz program, który tworzy proces potomny. Proces potomny powinien wywołać funkcję getppid() i wyświetlić na ekranie identyfikator PPID swojego rodzica. Następnie powinien zakończyć swoje działanie. Proces rodzica powinien poczekać na zakończenie procesu potomnego i wyświetlić na ekranie komunikat o jego zakończeniu.
4. Napisz program, który tworzy dwa procesy potomne. Pierwszy proces potomny powinien wyświetlić na ekranie komunikat "Jestem procesem 1" i zakończyć swoje działanie. Drugi proces potomny powinien wyświetlić na ekranie komunikat "Jestem procesem 2" i zakończyć swoje działanie. Proces rodzica powinien poczekać na zakończenie obu procesów potomnych i wyświetlić na ekranie komunikat "Wszystkie procesy potomne zakończyły swoje działanie".
5. Napisz program, który tworzy proces potomny. Proces potomny powinien wywołać funkcję wait() i oczekiwać na zakończenie innego procesu. Następnie powinien wyświetlić na ekranie identyfikator PID tego procesu oraz jego kod powrotu. Proces rodzica powinien zakończyć swoje działanie bez oczekiwania na zakończenie procesu potomnego.