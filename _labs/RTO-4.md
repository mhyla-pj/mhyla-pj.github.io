---
layout: lab
course: RTO
type: stacjonarne
lab_nr: 4
subject: RTOS‑Kolejki
description: Tu miał być żart o SKM, ale jest za późno i nic nie mogę wymyślić
---

**Kolejki** (ang. queues) są podstawowym mechanizmem komunikacji między zadaniami w FreeRTOS.

Co do zasady, kolejki umożliwiają bezpieczne przekazywanie danych pomiędzy taskami lub między przerwaniami (ISR) a taskami, bez konieczności używania wspólnej pamięci i synchronizacji tej pamięci np. mutexami. 

Używa się ich jako buforów FIFO (First In, First Out) – dane są odbierane w tej samej kolejności, w jakiej zostały wysłane.

Kolejka może przechowywać:
- proste typy (np. int, float),
- struktury danych,
- wskaźniki do większych buforów.

Są dwa sposoby implementacji kolejek we FreeRTOS -  kolejkowanie przez kopiowanie oraz kolejkowanie przez referencję. Pierwszy sposób w kolejce umieszcza kopię dodawanych do niej danych. Kolejkowanie przez referencję oznacza, że budować będziemy kolejkę wskaźników - metoda używana, kiedy kolejkowane dane są zbyt duże, aby ich kopiowanie było praktyczne. 

---

### Dlaczego FreeRTOS używa kolejek kopiujących dane (queue by copy)

FreeRTOS do do zasady stosuje mechanizm **kolejkowania przez kopiowanie**, ponieważ jest on **zarówno prostszy, jak i bardziej elastyczny** niż przekazywanie przez referencję.
Najważniejsze zalety:

- Kolejka kopiująca **nie wyklucza** użycia wskaźników — gdy dane są zbyt duże, można po prostu przekazać do kolejki **adres bufora** zamiast samych danych.
- Można wysłać do kolejki **zmienną lokalną (na stosie)**, nawet jeśli przestanie istnieć po zakończeniu funkcji — dane są kopiowane do pamięci zarządzanej przez RTOS.
- Nie ma potrzeby wcześniej **alokować bufora** – dane są kopiowane bezpośrednio do przestrzeni kolejki.
- **Zmienna lub bufor wysłany do kolejki** może być od razu ponownie użyty – jego zawartość została już przekopiowana.
- **Zadania wysyłające i odbierające** są całkowicie niezależne – nie trzeba ustalać, kto „posiada” dane ani kto je zwolni z pamięci.
- **FreeRTOS sam zarządza pamięcią** używaną do przechowywania danych w kolejce.

Kolejki są niezależnymi obiektami systemowymi — każde zadanie lub procedura przerwania (ISR), które posiada uchwyt do kolejki, może z niej korzystać.

**Możliwe jest więc:**

- wysyłanie danych do jednej kolejki przez wiele różnych zadań (wielu nadawców),
- odbieranie danych z jednej kolejki przez jedno lub więcej zadań (wielu odbiorców).

W praktyce najczęściej spotykana konfiguracja to wielu nadawców i jeden odbiorca.
Kolejki z wieloma odbiorcami również są obsługiwane, ale ponieważ tylko jedno zadanie może faktycznie odebrać konkretny element z kolejki — po jego odczytaniu dane znikają z bufora ich zastosowanie jest w praktyce marginalne.

Jeśli zadanie próbuje odczytać dane z **pustej kolejki**, może określić tzw. **czas blokowania** (block time) — czyli maksymalny czas, przez jaki ma pozostać w stanie **Blocked**, czekając na nadejście danych.
W tym czasie zadanie:
- nie zużywa czasu procesora,
- zostaje automatycznie odblokowane (Ready), gdy inny task lub ISR zapisze dane do kolejki,
- może też zostać odblokowane po upływie zadanego czasu oczekiwania (timeout).

## Koniec z teorią, piszemy

```c
QueueHandle_t xQueueCreate( UBaseType_t uxQueueLength, UBaseType_t uxItemSize );
```

