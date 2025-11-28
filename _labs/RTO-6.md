---
layout: lab
course: RTO
type: stacjonarne
lab_nr: 6
subject: Task Notifications
description: W końcu!
---

## Wprowadzenie
Aplikacje FreeRTOS są, jak już zapewne wszyscy doskonale wiedzą, ułożone jako seria **Tasków**, które nierzadko *w jakiś sposób* muszą się ze sobą komunikować. 

W poprzednich zajęciach przećwiczyliśmy mechanizmy synchronizacji i komunikacji w FreeRTOS:  
– taski i priorytety  
– kolejki  
– `vTaskDelay()`  
– semafory binarne  
– mutexy  
Każdy z nich ma swoje zadania i zalety — kolejki do przekazywania danych, semafory jako sygnał wykonania, mutexy do ochrony dostępu do zasobów. W praktycznych projektach pojawia się jednak sytuacja, w której te narzędzia mogą okazać się zbyt ciężkie, zbyt rozbudowane lub niewspółmiernie kosztowne czasowo w stosunku do problemu, który chcemy rozwiązać.

Przyszedł zatem moment na zapoznanie się z prawdopodobnie najważniejszym (a w każdym razie najlżejszym) sposobem komunikacji pomiędzy taskami - **Task Notifications**

### To co to dokładnie jest?

Każdy task w RTOS posiada tablicę powiadomień. Każde powiadomienie ma swój stan, który może być „pending” (oczekujące) lub „not pending” (nieoczekujące), oraz 32-bitową wartość powiadomienia. Stała `configTASK_NOTIFICATION_ARRAY_ENTRIES` określa liczbę elementów w tablicy powiadomień taska.

Przed FreeRTOS w wersji V10.4.0 taski posiadały tylko jedno powiadomienie, a nie całą tablicę. Powiadomienie bezpośrednie (ang. direct to task notification) to zdarzenie wysyłane bezpośrednio do taska, zamiast pośrednio za pomocą obiektu takiego jak kolejka, event group czy semafor.

Wysłanie powiadomienia bezpośredniego ustawia stan powiązanego powiadomienia taska na „pending”. Podobnie jak task może zostać zablokowany, czekając na dostępność semafora lub innego obiektu synchronizacyjnego, tak samo może zostać zablokowany czekając na zmianę stanu powiadomienia na oczekujące (pending).

**Direct to Task Notifications** to najlżejszy, najszybszy i najbardziej bezpośredni mechanizm komunikacji oraz synchronizacji między zadaniami w FreeRTOS.
To sygnał skierowany bezpośrednio do konkretnego taska, bez użycia żadnych pośrednich struktur takich jak kolejki, semafory, event groups czy message buffers. Mechanizm bazuje na tym, że każde zadanie ma wbudowany własny bufor powiadomień — nie trzeba nic tworzyć, alokować ani inicjalizować. Scheduler i wewnętrzne struktury FreeRTOS obsługują to niskopoziomowo.

Co do zasady - jeśli potrzebna jest komunikacja task-task oraz nie wymaga ona buforowania, to korzystamy z Task Notificatons.

### ✦ Stan powiadomienia: `pending` vs `not pending`

Każde powiadomienie taska posiada oprócz 32-bitowej wartości również **stan** określający, czy powiadomienie oczekuje na odebranie przez zadanie. Wyróżniamy dwa stany:

| Stan powiadomienia | Znaczenie |
|---|---|
| `pending`     | powiadomienie czeka na odbiór przez task |
| `not pending` | task nie ma oczekujących powiadomień |

Gdy task wywołuje `ulTaskNotifyTake()` lub `xTaskNotifyWait()` z opcją blokowania, scheduler wstrzymuje jego działanie **dopóki powiadomienie nie stanie się `pending`**. Oznacza to, że task nie zużywa czasu procesora, a obudzi się dopiero po nadejściu `notify` (np. od innego taska lub z ISR).  

