---
nav_exclude: true
layout: lab
---
# Ściąga: Logika boolowska i instrukcje `if` w Pythonie

## Wartości logiczne (bool)
W Pythonie mamy dwa możliwe stany logiczne:  
- `True` – prawda  
- `False` – fałsz  

Do sprawdzania warunków w instrukcjach `if` wykorzystujemy wyrażenia, które zwracają wartości boolowskie.

---

## Operatory porównania

| Operator | Przykład      | Wynik      |
|----------|---------------|------------|
| `==`     | `3 == 3`      | `True`     |
| `!=`     | `3 != 2`      | `True`     |
| `>`      | `5 > 2`       | `True`     |
| `<`      | `2 < 1`       | `False`    |
| `>=`     | `3 >= 3`      | `True`     |
| `<=`     | `4 <= 2`      | `False`    |


---

## Operatory logiczne

| Operator | Znaczenie                | Przykład                   | Wynik     |
|----------|--------------------------|----------------------------|-----------|
| `and`    | oba warunki prawdziwe    | `True and False`           | `False`   |
| `or`     | co najmniej jeden prawdziwy | `True or False`        | `True`    |
| `not`    | negacja                  | `not True`                 | `False`   |


---

## Instrukcja `if`
Instrukcja `if` wykonuje blok kodu tylko wtedy, gdy warunek jest `True`.

```python
x = 5

if x > 3:
    print("x jest większe niż 3")
```
W powyższym przykładzie, ponieważ `x > 3` jest `True`, zostanie wyświetlony komunikat.

---

## `if`, `elif` i `else`
Możemy sprawdzić wiele warunków:

```python
x = 10

if x > 10:
    print("Większe niż 10")
elif x == 10:
    print("Równe 10")
else:
    print("Mniejsze niż 10")
```
Wynik: `Równe 10`

---

## Złożone warunki
Łączymy warunki operatorami `and` / `or`:

```python
wiek = 20
student = True

if wiek < 26 and student:
    print("Masz zniżkę studencką!")
```

---

## Debugowanie warunków
Często warto sprawdzić, co zwracają wyrażenia logiczne:
```python
x = 5
print(x > 3, x < 10)  # True True
```
