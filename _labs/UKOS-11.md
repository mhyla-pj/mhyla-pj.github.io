---
layout: lab
course: UKOS
type: stacjonarne 
lab_nr: 11
subject: Kaskadowe Arkusze Stylów
description: CSSSSSSSS
---

Na poprzednich zajęciach wspominałem o CSS, czyli kaskadowych arkuszach stylów; wspominałem również o tym, że HTML używamy jedynie do ułożenia zawartości na stronie. Jednak strona z suchymi informacjami jest dość paskudna. HTML nigdy nie był stworzony do określania formatowania strony, więc wprowadzenie w wersji 3.2 tagów takich jak `<font>`, `<center>` i podobnych, których niektórzy z was mogli jeszcze używać w gimnazjum lub technikum, spowodowało ogromny problem dla deweloperów, szczególnie dużych serwisów. W odpowiedzi na ten problem powstał standard CSS.

**Dlaczego akurat kaskadowe?**

Kaskadowość można pokrótce opisać jako koncept, w wyniku którego wygląd każdej witryny jest wynikową działania kilku arkuszy stylów. Style możemy definiować:
1. Zewnętrznie (external) – w odrębnym pliku CSS. Taki plik może oddziaływać na więcej plików HTML np. w celu utrzymania jednakowego stylu graficznego w całym projekcie
2. Wewnętrznie (internal) – stylowanie umieszczamy w znaczniku `<style>` w sekcji `<head>` pliku HTML.
3. Inline – bezpośrednio w stylowanym znaczniku, jako atrybut

Ponadto każda z przeglądarek ma swoje własne wbudowane arkusze stylów, które znajdują się najniżej w hierarchii. Ich działanie można zauważyć zwykle po inputach, czy buttonach, jak również różnych wartościach marginesów znacznika body. Możemy to stylowanie potraktować jako punkt 0. Stylowanie odczytywane jest kolejno, jak podano na powyższej liście, przy czym jeśli jakiś element stylowany jest na więcej niż jednym arkuszu, wówczas przyjmie styl podany najpóźniej.

**Składnia**

```css
body { 
  padding: 15px; 
  font-family: "Century Gothic", serif; 
  background-color: #999999; 
  margin: 0; 
}
```

- Selektor wskazuje na znacznik, który chcemy ostylować;
- Deklaracja zawiera właściwość (property) oraz jej wartość;
- Każdy blok deklaracji zamykamy w nawiasy klamrowe. Ponadto każdą oddzielną deklarację musimy zakończyć średnikiem.

Zewnętrzny plik CSS może być napisany w dowolnym edytorze tekstu, jednak ze względu na podpowiedzi składni i autouzupełniane zalecam jednak używanie środowisk takich jak Jetbrains WebStorm, czy VS. Oba są dostępne dla studentów PJATK za darmo. Każdy zewnętrzny plik CSS musi posiadać rozszerzenie .css. Aby zaczął działać w naszym pliku HTML, musimy naszego zewnętrznego CSS-a zalinkować. Robimy to umieszczając w sekcji `<head>` następujący znacznik:

```html
<link rel="stylesheet" href="css/main.css">
```

## Zadanie na 5 minut

Korzystając z wiedzy nabytej na poprzednich zajęciach przygotuj swoją stronę domową, którą bez wstydu możnaby zamieścić na serwerach PJATK. Na razie tylko HTML.

## Właściwości

CSS ma tyle różnych właściwości, że na tych zajęciach ledwie zahaczymy o ułamek tych najważniejszych. Po całość zapraszam do dokumentacji: [CSS Reference](https://www.w3schools.com/cssref/default.asp)

Jednak, CSS jest bardzo logiczny, a w połączeniu z podpowiedziami środowiska można zrobić naprawdę dużo, równocześnie wiedząc bardzo niewiele. Wystarczy zacząć pisać nazwę właściwości, oczywiście po angielsku, a środowisko samo podpowie wszystkie możliwości.

Zacznijmy od zmiany tła. Służy do tego właściwość `background-color: #999999;` Warto ją na początku zastosować do selektora body, wówczas cała witryna będzie miała podany kolor. Na tło możemy również nałożyć obrazek (background-image) lub nakazać mu powtarzanie się (background-repeat).

Aby zmienić krój czcionki użyjemy deklaracji: `font-family: "Century Gothic", serif;` natomiast aby zmienić kolor czcionki zastosujemy deklarację: `color: #222222;`

**Box model**

Zasadniczo wszystkie elementy HTML mogą być traktowane jako boxy, czyli kontenery na treść. Każdy box ma podstawowe właściwości licząc od zewnątrz:
- Margines zewnętrzny (margin)
- Border (border)
- Margines wewnętrzny (padding)
- Zawartość (content)

Aby zobaczyć, jak tworzy się box wokół elementu najlepiej zastosować do niego tymczasowo `border: 2px solid black;` Narysuje to wokół elementu ramkę, która pozwoli nam określić, jak wygląda jego układ, jego wysokość, szerokość itd.

Dla potrzeb układu treści na stronie przydatne często okazuje się stworzenie pustego boxa, w którym umieścimy content strony. Taką zawartość zamykamy w znaczniku `<div>`

## Responsywność strony

W kontekście tworzenia nowoczesnych stron internetowych, responsywność stanowi kluczowy element projektowania. Dzięki responsywnemu podejściu, strony mogą dostosowywać swój wygląd i układ do różnych rozmiarów ekranów, co jest niezwykle istotne w erze różnorodnych urządzeń, takich jak smartfony, tablety i komputery stacjonarne.

W standardzie CSS, możemy korzystać z tzw. **media queries**, które pozwalają definiować różne style w zależności od parametrów ekranu. Przykładowo:

```css
@media only screen and (max-width: 600px) {
  body {
    font-size: 14px;
  }

  /* Dodatkowe style dla mniejszych ekranów */
}
```

W powyższym przykładzie, styl dla elementów zawartych w media query będzie aktywowany tylko gdy szerokość ekranu wynosi maksymalnie 600 pikseli. Dzięki temu, możemy zoptymalizować prezentację treści na różnych urządzeniach.

Responsywność może również być osiągnięta za pomocą technologii takich jak **flexbox** czy **grid**, które pozwalają elastycznie rozmieszczać elementy na stronie w zależności od dostępnego miejsca.

Warto również podkreślić znaczenie testowania responsywności na różnych urządzeniach oraz wykorzystanie narzędzi deweloperskich przeglądarek do weryfikacji, czy strona poprawnie dostosowuje się do różnych scenariuszy użytkowania. Dzięki tym narzędziom, projektanci i programiści mogą skutecznie dostosować prezentację treści, aby zapewnić optymalne wrażenia dla każdego użytkownika.