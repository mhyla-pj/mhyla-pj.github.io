---
nav-exclude: true
---

# 🧠 Zestaw zagadnień omawianych w ramach przedmiotu

Dodałem emoji, ale tylko jedno. Obiecuję, że na egzaminie będzie więcej.

## 1. Wprowadzenie do systemów operacyjnych
- definicja systemu operacyjnego
- warstwy w systemie (user/kernel/hardware)
- podstawowe komponenty: kernel, shell, interfejs użytkownika

## 2. Struktura systemu Linux
- katalog `/` i jego podkatalogi
- rola `/proc`, `/dev`, `/bin`, `/etc`, itp.
- różnice między użytkownikiem a superuserem

## 3. Bash i praca z CLI
- podstawowe polecenia bash (`ls`, `cd`, `echo`, `ps`, `kill`, `top`)
- przekierowania, potoki, zmienne środowiskowe
- skrypty bash i argumenty

## 4. Jądro systemu operacyjnego (Kernel)
- funkcje jądra (zarządzanie pamięcią, procesami, I/O)
- tryby (user ↔ kernel)

## 5. Architektury jądra systemu
- monolityczne, mikrojądra, hybrydowe

## 6. Procesy
- pojęcie procesu i jego cykl życia
- fork, exec, wait, exit
- PID, PPID, status procesu
- tworzenie, oczekiwanie, zabijanie procesów
- zombie i orphan processes

## 7. Wątki i POSIX Threads
- różnice: proces vs wątek
- `pthread_create`, `pthread_join`, `pthread_exit`
- wielowątkowość i jej zastosowania

## 8. Synchronizacja
- pojęcie wyścigu (race condition)
- mutex (`pthread_mutex_t`)
- semafor (`sem_t`, `sem_init`, `sem_wait`, `sem_post`)

## 9. Zarządzanie procesami przez planistę
- planowanie procesów
- `nice`, `renice`

## 10. Komunikacja międzyprocesowa (IPC)
- potoki (`pipe()`)
- gniazda (`socketpair()`, `socket()`)
- pamięć dzielona (`shm_open`, `mmap`, `munmap`)
- semafory jako synchronizacja IPC

## 11. Obsługa plików w C
- `fopen`, `fclose`, `fscanf`, `fprintf`, `fgetc`, `fgets`, `fputs`
- `fwrite` i `fread` – operacje na danych binarnych
- błędy przy otwieraniu plików, EOF

## 12. Sygnały
- `signal()`, `kill()`, `SIGINT`, `SIGKILL`
- obsługa sygnałów i ich użycie w kontroli procesów

## 13. Tworzenie demonów
- `fork()`, `setsid()`, `umask()`, `chdir("/")`, `close()`
- demonizacja procesu krok po kroku
- pojęcie sesji i grupy procesów

## 14. Zarządzanie pamięcią *(częściowo wspomniane)*
- `malloc`, `free`, `brk`, `mmap`
- segmenty pamięci

## 15. Bootloader
- rola bootloadera
- kodowanie pierwszego sektora (MBR)
- przejście z trybu real mode do protected mode
- ładowanie jądra do pamięci

## 16. GDT – Global Descriptor Table
- struktura GDT: segment code/data, TSS
- ustawianie rejestrów segmentowych
- różnice między trybem real a protected
