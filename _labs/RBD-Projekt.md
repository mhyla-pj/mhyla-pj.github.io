---
layout: lab
subject: Założenia projektu RBD
nav_exclude: true
---

## 1. Cel projektu

Celem projektu jest zaprojektowanie i przygotowanie relacyjnej bazy danych dla wybranego problemu biznesowego, organizacyjnego lub użytkowego. Projekt powinien pokazywać, że student potrafi:

- przeanalizować prosty problem i zamodelować go w postaci bazy danych,
- zaprojektować tabele, klucze główne i obce,
- określić relacje między encjami,
- przygotować diagram ERD,
- utworzyć przykładowe dane,
- napisać zapytania SQL korzystające z przygotowanej struktury,
- udokumentować działanie bazy danych.

Projekt może dotyczyć dowolnej sensownej dziedziny, np. biblioteki, wypożyczalni, sklepu internetowego, systemu rezerwacji, restauracji, siłowni, uczelni, przychodni, wydarzenia, gry, aplikacji społecznościowej itp.

---

## 2. Minimalne wymagania funkcjonalne

Projekt musi zawierać co najmniej:

1. **Minimum 7 tabel**  
   Tabele powinny wynikać z opisywanego problemu. Nie należy tworzyć sztucznych tabel wyłącznie po to, aby spełnić wymaganie liczby tabel.

2. **Relacje między tabelami**  
   W projekcie muszą występować relacje typu:
   - jeden do wielu,
   - wiele do wielu, zrealizowane przez tabelę pośredniczącą.

3. **Klucze główne i obce**
   Każda tabela powinna mieć klucz główny. Relacje między tabelami powinny być zrealizowane za pomocą kluczy obcych.

4. **Odpowiednie typy danych**
   Dla każdej kolumny należy dobrać odpowiedni typ danych, np. liczbowy, tekstowy, data, wartość logiczna itp.

5. **Ograniczenia integralności**
   W projekcie powinny pojawić się przykładowe ograniczenia, takie jak:
   - `NOT NULL`,
   - `UNIQUE`,
   - `CHECK`,
   - `DEFAULT`,
   - klucze obce z odpowiednimi regułami usuwania lub aktualizacji, jeżeli są potrzebne.

6. **Dane testowe**
   Baza powinna zawierać przykładowe dane umożliwiające przetestowanie zapytań. Dane nie muszą być bardzo rozbudowane, ale powinny być realistyczne i spójne.

7. **Przykładowe zapytania SQL**
   Projekt musi zawierać zestaw zapytań pokazujących, że baza działa i umożliwia uzyskanie sensownych informacji.

8. **Dokumentację**
   Projekt musi być opisany w sposób pozwalający zrozumieć:
   - czego dotyczy baza danych,
   - jakie tabele zawiera,
   - jakie relacje występują między tabelami,
   - do czego służą przykładowe zapytania.
