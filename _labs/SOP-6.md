---
layout: lab
course: SOP
type: stacjonarne
lab_nr: 06
subject: Wstęp do programowania w C, procesy
description: Bash był fajniejszy
---

Zaczniemy od dość prostego przykładu – do skryptów basha możemy bez większego problemu przekazać jakieś dane w postaci argumentów. Do programu w C również. Zaczniemy od funkcji main(). Program w C zawsze się od takowej zaczyna, jest to bowiem funkcja, która jest wywoływana przy uruchomieniu programu. Możemy ją oczywiście wywołać pustą, ale wtedy nie przekażemy do niej żadnych argumentów. Aby cokolwiek do niej przekazać, użyjemy konstrukcji
```c
int main(int argc, char *argv[]){}
```
*argc* jest intem, w którym znajdować się będzie liczba argumentów przekazanych do programu. *Argv[]* natomiast jest tablicą o rozmiarze takim jak *argc*, która zawierać będzie kolejno wszystkie przekazane do programu argumenty.

### ✍️ Szybkie zadanko
Napisz programik, który przyjmie ileś argumentów, a następnie je wszystkie wypisze na terminalu. Przypomnę przy okazji, że do wydrukowania tekstu użyjemy funkcji printf (należy zaincludować <stdio.h>).

```c
int printf(stala_lancuchowa, argument1, argument2...)
```
stała łańcuchowa to w uproszczeniu tekst, który chcemy wypisać. Może zawierać zwykłe znaki, które są przepisywane na ekran oraz kody formatujące kolejne argumenty.
- %c – pojedynczy znak
- %s – string
- %d – signed int
- %f – float
- %u – unsigned int

Czyli, aby wydrukować zawartość zmiennych int jajco i łańcucha PJATK wywołamy:

```c
printf("jajco ma wartość %d, natomiast PJATK ma wartość %s", jajco, PJATK)
```

## 🚪 Main()
Wywołanie programu to tak naprawdę wywołanie funkcji main() tego programu. Jeśli int main() zwraca 0, to znaczy że program się wykonał prawidłowo i wszyscy jesteśmy szczęśliwi. Stąd też *return 0* na końcu. Jakakolwiek inna wartość oznacza błąd. Możemy również użyć exit(0) dla prawidłowo wykonanych programów. Parametr basha $? zawiera wartość zwracaną przez ostatnio zakończony program.

## 👨‍👦 Pora na procesy

Linux zawiera szereg rozwiązań umożliwiających rozdzielania programu na wiele procesów, zarządzanie nimi i komunikację między nimi.

Wywołanie fork() jest używane do stworzenia nowego procesu, nazywanego child process, który będzie działał równolegle do procesu dokonującego wywołania, czyli parent process. Kiedy utworzony zostanie proces podrzędny, oba procesy wykonają już następną instrukcję. Dla przykładu:

```c
#include <stdio.h>
#include <unistd.h>
int main(int argc, char *argv[]){

printf("%s", "zaraz sie podziele!\n");
fork();
printf("Hello World\n");

return 0;
}
```

Systemowa funkcja fork() nie przyjmuje żadnych argumentów, a zwraca wartość typu int o wartości zależnej od tego, w którym procesie ją sprawdzimy:
- `< 0` – błąd podczas tworzenia procesu
- `== 0` – jesteśmy w procesie dziecka
- `> 0` – jesteśmy w rodzicu, wartość to PID dziecka

Wywołanie wait() służy do poczekania na zmiany w procesie-dziecku wywołującego procesu. Taką zmianą może być na przykład zakończenie, zatrzymanie sygnałem, wznowienie. W wypadku terminacji, system uwolni zasoby zarezerwowane dla dziecka.
Mamy również kilka funkcji, które pomogą nam odczytywać pid bieżącego i nadrzędnego procesu, są to odpowiednio

```c
getpid();
getppid();
```

procesem wywołującym funkcję main() będzie terminal, z którego została wywołana.

## 🕓 Synchronizacja procesów – `wait()` i `waitpid()`

Po utworzeniu dziecka proces rodzic może:
- **zakończyć się od razu**, co uczyni dziecko „sierotą” (adoptowaną przez `init`)
- **poczekać na dziecko** dzięki funkcji `wait()` lub `waitpid()`

### 🛑 `wait()`
- Czeka, aż jakikolwiek proces potomny zakończy się.
- Zwraca PID zakończonego procesu.
- Przykład:
```c
#include <sys/wait.h>

int status;
pid_t pid = wait(&status);
```

### 🧠 `waitpid()`
- Czeka na konkretny proces o danym PID.
- Można użyć z dodatkowymi flagami (np. `WNOHANG`).
- Przykład:
```c
pid_t pid = waitpid(child_pid, &status, 0);
```

### 📌 Odczyt kodu zakończenia:
```c
if (WIFEXITED(status)) {
    int code = WEXITSTATUS(status);
    printf("Proces zakończył się kodem %d\n", code);
}
```

---

## 📌 Podsumowanie

| Funkcja       | Opis                                          |
|---------------|-----------------------------------------------|
| `fork()`      | Tworzy nowy proces                            |
| `getpid()`    | Zwraca PID bieżącego procesu                 |
| `getppid()`   | Zwraca PID procesu nadrzędnego               |
| `wait()`      | Czeka na zakończenie jakiegokolwiek dziecka  |
| `waitpid()`   | Czeka na konkretny PID procesu                |