---
layout: lab
course: RTO
type: stacjonarne
lab_nr: 3
subject: RTOS‑Synchronizacja
description: Niby to co na SOP, ale lepsze, bo nie na Linuksie
---

Na każdych zajęciach do tej pory marnowaliśmy mnóstwo czasu na jakiś problem techniczny. Dlatego aby podtrzymać tę tradycję dziś postaramy się opuścić Arduino IDE i przejść na PlatformIO w VSCode.

## **Wprowadzenie**

Do tej pory każde z naszych zadań wykonywało swoją pracę niezależnie od pozostałych:  
jedno migało diodą, inne wypisywało komunikaty, jeszcze inne generowało dźwięk.  
Wszystko to działało, dopóki taski nie próbowały **korzystać z tego samego zasobu**. A ktoś tak rozsądnie ułożył zadania, że nie korzystały.

W rzeczywistym systemie czasem **równoległość staje się problemem** —  
dwa taski mogą w tym samym momencie chcieć:
- zapisać coś na Serialu,  
- zmienić stan tego samego pinu,  
- odczytać ten sam czujnik,  
- lub (co gorsza) zapisać do tej samej zmiennej w pamięci.

Efekt?  
Na pierwszy rzut oka system nadal „działa”, ale zachowuje się **dziwnie i niestabilnie** — pojawiają się błędy trudne do odtworzenia:  
czasem dane się mieszają, czasem znaki giną, a czasem jeden task „zjada” drugi.

---

## **Obrazowy przykład**

Na SOP wspominając o synchronizacji używaliśmy przykładu toalety na stacji benzynowej. Jeśli dostępna jest jedna *niezamykana* kabina, a nastąpi sytuacja, w której dwie osoby będą chciały z niej skorzystać w jednym momencie, to będziemy mieli niekomfortową sytuację. 

---

## **Przykład problemu – dwa taski bez kontroli dostępu**

Poniższy program tworzy dwa taski: `TaskA` i `TaskB`.  
Oba wypisują swoje komunikaty na port szeregowy co 500 ms.  
Każdy z nich korzysta z `Serial.println()`, ale żaden nie kontroluje, czy drugi akurat też tego nie robi.

```c++
void TaskA(void *pv) {
  for (;;) {
    Serial.print("A: ############ HELLO FROM TASK A ############\r\n");
    vTaskDelay(1);
  }
}

void TaskB(void *pv) {
  for (;;) {
    Serial.print("B: ************ HELLO FROM TASK B ************\r\n");
    vTaskDelay(1);
  }
}

void setup() {
  Serial.begin(115200);
  vTaskDelay(pdMS_TO_TICKS(200));

  xTaskCreatePinnedToCore(TaskA, "TaskA", 2048, NULL, 1, NULL, 0);
  xTaskCreatePinnedToCore(TaskB, "TaskB", 2048, NULL, 1, NULL, 1);
}

void loop() {}
```

**Co się stanie**
Co prawda nie widzimy potężnego śmietniska tekstu na Serial Monitorze, głównie ze względu na to, że sam Serial.print() jest już obłożony domyślnie mutexem, ale jeśli kod działa tak jak na moim ESP32, to powinniśmy widzieć, że zadania nie są w żaden sposób przeplecione, tylko czasem będziemy mieli kilka zwrotek z taska A, a czasem kilka zwrotek z taska B pod rząd. 

Dzieje się tak dlatego, że Serial jest zasobem przez oba wątki współdzielonym. Podobny efekt **desynchronizacji** możemy uzyskać np. gdy współdzielonym zasobem będzie dioda LED. 

## Zadanie

Zrealizuj przykład race conditions, gdy współdzielonym zasobem jest wbudowany LED. Niech jeden task chce mrugać diodą co 400ms, a drugi co 100ms.

## Wniosek

Logicznym jest, że jedna dioda nie może mrugać równocześnie z dwiema różnymi częstotliwościami. 

Kiedy dwa taski próbują korzystać z tego samego zasobu, potrzebujemy mechanizmu, który pozwoli im się dogadać, czyli synchronizować dostęp. Takim mechanizmem może być:
- mutex (mutual exclusion) – chroni wspólny zasób,
- semafor – pozwala na przekazywanie sygnału między taskami.

Zaczniemy od **muteksa**, bo on najładniej naprawia problem, który właśnie zobaczyliśmy z LED-em.

---

### 2.1. Co chcemy uzyskać