Z kolei w momencie odebrania powiadomienia — w zależności od użytej funkcji i parametrów — stan zwykle ulega przejściu **z `pending` → `not pending`**, a task może kontynuować działania lub ponownie oczekiwać na kolejne zdarzenie.

Można więc myśleć o tym stanie jak o **fladze powiadomienia dla danego taska** — jeżeli jest `pending`, zadanie ma „wiadomość do odebrania”; jeżeli jest `not pending`, to „skrzynka jest pusta” i wywołanie funkcji oczekującej na powiadomienie spowoduje blokadę do czasu, aż ktoś wyśle `notify()`.  
W praktyce `pending/not pending` pełni tę samą rolę, którą w semaforach reprezentuje obecność lub brak dostępnego sygnału — z tą różnicą, że w przypadku Task Notifications nie korzystamy z dodatkowych obiektów, bo stan przechowywany jest **bezpośrednio w strukturze taska (TCB)**.


## Tryb semaforowy (Give/Take)

W tym wariancie `Task Notification` zachowuje się jak **semafor binarny** — może sygnalizować wykonanie zdarzenia, wybudzenie taska lub przekazanie sterowania między dwoma wątkami.  
Od strony API działa bardzo podobnie do `xSemaphoreGive()` i `xSemaphoreTake()`, jednak posiada dwie kluczowe różnice:

1. **Nie wymaga żadnego dodatkowego obiektu w pamięci.**  
   Powiadomienie jest wewnętrzną częścią struktury TCB taska. Nie tworzymy semafora, nie alokujemy RAM — FreeRTOS ma to „wbudowane”.
2. **Jest szybsze niż tradycyjny semafor.**  
   Operacje powiadomień są zoptymalizowane, a scheduler nie musi obsługiwać oddzielnego mechanizmu synchronizacyjnego.

Takie użycie notyfikacji sprawdza się szczególnie tam, gdzie mamy komunikację 1:1 — jeden task produkuje sygnał, drugi na niego czeka.  
Nie przekazujemy tutaj żadnych danych — tylko informację „zdarzenie nastąpiło”.


### Jak to działa?

Notyfikacja ma swój *internal counter* (wewnętrzny licznik), a wybudzenie działa na zasadzie:

| Wywołanie                     | Znaczenie                                                |
|------------------------------|----------------------------------------------------------|
| `xTaskNotifyGive(handle)`    | Nadaje sygnał — zwiększa licznik powiadomień taska       |
| `ulTaskNotifyTake(...)`      | Czeka na powiadomienie i — w zależności od konfiguracji — zmniejsza licznik |

Najczęściej stosuje się:

```c
ulTaskNotifyTake(pdTRUE, portMAX_DELAY);
```

gdzie:
- `pdTRUE` - po odebraniu sygnału licznik zostanie wyzerowany (jak semafor binarny),
- `portMAX_DELAY` - task będzie czekał tak długo, aż powiadomienie nadejdzie.
- 
Można tak jak zawsze użyć timeoutu, np. 100ms — wtedy task po upływie czasu będzie mógł wziąć i zająć się czymś innym.

Przykładowy kod: 
(tu małe info - kod nietestowany, o godzinie 22:30 spaliłem moje ostatnie ESP32. Na moim przedostatnim usiadłem dzień wcześniej)

```c
void taskA(void *pvParameters) {
  (void) pvParameters;

  for (;;) {
    vTaskDelay(pdMS_TO_TICKS(1000));  // 1s
    // Wyślij powiadomienie typu "Give" do taskB
    xTaskNotifyGive(taskBHandle);
    Serial.println("TaskA: wysłano powiadomienie do TaskB");
  }
}

// TaskB: czeka na powiadomienie i reaguje
void taskB(void *pvParameters) {
  (void) pvParameters;

  for (;;) {
    // Czekamy, aż TaskA nas powiadomi
    ulTaskNotifyTake(pdTRUE, portMAX_DELAY);
    // Po otrzymaniu sygnału:
    Serial.println("TaskB: odebrano powiadomienie (notify)");
  }
}
```

