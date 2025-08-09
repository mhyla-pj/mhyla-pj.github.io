---
layout: exercise
course: Python
type: stacjonarne
lab_nr: 9
topic: Rozwijamy nasze API o wyszukiwarkę
---
1. Zadanie polega na dodaniu funkcjonalności wyszukiwania zwierząt po imieniu w naszej bazie.
- Zostaw strukturę i pamięć w liście. Dodaj dokładnie dwie proste funkcje:
- PUT /animals/{id} – zmienia tylko name (osobny model AnimalNameUpdate z jednym polem).
- GET /animals/search?name= – zwraca zwierzaki, których name zawiera podany fragment (case-insensitive).

Reszta pozostaje bez zmian: GET /animals, GET /animals/{id}, POST /animals, DELETE /animals/{id} działają jak na zajęciach.

2. Dodaj do aplikacji funkcjonalność walidacji: jeśli podane w wyszukiwaniu, dodawaniu lub modyfikacji imię zwierzątka jest krótsze niż 2 znaki aplikacja powinna zwrócić informację o nieprawidłowym formacie i **nie dodawać** tego imienia do bazy.