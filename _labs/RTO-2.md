---
layout: lab
course: RTO
type: stacjonarne
lab_nr: 2
subject: RTOS‑Lab‑02
description: Pierwsze kroki z współbieżnością na FreeRTOS
---

## Wprowadzenie
W klasycznym programie mikrokontrolera, dla uproszczenia we Frameworku Arduino, który mogliście poznać na innych zajęciach program wykonuje się krok po kroku:

```c++
void loop() {
    blinkLed();
    readSensor();
    sendData();
}
```

Jednak gdy jedna z funkcji zajmuje zbyt dużo czasu, np. `sendData();` staje cały system - nie mamy drugiej pętli, która mogłaby coś w międzyczasie wykonać.

> Problemem jest tu brak równoległości

W klasycznym programie mikrokontrolera (np. Arduino UNO z ATmegą) kod wykonywany jest **sekwencyjnie** — procesor wykonuje jedną instrukcję naraz, linijka po linijce. Jedna funkcja musi się zakończyć, zanim zacznie się kolejna.

ESP32 to jednak **bardziej zaawansowany mikrokontroler**, wyposażony w **dwa rdzenie CPU**:
- **Core 0** – często obsługuje zadania systemowe, komunikację Wi-Fi/Bluetooth,
- **Core 1** – zwykle uruchamia kod użytkownika (ale można to zmienić).

System FreeRTOS zarządza oboma rdzeniami i potrafi wykonywać **różne taski równolegle** – jeden na każdym rdzeniu.

Przykład pierwszy: kod nierównoległy

```c++
void setup() {
  pinMode(2, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  // "Zadanie" 1 — LED (blokujące)
  digitalWrite(2, !digitalRead(2));
  delay(500);                 // blokuje całe loop na 500 ms

  // "Zadanie" 2 — log (też blokujące)
  Serial.println("Hello!");
  delay(1000);                // znów blokada na 1000 ms
}
```

Na pierwszy rzut oka może się wydawać, że wyjście na pinie 2 (Builtin LED w ESP32) będzie się przełączać co pół sekundy. Na drugi rzut oka okazuje się jednak, że zmiana stanu następować będzie co półtorej sekundy.

> W tym podejściu jedna operacja blokuje drugą

### Wejście w świat systemów czasu rzeczywistego

Program we FreeRTOS możemy podzielić na **niezależne jednostki wykonywalne**, zwane **taskami** (ang. _tasks_).  

Każdy task to w praktyce **funkcja w nieskończonej pętli**, która wykonuje swoje zadanie, a następnie **oddaje sterowanie schedulerowi**, aby inne taski również mogły działać.

### Czym jest ten task?

Task można porównać do „miniaturowego programu”, który działa **własnym rytmem**:

- ma własny **stos** (pamięć lokalną),
- posiada **priorytet** – czyli informację, jak ważny jest dla systemu,
- może być **wstrzymany, zablokowany, uśpiony lub wykonywany**.

W tradycyjnym programie Arduino mamy tylko jedną pętlę -> `loop()`.  
W FreeRTOS każda pętla (każdy task) jest traktowana osobno i to scheduler decyduje, _kiedy i na jakim rdzeniu_ zostanie wykonana.

Scheduler to część FreeRTOS, która zarządza czasem procesora i decyduje, które zadanie ma być aktualnie wykonywane.

- W danym momencie **każdy rdzeń ESP32** może wykonywać **jeden task**.
- Jeśli liczba zadań jest większa niż liczba rdzeni, scheduler **przełącza je bardzo szybko** (zwykle co 1 ms – tzw. _tick_).
- W efekcie wszystkie taski wyglądają na działające równocześnie.

**Każde zadanie powinno co jakiś czas:**
- wykonać operację `vTaskDelay(...)` lub
- oczekiwać na zdarzenie (np. kolejkę, semafor, powiadomienie), aby oddać CPU innym taskom.

**Dzięki temu system zachowuje płynność i nie blokuje innych funkcji!** 

### Stany tasków

|Stan|Opis|
|---|---|
|**Running**|Zadanie aktualnie działa na CPU.|
|**Ready**|Gotowe do działania, czeka na swoją kolej.|
|**Blocked**|Wstrzymane, np. przez `vTaskDelay()` lub oczekiwanie na zdarzenie.|
|**Suspended**|Uśpione — nie jest brane pod uwagę przez scheduler.|

### Jak tworzony jest task?

```c++
xTaskCreate(
  TaskBlink,      // funkcja taska
  "Blink",        // nazwa (dla debugowania)
  2048,           // rozmiar stosu w bajtach
  NULL,           // argument przekazywany do taska
  1,              // priorytet (większy = ważniejszy)
  NULL            // uchwyt (opcjonalnie)
);
```

### Kod z początku
Ale tym razem - zadania realizowane równolegle

```c++
void TaskBlink(void *pv) {
  pinMode(2, OUTPUT);
  for (;;) {
    digitalWrite(2, !digitalRead(2));
    vTaskDelay(pdMS_TO_TICKS(500));  // oddaje CPU na ~500 ms
  }
}

void TaskLog(void *pv) {
  // krótka pauza, żeby Serial z setup() zdążył się zestawić
  vTaskDelay(pdMS_TO_TICKS(200));
  for (;;) {
    Serial.println("Hello!");
    vTaskDelay(pdMS_TO_TICKS(1000)); // oddaje CPU na ~1000 ms
  }
}

void setup() {
  Serial.begin(9600);

  // Dwa taski o tym samym priorytecie (1). Stosy po 2048 bajtów.
  xTaskCreate(TaskBlink, "Blink", 2048, NULL, 1, NULL);
  xTaskCreate(TaskLog,   "Log",   2048, NULL, 1, NULL);
}

void loop() {
  // puste — scheduler FreeRTOS zarządza zadaniami
}
```

Funkcja **`vTaskDelay()`** służy do **wstrzymania wykonywania taska na określony czas** (liczony w _tickach_ systemowych).  To podstawowy i najprostszy sposób, by **oddać procesor (CPU)** innym zadaniom w systemie FreeRTOS.

Aby wygodnie przeliczać milisekundy na ticki, używamy makra:
```c++
pdMS_TO_TICKS(ms)
```

1. Gdy task wywoła `vTaskDelay()`, FreeRTOS **zmienia jego stan z „Running” na „Blocked”**.
2. Scheduler **usuwa go z listy zadań gotowych do działania**.
3. Upływ czasu (ticki systemowe) jest zliczany przez zegar RTOS.
4. Po upływie zadanego czasu scheduler **przywraca task do stanu „Ready”** – i od tej chwili może znowu zostać uruchomiony.

Ważne: w tym czasie CPU może spokojnie wykonywać **inne taski**.


