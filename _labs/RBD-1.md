---
layout: lab
course: RBD
type: stacjonarne
lab_nr: 1
subject: Podstawy baz danych
description: Bazowe pojęcia dotyczące baz danych
---
Przedmiot ten w całości poświęcony będzie bazom danych. Celowo nie wspominam o relacyjnych, bowiem w trakcie semestru poznamy kilka rodzajów baz danych. Niemniej, zacząć należy od zrozumienia, czym się i do czego służą **Bazy Danych**. 

## Czym jest baza danych?
Jako bazę danych rozumiemy uporządkowaną kolekcję danych, wykorzystywanych do modelowania danych, ich kształtu i związków między nimi. Technicznie rzecz biorąc, każdą formę zbierania danych, chociażby przy użyciu kartki papieru i długopisu, możemy określić jako bazę danych. Niemniej, na tych zajęciach zajmować się będziemy jedynie informatyczną implementacją baz danych. Najprostszym jej przykładem będą pliki tekstowe i arkusze kalkulacyjne i to właśnie arkuszami kalkulacyjnymi posłużymy się jako wstępnym przykładem do zrozumienia, czym są i jak działają bazy danych. Poniższy przykład przechowuje informacje o studentach i ich ocenach

| Imię     | Nazwisko | Kolos 1 | Ocena |
|----------|----------|---------|-------|
| Paweł    | Lelental | 60%     | 3     |
| Jan      | Nowak    | 74%     | 4     |
| Paweł    | Kowal    | 80%     | 4     |
| Jarosław | K.       | 8%      | 2     |

Pojedyncza komórka sama w sobie właściwie nie przedstawia dla nas żadnej wartości informacyjnej, bowiem pojedyncza dana

| Paweł | 

niewiele nam mówi. Nie wiemy, czego się tyczy, jaką wiedzę opisuje. Taka pojedyncza komórka, zwana *wartością pola* nie przekazuje nam żadnej wartościowej informacji. 

Cały wiersz również sam w sobie nie powie nam nic interesującego, bo brakuje mu jednego ważnego aspektu - **kontekstu**

| Jan      | Nowak    | 74%     | 4     |

W powyższym wypadku nie wiemy, czy Jan to imię, 4 to liczba palców lewej ręki, a 74% to ulubione stężenie alkoholu pana Jana w Long Island Ice Tea, czy jednak są to racjonalniejsze dane. Sama dana pozbawiona kontekstu jest nic nie warta. Dopiero postawienie takiej danej w kontekście przedstawia jakąkolwiek wartość informacyjną

| Imię     | Nazwisko | Kolos 1 | Ocena |
|----------|----------|---------|-------|
| Jan      | Nowak    | 74%     | 4     |

Wiele takich danych, przedstawionych w uporządkowany sposób stworzy nam **bazę danych**. Baza taka składa się z jednej lub wielu tabel o **ściśle określonej strukturze**. Oznacza to, że w ramach jednej tabeli wszystkie rekordy będą przedstawiane w identyczny sposób. W powyższym przykładzie, każdy wiersz w pierwszej komórce posiada imię, w drugiej nazwisko itd.

## Podstawowe pojęcia
   - Encja (tabela), w teorii relacyjnej określana również jako *relacja*. Baza danych składa się z przynajmniej jednej tabeli, a każda tabela składa się z przynajmniej jednego pola. Nazwę tabeli określamy rzeczownikiem w liczbie mnogiej, np. Wyniki, Oceny, Adresy
   - Krotka (rekord) - unikatowy wpis w tabeli opisujący cechy jakiegoś obiektu, składa się na niego zestaw pól w jednym wierszu. 
   - Atrybut (pole) - wizualnie kolumna. W praktyce jest to najmniejszy element struktury bazy danych, opisujący jedną cechę rekordu. Kolumny nazywamy rzeczownikiem w liczbie pojedynczej, np. Ulica, Imię, PESEL
   - Klucz główny (klucz podstawowy) - Specjalne pole tabeli, która pozwala na jednoznaczną identyfikację rekordu. Oznaczany skrótem **PK** od ang. Primary Key. Technicznie rzecz biorąc występować może klucz główny łączony, czyli wiele pól, które razem pozwolą jednoznacznei zidentyfikować rekord, w praktyce odradzany.

Wracając zatem do wcześniejszego przykładu. Mamy tabelę *Oceny*, składającą się z pól *Imię, Nazwisko, Kolos 1, Ocena*. Czy widzimy tu kandydata na kolumnę, która mogłaby być kluczem głównym? Możemy mieć przecież w naszym arkuszu wielu Janów, wielu Nowaków, nawet kilku Janów Nowaków ma potencjał, by się tu znaleźć. Wynik procentowy z kolokwium również powtórzy się wielokrotnie, wystarczy, że dwie osoby zdobędą max. Ocena tym bardziej będzie się powtarzać. W takiej sytuacji znaleźć musimy jakąś cechę tych wszystkich obiektów, która będzie unikatowa. Dla studentów będzie to na przykład numer indeksu

| Indeks | Imię     | nazwisko | Kolos 1 | Ocena |
|--------|----------|----------|---------|-------|
| s13820 | Paweł    | Lelental | 60%     | 3     |
| s2137  | Jan      | Nowak    | 74%     | 4     |
| s42069 | Paweł    | Kowal    | 80%     | 4     |
| s500   | Jarosław | K.       | 8%      | 2     |

