---
layout: exercise
course: Python
type: stacjonarne
lab_nr: 1
topic: Proste, przyjemne zadania
---
### Zadanie domowe 1: Sklep i koszyk zakupowy
Napisz program, który:  
1. Ma zdefiniowaną **listę** dostępnych produktów w sklepie, np.:  
   ```python
   produkty = ["mleko", "chleb", "masło", "ser", "jabłka"]
   ```  
2. Poprosi użytkownika o dodanie **3 produktów** do koszyka (wczytaj z `input()` i dodaj do listy `koszyk`).  
3. Sprawdzi, czy każdy wybrany produkt znajduje się w ofercie sklepu. Jeśli nie, wypisze komunikat: *„Produkt X jest niedostępny”*.  
4. Na koniec wypisze wszystkie produkty w koszyku, uporządkowane alfabetycznie.

---

### Zadanie domowe 2: Analiza komentarzy
Napisz program, który analizuje komentarze z ankiety:  
1. Wczytaj od użytkownika **3 komentarze tekstowe** (np. opinie o zajęciach) i umieść je w **liście**.  
2. Rozbij każdy komentarz na słowa i utwórz **set** zawierający wszystkie **unikalne słowa** ze wszystkich komentarzy.  
3. Wypisz liczbę unikalnych słów oraz te, które mają więcej niż 5 liter.  
4. Jeśli wśród komentarzy pojawi się słowo „Python”, wypisz komunikat: *„Uczestnicy lubią Pythona!”*.

---

### Zadanie domowe 3: Statystyka ocen pracowników
Firma przeprowadziła test dla nowych pracowników. Wyniki zapisano w **tupli**:  
```python
wyniki = (45, 67, 82, 90, 55, 74, 100, 61)
```  
Napisz program, który:  
1. Policz i wypisz średnią ocen.  
2. Wypisz wszystkie wyniki powyżej średniej.  
3. Wypisz ile osób zdało test (wynik >= 60).  
4. Jeśli ktoś zdobył 100 punktów, wypisz komunikat: *„Gratulacje dla najlepszego uczestnika!”*.
