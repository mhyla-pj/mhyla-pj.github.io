---
nav_exclude: true
layout: lab
---
# Diagramy i kod w Pythonie

## 1. Instrukcja `if`

### Diagram
```mermaid
flowchart TD
    A([Start]) --> B["Wczytaj liczbę x"]
    B --> C{Czy x > 0?}
    C -- Tak --> D["Wypisz 'Dodatnia'"]
    C -- Nie --> E(["Koniec"])
    D --> E
```

### Kod w Pythonie
```python
x = int(input("Podaj liczbę: "))
if x > 0:
    print("Dodatnia")
```

---

## 2. Zagnieżdżony `if`

### Diagram
```mermaid
flowchart TD
    A([Start]) --> B["Wczytaj liczbę x"]
    B --> C{Czy x > 0?}
    C -- Tak --> D{Czy x < 10?}
    D -- Tak --> E["Wypisz 'Dodatnia i < 10'"]
    D -- Nie --> F["Wypisz 'Dodatnia i >= 10'"]
    C -- Nie --> G["Wypisz 'Niedodatnia'"]
    E --> H([Koniec])
    F --> H
    G --> H
```

### Kod w Pythonie
```python
x = int(input("Podaj liczbę: "))
if x > 0:
    if x < 10:
        print("Dodatnia i < 10")
    else:
        print("Dodatnia i >= 10")
else:
    print("Niedodatnia")
```

---

## 3. `if`, `elif`, `else`

### Diagram
```mermaid
flowchart TD
    A([Start]) --> B["Wczytaj liczbę x"]
    B --> C{Czy x < 0?}
    C -- Tak --> D["Wypisz 'Ujemna'"]
    C -- Nie --> E{Czy x == 0?}
    E -- Tak --> F["Wypisz 'Zero'"]
    E -- Nie --> G["Wypisz 'Dodatnia'"]
    D --> H([Koniec])
    F --> H
    G --> H
```

### Kod w Pythonie
```python
x = int(input("Podaj liczbę: "))
if x < 0:
    print("Ujemna")
elif x == 0:
    print("Zero")
else:
    print("Dodatnia")
```

---

## 4. Pętla `while`

### Diagram
```mermaid
flowchart TD
    A([Start]) --> B["i = 1"]
    B --> C{i <= 5?}
    C -- Tak --> D["Wypisz i"]
    D --> E["i = i + 1"]
    E --> C
    C -- Nie --> F([Koniec])
```

### Kod w Pythonie
```python
i = 1
while i <= 5:
    print(i)
    i += 1
```

---

## 5. Zagnieżdżona pętla

### Diagram
```mermaid
flowchart TD
    A([Start]) --> B["i = 1"]
    B --> C{i <= 3?}
    C -- Tak --> D["j = 1"]
    D --> E{j <= 3?}
    E -- Tak --> F["Wypisz i * j"]
    F --> G["j = j + 1"]
    G --> E
    E -- Nie --> H["i = i + 1"]
    H --> C
    C -- Nie --> I([Koniec])
```

### Kod w Pythonie
```python
for i in range(1, 4):
    for j in range(1, 4):
        print(i, "*", j, "=", i * j)
```
