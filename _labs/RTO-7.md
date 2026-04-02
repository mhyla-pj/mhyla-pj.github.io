---
layout: lab
course: RTO
type: stacjonarne
lab_nr: 7
subject: Software Timers
description: Przyszedł na mnie czas
---

## Wprowadzenie

Do tej pory układaliśmy nasze aplikacje FreeRTOS z klocków takich jak:
- taski o różnych priorytetach
- `vTaskDelay()` 
- kolejki
- semafory i mutexy
- Task Notifications
- 
Dzięki nim potrafimy na przykład „budzić” taski na sygnał od innych tasków / ISR, przekazywać dane między wątkami albo po prostu czekać na zdarzenia bez marnowania zasobów CPU.

**Pozostaje jednak jeden, bardzo częsty problem praktyczny:**
> „Chcę, żeby co X ms coś się działo”
albo
> „Jeśli w ciągu Y ms nie stało się Z, to wykonaj jakąś akcję (timeout)”.

Oczywiście można to posklejać z `vTaskDelay()` i pętli wewnątrz taska, ale szybko może się to skończyć np. taskami, które istnieją tylko po to, żeby liczyć czas, albo patologicznym *spaghetti-code* z `vTaskDelay()` w kilku miejscach kodu taska, a przede wszystkim komplikuje zmianę interwałów (czasem co ćwierć sekundy, a czasem co dwie).

**I aby pomóc nam rozwiązać te problemy w sposób elegancki na scenę wkraczają - całe na biało - *Software Timers***

Software timer to obiekt FreeRTOS, który odlicza ticki systemowe, a po upływie zadanego czasu wywołuje wskazaną funkcję. Alternatywnie, timery software'owe mogą również wykonywać zadaną funkcję okresowo. Funkcja wykonywana przez software timer nazywana będzie *software timer's callback function* 

### Każdy timer ma:
- okres (*period*) – ile ticków mija między startem a wywołaniem callbacka,
- tryb:
  - one-shot – strzela jeden raz i koniec,
  - auto-reload – po wywołaniu callbacka automatycznie startuje od nowa; 
- callback – funkcja wywoływana przy wygaśnięciu timera.

### Wewnątrz jądra działa sobie timer service (daemon) task, który:
- trzyma listę aktywnych timerów,
- odbiera komendy z wewnętrznej kolejki (start, stop, reset, zmiana okresu, delete),
- gdy któryś timer „wygaśnie”, wywołuje jego callback. 
  

## A prościej?

Wyobraź sobie budzik:
1. Nastawiasz go na 7:00 (bo zajęcia o 8:00)
2. Kładziesz się spać
3. Budzik sam pilnuje czasu
4. Punktualnie o 7:00 - dzwoni

My nie musimy dzięki zastosowaniu tego budzika co chwila otwierać oczu i patrzeć na zegar, ani tym bardziej liczyć w głowie czasu od zaśnięcia. To byłoby dość trudne - a właśnie tak (w pewnym uproszczeniu) tworzyliśmy do tej pory systemy.

Porównanie z budzikiem jest w zasadzie wielowarstwowe i można na nim wytłumaczyć również zasadę działania trybów timerów:
- one-shot to budzik jednorazowy, odpalany na jeden dzień (np. piątek, kiedy zaczynam dwie godziny wcześniej niż każdego innego dnia). Uruchomi się raz i już nigdy więcej - chyba że go przeładujemy manualnie.
- auto-reload będzie budzikiem ustawianym od poniedziałku do piątku na tę samą godzinę - dzwoni co 24 godziny i sam się przeładowuje.

W FreeRTOS przy tworzeniu Software Timera określać będziemy trzy rzeczy: okres, tryb, funkcję, którą ma wykonać. 

## No i po co to wszystko?