### Funkcje API `xTaskNotify()` i `xTaskNotifyFromISR()`

`xTaskNotify()` jest bardziej rozbudowaną wersją `xTaskNotifyGive()`, która może być użyta do
aktualizacji wartości powiadomienia taska na jeden z poniższych sposobów:

- **Inkrementacja** (zwiększenie o 1) wartości powiadomienia taska.  
  W takim przypadku `xTaskNotify()` jest równoważne `xTaskNotifyGive()`.

- **Ustawienie jednego lub więcej bitów** w wartości powiadomienia taska.  
  Pozwala to traktować wartość powiadomienia jako lżejszą i szybszą alternatywę dla event group.

- **Zapisanie całkowicie nowej liczby** do wartości powiadomienia taska, *ale tylko wtedy*, gdy task
  odczytał swoją wartość powiadomienia od czasu ostatniej aktualizacji.  
  Dzięki temu wartość powiadomienia może dostarczać funkcjonalność podobną do kolejki o długości 1.

- **Zapisanie całkowicie nowej liczby** do wartości powiadomienia taska, *nawet jeśli* task nie
  odczytał jeszcze swojej wartości powiadomienia od czasu ostatniej aktualizacji.  
  Pozwala to używać wartości powiadomienia w sposób podobny do funkcji `xQueueOverwrite()`.  
  Takie zachowanie bywa nazywane *„skrzynką pocztową”* (*mailbox*).

`xTaskNotify()` jest bardziej elastyczne i potężniejsze niż `xTaskNotifyGive()`, a z powodu tej
dodatkowej elastyczności i możliwości jest też nieco bardziej złożone w użyciu.

`xTaskNotifyFromISR()` jest wersją `xTaskNotify()`, której można używać w procedurze obsługi
przerwania (ISR), dlatego posiada dodatkowy parametr `pxHigherPriorityTaskWoken`.

Wywołanie `xTaskNotify()` **zawsze** ustawia stan powiadomienia taska docelowego na *pending*
(oczekujące), jeśli wcześniej nie był on ustawiony.


## 1)`xTaskNotify()`

```c
BaseType_t xTaskNotify(
    TaskHandle_t  xTaskToNotify,
    uint32_t      ulValue,
    eNotifyAction eAction
);
```
Wysyła powiadomienie do taska i modyfikuje jego wartość powiadomienia zgodnie z `eAction`.

**Argumenty:**

| Argument        | Znaczenie                                       |
| --------------- | ----------------------------------------------- |
| `xTaskToNotify` | task, który ma otrzymać powiadomienie           |
| `ulValue`       | liczba/bity zależnie od trybu (patrz `eAction`) |
| `eAction`       | sposób aktualizacji wartości powiadomienia      |

**Dostępne tryby `eAction`:**

| Tryb                        | Działanie                                         | Typowe zastosowanie                |
| --------------------------- | ------------------------------------------------- | ---------------------------------- |
| `eIncrement`                | zwiększa wartość o 1                              | semafor zliczający                 |
| `eSetBits`                  | ustawia wybrane bity                              | event flags dla jednego taska      |
| `eSetValueWithOverwrite`    | nadpisuje liczbę zawsze                           | mailbox → zawsze najnowsza wartość |
| `eSetValueWithoutOverwrite` | nadpisuje tylko jeśli poprzednia została odebrana | queue length = 1 bez nadpisywania  |

**Return:**

* `pdPASS` → powiadomienie zapisane poprawnie
* `pdFAIL` → odrzucone (głównie przy `WithoutOverwrite`)

---

## 2) `xTaskNotifyFromISR()`

```c
BaseType_t xTaskNotifyFromISR(
    TaskHandle_t  xTaskToNotify,
    uint32_t      ulValue,
    eNotifyAction eAction,
    BaseType_t   *pxHigherPriorityTaskWoken
);
```

