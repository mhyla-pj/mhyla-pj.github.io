---
layout: exercise
course: SOP
type: stacjonarne
lab_nr: 10
topic: Wątki
---

1. Napisz program w języku C, który tworzy 5 wątków. Każdy wątek ma zwiększyć wspólną zmienną globalną o 1, 1000 razy. Wykorzystaj mutex, aby zapewnić, że dostęp do zmiennej jest zsynchronizowany i żaden wątek nie zmodyfikuje jej w tym samym czasie co inny wątek.
2. Napisz program, który symuluje problem producenta-konsumenta z jednym producentem i jednym konsumentem, korzystając z semaforów. Producent ma wypełniać bufor danymi (np. liczby całkowite), a konsument ma te dane pobierać i wyświetlać. Użyj semaforów do synchronizacji dostępu do bufora.
3. Napisz program w języku C, który symuluje problem czytelników i pisarzy. Użyj semaforów do synchronizacji, aby wielu czytelników mogło jednocześnie czytać, ale tylko jeden pisarz mógł pisać w danym momencie. Gdy pisarz pisze, żaden czytelnik nie może czytać.