Zastosowań jest mnogość, przejdziemy dziś przez kilka z nich, ale najprościej jest to wyjaśnić obrazowo:
### 1. One-shot Timer
- **Opóźniona reakcja na przycisk (debouncing)** - użytkownik naciska przycisk, a my chcemy zareagować dopiero, gdy przycisk był stabilnie wciśnięty przez 50 ms. ISR od przycisku tylko startuje / resetuje one-shot timer na 50 ms. Jeśli po 50 ms timer „zadzwoni”, w callbacku sprawdzamy stan pinu – jeśli wciąż wciśnięty - dopiero wtedy uznajemy, że klik był prawdziwy. Dzięki temu nie reagujemy na drgania styków, a logika siedzi w ładnym miejscu (callback), a nie w brzydkich pętlach z opóźnieniami.
- **Jednorazowe „opóźnione” zdarzenie w UI** - użytkownik coś klika, a my chcemy po 3 sekundach pokazać komunikat („Zapisano ustawienia”, „Restarting”, "Jajco"). Po kliknięciu przycisku: start timer one-shot na 3000 ms. W callbacku wyświetlamy komunikat na ekranie, mrugamy diodą, przełączamy stan urządzenia itp. Doskonałe, jeśli nie chcemy np. blokować interfejsu `vTaskDelay()`.

### 2. Auto-reload Timer
- **Okresowe odświeżanie ekranu / UI** - np. mamy mały wyświetlacz (np. TFT, OLED), który ma się odświeżać np. co 200 ms. Ustawiamy timer auto-reload co 200 ms. W callbacku ustawiamy flagę „odśwież UI” albo od razu odświeżamy licznik, godzinę, poziom sygnału, etc. Dzięki temu UI jest „na zegarku”, a logika w taskach może spokojnie robić swoje.
- **Regularne zapisywanie danych do pamięci (logi, statystyki)** - co 10 sekund zapisujemy do flasha lub na kartę SD np. temperaturę, licznik błędów, stan urządzenia. Timer auto-reload z okresem 10 000 ms. Callback wrzuca dane do kolejki dla „taska od zapisu” albo sam robi prosty zapis. 

## Stany egzystencji timerów.

Timer programowy w FreeRTOS może znajdować się w jednym z dwóch stanów:
**1. Dormant (uśpiony / nieaktywny)**
Timer w stanie Dormant:
- istnieje w systemie - został utworzony i ma ważny uchwyt (`TimerHandle_t`), 
- ale nie jest uruchomiony - system nie odlicza jego okresu,
- jego funkcja callback nie będzie wywoływana, dopóki timer nie zostanie wystartowany.
Przykładowo: świeżo po utworzeniu timer jest właśnie w stanie Dormant – dopiero wywołanie `xTimerStart()` lub `xTimerReset()` (w zależności od konfiguracji) przełącza go w stan Running.


**2. Running (aktywny / działający)**
Timer w stanie Running:
- jest aktywnie odliczany przez FreeRTOS (na podstawie ticków systemowych),
- po upływie czasu równego jego okresowi:
  - od momentu wejścia w stan Running
  - lub od ostatniego resetu (`xTimerReset()`),
  wywołana zostanie jego funkcja **callback**.
- W zależności od typu timera:
  - dla timera one-shot – po wywołaniu callbacka timer zwykle wraca do stanu Dormant,
  - dla timera auto-reload – po wywołaniu callbacka jego licznik jest automatycznie zerowany i timer pozostaje w stanie Running odliczając kolejny okres.

Przejście między stanami (Dormant <-> Running) odbywa się poprzez wywołania API (`xTimerStart()`, `xTimerStop()`, `xTimerReset()`),
dopóki timer jest w stanie Running, możemy go w każdej chwili zatrzymać, zmienić jego okres albo zresetować odliczanie.


## Podsumowując zatem
Software Timery są dla nas takim wbudowanym budzikiem FreeRTOS-a: zamiast upychać vTaskDelay() po taskach i ręcznie liczyć czas, tworzymy obiekt timera, podajemy mu:
- okres (jak długo ma czekać),
- tryb (jeden strzał czy powtarzanie),
- callback (co ma się stać, kiedy „zadzwoni”).
**Timer może być:**
- Dormant – istnieje, ale „leży w szufladzie”, niczego nie odlicza, callback się nie wykona,
- Running – aktywnie odlicza ticki i po upływie okresu wywoła callback (raz albo cyklicznie).
  