Funkcja `xQueueCreate` - tu niespodzianka - tworzy kolejkę. PRzyjmuje dwa argumenty: 
- `uxQueueLength` - maksymalna długość kolejki
- `uxItemSize` - rozmiar pojedynczego elementu trzymanego w kolejce

Funkcja zwraca NULL, jeśli system nie dysponuje wystarczającą ilością pamięci. Każdy inny return oznacza prawidłowe utworzenie kolejki. 

`xQueueReset()` to funkcja, która przywraca już utworzoną kolejkę do stanu pierwotnego.

### Umieszczanie danych w kolejce

Mamy trzy funkcje, którymi możemy umieszczać dane w kolejce:
- `xQueueSendToBack()` - wysyła dane na koniec kolejki
- `xQueueSendToFront()` - wysyła dane na początek kolejki
- `xQueueSend()` - robi dokładnie to samo, co `xQueueSendToBack()` i jest równocześnie standardowym sposobem użycia kolejki FIFO.

```c
BaseType_t xQueueSend( 
    QueueHandle_t xQueue, 
    const void * pvItemToQueue,
    TickType_t xTicksToWait );
```

Funkcja przyjmuje 3 argumenty:

1. Kolejka, do której się odnosimy
2. Wskaźnik na element, który ma zostać do kolejki przesłany
3. Maksymalny czas oczekiwania - tak długo task będzie blokowany, jeśli docelowa kolejka będzie pełna. Funkcja zwróci natychmiast, jeśli ten argument będzie ustawiony na NULL, a kolejka będzie pełna. Ustawienie `xTicksToWait` na wartość `portMAX_DELAY` spowoduje oczekiwanie bez końca (jeśli `INCLUDE_vTaskSuspend` jest ustawiony na 1 w pliku `FreeRTOSConfig.h.`)

**Return**
Możliwe są dwie zwrotku z funckji - `pdPASS` jeśli element w określonym czasie zostanie dodany do kolejki. `errQUEUE_FULL` (czyli `pdFAIL`) zostanie zwrócony jeśli kolejka jest pełna i doszło do timeoutu.


### Odbiór z kolejki

`xQueueReceive()` to funkcja odczytująca z kolejki. Odczytany element jest usuwany z kolejki

```c
BaseType_t xQueueReceive( 
    QueueHandle_t xQueue,
    void * const pvBuffer,
    TickType_t xTicksToWait );
```

Funkcja odbierająca również przyjmuje 3 argumenty:
1. Kolejka, z której odczytywane są dane
2. Wskaźnik na pamięć, gdzie odczytane dane zostaną umieszczone
3. Maksymalny czas oczekiwania na odczyt. Jeśli `xTicksToWait` jest ustawiony na 0, to oczekiwanie na fukncja zwróci natychmiast, jeśli kolejka jest pusta. Podobnie jak w zapisie, możemy ustawić `xTicksToWait` na `portMAX_DELAY` - wówczas Task będzie wisiał w stanie zablokowanym.

**Return**
Funkcja może zwrócić:
- `pdPASS` - kiedy dane są z sukcesem odczytane z kolejki
- `pdFAIL` (`errQUEUE_EMPTY`) - kiedy kolejka nic nie zwróciła i dotarliśmy do timeoutu.


### Mały wtręt o pętli nieskończonej
W FreeRTOS każdy task jest zwykłą funkcją w C, która działa dopóki nie zakończy się jej kod.

Jeśli funkcja dojdzie do końca (zwróci return lub wyjdzie poza for(;;)) FreeRTOS usuwa to zadanie z systemu - dlatego większość zadań ma formę:

```c 
for (;;)
{
    // główna logika
}
```

W przypadku zadań nasłuchujących kolejki, pętla nieskończona jest naturalna – zadanie powinno reagować na napływające dane przez cały czas działania systemu.
Jednak czas oczekiwania w `xQueueReceive()` decyduje o tym, czy zadanie może wykonać dodatkowe działania, jeśli nic nie przyszło.
**Na przykład:**
- `portMAX_DELAY` — task będzie zablokowany aż do nadejścia danych, nie wykona nic innego;
- `pdMS_TO_TICKS(500)` — task odblokuje się po 500 ms, dzięki czemu można dodać obsługę błędu, timeoutu lub komunikat „brak danych”.