**To samo co `xTaskNotify()`**, lecz do użycia w przerwaniach.

| Argument                    | Znaczenie                                                                                                        |
| --------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| `pxHigherPriorityTaskWoken` | ustawiany na `pdTRUE`, gdy notify budzi task o wyższym priorytecie — po ISR można wymusić kontekst przełączeniem |


## 3) `xTaskNotifyGive()` 

```c
BaseType_t xTaskNotifyGive(TaskHandle_t xTaskToNotify);
```

Zachowuje się jak:

```c
xTaskNotify(xTaskToNotify, 0, eIncrement);
```

Najprostsza forma — sygnał/licznik.
Użycie: **producent → konsument licznika zdarzeń**.

Dostępna też wersja ISR:

```c
void vTaskNotifyGiveFromISR(TaskHandle_t t, BaseType_t *pxHigherPriorityTaskWoken);
```

## 4) `ulTaskNotifyTake()` — odbiór w trybie semafor/licznik

```c
uint32_t ulTaskNotifyTake(
    BaseType_t xClearCountOnExit,
    TickType_t xTicksToWait
);
```

**Co robi:**
Odbiera powiadomienie *jako licznik*. Jeśli nie jest pending — może czekać.

| Argument                      | Znaczenie                              |
| ----------------------------- | -------------------------------------- |
| `xClearCountOnExit = pdTRUE`  | po odebraniu licznik jest zerowany     |
| `xClearCountOnExit = pdFALSE` | licznik zmniejszony o 1 (gdy > 0)      |
| `xTicksToWait`                | timeout (`portMAX_DELAY` = bez limitu) |

**Zwraca:** liczbę odebranych powiadomień.
Jeśli timeout - `0` (podręcznik mówi `pdFAIL`).

## 5) `xTaskNotifyWait()` — odbiór wartości/bits/mailbox

```c
BaseType_t xTaskNotifyWait(
    uint32_t  ulBitsToClearOnEntry,
    uint32_t  ulBitsToClearOnExit,
    uint32_t *pulNotificationValue,
    TickType_t xTicksToWait
);
```

Najbardziej elastyczna forma odbioru.

| Argument               | Znaczenie                                   |
| ---------------------- | ------------------------------------------- |
| `ulBitsToClearOnEntry` | skasuj wskazane bity **przed** oczekiwaniem |
| `ulBitsToClearOnExit`  | skasuj bity **po** odebraniu powiadomienia  |
| `pulNotificationValue` | jeśli ≠ NULL → tu trafia wartość notify     |
| `xTicksToWait`         | timeout (możliwe blokowanie)                |

Return:

* `pdPASS` — powiadomienie odebrane
* `pdFAIL` — timeout

Typowa forma uproszczona:

```c
uint32_t val;
xTaskNotifyWait(0, 0, &val, portMAX_DELAY);
```

---

## Najprostsze podsumowanie w jednym zdaniu:

> `xTaskNotify()` = wyślij → `ulTaskNotifyTake()` albo `xTaskNotifyWait()` = odbierz
> a sposób działania zależy od `eAction`: *inkrement*, *bity*, *nadpisanie/bez nadpisania*.

## Przykładowy kod