**Cała „magia zegarka” dzieje się w timer service tasku, więc:**
- nie potrzebujemy osobnych tasków, które tylko śpią i czekają na upłynięcie czasu,
- logika czasowa jest skupiona w jednym miejscu (callbacki timerów),
- łatwo jest zmieniać interwały (wystarczy zmienić parametr timera, a nie pół taska).

W dalszej części labu zobaczymy, jak taki timer stworzyć, wystartować, zatrzymać i zresetować, a potem wykorzystamy to do zbudowania konkretnych mechanizmów, których na tym etapie pisania laba jeszcze nie wymyśliłem.


# To teraz technicznie

Każdy timer wykonuje funkcję **callback**, której prototyp musi być zgodny z typem `TimerCallbackFunction_t`:

```c
typedef void (*TimerCallbackFunction_t)( TimerHandle_t xTimer );
```

Przykładowa definicja funkcji:

```c
void vTimerCallback( TimerHandle_t xTimer )
{
    // Kod wykonywany przy wygaśnięciu timera
}
```

* Funkcja **nie zwraca** żadnej wartości (`void`).
* Jako parametr dostaje **uchwyt timera**, który ją wywołał – w callbacku możemy dzięki temu:

  * sprawdzić jego okres (`xTimerGetPeriod()`),
  * odczytać/ustawić ID (`pvTimerGetTimerID()`, `vTimerSetTimerID()`),
  * rozróżnić kilka timerów używających tego samego callbacka.

---

## 1) `xTimerCreate()` — tworzenie timera (dynamiczne)

```c
TimerHandle_t xTimerCreate(
    const char * const        pcTimerName,
    TickType_t                xTimerPeriodInTicks,
    BaseType_t                xAutoReload,
    void * const              pvTimerID,
    TimerCallbackFunction_t   pxCallbackFunction
);
```

Tworzy nową instancję timera programowego i zwraca **uchwyt** (`TimerHandle_t`), przez który timer będzie później referencjonowany.
Samo utworzenie **nie uruchamia** timera.

**Argumenty:**

| Argument              | Znaczenie                                                                                                                                           |
| --------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| `pcTimerName`         | Opcjonalna, „ludzka” nazwa timera (dla debugowania, np. w trace’u).                                                                                 |
| `xTimerPeriodInTicks` | Okres timera w tickach (`TickType_t`). Typowo podajemy `pdMS_TO_TICKS(ms)`.                                                                         |
| `xAutoReload`         | `pdTRUE` - timer typu *auto-reload*; `pdFALSE` - *one-shot*                                                               |
| `pvTimerID`           | Każdy timer ma swoją wartość ID - jest to *void pointer* - może zatem być użyty do dowolnego celu. Np. jakiś storage.|
| `pxCallbackFunction`  | Funkcja callback wywoływana przy zakończeniu timera (`TimerCallbackFunction_t`).                                                                    |

**Zwraca:**

* **not-NULL** (`TimerHandle_t`) – timer utworzony poprawnie,
* **NULL** – błąd (np. brak pamięci).

Timer można wywołać również statycznie `xTimerCreateStatic()` - w tym wypadku musimy w dodatkowym argumencie wywołania dostarczyć bufor na strukturę timera.

---

## 2) `xTimerStart()` — uruchomienie timera

```c
BaseType_t xTimerStart(
    TimerHandle_t xTimer,
    TickType_t    xTicksToWait
);
```

Wysyła do **timer service tasku** polecenie „uruchom timer”.
Jeżeli timer był w stanie Dormant, przechodzi do stanu Running i zaczyna odliczać okres.

**Argumenty:**

| Argument       | Znaczenie                                                                                                                                                                                                          |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `xTimer`       | Uchwyt do timera, który ma zostać uruchomiony.                                                                                                                                                                     |
| `xTicksToWait` | Maksymalny czas (w tickach), przez jaki wywołujący **task** może blokować się, czekając na miejsce w kolejce komend timera. Nie ma nic wspólnego z czasem odliczanym przez sam timer. Często po prostu `0` |

