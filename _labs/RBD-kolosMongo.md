---
layout: lab
subject: Kolokwium MongoDB
nav_exclude: true
---

Kolokwium składa się z 2 kolekcji, do każdej po 4 zapytania do wykonania. Rozwiązania (tylko zapytania, w nowych liniach), proszę przesłać w pliku tekstowym na adres mhyla@pjwstk.edu.pl, w temacie **KolkwiumRBD_MongoDB**

Wszystkie zadania można wykonać korzystając z [W3Schools](https://www.w3schools.com/mongodb/index.php) oraz [Dokumentacji MongoDB](https://www.mongodb.com/docs/manual/). Każda z kolekcji zawiera 3 proste zadanie oraz jedno, które może wymagać trochę researchu w internecie, ale taki jest też cel tego kolokwium.

## Kolekcja 1 - posts
W kolekcji znajdują się informacje dotyczące postów na forum. Układ w kolekcji:

```json
{
    "user_id":91,
    "username":"ballsebrook1",
    "post_id":2,
    "title":"Honorable",
    "content":"Phasellus in felis. Donec semper sapien a libero. Nam dui.\n\nProin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.\n\nInteger ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.",
    "timestamp":{"$date":{"$numberLong":168312467000}}
}
```
### Zadania:
1. Napisz zapytanie, które będzie dodawało nowy post użytkownika o id 10, "username": "Smelly_Socks", "post_id": 1337. Tytuł i content do wymyślenia samodzielnie
2. Napisz zapytanie, które policzy, ile postów napisał użytkownik o id 10
3. Napisz zapytanie, które znajdzie 5 najdłuższych postów. Aby znaleźć długość posta należy przy agregacji dodać pole ($set), które będzie zawierać policzoną długość pola "content" - [$strLenCP](https://www.mongodb.com/docs/manual/reference/operator/aggregation/strLenCP/)
4. Napisz zapytanie, które dla użytkownika od id 100 ustawi na "deleted_user".


## Kolekcja 2 - cars
W tej kolekcji znajdują się informacje dot. samochodów. Układ: 

```json
{
    "car_id": 1,
    "make": "Toyota",
    "model": "Camry",
    "year": 2021,
    "price": 24000,
    "features": ["Bluetooth", "Backup Camera", "Cruise Control"],
    "specs": {
      "engine": "2.5L I4",
      "horsepower": 203,
      "transmission": "8-Speed Automatic"
    }
  }
```

1. Napisz zapytanie, które wyświetli markę, model i cenę najtańszego samochodu wyposażonego w "Apple CarPlay"
2. Znajdź wszystkie samochody, których cena wynosi od 30,000 do 50,000.
3. Policz liczbę samochodów dla każdej marki (make).
4. Znajdź wszystkie samochody, których moc silnika wynosi co najmniej 300 koni mechanicznych.