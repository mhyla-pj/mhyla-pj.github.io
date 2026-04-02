---
layout: lab
course: SOP
type: stacjonarne
lab_nr: 08
subject: Sygnały
description: 
---

Sygnał to „wydarzenie”, generowane, aby poinformować proces, że coś ważnego się wydarzyło. W momencie, w którym proces dostanie taki sygnał, powinien się wstrzymać z tym co aktualnie wykonuje i wykonać jakąś akcję. Wykorzystywane są do np. komunikacji między procesami.
Sygnały są definiowane w pliku nagłówkowym signal.h. Nazwa każdego z sygnałów zaczyna się od SIG, a kończy częścą tzw. Deskryptywną, np. SIGQUIT, SIGINT, SIGABRT. Każdy z sygnałów ma też swoją przypisaną wartość numeryczną, aczkolwiek raczej używamy nazw ze względu na to, że między systemami wartości numeryczne mogą się różnić, a nazwy zawsze będą robić to samo.

Aby obsługiwać sygnały w programie napisanym w języku C, należy skorzystać z funkcji dostępnych w bibliotece signal.h. Najważniejsze z nich:

- ```signal()``` - służy do ustawienia funkcji obsługi danego sygnału. 
```c
signal(int sig, void (*handler)(int));
```
 Pierwszy argument sig to numer sygnału, dla którego chcemy ustawić funkcję obsługi. Drugi argument handler to wskaźnik na funkcję obsługi. Funkcja signal() zwraca wskaźnik na poprzednią funkcję obsługi danego sygnału lub SIG_ERR w przypadku błędu.
- raise() - służy do wysłania sygnału do samego siebie.
  ```c
  int raise(int sig);
  ```
    Argument sig to numer sygnału, który chcemy wysłać. Funkcja zwraca wartość różną od zera w przypadku błędu.


```c

#include <stdio.h>
#include <signal.h>
#include <unistd.h>

void sig_handler(int signum);

int main(){
        signal(SIGINT, sig_handler);
        while(1){
                printf("Jestem w mainie!\n");
                sleep(1);
        }
}

void sig_handler(int signum){
        printf("jestem w handlerze!\n");
        sleep(1);
}
```

```c
void sig_handler(int signum){
        printf("jestem w handlerze!\n");
        sleep(1);
        printf("zara strzele samoboja!\n");
        raise(SIGTERM);
        printf("Zegnaj okrutny swiecie\n!");
}
```

Funkcja raise ma tę jedna niedogodność, że może wysyłać w zasadzie tylko sygnały do procesu wywołującego. Jeślibyśmy jednak chcieli wysłać sygnał do innego procesu, to użyjemy funkcji kill():

```c
#include <stdio.h>
#include <signal.h>
#include <unistd.h>

int main() {
    pid_t target_pid = 1234;
    
    printf("Sending SIGTERM signal to process %d...\n", target_pid);
    int result = kill(target_pid, SIGTERM);
    if(result == 0) {
        printf("Signal sent successfully.\n");
    } else {
        printf("Error sending signal.\n");
    }
    
    return 0;
}
```

Do komunikacji między procesami możemy użyć tzw. sygnałów użytkownika, które nie mają jakieś specjalnej akcji przypisanej domyślnie, ale to żaden problem, bo doskonale wiemy, że możemy taki handler napisać samodzielnie. Problem może się pojawić, jeśli byśmy chcieli taki sygnał wysłać. Znaczy
oczywiście możemy, ale co to za zabawa w wysyłanie wewnątrz jednego procesu sygnału, który służy do komunikacji między procesami. Najpierw wyślemy sobie go z terminala do programu, w tym celu z terminala proces z programem odpalamy w tle (./z3 &), a następnie wysłać musimy doń sygnał. Użyjemy polecenia kill –[SYGNAŁ] [pid procesu].