Chcemy, żeby nasz wcześniejszy przykład:

- „task A miga co 400 ms”
- „task B miga co 100 ms”

zachowywał się **przewidywalnie**.  
To nie znaczy, że dioda nagle „magicznie” będzie migać dwiema częstotliwościami — bo nie będzie. No nie da się xd  
To znaczy, że:

- w danej chwili **dokładnie jeden task** ma prawo sterować diodą,
- drugi **czeka na swoją kolej**,
- nie ma już „szarpania” albo nadpisywania stanu przez drugi task w losowym momencie.

Czyli: **z chaosu robimy kontrolowaną kolejkę.**

---

## Mutex – techniczny opis

Muteks (ang. *mutual exclusion*) to najprostszy sposób na powiedzenie:  
> „To jest moja sekcja krytyczna. Jak już do niej wszedłem, nikt inny nie może.”

W FreeRTOS wygląda to tak:

1. **Tworzymy mutex** (raz, w `setup()`):
   ```cpp
   SemaphoreHandle_t ledMutex;
   ledMutex = xSemaphoreCreateMutex();
   ```

2. **Przed sterowaniem LED-em bierzemy mutex:**
   ```c++
   xSemaphoreTake(ledMutex, portMAX_DELAY);
   ```
3. **Robimy operację na LED (to jest nasza sekcja krytyczna):**

    ```c++
    digitalWrite(ledPin, HIGH);
    vTaskDelay(pdMS_TO_TICKS(100));
    digitalWrite(ledPin, LOW);
    ```
4.	**Oddajemy mutex:**
    ```c++
    xSemaphoreGive(ledMutex);
    ```
Jeśli w tym samym czasie drugi task spróbuje wziąć ten sam mutex, FreeRTOS go zablokuje i wpuści dopiero wtedy, gdy pierwszy skończy.

LED nie jest najlepszym przykładem do opowiadania o mutexach, więc przykładowa implementacja na współdzielonym zasobie w postaci licznika - najprostszy przykład.

```c++
volatile int counter = 0;
SemaphoreHandle_t serialMutex;   // wspólny mutex dla obu tasków

void TaskA(void *pv) {
  for (;;) {
    if (xSemaphoreTake(serialMutex, portMAX_DELAY)) {
      counter++;
      Serial.print("A: ");
      Serial.println(counter);
      xSemaphoreGive(serialMutex);
    }
    vTaskDelay(pdMS_TO_TICKS(10));
  }
}

void TaskB(void *pv) {
  for (;;) {
    if (xSemaphoreTake(serialMutex, portMAX_DELAY)) {
      counter++;
      Serial.print("B: ");
      Serial.println(counter);
      xSemaphoreGive(serialMutex);
    }
    vTaskDelay(pdMS_TO_TICKS(15));
  }
}

void setup() {
  Serial.begin(115200);
  vTaskDelay(pdMS_TO_TICKS(200));

  serialMutex = xSemaphoreCreateMutex();   // tworzymy mutex

  xTaskCreate(TaskA, "TaskA", 2048, NULL, 1, NULL);
  xTaskCreate(TaskB, "TaskB", 2048, NULL, 1, NULL);
}

void loop() {}
```

Na tym przykładzie możemy doskonale zaobserwować piękno i magię działania mutexów. Choć czasem zdarzy się, że jedno zadanie zostanie np. wykonane dwukrotnie pod rząd, to współdzielony zasób jest chroniony:

```
B: 1344
A: 1345
A: 1346
B: 1347
A: 1348
B: 1349
A: 1350
A: 1351
B: 1352
```

## SemaphoreHandle_t serialMutex

**Typ:**  
`SemaphoreHandle_t` To uchwyt, za pomocą którego taski odwołują się do danego mechanizmu synchronizacji.  
Deklaracja nie tworzy jeszcze mutexa — dopiero `xSemaphoreCreateMutex()` alokuje strukturę w pamięci FreeRTOS i zwraca jej adres.  
Mutex posiada także wbudowany mechanizm dziedziczenia priorytetu.

---

## xSemaphoreTake(serialMutex, portMAX_DELAY)

**Prototyp:**  
```c
BaseType_t xSemaphoreTake(SemaphoreHandle_t xMutex, TickType_t xTicksToWait);
```

Funkcja próbuje „zająć” mutex (wejść do sekcji krytycznej).  
Jeśli mutex jest wolny – task natychmiast go przejmuje.  
Jeśli mutex jest zajęty – task zostaje zablokowany (stan *Blocked*) i scheduler przekazuje CPU innym zadaniom.  
Po zwolnieniu mutexa przez inny task, kernel odblokowuje oczekujący task.

