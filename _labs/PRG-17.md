---
layout: lab
course: PRG
type: stacjonarne
lab_nr: 17
subject: Obiektowość cz.2
description: programowanie dla jeszcze większych programistów
---

## Specyfikatory dostępu

W poprzednim labie trzymaliśmy się tematu samochodu, więc i dziś w nim pozostaniemy. Czy zastanawialiście się kiedyś, co się dzieje, kiedy przekręcimy kluczyk w stacyjce? Co dokładnie sprawia, że silnik rusza? Ja się zastanawiałem, bo mam piękną historię jeżdżenia psującymi się złomami, ale ogólna idea jest taka, że wciskamy guzik, silnik się włącza. Tak naprawdę jednak pod spodem dzieje się bardzo dużo rzeczy, do których nie mamy dostępu. Nie podajemy bezpośrednio napięcia na rozrusznik, nie włączamy odrębnie pompy paliwa.

Podobna idea przyświeca *enkapsulacji*, czyli metodzie pozwalającej na ukrywanie specyfiki implementacji wewnętrznych szczegółów obiektu, pozostawiając dostęp do niego przy użyciu publicznego interfejsu. Bardziej obrazowo:

```c++
class Car {
private:
    bool engineState=false;
    void switchEngine();
public:
    void keyTurn();
    void revEngine();
};
```

wystawione publicznie są metody standardowo dostępne dla kierowcy:

- przekręcenie kluczyka
- przygazowanie

natomiast ukryte przed nim (prywatne) są rzeczy wymagające bardziej złożonych procesów - przełączanie silnika. W ten sposób użytkownik nie ma uprawnień, żeby magicznie włączyć silnik. Najpierw musi przekręcić kluczyk, dopiero to uruchomi silnik. A dopiero z uruchomionym silnikiem usłyszymy "vroom".

```c++
class Car {
private:
    bool engineState=false;
    void switchEngine();
public:
    void keyTurn();
    void revEngine();
};
void Car::keyTurn() {
    cout<<"Przekrecenie kluczyka"<<endl;
    switchEngine();
}
void Car::switchEngine() {
    engineState=!engineState;
}
void Car::revEngine() {
    if (engineState){
        cout<<"vroom!"<<endl;
    }
}
int main() {
    Car Skoda;
    cout<<"Pierwsza proba: "<<endl;
    Skoda.revEngine();
    //Skoda.switchEngine(); - tego się nie da wykonać
    Skoda.keyTurn();
    cout<<"Druga proba: "<<endl;
    Skoda.revEngine();
    return 0;
}
```

Najważniejsze jest aby zapamiętać, że zazwyczaj pola powinny być niedostępne z zewnątrz - prywatne. Dostęp do nich powinniśmy uzyskiwać za pomocą funkcji ustawiającej i odczytującej - *settera* i *gettera*. W ten sposób zabezpieczymy dane tak, aby nie zostały nigdy przypadkiem nieprawidłowo ustawione:

```c++
class Car {
private:
    int Speed;
public:
    int getSpeed() const {
        return Speed;
    }

    void setSpeed(int speed) {
        if (speed < 210 ) Speed = speed;
    }
};
```

Powyższy kod korzysta z metody setSpeed, aby uniemożliwić ustawienie prędkości na większą niż 210. Gdyby pole Speed było publiczne, moglibyśmy omyłkowo ustawić prędkość samochodu na milion i w efekcie rozwalić resztę logiki programu.

## Konstruktory

Konstruktor w programowaniu obiektowym to specjalna metoda klasy, która jest automatycznie wywoływana podczas tworzenia nowego obiektu danej klasy. Konstruktor ma za zadanie zainicjować obiekt w momencie jego powstawania, ustawiając początkowe wartości pól, rezerwując zasoby, i/lub wykonując inne czynności konieczne dla poprawnego działania obiektu.

```c++
class Car {
private:
    int Speed;
    string Make;
    string Model;
    double Engine;
public:

    Car(const string &make, const string &model, double engine) : Make(make), Model(model), Engine(engine) {}
    
    void showInfo(){
        cout<<Make<<' '<<Model<<' '<<Engine<<endl;
    }
};
int main() {
    Car hylaCar("Skoda", "Karoq", 1.5);
    hylaCar.showInfo();
    return 0;
}
```