**Zwraca:**

* `pdPASS` – komenda startu została poprawnie wysłana do kolejki (timer wystartuje),
* `pdFAIL` – nie udało się wysłać komendy (np. przepełniona kolejka timera).

### `xTimerStartFromISR()`

```c
BaseType_t xTimerStartFromISR(
    TimerHandle_t xTimer,
    BaseType_t   *pxHigherPriorityTaskWoken
);
```

Wersja do użycia w ISR.
Jeżeli wywołanie powoduje wybudzenie taska timera o wyższym priorytecie niż aktualnie wykonywany task, ustawia `*pxHigherPriorityTaskWoken = pdTRUE`.
Po wyjściu z ISR należy wtedy wymusić przełączenie kontekstu.

---

## 3) `xTimerStop()` — zatrzymanie timera

```c
BaseType_t xTimerStop(
    TimerHandle_t xTimer,
    TickType_t    xTicksToWait
);
```

Zatrzymuje timer (przechodzi do stanu Dormant, jeśli był Running).
Komenda jest wysyłana do timer service tasku przez kolejkę.

**Argumenty:**

| Argument       | Znaczenie                                                                    |
| -------------- | ---------------------------------------------------------------------------- |
| `xTimer`       | Uchwyt do timera, który ma zostać zatrzymany.                                |
| `xTicksToWait` | Czas oczekiwania na miejsce w kolejce komend timera (jak w `xTimerStart()`). |

**Zwraca:**

* `pdPASS` – komenda stop została poprawnie wysłana,
* `pdFAIL` – nie udało się (np. kolejka pełna).

### `xTimerStopFromISR()`

```c
BaseType_t xTimerStopFromISR(
    TimerHandle_t xTimer,
    BaseType_t   *pxHigherPriorityTaskWoken
);
```

Wersja do użycia w ISR, działa analogicznie do `xTimerStartFromISR()`.

---

## 4) `xTimerReset()` — restart / start timera

```c
BaseType_t xTimerReset(
    TimerHandle_t xTimer,
    TickType_t    xTicksToWait
);
```

**Restartuje** timer:

* jeśli timer jest już Running → jego czas wygaśnięcia liczony jest od nowa (od momentu resetu),
* jeśli timer był Dormant → reset pełni rolę startu (timer przechodzi do Running).

Argumenty i wartości zwracane jak w `xTimerStart()` (`xTimer`, `xTicksToWait`, `pdPASS` / `pdFAIL`).

### `xTimerResetFromISR()`

```c
BaseType_t xTimerResetFromISR(
    TimerHandle_t xTimer,
    BaseType_t   *pxHigherPriorityTaskWoken
);
```

Wersja resetu do wywołania w ISR.

---

## 5) `xTimerChangePeriod()` — zmiana okresu timera

```c
BaseType_t xTimerChangePeriod(
    TimerHandle_t xTimer,
    TickType_t    xNewPeriod,
    TickType_t    xTicksToWait
);
```

Zmienia okres istniejącego timera na nowy (`xNewPeriod`).
Jeśli timer jest Running, jego nowy czas wygaśnięcia będzie liczony **od momentu wywołania** tej funkcji, z użyciem nowego okresu.

**Argumenty:**

| Argument       | Znaczenie                                                  |
| -------------- | ---------------------------------------------------------- |
| `xTimer`       | Uchwyt do timera, którego okres chcemy zmienić.            |
| `xNewPeriod`   | Nowy okres timera w tickach (`TickType_t`).                |
| `xTicksToWait` | Jak długo można czekać na miejsce w kolejce komend timera. |

**Zwraca:**

* `pdPASS` – komenda zmiany okresu przyjęta,
* `pdFAIL` – nie udało się wstawić komendy do kolejki.

### `xTimerChangePeriodFromISR()`

