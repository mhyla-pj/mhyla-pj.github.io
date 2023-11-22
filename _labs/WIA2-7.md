---
layout: lab
course: WIA2
type: [ stacjonarne ]
lab_nr: 7
subject: Pętle i ćwiczenia
description: na szyi
---

Temat zajęć jest absurdalnie prosty, do omówienia w 15 sekund, dlatego dzisiejsze zajęcia raczej poświęcimy na ćwiczenia w innych obszarach

## Pętle

Pętle w asm realizujemy przy użyciu instrukcji ```loop```. Zmniejsza ona rejestr CX o 1 i jeśli
jest on >0, to wykonuje skok do podanego w instrukcji ```loop``` adresu (etykiety w tym wypadku).

```asm
mov cx, 10
petla_1:
    ; jakies zaawansowane obliczenia
loop petla_1
```