```c
void taskSensor(void *pvParameters) {
  (void) pvParameters;

  uint32_t value = 0;

  for (;;) {
    // Symulacja pomiaru (np. ADC, temperatura, itp.)
    value = (value + 7) % 100;   // "pomiary" 0..99

    // Wysyłamy wartość do taskLogger:
    // - loggerTaskHandle: który task powiadamiamy
    // - value: nowa wartość pomiaru
    // - eSetValueWithOverwrite: zawsze nadpisz poprzednią wartość
    xTaskNotify(
      loggerTaskHandle,
      value,
      eSetValueWithOverwrite
    );

    // Info pomocnicze (nie jest konieczne)
    // Serial.printf("Sensor: wyslano wartosc %lu\n", (unsigned long)value);

    vTaskDelay(pdMS_TO_TICKS(200));  // 200 ms między pomiarami
  }
}

// TaskLogger: czeka na powiadomienie i wypisuje ostatnią otrzymaną wartość
void taskLogger(void *pvParameters) {
  (void) pvParameters;

  uint32_t received = 0;

  for (;;) {
    // czekamy na powiadomienie:
    // ulBitsToClearOnEntry = 0 (nic nie czyscimy na wejsciu)
    // ulBitsToClearOnExit  = 0 (nic nie czyscimy automatycznie na wyjsciu)
    // &received            = tutaj trafi wartosc powiadomienia
    // portMAX_DELAY        = czekamy bez ograniczenia
    BaseType_t notified = xTaskNotifyWait(
      0,
      0,
      &received,
      portMAX_DELAY
    );

    if (notified == pdPASS) {
      Serial.printf("Logger: otrzymano wartosc = %lu\n", (unsigned long)received);
    } else {
      // tu trafiłby przypadek timeoutu, gdyby xTicksToWait != portMAX_DELAY
      Serial.println("Logger: timeout na powiadomieniu");
    }
  }
}
```
# Zadanie 1
1. Task Producent:
   - cyklicznie generuje zdarzenia (np. pomiary, sygnały z czujnika,
     zdarzenia z przycisku, losowe wartości — wybór dowolny),
   - zamiast kolejki lub semafora, wykorzystuje:
     ```c
     xTaskNotifyGive()             // lub xTaskNotify(..., eIncrement)
     ```
   - liczba wywołań = liczba „nagromadzonych” zdarzeń

2. Task Konsument:
   - czeka na powiadomienie, wykorzystując:
     ```c
     ulTaskNotifyTake(pdTRUE, portMAX_DELAY);
     ```
   - odczytuje zwróconą wartość i interpretuje ją jako **ilość zgromadzonych zdarzeń**
   - wypisuje wynik na UART (lub wykonuje inną akcję)

**Do wykonania:**
- przygotuj prosty eksperyment:
  - zwiększ częstotliwość Producenta tak, aby Konsument nie nadążał,
  - zaobserwuj, jak rośnie zwrócona wartość,
  - odnotuj co dzieje się z licznikiem gdy `pdTRUE` - reset vs gdy `pdFALSE`.

**Pytania kontrolne:**
- co stanie się, jeśli zdarzenia przychodzą 10x szybciej niż odbiór?
- kiedy ten mechanizm jest lepszy od kolejki?
- kiedy byłby niewystarczający?

# Zadanie 2
 — Task Notifications jako mailbox (wartość nadpisywana)

Stwórz system 2 tasków: **Źródło danych** oraz **Odbiornik**.

1. Task Źródło:
   - generuje dane (dowolne — pomiar czujnika, procent baterii,
     prędkość obrotowa, poziom światła, temperatura…),
   - wysyła wartość do odbiornika za pomocą:
     ```c
     xTaskNotify(taskHandle, value, eSetValueWithOverwrite);
     ```
     Tak, aby zawsze zachowana była *tylko najnowsza wartość*.

2. Task Odbiornik:
   - czeka na powiadomienie używając:
     ```c
     xTaskNotifyWait(0, 0, &received, portMAX_DELAY);
     ```
   - po odebraniu wyświetla lub przetwarza wartość

**Eksperyment obowiązkowy:**
- zwiększ częstotliwość wysyłania danych przez Źródło
- dodaj celowe opóźnienie w Odbiorniku (np. `vTaskDelay(1000)`)
- sprawdź → **czy stare dane giną?**  
  (powinny – mechanizm mailbox przechowuje tylko ostatnią wartość)

**Dodatkowe pytania:**
- w jakich aplikacjach nie chcemy pamiętać historii danych?
- jak zachowałaby się kolejka w tym scenariuszu?
- co by się zmieniło przy `eSetValueWithoutOverwrite`?