**Drugi argument:**  
`portMAX_DELAY` – oznacza czekanie w nieskończoność, aż mutex będzie dostępny.

Zwraca `pdTRUE` (mutex zdobyty) lub `pdFALSE` (timeout).  
Scheduler zarządza kolejką oczekujących, aby zapobiec głodzeniu zadań.

---

## xSemaphoreGive(serialMutex)

**Prototyp:**  
```c
BaseType_t xSemaphoreGive(SemaphoreHandle_t xMutex);
```

Zwalnia mutex, umożliwiając innym taskom uzyskanie dostępu do zasobu.  
Jeśli istnieją taski oczekujące w kolejce, scheduler wybiera pierwszy i odblokowuje go.  
Mutex powinien być zawsze zwalniany przez ten sam task, który go zajął.  
Zwraca `pdTRUE` przy powodzeniu, `pdFALSE` w przypadku błędu (np. mutex nie był zajęty).

---

## W skrócie

- `SemaphoreHandle_t serialMutex` — deklaracja uchwytu do mutexa, wspólna dla tasków  
- `xSemaphoreTake(serialMutex, portMAX_DELAY)` — próba zajęcia mutexa i wejście do sekcji krytycznej  
- `xSemaphoreGive(serialMutex)` — zwolnienie mutexa i przekazanie zasobu kolejnemu taskowi  

Mutex w FreeRTOS zapewnia, że tylko jeden task w danym momencie korzysta z chronionego zasobu,  
a scheduler zarządza kolejką oczekujących, gwarantując przewidywalne działanie systemu.


# 3. Semafor binarny – sygnalizacja między zadaniami

W poprzedniej części zobaczyliśmy, że **mutex** służy do tego, żeby *uporządkować dostęp* do jednego, współdzielonego zasobu (np. Serial, wspólny bufor, jeden pin).  
Czasem jednak nie chodzi o to, żeby „chronić zasób”, tylko żeby **powiedzieć innemu taskowi: „hej, zdarzyło się coś, możesz działać”**.

Do tego służy **semafor binarny**.

---

## Co to jest semafor binarny?

Semafor binarny to **flaga sterowana przez RTOS**:
- ma tylko dwa stany: *jest* (1) albo *nie ma* (0),
- jeden task (albo przerwanie) może **dać** semafor (`xSemaphoreGive()`),
- inny task może na ten semafor **czekać** (`xSemaphoreTake()`),
- jeśli semafora „nie ma”, task **czeka blokując się** (nie mieli w pętli i nie zużywa CPU),
- gdy semafor zostanie „dany”, czekający task się **budzi** i wykonuje swoją akcję.

Różnica względem mutexa:  
- **mutex** – „tylko jeden naraz w sekcji krytycznej”,  
- **semafor binarny** – „uruchom mnie, gdy coś się stanie”.

---

## Typowy scenariusz

Bardzo częsty wzorzec w RTOS-ach:

1. **Task producenta zdarzenia** (np. odlicza czas, nasłuchuje przycisku, kończy pomiar) – kiedy skończy, robi `xSemaphoreGive()`.
2. **Task konsumenta zdarzenia** (np. zapala LED, wysyła dane, odświeża ekran) – czeka na `xSemaphoreTake(...)`.

Dzięki temu konsument **nie musi**:
- robić pętli `if(flag) ...`,
- sprawdzać statusu co 10 ms,
- ani używać `delay()`.

On po prostu **śpi, aż ktoś go zawoła**.

---

## Minimalny przykład: „A wyzwala, B reaguje”

Poniżej masz najprostszy możliwy przykład: jeden task co sekundę wysyła sygnał, drugi na ten sygnał reaguje.

```cpp
SemaphoreHandle_t signalSem;

void TaskProducer(void *pv) {
  for (;;) {
    vTaskDelay(pdMS_TO_TICKS(1000));   // co 1 s generujemy zdarzenie
    Serial.println("Task A: sygnał!");
    xSemaphoreGive(signalSem);         // powiadom odbiorcę
  }
}

void TaskConsumer(void *pv) {
  for (;;) {
    // czekamy, aż ktoś "da" semafor
    if (xSemaphoreTake(signalSem, portMAX_DELAY) == pdTRUE) {
      Serial.println("Task B: dostałem sygnał -> robię swoje");
      // tu np. mignij diodą, zagraj buzzerem itd.
    }
  }
}

void setup() {
  Serial.begin(115200);
  vTaskDelay(pdMS_TO_TICKS(200));

  // tworzymy semafor binarny (początkowo pusty = 0)
  signalSem = xSemaphoreCreateBinary();

  xTaskCreate(TaskProducer, "Producer", 2048, NULL, 1, NULL);
  xTaskCreate(TaskConsumer, "Consumer", 2048, NULL, 1, NULL);
}

void loop() {}
```

