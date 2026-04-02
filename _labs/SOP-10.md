---
layout: lab
course: SOP
type: stacjonarne
lab_nr: 10
subject: Synchronizacja w wątkach
description: Mutex, semafory
---

Problem sekcji krytycznej jest jednym z fundamentalnych problemów synchronizacji w wielowątkowym lub wieloprocesorowym środowisku. Polega na tym, że wiele wątków lub procesów ma dostęp do wspólnego zasobu lub obszaru pamięci, zwanej sekcją krytyczną, i musi zapewnić, że tylko jeden wątek/proces na raz może wykonywać operacje na tym obszarze. W przypadku, gdy dwa lub więcej wątków lub procesów jednocześnie wykonuje operacje na sekcji krytycznej, może dochodzić do problemów takich jak wzajemne wykluczanie, deadlock, czy starvation. 

## Mutex

Rozwiązaniem problemu sekcji krytycznej jest zastosowanie mechanizmów synchronizacji, takich jak mutexy, czy semafory. Te mechanizmy pozwalają kontrolować dostęp do sekcji krytycznej i zapewniają, że tylko jeden wątek na raz ma do niej dostęp. Mechanizmy te są projektowane w taki sposób, aby uniknąć zakleszczeń i zapewnić sprawiedliwość dostępu do sekcji krytycznej.

```c
#include <stdio.h>
#include <pthread.h>

pthread_mutex_t mutex; // Deklaracja mutexu

int counter = 0; // Globalny licznik

void* threadFunction(void* arg) {
    pthread_mutex_lock(&mutex); // Blokowanie mutexu przed dostępem do sekcji krytycznej

    // Sekcja krytyczna
    int i;
    for (i = 0; i < 1000000; i++) {
        counter++;
    }

    pthread_mutex_unlock(&mutex); // Odblokowanie mutexu po zakończeniu sekcji krytycznej

    return NULL;
}

int main() {
    pthread_t thread1, thread2;

    pthread_mutex_init(&mutex, NULL); // Inicjalizacja mutexu

    // Tworzenie wątków
    pthread_create(&thread1, NULL, threadFunction, NULL);
    pthread_create(&thread2, NULL, threadFunction, NULL);

    // Oczekiwanie na zakończenie wątków
    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);

    pthread_mutex_destroy(&mutex); // Zniszczenie mutexu

    printf("Wartość licznika: %d\n", counter);

    return 0;
}
```

Powyższy kod proponuję wykonać również z zakomentowanymi ustawianiem i zdejmowaniem blokady.

## Semafory

Mechanizm semaforów, stworzony przez Edsgera Dijkstrę (tego od algorytmu, nie z Wiedźmina), pozwala na zarządzanie procesami i wątkami przy użyciu jednego integera – semafora. Semafor, w skrócie to nieujemna wartość dzielona pomiędzy wątkami, która służy do rozwiązania problemu sekcji krytycznej i synchronizacji w środowiskach wieloporcesowych i wielowątkowych.
Sekcja krytyczna to kawałek kodu, w którym korzystamy z dzielonego zasobu, co za tym idzie, może być w jednej chwili używany przez jeden i tylko jeden wątek.
Semafory binarne w zasadzie już omówiliśmy – jest to po prostu blokada mutex, która może przyjmować wartości 0 lub 1. Semafory zliczające są odrobinę bardziej złożone, więc najprościej bedize je wytłumaczyć analogią. Znane mi są dwie, ze śpiącym barberem i kelnerem, ta z kelnerem jest lepsza.
Załóżmy, że w restauracji mamy stoliki (zasoby), klientów (procesy) i kelnera (semafor), który będzie osobą decyzyjną przy rozdziale stolików. Kelner zlicza wolne stoliki i wie, kogo powinien umieścić przy zwalniającym się stoliku. Kiedy restauracja się otwiera jest oczywiście pusta, więc wartość semafora będzie ustawiona na liczbę wszystkich wolnych stolików. Kiedy ktoś wejdzie do restauracji, to wartość semafora będzie równa liczbie stolików – 1. W ten sposób, kiedy nowi klienci będą wchodzić do restauracji, to będą lokowani przy stolikach w kolejności przybycia tak długo, aż liczba wolnych stolików będzie >0. Jeśli w restauracji nie będzie wolnych stolików, to kelner zatrzyma klientów, którzy będą musieli poczekać w kolejce. Jeśli stolik się zwolni, to kelner obliczy nową wartość wolnych stolików (stoliki=stoliki+1) i wpuści klienta z kolejki.

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>
#include <pthread.h>

#define NUM_THREADS 3

int global_variable = 0;
sem_t sem;

void *thread_function(void *arg) {
    int *thread_num = (int *) arg;

    // Wątek oczekuje na semaforze
    sem_wait(&sem);

    // Sekcja krytyczna
    global_variable++;
    printf("Wątek %d: zwiększam globalną zmienną na %d\n", *thread_num, global_variable);

    // Wątek zwalnia semafor
    sem_post(&sem);

    pthread_exit(NULL);
}

int main() {
    pthread_t threads[NUM_THREADS];
    int thread_args[NUM_THREADS];

    // Inicjalizacja semafora
    if (sem_init(&sem, 0, 1) == -1) {
        perror("Nie udało się zainicjować semafora");
        exit(EXIT_FAILURE);
    }

    // Tworzenie wątków
    for (int i = 0; i < NUM_THREADS; i++) {
        thread_args[i] = i;
        if (pthread_create(&threads[i], NULL, thread_function, &thread_args[i]) != 0) {
            perror("Błąd przy tworzeniu wątku");
            exit(EXIT_FAILURE);
        }
    }

    // Oczekiwanie na zakończenie wątków
    for (int i = 0; i < NUM_THREADS; i++) {
        if (pthread_join(threads[i], NULL) != 0) {
            perror("Błąd przy oczekiwaniu na zakończenie wątku");
            exit(EXIT_FAILURE);
        }
    }

    // Usuwanie semafora
    sem_destroy(&sem);

    return 0;
}
```


