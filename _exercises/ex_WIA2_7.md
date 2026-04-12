---
layout: exercise
course: WIA2
type:  stacjonarne
lab_nr: 07
topic: Praktyka
---
Dzisiejsze zadanka proponuję realizować samodzielnie przez ok. 45 minut, potem omówimy je razem, publicznie
1. Napisz programik, który wydrukuje jedną pod drugą 12 literek H.
2. Napisz program, który wczyta ciąg znaków za pomocą przerwania 21h i wypisze go na
ekranie, także za pomocą przerwania 21h.
3. Zmodyfikuj poprzedni program tak, aby wypisywał tekst od 10 znaku.
4. Korzystając z pamięci karty graficznej wyświetl w prawym dolnym rogu ostatnią cyfrę z twojego numeru indeksu. Jest 80 znaków w wierszu, oraz jest 25 wierszy.
5. Korzystając z pamięci karty graficznej wyświetl
   - na samym środku ekranu czerwone serduszko na białym tle
   - u góry ekranu, na środku, czerwony trefl na czarnym tle
   - na dole ekranu, na środku, czarny pik na białym tle. 

Do zadań 4 i 5 wykorzystać należy przerwania: [Int 10/AH=02h](http://www.ctyme.com/intr/rb-0087.htm) oraz [Int 10/AH=09h](http://www.ctyme.com/intr/rb-0099.htm)