**W praktyce:**

- Długie oczekiwanie (`portMAX_DELAY`) – dla zadań, które po prostu „czekają na dane” i nic innego nie robią.
- Ograniczony timeout – gdy potrzebna jest reakcja na brak danych (np. sygnalizacja LED, watchdog, retransmisja).

## Przykładowy kod

```c
#include <FreeRTOS.h>
#include <task.h>
#include <queue.h>
#include <stdio.h>

QueueHandle_t xQueue;

/* Zadanie wysyłające dane */
void vSenderTask(void *pvParameters)
{
    int valueToSend = 0;

    for (;;)
    {
        if (xQueueSend(xQueue, &valueToSend, portMAX_DELAY) == pdPASS)
        {
            printf("Wysłano: %d\n", valueToSend);
            valueToSend++;
        }

        vTaskDelay(pdMS_TO_TICKS(1000)); // co 1 sekundę
    }
}

/* Zadanie odbierające dane */
void vReceiverTask(void *pvParameters)
{
    int receivedValue;

    for (;;)
    {
        /* Odbiór danych z kolejki */
        if (xQueueReceive(xQueue, &receivedValue, pdMS_TO_TICKS(500)) == pdPASS)
        {
            printf("Odebrano: %d\n", receivedValue);
        }
        else
        {
            /* Kolejka była pusta przez 500 ms — można zareagować */
            printf("Brak danych w kolejce!\n");
        }
    }
}

/* Funkcja main */
int main(void)
{
    xQueue = xQueueCreate(5, sizeof(int));

    if (xQueue != NULL)
    {
        xTaskCreate(vSenderTask, "Sender", 2048, NULL, 1, NULL);
        xTaskCreate(vReceiverTask, "Receiver", 2048, NULL, 1, NULL);
        // vTaskStartScheduler(); - do weryfikacji
    }
    else
    {
        printf("Nie udało się utworzyć kolejki!\n");
    }

    for (;;);
}
```

## Zadanie - kolejka jako bufor pomiarów

**Założenie**
Mamy **task-producenta**, który okresowo czyta wartość z czujnika (np. fotorezystora albo potencjometru) i wrzuca ją do kolejki, oraz **task-konsumenta**, który odbiera dane z kolejki i:

- wypisuje je po UART
- sygnalizuje prawidłowy odbiór danych mrugnięciem LED

W tym zadaniu należy utworzyć strukturę przechowującą wartość pojedynczego pomiaru oraz jego timestamp:

```c
typedef struct {
    uint32_t timestampMs;
    int rawValue;      // wartość z czujnika
} Measurement_t;
```

Rozwiązanie, jaką wartość ma przyjmować timestamp pozostawiam wam (ticki, faktyczny czas, losowy int - opcji jest wiele)

**Task-producent:**
Co 200ms
  - Odczytuje wartość z czujnika
  - Wypełnia strukturę `Measurment_t`
  - wysyła strukturę do kolejki (xQueueSend z jakimś sensownym timeoutem, np. 50 ms)
  - jeśli kolejka jest pełna → zasygnalizuj błąd podwójnym mrugnięciem LED-em i brzeczykiem
  - Jeśli czujnik zwraca wartość 0 - zakłada, że wystąpił błąd i nie dodaje niczego do kolejki - sygnalizuje błąd podwójnym mrugnięciem LED.

**Task-konsument**
  - Odbiera dane z kolejki
  - Loguje je na serialu
  - Wykonuje pojedyncze mrugnięcie LED po prawidłowym odczycie
  - Timeout powinien mieć ustawiony na 1 sekundę - jeśli w tym czasie nie otrzyma danych powinien wykonać trzykrotne mrugnięcie LED i zalogować error na Serialu.

**Opcje rozbudowy**
1. Zrób dwóch producentów - wrzucających do tej samej kolejki - w strukturze dodaj pole `sourceId`, żeby odróżniać źródła. Drugi producent dla utrudnienia może czytać z Seriala. 
2. Dodaj możliwość zmiany częstotliwości próbkowania przyciskiem (task nasłuchujący przycisku zmienia okres działania vSensorTask) - to zakłada, że znajdziemy gdzieś na wydziale przyciski. 