**Co zobaczymy na Serialu:**

```
Task A: sygnał!
Task B: dostałem sygnał -> robię swoje
Task A: sygnał!
Task B: dostałem sygnał -> robię swoje
...
```

Kolejność jest zawsze taka sama: **najpierw A, potem B**.  
To ważne: semafor binarny nie przepuszcza wielu tasków naraz — każdy „give” budzi dokładnie jedno oczekujące zadanie.

---

## Różnice: mutex vs semafor binarny

| Cecha | Mutex | Semafor binarny |
|-------|-------|-----------------|
| Cel | ochrona zasobu | sygnalizacja zdarzeń |
| Właściciel | tak (musi oddać ten, kto wziął) | nie (może dać ktoś inny) |
| Dziedziczenie priorytetu | tak | nie |
| Użycie z ISR | raczej nie | tak (`xSemaphoreGiveFromISR`) |
| Przykład | Serial, bufor, wyświetlacz | przycisk, zakończony pomiar, „nowe dane” |

W tym labie **warto to powiedzieć wprost**:  
> „API wygląda prawie tak samo, ale intencja jest inna.”

---

## Semafor binarny + przerwanie (wersja „realna”)

To jest najfajniejszy przypadek: **przycisk wywołuje przerwanie**, a z przerwania **wybudzamy task**, który coś zrobi (np. zapali LED na 200 ms).  
Dzięki temu cała „ciężka” robota jest w tasku, a nie w ISR.

```cpp
SemaphoreHandle_t buttonSem;
const int buttonPin = 0;
const int ledPin = 2;

void IRAM_ATTR handleButtonISR() {
  BaseType_t xHigherPriorityTaskWoken = pdFALSE;
  xSemaphoreGiveFromISR(buttonSem, &xHigherPriorityTaskWoken);
  portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
}

void TaskLed(void *pv) {
  pinMode(ledPin, OUTPUT);
  for (;;) {
    if (xSemaphoreTake(buttonSem, portMAX_DELAY) == pdTRUE) {
      digitalWrite(ledPin, HIGH);
      vTaskDelay(pdMS_TO_TICKS(200));
      digitalWrite(ledPin, LOW);
    }
  }
}

void setup() {
  Serial.begin(115200);
  pinMode(buttonPin, INPUT_PULLUP);

  buttonSem = xSemaphoreCreateBinary();
  xTaskCreate(TaskLed, "LED", 2048, NULL, 1, NULL);
  attachInterrupt(digitalPinToInterrupt(buttonPin), handleButtonISR, FALLING);
}

void loop() {}
```

**Co tu jest ważne:**
- ISR jest **krótkie** – tylko „daje” semafor,
- cała logika (delay, LED, logi) jest w tasku – to poprawny wzorzec RTOS,
- semafor binarny jest tu **mostem między światem przerwań a światem tasków**.

---

## Funkcje, które poznajemy

- `xSemaphoreCreateBinary()` – tworzy semafor binarny (domyślnie pusty)
- `xSemaphoreTake(sem, portMAX_DELAY)` – czeka, aż ktoś „da” semafor
- `xSemaphoreGive(sem)` – daje semafor z poziomu taska
- `xSemaphoreGiveFromISR(sem, &xHigherPriorityTaskWoken)` – daje semafor z poziomu przerwania
- `portYIELD_FROM_ISR(...)` – mówi schedulerowi: „przełącz się teraz, bo obudziłem ważniejszy task”

---

## Wniosek

> Mutexy rozwiązują problem „*kto ma prawo wejść do sekcji krytycznej*”.  
> Semafory binarne rozwiązują problem „*kto ma się teraz obudzić, bo coś się stało*”.

W praktycznym projekcie RTOS obie rzeczy występują razem:  
- mutex na zasób (np. wyświetlacz, UART),  
- semafor binarny na zdarzenie (np. kliknięcie, przyjście danych, timeout z timera).
