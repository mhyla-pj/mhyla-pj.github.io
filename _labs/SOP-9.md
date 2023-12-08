---
layout: lab
course: SOP
type: stacjonarne
lab_nr: 09
subject: Wątki
description: 
---
Z definicji, wątek to część programu wykonywana współbieżnie w obrębie jednego procesu. Można powiedzieć, że to podstawowy fragment kodu, którym scheduler może niezależnie zarządzać. Wątki zwane są również procesami lekkimi. Bierze się to z tego, że wątek, to tak w zasadzie proces działający w tej samej przestrzeni adresowej co tworzący go ciężki proces. Równouprawnione wątki dzielą ze sobą np. zasoby systemowe, data segment, PID oraz należą do tego samego użytkownika, ale każdy z wątków ma swój własny licznik rozkazów, zbiór rejestrów i stos. Z tego względu wymagać będą synchronizacji między sobą.
Zastosowanie wątków pozwala na przetwarzanie współbieżne. Wątki uruchomione na tym samym procesorze są przełączane bardzo szybko między sobą, więc wygląda jakby były wykonywane równolegle. W pewnym stopniu uproszczenia, program wielowątkowy składa się z dwóch lub więcej części, które wykonują się równocześnie.
Wątki są małymi jednostkami wykonawczymi, które mogą działać niezależnie od siebie, dzieląc zasoby i komunikując się między sobą. Wątki są szczególnie przydatne w przypadku programów, które wymagają jednoczesnego przetwarzania wielu zadań, takich jak obsługa wielu klientów w serwerze lub przetwarzanie danych w tle.

## Tworzenie wątków
Aby utworzyć nowy wątek, można użyć funkcji pthread_create(), która przyjmuje wskaźnik na identyfikator wątku, funkcję, którą wątek ma wykonać, oraz argumenty przekazywane do tej funkcji.

```c
#include <stdio.h>
#include <pthread.h>

#define NUM_THREADS 5

// Funkcja, która będzie wykonywana przez wątek
void *thread_function(void *thread_arg) {
    int thread_id = *(int *)thread_arg;
    printf("Wątek %d: Witaj, świecie!\n", thread_id);
    pthread_exit(NULL);
}

int main() {
    pthread_t threads[NUM_THREADS];
    int thread_args[NUM_THREADS];
    int i;

    // Tworzenie wątków
    for (i = 0; i < NUM_THREADS; i++) {
        thread_args[i] = i;
        pthread_create(&threads[i], NULL, thread_function, (void *)&thread_args[i]);
    }

    // Oczekiwanie na zakończenie wątków
    for (i = 0; i < NUM_THREADS; i++) {
        pthread_join(threads[i], NULL);
    }

    printf("Wszystkie wątki zakończyły pracę. Program kończy działanie.\n");

    return 0;
}
```

W powyższym przykładzie definiujemy funkcję thread_function(), która jest wykonywana przez każdy utworzony wątek. W funkcji main tworzymy tablicę wątków threads oraz przekazujemy identyfikatory wątków do tablicy thread_args. Następnie używamy funkcji pthread_create do utworzenia wątków i przekazania im odpowiednich argumentów.

Po utworzeniu wątków używamy pętli pthread_join, aby oczekiwać na zakończenie każdego wątku. Funkcja pthread_join blokuje wykonanie głównego wątku, dopóki dany wątek się nie zakończy. To taki odpowiednik wait();

Po zakończeniu wszystkich wątków, program wyświetla komunikat i kończy działanie.

Warto zauważyć, że kompilując ten program, konieczne może być dodanie flagi -pthread podczas kompilacji, aby skompilować go z biblioteką pthread. Na przykład: 
```bash
gcc program.c -o program -pthread
```

Bierze się to z tego, że wątki nie są w zasadzie C nie zawiera wbudowanego wsparcia dla aplikacji wielowątkowych, opiera się na systemie operacyjnym, żeby tę funkcjonalność udostępnił.

Poza tym, do dyspozycji mamy również funkcje:
```c
pthread_exit(void *retval) //zakończy wątek
pthread_self() // zwróci swoje ID
```