```c
BaseType_t xTimerChangePeriodFromISR(
    TimerHandle_t xTimer,
    TickType_t    xNewPeriod,
    BaseType_t   *pxHigherPriorityTaskWoken
);
```

Wersja do użycia w ISR – analogicznie jak inne funkcje `*FromISR()`.

---

## 6) `xTimerDelete()` — usunięcie timera

```c
BaseType_t xTimerDelete(
    TimerHandle_t xTimer,
    TickType_t    xTicksToWait
);
```

Usuwa timer utworzony wcześniej przez `xTimerCreate()` / `xTimerCreateStatic()`.
Po usunięciu uchwyt staje się nieważny.

**Argumenty:**

| Argument       | Znaczenie                                            |
| -------------- | ---------------------------------------------------- |
| `xTimer`       | Uchwyt do timera, który ma zostać usunięty.          |
| `xTicksToWait` | Czas oczekiwania na miejsce w kolejce komend timera. |

**Zwraca:**

* `pdPASS` – komenda usunięcia została przyjęta,
* `pdFAIL` – nie udało się wysłać komendy.

---

## 7) `xTimerIsTimerActive()` — sprawdzenie stanu timera

```c
BaseType_t xTimerIsTimerActive(
    TimerHandle_t xTimer
);
```

Pozwala sprawdzić, czy timer jest aktualnie Running.
Przydatne, gdy chcemy warunkowo startować/stopować timery lub diagnozować ich zachowanie.

**Zwraca:**

* `pdFALSE` – timer NIE jest aktywny (np. w stanie Dormant lub wygasły one-shot, który nie został zrestartowany),
* `pdTRUE` – timer jest Running.

# Przykładowy kod

```c
#include <Arduino.h>
#include "freertos/FreeRTOS.h"
#include "freertos/timers.h"

const int LED_PIN    = 2;  // dopasuj do swojej płytki
const int BUTTON_PIN = 4;  // przycisk do GND, wejście z PULLUP

TimerHandle_t blinkTimer;

// Callback timera – co okres zmienia stan LED-a
void vBlinkCallback(TimerHandle_t xTimer)
{
  (void)xTimer; // nieużywany parametr
  digitalWrite(LED_PIN, !digitalRead(LED_PIN));
}

void setup()
{
  pinMode(LED_PIN, OUTPUT);
  pinMode(BUTTON_PIN, INPUT_PULLUP); // przycisk zwiera do masy

  // Tworzymy timer: 500 ms, auto-reload, prosty callback
  blinkTimer = xTimerCreate(
      "Blink",
      pdMS_TO_TICKS(500),
      pdTRUE,
      nullptr,
      vBlinkCallback
  );

  // Na start timer jest zatrzymany – LED nie miga
}

void loop()
{
  static int lastButton = HIGH;

  int current = digitalRead(BUTTON_PIN);

  // Wykrycie zbocza opadającego (puszczony -> wciśnięty)
  if (lastButton == HIGH && current == LOW)
  {
    // Jeśli timer nieaktywny -> start; jeśli aktywny -> stop
    if (xTimerIsTimerActive(blinkTimer) == pdFALSE)
    {
      xTimerStart(blinkTimer, 0);
    }
    else
    {
      xTimerStop(blinkTimer, 0);
      digitalWrite(LED_PIN, LOW); // zgaś LED po zatrzymaniu
    }
  }

  lastButton = current;
  delay(20); // proste odfiltrowanie drgań styków
}
```

# Zadania
Zadanka dzisiaj zaprojektowane są tak, żeby was skutecznie spacyfikować na dłużej - Pierwwsze dwa, podobnie jak tydzień temu dotyczą tylko bazowej implementacji wprowadzonego dziś materiału. Dwa kolejne, o rosnącym poziomie trudności będą wymagać trochę pracy i pokazują bardziej profesjonalne zastosowania timerów - pierwsze dwa zadania każdy zespół powinien rozliczyć na zajęciach. Zadania 3 i 4 można będzie oddać za tydzień. GPT porozbijał mi zadania na prostsze taski - jak coś będzie niejasne albo wygląda jak bełkot to proszę wołać, jest 3:15.

