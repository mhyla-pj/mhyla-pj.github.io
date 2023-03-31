---
layout: lab
course: SOP
type: stacjonarne
lab_nr: 5
subject: Ostatnie zajęcia z bashem
description: Tak, ja też się cieszę
---
Dzisiaj na zajęciach skupimy się na jednym, dużym skrypcie, który stworzymy razem. Dziś użycie Google i Stack Overflow będzie kluczowe. Celem tych zajęć jest skrypt, który wygeneruje wykres kursu dolara amerykańskiego na przestrzeni lat. 

Skorzystać można z następujących programów:
1. gnuplot - narzędzie do tworzenia wykresów
2. curl - do pobierania danych i plików - tu będzie nas interesowało pobieranie JSON-ów
3. jq - program do obsługi plików .json - pozwoli na obsługę jsona bez konieczności walki z ```sed``` albo ```awk```

Dane pobierać będziemy z (API NBP)[http://api.nbp.pl]. 