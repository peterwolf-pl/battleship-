# BatleShip – mod do Factorio 2.0

## Opis projektu
BatleShip to mod do Factorio 2.0 dodający bojowy statek morski typu cargo ship.

**Statek:**
- porusza się po wodzie
- posiada 3 działa artyleryjskie
- ma wewnętrzną ładownię na pociski artyleryjskie
- automatycznie ładuje amunicję do dział

Mod łączy logistykę, artylerię i walkę morską. Jest przeznaczony dla graczy,
którzy chcą prowadzić ofensywę z wody.

## Cele projektu
- Dodać nowy typ jednostki bojowej.
- Wykorzystać istniejącą mechanikę artylerii.
- Zachować balans gry.
- Utrzymać wysoką wydajność UPS.
- Być w pełni kompatybilnym z Factorio 2.0.

## Zakres funkcjonalny
### Statek
- Wygląd cargo ship.
- Jedna encja bazowa.
- Własna ładownia (inventory).

### Uzbrojenie
- 3 działa artyleryjskie.
- Stałe pozycje na pokładzie.
- Normalne zachowanie artylerii.

### Logistyka amunicji
- Amunicja przechowywana w ładowni statku.
- Automatyczne ładowanie do dział.
- Brak inserterów.
- Kontrola ilości pocisków na każde działo.

## Architektura moda
### Struktura plików
```
batleship/
├─ info.json
├─ data.lua
├─ control.lua
├─ prototypes/
│  ├─ ship.lua
│  ├─ turrets.lua
│  ├─ items.lua
│  ├─ recipes.lua
│  └─ technology.lua
├─ graphics/
│  ├─ ship/
│  └─ icons/
└─ locale/
   └─ en/
```

## Plan implementacji
### Etap 1 – Szkielet moda
- info.json
- pusta struktura plików
- rejestracja moda w grze

### Etap 2 – Encja statku
- definicja prototypu statku
- inventory typu cargo
- kolizje wodne
- animacja i hitbox

### Etap 3 – Działa artyleryjskie
- użycie typu artillery-turret
- 3 działa jako osobne encje
- stałe offsety względem statku

### Etap 4 – Logika control.lua
- wykrywanie postawienia statku
- automatyczne tworzenie 3 dział
- zapisywanie relacji statek–działa w global

### Etap 5 – Automatyczne ładowanie
- odczyt ładowni statku
- odczyt inventory ammo turretów
- przenoszenie pocisków
- limit amunicji na działo

### Etap 6 – Ruch i synchronizacja
- utrzymanie offsetów dział
- teleport dział razem ze statkiem
- cleanup przy zniszczeniu statku

### Etap 7 – Balans
- koszt receptury
- zużycie energii lub paliwa
- limit prędkości
- ewentualne ograniczenia zasięgu

### Etap 8 – Technologia
- osobna technologia odblokowująca statek
- wymagania: artyleria + transport
- ikona i opis

## Założenia techniczne
- Factorio 2.0 API
- Lua scripting
- Tick logic ograniczona do on_nth_tick
- Brak logiki per tick
- Bez inserterów i combinatorów

## Wydajność
- Autoload co 30–60 ticków
- Brak skanowania mapy
- Tylko śledzone statki
- Bez pętli globalnych bez potrzeby

## Balans rozgrywki
- Drogi w produkcji
- Ograniczona liczba dział
- Duże zużycie amunicji
- Ryzyko utraty całego zapasu przy zniszczeniu