## Zadanie 1 — „Mrugająca dioda na budziku” (podstawy timera)

**Cel:**
Poznanie podstaw API software timerów: `xTimerCreate()`, `xTimerStart()`, `xTimerStop()`, callback, tryb auto-reload.

**Opis:**

1. Utwórz **jeden timer auto-reload** z okresem np. 250–1000 ms.
2. Timer w callbacku ma **przełączać stan jakiegoś wyjścia**:

   * może to być dioda LED,
   * albo po prostu wypis na UART („TICK”).
3. Na początku programu timer jest **zatrzymany**.
4. Jeden przycisk (albo komenda przez UART) ma:

   * jeśli timer jest zatrzymany → **uruchomić go**,
   * jeśli timer jest uruchomiony → **zatrzymać** i „posprzątać” (np. zgasić LED).

**Wymagania techniczne:**

* użyj `xTimerCreate()` (lub `xTimerCreateStatic()`),
* użyj `xTimerIsTimerActive()` do sprawdzenia stanu,
* logika w callbacku ma być krótka – żadnych `vTaskDelay()`.

**Możliwe rozszerzenie (dla chętnych):**

* po zatrzymaniu timera zmień okres (np. z 250 ms na 1000 ms) i wystartuj go ponownie; użyj `xTimerChangePeriod()`.

---

## Zadanie 2 — „Przycisk, który przestaje drżeć” (one-shot + debounce)

**Cel:**
Pokazanie praktycznego zastosowania timera **one-shot** do eliminacji drgań styków (debounce) i komunikacji z taskiem.

**Opis:**

1. Konfigurujesz **przerwanie od przycisku** (lub w prostszej wersji — polling w tasku, ale ISR jest mile widziany).

2. Tworzysz **timer one-shot** o okresie ok. 30–50 ms.

3. Każde wciśnięcie / zmiana stanu przycisku:

   * w ISR wywołuje `xTimerStartFromISR()` lub `xTimerResetFromISR()` na tym timerze,
   * timer startuje / restartuje od nowa.

4. Jeżeli po tych 30–50 ms nikt nie „ruszył” timera, jego callback:

   * **czyta aktualny stan przycisku**,
   * jeśli wciąż jest wciśnięty → uznajemy to za „prawdziwe” wciśnięcie.

5. Informacja o **ustabilizowanym wciśnięciu** trafia do głównego taska:

   * np. przez **kolejkę**,
   * albo przez **task notification**.

Task po otrzymaniu zdarzenia może np.:

* przełączyć LED,
* policzyć liczbę kliknięć,
* wypisać coś na UART.

**Wymagania techniczne:**

* timer musi być typu **one-shot** (`xAutoReload = pdFALSE`),
* użyj wersji `*FromISR()` przy wywołaniach z przerwania,
* większość „grubszej” logiki (zmiana LED, obsługa UI) powinna odbywać się w **tasku**, a nie w callbacku timera.

**Rozszerzenia (opcjonalnie):**

* rozróżnij **krótkie** i **długie** przyciśnięcie:

  * krótkie kliknięcie → pojedyncze naciśnięcie (one-shot timer),
  * długie przytrzymanie → drugi timer, który zlicza np. 1 s.

---

## Zadanie 3 — „Timeout na komunikację” (one-shot + taski)

**Cel:**
Zastosowanie timera jako **mechanizmu timeoutu** między taskami – integracja timera, kolejek / notification i prostego „protokołu”.

**Opis:**

Zbuduj prosty scenariusz z dwoma taskami:

* **Task A** – „zleceniodawca”,
* **Task B** – „pracownik”, który wykonuje zadanie z pewnym opóźnieniem.

Przebieg:

1. Task A wysyła do Task B „zlecenie” (np. przez kolejkę).
2. **W momencie wysyłania zlecenia** Task A:

   * uruchamia **timer one-shot** o okresie np. 2000 ms (`xTimerStart()` lub `xTimerReset()`),
   * zapisuje gdzieś informację, że „czekamy na odpowiedź”.