Taką jedną tabelę możemy zatem porównać do pojedynczego arkusza kalkulacyjnego, jednak przestrzegać musimy kilku zasad:
- Każde pole powinno zawierać jedną wartość
- Nazwa pola pozwala jednoznacznie zidentyfikować rodzaj tej wartości

W źle zaprojektowanych bazach danych standardowymi błędami będą
- Pola złożone - zawierające więcej niż jedną wartość w ramach jednego pola - np. Imię i Nazwisko, Kod pocztowy i Miasto
- Pola wielowartościowe - zawierające kilka powtórzeń tego samego elementu, np. pole Uprawnienia, zawierające "admin, user"
- Pole obliczeniowe - zawierające wynik obliczenia wartości z dwóch lub więcej pól lub złączenia treści dwóch lub więcej pól z tabeli. 

Dla przykładu:

| Imię i Nazwisko | pkt Kolos | % Kolos 1 | Ocena |
|-----------------|-----------|-----------|-------|
| Paweł Lelental  | 30        | 60%       | 3     |
| Jan Nowak       | 37        | 74%       | 4     |
| Paweł Nowak     | 40        | 80%       | 4     |
| Jarosław Nowak  | 4         | 8%        | 2     |

Pojedyncza kolumna powinna przedstawiać jedną, niepodzielną informację. Dlatego w tabelach raczej unikać będziemy przechowywać pola "Adres" a oddzielne "Ulica", "Numer Domu", "Miasto", "Kod pocztowy"

### Zadanie na zajęcia
Zaplanuj, jakie dane powinna porzechowywać tabela *Pracownik* znajdująca się w bazie danych pewnej firmy usługowej. Proszę o projekt zawierający nazwy kolumn oraz 2 przykładowe rekordy. Proponuję skorzystać z arkusza kalkulacyjnego lub kartki i długopisu

## Relacje
Jak sama nazwa przedmiotu wskazuje, zajmujemy się tutaj *relacyjnymi* bazami danych. O co zatem chodzi z relacjami? Tabele w bazie mogą być ze sobą w jakiś sposób powiązane. Inaczej rzecz ujmując, między dwiema tabelami zachodzi relacja, jeśli można w jakiś sposób skojarzyć rekordy z jednej tabeli z rekordami z drugiej i zachodzi pomiędzy nimi *logiczny związek*. 

Stwórzmy dla przykładu tabele Osoby oraz Oceny - pamiętajcie, że to tylko przykładowe dane, w normalnej bazie danych byłoby ich znacznie więcej.

#### Osoby

| Indeks  | Imie  | Nazwisko |
|---------|-------|----------|
| s13820  | Paweł | Lelental |
| s2137   | Jan   | Nowak    |

#### Oceny

| Przedmiot | Ocena | Indeks |
|-----------|-------|--------|
| WIA2      | 3     | s13820 |
| RBD       | 3,5   | s2137  |
| RBD       | 4     | s13820 |

Z tabeli *Oceny* wywnioskować możemy, że do indeksu s2137 przypisana jest ocena 3.5 z RBD. Z tabeli *Osoby* wywnioskować możemy, że do indeksu s2137 przypisany jest Jan Nowak. W taki sposób łączyć będziemy ze sobą dane znajdujące się w oddzielnych tabelach, ale ze sobą powiązane. Istnieją **3 rodzaje relacji**
- jeden do jednego - 1:1 - Najprostszy do zrozumienia rodzaj relacji. Łączy dokładnie jeden rekord z Tabeli 1 z dokładnie jednym rekordem z Tabeli 2. Stosowany często do rozszerzania pewnych informacji. Dla przykładu, w danym momencie jedna osoba może posiadać tylko jeden paszport w danym kraju. W momencie wydania nowego, stary jest unieważniany. Dlatego w krajowej bazie danych paszport możemy połączyć z daną osobą połączeniem 1:1. Zapis na diagramie ERD:
```mermaid
erDiagram
    PERSONS ||--|| PASSPORTS : have
```
- jeden do wielu - 1:n - Odrobinę bardziej złożony i bardzo często stosowany. W tym rodzaju relacji jeden rekord z Tabeli 1 przypisany może być do wielu rekordów z Tabeli 2. Przykładem takiej relacji może być związek pomiędzy przedstawionymi wyżej tabelami **Osoby** i **Oceny**, ale również przedstawiony poniżej przykład, w którym wiele biletów lotniczych może być przypisanych do jednego paszportu, ale na jednym bilecie może być tylko jeden paszport. 
```mermaid
erDiagram
    PASSPORTS ||--|{ TICKETS : "have assigned"
```
- wiele do wielu - m:n - Ten rodzaj relacji określa, że wiele rekordów z Tabeli 1 może być przypisanych do wielu rekordów Tabeli 2. W implementacji bazy danych taka relacja wymaga stworzenia dodatkowej tabeli, tzw. łączącej lub asocjacyjnej. Spotkać się można również z określeniem *tabela agregująca*, ale jest ono błędne. Przykładem takiej relacji może być sytuacja z rezerwacjami lotniczymi, w której na jednej rezerwacji znajduje się wiele osób, a każda osoba może być prypisana do wielu rezerwacji. 
```mermaid
erDiagram
    PERSONS }|--|{ BOOKINGS : "are on"
```