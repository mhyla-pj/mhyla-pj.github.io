---
layout: lab
course: RBD
type: stacjonarne
lab_nr: 11
subject: MongoDB - wstęp
description: Podstawowe instrukcje i obsługa MongoDB
---

# Wstawianie dokumentów

## `insertOne()`

```javascript
db.students.insertOne({
    name: "Anna Kowalska",
    age: 21,
    faculty: "Informatyka"
})
```

---

## `insertMany()`

```javascript
db.students.insertMany([
{
    name: "Jan Nowak",
    age: 22,
    faculty: "Cyberbezpieczeństwo"
},
{
    name: "Maria Wiśniewska",
    age: 20,
    faculty: "Informatyka"
}
])
```

---

# Wyświetlanie danych

## Wszystkie dokumenty

```javascript
db.students.find()
```

---

## Ładne formatowanie

```javascript
db.students.find().pretty()
```

---

## Jeden dokument

```javascript
db.students.findOne()
```

---

# Filtrowanie danych

## Równość

```javascript
db.students.find({
    faculty: "Informatyka"
})
```

---

## Większe niż (`$gt`)

```javascript
db.students.find({
    age: { $gt: 21 }
})
```

---

## Mniejsze niż (`$lt`)

```javascript
db.students.find({
    age: { $lt: 22 }
})
```

---

## Większe lub równe (`$gte`)

```javascript
db.students.find({
    age: { $gte: 21 }
})
```

---

## Mniejsze lub równe (`$lte`)

```javascript
db.students.find({
    age: { $lte: 22 }
})
```

---

## Różne od (`$ne`)

```javascript
db.students.find({
    faculty: { $ne: "Grafika" }
})
```

---

# Operatory logiczne

## `$and`

```javascript
db.students.find({
    $and: [
        { faculty: "Informatyka" },
        { age: { $gt: 20 } }
    ]
})
```

---

## `$or`

```javascript
db.students.find({
    $or: [
        { faculty: "Informatyka" },
        { faculty: "Cyberbezpieczeństwo" }
    ]
})
```

---

# Wyszukiwanie w tablicach

## Dane

```javascript
db.students.insertOne({
    name: "Piotr Zieliński",
    courses: ["MongoDB", "Linux", "Python"]
})
```

---

## Wyszukanie elementu w tablicy

```javascript
db.students.find({
    courses: "MongoDB"
})
```

---

# Projekcja pól

## Tylko wybrane pola

```javascript
db.students.find(
    {},
    {
        _id: 0,
        name: 1,
        faculty: 1
    }
)
```

---

# Sortowanie

## Rosnąco

```javascript
db.students.find().sort({
    age: 1
})
```

---

## Malejąco

```javascript
db.students.find().sort({
    age: -1
})
```

---

# Limit wyników

```javascript
db.students.find().limit(2)
```

---

# Pomijanie wyników (`skip`)

```javascript
db.students.find().skip(2)
```

---

# Aktualizacja danych

## `updateOne()`

```javascript
db.students.updateOne(
{
    name: "Anna Kowalska"
},
{
    $set: {
        age: 22
    }
}
)
```

---

## `updateMany()`

```javascript
db.students.updateMany(
{},
{
    $set: {
        active: true
    }
}
)
```

---

# Usuwanie pól

```javascript
db.students.updateOne(
{
    name: "Anna Kowalska"
},
{
    $unset: {
        active: ""
    }
}
)
```

---

# Dodawanie elementu do tablicy

```javascript
db.students.updateOne(
{
    name: "Piotr Zieliński"
},
{
    $push: {
        courses: "Docker"
    }
}
)
```

---

# Usuwanie elementu z tablicy

```javascript
db.students.updateOne(
{
    name: "Piotr Zieliński"
},
{
    $pull: {
        courses: "Linux"
    }
}
)
```

---

# Usuwanie dokumentów

## `deleteOne()`

```javascript
db.students.deleteOne({
    name: "Jan Nowak"
})
```

---

## `deleteMany()`

```javascript
db.students.deleteMany({
    faculty: "Grafika"
})
```