3. Task B po jakimś czasie (np. po `vTaskDelay(500)` lub dłużej) odpowiada do Task A (kolejką / notification).
4. Po otrzymaniu odpowiedzi Task A:

   * **zatrzymuje timer** (`xTimerStop()`),
   * melduje „OK, odpowiedź przyszła na czas”.
5. Jeżeli odpowiedź **nie przyjdzie** w ciągu 2 s:

   * timer wywołuje callback,
   * callback informuje Task A o timeout (np. notification lub wrzucenie specjalnej wartości do kolejki),
   * Task A przechodzi w stan „błąd” (zapala czerwoną diodę, wypisuje komunikat, resetuje B, itd.).

**Wymagania techniczne:**

* jeden timer one-shot, współpracujący z **Task A**,
* przynajmniej jedna kolejka lub task notifications między A i B,
* rozróżnienie dwóch przypadków:

  * odpowiedź na czas (timer zatrzymany),
  * timeout (timer wywołał callback).

**Rozszerzenia (opcjonalnie):**

* Task A może co jakiś czas ponawiać próbę (kolejna komenda + restart timera);
* sygnalizuj różne stany systemu diodami / buzzerem.

---

## Zadanie 4 — „Softowy scheduler / watchdog mini-system” (wiele timerów, stan, FromISR)

**Cel:**
Zbudowanie małego, wieloelementowego „systemu czasowego” opartego na kilku timerach:
watchdog, okresowe zadanie, zmiana okresu, reakcja na „zawieszony” task.

**Opis (propozycja scenariusza):**

Masz system z jednym „głównym taskiem” obsługującym np. logikę urządzenia.
Chcemy:

1. Co 500 ms wykonywać prostą akcję okresową (np. status LED, log na UART) → **timer auto-reload A**.
2. Pilnować, że główny task „żyje” i melduje się regularnie → **timer one-shot B** pełniący rolę watchdog’a.
3. Zmieniać okres jednego z timerów w locie w reakcji na zdarzenia (np. po naciśnięciu przycisku / otrzymaniu komendy) → `xTimerChangePeriod()`.

Szczegóły:

* **Timer A (auto-reload)**

  * okres np. 500 ms,
  * callback: przełącza LED statusu albo wysyła powiadomienie do taska, że „minęło 500 ms”.

* **Timer B (one-shot, watchdog)**

  * okres np. 2000 ms,
  * główny task w każdej iteracji pętli / po wykonaniu ważnego kroku wywołuje `xTimerReset()` na tym timerze („karmi psa”),
  * jeśli główny task się zawiesi lub „zapomni nakarmić”:

    * Timer B dojdzie do końca → callback,
    * w callbacku ustawiasz flagę „system w stanie awaryjnym”, włączasz czerwoną diodę, może wysyłasz komunikat, ew. restartujesz MCU.

* **Wejście zewnętrzne (przycisk / ISR / UART)**

  * np. przycisk zmienia tryb pracy:

    * w trybie normalnym Timer A ma okres 500 ms,
    * w trybie „oszczędzania energii” → zwiększasz okres do 2000 ms (`xTimerChangePeriod()`),
  * jeśli używasz ISR, skorzystaj z `xTimerChangePeriodFromISR()` / `xTimerStartFromISR()`.

**Wymagania techniczne:**

* min. **dwa różne timery** (one-shot + auto-reload),
* **zmiana okresu timera w locie** (`xTimerChangePeriod()` lub `xTimerChangePeriodFromISR()`),
* zastosowanie timera jako **watchdog’a**: brak resetu → callback sygnalizuje awarię,
* czysta separacja odpowiedzialności:

  * timery zajmują się „kiedy”,
  * taski zajmują się „co”.

**Rozszerzenia (opcjonalnie):**

* rozbij logikę na kilka tasków (np. UI, logika, komunikacja) i daj każdemu własny watchdog (kilka timerów);
* dodaj stanową maszynę (np. „INIT → RUN → ERROR”) i część przejść wyzwalaj przez timery.