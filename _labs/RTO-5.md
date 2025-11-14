---
layout: lab
course: RTO
type: stacjonarne
lab_nr: 5
subject: Projekty!
description: Chciałem to zrobić za tydzień, ale nagle zmieniłem zdanie
---

## 1. Wprowadzenie
To są nasze pierwsze zajęcia projektowe. Przypomnę, że ten projekt wart jest 20% oceny. Deadline realizacji: **21.11**. Na ocenę wpływają: 

- Kompletność projektu
- prawidłowość logiki działania
- zgodność z założeniami

## 2. Wymagania ogólne
- Każdy projekcik powinien zawierać minimum 4 taski.
- Wykorzystanie co najmniej 3 mechanizmów FreeRTOS: kolejki, semafory, mutexy, task notifications, ISR.
- Jeden lub więcej czujników / wejść.
- Dokumentacja architektury systemu.

Co do zasady pozostawiam wam wolną rękę co do tematyki projektu oraz wykorzystanych narzędzi. Przed podjęciem prac implementacyjnych proszę o wypełnienie dokumentu założeń projektowych - [dostępny tutaj](/assets/RTO/szablon_zalozen_projektu_rtos.docx) i skonsultowanie z prowadzącym. 

Poniżej znajdują się przykładowe projekty, można zrealizować jeden z nich, lub wymyślić coś zupełnie innego. 

## 3. Przykładowe projekty ze szczegółowymi rolami tasków

### 3.1 Projekt: Inteligentny system domowy
#### TaskSensorTemp
- Odczyt temperatury co 1 sekundę.
- Wysyłanie danych do kolejki `xQueueSensors`.
- Wynik wysyłany jako struct z timestampem, wynikiem pomiaru i ID sensora

#### TaskSensorLight
- Pomiar światła co 500 ms.
- Przesyłanie wyników do `xQueueSensors`.
- Wynik wysyłany jako struct z timestampem, wynikiem pomiaru i ID sensora

#### TaskLogic
- Odbieranie pomiarów z kolejki.
- Przetwarzanie danych i podejmowanie decyzji dot. sygnalizacji stanów
- Wysyłanie komend do `xQueueActuator`.

#### TaskActuator
- Sterowanie diodami/buzzerem.
- Priorytet wysoki.

#### TaskLogger
- Logowanie działania systemu.
- Wykorzystanie mutexu na UART.

---

### 3.2 Projekt: Mini-stacja pogodowa
#### TaskSensorTemp/Humidity/Pressure
- Odczyty z różnych czujników co różne interwały
- Interwały regulowane potencjometrem (lewo = rzadko, prawo = często)
- Wysyłanie pomiarów do kolejki.

#### TaskAggregator
- Uśrednianie wyników.
- Przechowywanie statystyk.

#### TaskScheduler
- Wyzwalanie raportów co 60 sekund.
- Powiadamianie loggera przez task notification.

#### TaskLogger
- Generowanie raportów i drukowanie przez UART.

---

## 4. Dobre praktyki w projektach RTOS
- Zadania należy projektować z jasnym podziałem realizowanych zadań.
- Priorytety powinny wynikać z krytyczności zadania.
- Unikać opóźnień blokujących w ISR.
- Komunikacja przez kolejki do danych, semafory/notify do sygnałów.

