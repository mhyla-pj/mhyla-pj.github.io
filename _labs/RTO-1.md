---
layout: lab
course: RTO
type: stacjonarne
lab_nr: 1
subject: RTOS‑Lab‑01
description: Pierwsze kroki z współbieżnością na Linuksie (pthread)
---

**Czas trwania:** ~3h
**Poziom:** pierwsze zajęcia specjalizacyjne
**Środowisko:** Linux; kompilator `gcc`

---

## 📦 Struktura plików

```
rtos-lab-01-student/
├── Makefile
├── 01_hello_threads.c
├── 02_mutex_counter.c
└── 03_queue_condvar.c   # opcjonalne
```

### Makefile

```makefile
CC=gcc
CFLAGS=-O2 -Wall -Wextra -pthread

all: 01 02 03

01: 01_hello_threads.c
	$(CC) $(CFLAGS) $^ -o $@

02: 02_mutex_counter.c
	$(CC) $(CFLAGS) $^ -o $@

03: 03_queue_condvar.c
	$(CC) $(CFLAGS) $^ -o $@

clean:
	rm -f 01 02 03
```

---

## 1) Hello Threads — dwa wątki, różne okresy

**Plik:** `01_hello_threads.c`

**Instrukcja:**

1. Utwórz dwa wątki: `TaskA` (co 1 s) i `TaskB` (co 2 s).
2. Po ~8–10 sekundach zakończ działanie programu.
3. Obserwuj przeplot wypisów.

```c
// 01_hello_threads.c
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <stdatomic.h>

static atomic_int run = 1;

// TODO: funkcja task_a
// powinna co 1 s wypisywać "[A] tick"

// TODO: funkcja task_b
// powinna co 2 s wypisywać "[B] tock"

int main(void){
    pthread_t a,b;
    // TODO: utwórz wątek a
    // TODO: utwórz wątek b

    sleep(10);
    atomic_store(&run,0);

    // TODO: dołącz wątki

    puts("Done.");
}
```

**Pytania:**

* Dlaczego oba wątki działają „naraz”?
* Co się stanie, jeśli wszystko byłoby w jednej pętli?

---

## 2) Race Condition & Mutex — bezpieczny licznik

**Plik:** `02_mutex_counter.c`

**Instrukcja:**

1. Uruchom program bez mutexa – zobacz, że `counter` jest mniejszy niż oczekiwany.
2. Włącz ochronę muteksem – wynik staje się deterministyczny.
3. Wyjaśnij, czym jest sekcja krytyczna.

```c
// 02_mutex_counter.c
#include <stdio.h>
#include <pthread.h>

//#define USE_MUTEX

static long long counter = 0;
#ifdef USE_MUTEX
static pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;
#endif

void* worker(void* _){
    for(int i=0;i<100000;i++){
#ifdef USE_MUTEX
        // TODO: zablokuj mutex
#endif
        counter++;
#ifdef USE_MUTEX
        // TODO: odblokuj mutex
#endif
    }
    return NULL;
}

int main(void){
    pthread_t t1,t2,t3,t4;
    // TODO: utwórz cztery wątki worker

    // TODO: dołącz wszystkie wątki

    printf("Final counter=%lld (expected=%d)\n", counter, 4*100000);
}
```

**Pytania:**

* Dlaczego bez mutexa wynik jest błędny?
* Co to jest sekcja krytyczna?
* Jak przenieść to na FreeRTOS?

---

## 3) Opcjonalnie: prosta kolejka logów na `pthread_cond`

**Plik:** `03_queue_condvar.c`

**Instrukcja:**

1. Zaimplementuj bufor cykliczny na 8 intów.
2. Producent (`sensor`) co 500 ms generuje dane.
3. Konsument (`logger`) czeka, aż w kolejce pojawią się dane, i wypisuje je.
4. Użyj `pthread_cond_wait` i `pthread_cond_signal`.

```c
// 03_queue_condvar.c
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <stdatomic.h>

#define QN 8
static int q[QN];
static int head=0, tail=0, count=0;
static pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;
static pthread_cond_t  cv  = PTHREAD_COND_INITIALIZER;
static atomic_int run = 1;

// TODO: funkcja q_push
// dodaje element do kolejki, sygnalizuje condition variable

// TODO: funkcja q_pop
// czeka na element, pobiera z kolejki

void* sensor(void* _){
    // TODO: generuj co 500ms liczby i wrzucaj do kolejki
    return NULL;
}

void* logger(void* _){
    // TODO: pobieraj liczby z kolejki i wypisuj
    return NULL;
}

int main(void){
    pthread_t ts, tl;
    // TODO: utwórz wątki sensor i logger

    sleep(10);
    atomic_store(&run,0);
    pthread_cond_broadcast(&cv); // obudź czekających

    // TODO: dołącz wątki

    puts("Done.");
}
```

**Pytania:**

* Po co używamy `while` w `pthread_cond_wait`?
* Co się stanie, jeśli kolejka jest pełna?
* Jak wygląda to w FreeRTOS (`xQueueSend/Receive`)?

---

## ✅ Komendy

```bash
make     # kompilacja wszystkich przykładów
./01     # Hello Threads
./02     # Race Condition & Mutex
./03     # kolejka na pthread_cond (opcjonalnie)
```
