---
layout: lab
subject: Hashowanie, szyfrowanie i haseł łamanie
description: Bash is back
---

## Hashowanie

Haszowanie to proces przekształcenia dowolnie długiego ciągu danych wejściowych w stałej długości ciąg wyjściowy, zwany skrótem (hash). Proces ten jest w teorii jednokierunkowy, co oznacza, że nie można odzyskać danych wejściowych na podstawie ich hasha. 

### Do czego służy hashowanie?

- Zabezpieczania haseł (przechowywanie ich w formie hashy zamiast w postaci jawnej).
- Sprawdzania integralności danych (np. porównywanie hashy plików).
- Generowania sygnatur cyfrowych.

Aby dodatkowo zabezpieczyć się przed atakami na dane możemy stosować tzw. salt, czyli losowy ciąg znaków dodawany do danych przed ich haszowaniem. Pomaga to zapobiegać atakom typu Rainbow Table oraz powtórzeniom hashy. 

### Przykłady: 

1. Generowanie prostego hasha SHA-256:
```bash
echo -n "haslo123" | sha256sum
```
2. Generowanie hashy za pomocą md5sum:
```bash
echo -n "haslo123" | md5sum
```
3. Generowanie hasha z bcrypt przy użyciu mkpasswd:
```bash
mkpasswd --method=bcrypt "haslo123"
```

Łamanie zahashowanych haseł jest wykonalne, jednak potrafi być dość kosztowne czasowo i obliczeniowo. Wymaga wykonania operacji hashowania na wordliście i porównywania wynikowych hashy. 

```bash
mkpasswd --method=sha-512 > hashes.txt
```

```mkpasswd``` poprosi nas o podanie hasła - korzystać będziemy z wordlisty rockyou.txt, która zawiera ~15 mln. unikatowych haseł, więc pole wybory mamy dość szerokie, ale proponuję wybrać coś bardziej oczywistego, jak 'iloveyou' albo 'realmadrid'. 

```bash
john hashes.txt --wordlist=/usr/share/wordlists/rockyou.txt
```

Powyższe polecenie powinno po chwili namysłu zwrócić nam podane przez nas hasło. 


## Szyfrowanie asymetryczne 

Samo zadanie przedstawię na zajęciach, natomiast polecenia do kopiowania zamieszczam tu:
```bash
openssl genrsa -out private.pem 2048
openssl rsa -in private.pem -outform PEM -pubout -out public.pem
echo "Tajna wiadomość" | openssl rsautl -encrypt -inkey public.pem -pubin -out message.encrypted
openssl rsautl -decrypt -inkey private.pem -in message.encrypted
```