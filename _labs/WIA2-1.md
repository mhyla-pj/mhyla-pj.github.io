---
layout: lab
course: WIA2
type: [ niestacjonarne, stacjonarne ]
lab_nr: 1
subject: Podstawy architektury komputera
description: Czyli dlaczego na kalkulatorze możemy odpalić Hogwarts Legacy
---
W ramach tego przedmiotu omówimy, w jaki sposób działają komputery, konkretnie w intelowskiej architekturze x86. Narzędziem, którego będziemy do tego celu używali będzie asembler. Asembler *(ang. assembler)*, to z technicznego punktu widzenia program budujący (asemblujący) kod maszynowy do wykonania przez procesor. Z naszego punktu widzenia, pojęcia tego będzimy korzystali myśląc o języku asemblera. Podstawowymi cechami *języka asemblera* jest to, że jedno polecenie tego języka odpowiada właściwie zawsze (no, bardzo często) jednemu rozkazowi procesora. 

## Jakiemu rozkazowi, jakiego procesora?
Procesor to w zasadzie bardzo szybki, bardzo wydajny i bardzo grzejący się kalkulator. Jest to urządzenie elektroniczne, którego zadaniem jest przetwarzanie danych. Składa się on z olbrzymiej ilości tranzystorów, połączonych ze sobą w odpowiedni sposób. Bez wnikania w szczegóły, procesor jest w stanie sam w sobie wykonywać operacje arytmetyczne, logiczne oraz komunikować się m.in z pamięcią komputera. Im głębiej będziemy grzebać, tym bardziej będzie się okazywać, że procesor jest w zasadzie bardzo głupi, jednak wykonuje przekazane mu polecenia bezbłędnie, w ogromnej ilości i absurdalnie szybko - dlatago jest tak potężnym urządzeniem

Jeśli chodzi o wspomniane wyżej rozkazy - procesor otrzymuje polecenie w formie binarnej, czyli ciągu zer i jedynek, interpretuje je i odpowiednio wykonuje - np. doda zawartość jednego rejestru do drugiego, przeniesie coś do pamięci, pobierze, przesunie bitowo itd. 
Na przykład, przekazany do procesora ciąg ```101110000000000001001100``` przeniesie do rejestru AX wartość ```100110000000000```. Proste, prawda?

## Jednak nie? Rozbijmy zatem te zagadnienia na części pierwsze
Zaczniemy od tego dziwnego ciągu 0 i 1. Jest to kod binarny, czyli liczba przedstawiona w systemie dwójkowym. 

Systemy liczbowe, a w naszym przypadku pozycyjne systemy liczbowe to sposób reprezentacji liczb za pomocą cyfr i symboli. Wszystkie pozycyjne systemy liczbowe mają identyczną zasadę działania, różnią się od siebie jedynie podstawą. Najpierw najprostszy przypadek:
### System dziesiętny
W pozycyjnych systemach liczbowych każda cyfra ma swoją pozycję, zaczynając od 0 z prawej strony. Numer pozycji równocześnie będzie stanowił potęgę, do której podnosić będziemy podstawę systemu na którym operujemy. Następnie znajdująca się na danej pozycji cyfra jest przez podniesioną do odpowiadającej jej potęgi podstawę systemu mnożona, a na koniec wszystkie liczby są do siebie dodawane. Dla przykładu, dziesiętna i zupełnie losowa liczba 2137:

|2|1|3|7|
|:---:|:---:|:---:|:---:|
|3|2|1|0|
|2*10<sup>3</sup>|1*10<sup>2</sup>|3*10<sup>1</sup>|7*10<sup>0</sup>|

*2\*10<sup>3</sup> + 1\*10<sup>2</sup> + 3\*10<sup>1</sup> + 7\*10<sup>0</sup> = 2137*

W tym przykładzie przeliczyliśmy liczbę 2137 z sytemu dziesiętnego na system dziesiętny. Wspaniałe zajęcia.

### System binarny
Podstawą systemu binarnego, czyli dwójkowego jest 2. I tak jak liczby w systemie dziesiętnym budujemy z 10 cyfr (0-9), tak tu liczby budować będziemy z 2 cyfr (0-1). Niemniej, potęgi zależne od pozycji, jak i sama numeracja pozycji nie jest jakkolwiek z tym systemem związana i pozostaje taka sama niezależnie od systemu liczbowego. Dla przykładu: ```1101 1011```

| 1               | 1               | 0               | 1               | 1               | 0               | 1               | 1               |
|:---------------:|:---------------:|:---------------:|:---------------:|:---------------:|:---------------:|:---------------:|:---------------:|
| 7               | 6               | 5               | 4               | 3               | 2               | 1               | 0               |
| 1*2<sup>7</sup> | 1*2<sup>6</sup> | 0*2<sup>5</sup> | 1*2<sup>4</sup> | 1*2<sup>3</sup> | 0*2<sup>2</sup> | 1*2<sup>1</sup> | 1*2<sup>0</sup> |

*1\*2<sup>7</sup> + 1\*2<sup>6</sup> + 0\*2<sup>5</sup> + 1\*2<sup>4</sup> + 1\*2<sup>3</sup> + 0\*2<sup>2</sup> + 1\*2<sup>1</sup> + 1\*2<sup>0</sup> = 128 + 64 + 0 + 16 + 8 + 0 + 2 + 1 = 209*

Ten przykład jest ambitniejszy, niż poprzedni, ponieważ przeliczyliśmy ```1101 1011``` na system dziesiętny. 

### System heksadecymalny
Podstawą systemu heksadecymalnego jest 16. Zasada działania jest dokładnie taka sama jak w pozostałych, ale ci bardziej spostrzegawczy mogli już się zorientować, że brakuje nam cyfr arabskich, żeby przedstawić 16 symboli budujących liczby. Problem ten rozwiązywany jest w dość prosty sposób: nieistniejące cyfry 10-15 zastąpione są kolejno literami A-F. 

System szesnastkowy ma jeszcze jedną, niewiarygodnie przydatną cechę - jego podstawą jest potęga dwójki, konkretnie 2<sup>4</sup>. Oznacza to, że konwersja między systemem binarnym a szesnastkowym jest bardzo prosta, jeden symbol systemu heksadecymalnego odpowiada bowiem zawsze 4 bitom w systemie dwójkowym. Np. 1111(bin) = 15(dec) = F(hex)

### Oznaczanie systemów liczbowych
Dość ważna sprawa, bo zapisując liczbę 1010 nie wiemy, czy na myśli mamy tysiąc dziesięć, czy liczbę binarną, w przeliczeniu 10. Stukrotna różnica.
- system binarny - 1111(2) lub 1111b
- system dziesiętny - 2137 lub 2137(dec) lub 2137(10)
- system heksadecymalny - 0xAF, lub AF(hex) lub AF(16)