---
layout: exercise
course: WIA2
type:  stacjonarne
lab_nr: 07
topic: Praktyka
---
Dzisiejsze zadanka proponuję realizować samodzielnie przez ok. 45 minut, potem omówimy je razem, publicznie
1. Napisz programik, który wydrukuje jedną pod drugą 12 literek H.
1. Napisz program, który wczyta ciąg znaków za pomocą przerwania 21h i wypisze go na
ekranie, także za pomocą przerwania 21h.
2. Zmodyfikuj poprzedni program tak, aby wypisywał tekst od 10 znaku.
3. Korzystając z pamięci karty graficznej wyświetl w prawym dolnym rogu ostatnią cyfrę z
Twojego numeru indeksu. Segment pamięci karty graficznej to 0b800h. Każdy znak
zajmuje 2 bajty (znak + atrybuty). Jest 80 znaków w wierszu, oraz jest 25 wierszy.
4. Korzystając z pamięci karty graficznej wyświetl
   - na samym środku ekranu czerwone serduszko na białym tle
   - u góry ekranu, na środku, czerwony trefl na czarnym tle
   - na dole ekranu, na środku, czarny pik na białym tle. Adres segmentu pamięci
domyślnego trybu tekstowego to 0B800h. Atrybuty znaku. Ekran ma szerokość 80
znaków, a wysokość 25 znaków. Kolejne bajty są zapisywane od góry, lewej strony,
wierszami.