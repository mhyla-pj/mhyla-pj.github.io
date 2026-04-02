---
layout: exercise
nav-exclude: true
---
1. Producent i konsument: Zaimplementuj program z wykorzystaniem wątków, który symuluje współpracę producenta i konsumenta. Producent będzie generował dane, a konsument będzie je pobierał i przetwarzał. Wątki powinny być odpowiednio zsynchronizowane za pomocą semaforów lub mutexów, aby zapewnić bezpieczne dzielenie bufora między producentem a konsumentem.
   
2. Napisz program w języku C, który implementuje równoległe sortowanie tablicy liczb całkowitych przy użyciu wielu wątków. Program powinien podzielić tablicę na podtablice, posortować każdą z nich przy użyciu oddzielnego wątku, a następnie połączyć posortowane podtablice w jedną posortowaną tablicę - liczby do testów należy sobie wygenerować samodzielnie, testować będę na zbiorze 85.000 liczb w zakresie 1-1000000.