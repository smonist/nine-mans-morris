# nine-mans-morris

Regeln:

Setzphase: 
Die Spieler setzen abwechselnd je einen Stein, insgesamt je neun, auf Kreuzungs- oder Eckpunkte des Brettes

Zugphase: 
Die Spielsteine werden gezogen, das heißt, pro Runde darf jeder Spieler einen Stein auf einen angrenzenden, 
freien Punkt bewegen. Kann ein Spieler keinen Stein bewegen, so hat er verloren.

Endphase: 
Sobald ein Spieler nur noch drei Steine hat, darf er mit seinen Steinen springen, das heißt, er darf nun 
pro Runde mit einem Stein an einen beliebigen freien Punkt springen. Sobald ihm ein weiterer Stein abgenommen wird, hat er das Spiel verloren.

---

Assets:

Datensatz:
SpielNr_Spielzug.jpg
bsp: 1_3.jpg    Spiel 1 Zug 3

Threshold:
T + SpielNr_Spielzug.jpg
bsp: T1_3.jpg

---


Vorbedingungen:
("annähernd“ Vogelperspektive) - maximale Verzerrung: 30° Winkel
Hintergrund: Einfärbig, eher dunkel mit einem guten Kontrast zum (weißen) Spielfeld
Pipeline:
1. Threshold um Hintergrund von Spielfeld separieren.
            Input: RGB Bild
            Output: RGB Bild, SW Bild, 4 Eckpunkte
2. Transformationsmatrix anhand der Eckpunkte des separierten Spielfeldes berechnen
            Input: RGB Bild, 4 Eckpunkte 
            Output: RGB Bild, Transformationsmatrix
3. Geometrische Transformation
            Input: RGB Bild, Transformationsmatrix
            Output: Entzerrtes RGB Bild
4. Spielfeld ausschneiden, Bild auf 500px Breite (hinunter)skalieren!
            Input: Entzerrtes RGB Bild
            Output: 500 x 500 Pixel Spielfeld RGB
5. Canny – Kantenerkennung
            Input: Spielfeld RGB
            Output: Spielfeld RGB, Kanten
6. Hough - Spielsteine finden
            Input: Spielfeld RGB
            Output: Spielsteine/Kreise
7. Spielzug erkennen (Ganze Pipeline mit zweitem Bild nochmal und prüfen, ob Spielzug gültig ist)
            Input: Kanten, Spielsteine
            Output: Spielzug legal/ilegal
Spielzugerkennung = testen, ob Spielzug gültig ist



---
Spielzugerkennung = testen, ob Spielzug gültig ist


Geometrische Transformation und Canny beide notwendig?

Bild einheitlich skalieren!


res:

http://www.johnloomis.org/ece564/notes/tform/