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

Vorbedingungen:

"annähernd" Vogelperspektive - ~30° Winkel

Hintergrund: einfärbig, guter Kontrast zu Spielfeld

Pipeline:

Treshold - Hintergrund erkennen, zu Binärbild, Transformationsmatrix ausrechnen durch Seitenlängen

Geometrische Transformation

Spielfeld ausschneiden, Bild einheitlich skalieren!

Canny - Kantenerkennung

Hough - Spielsteine finden


---
Spielzugerkennung = testen, ob Spielzug gültig ist


Geometrische Transformation und Canny beide notwendig?

Bild einheitlich skalieren!


res:

http://www.johnloomis.org/ece564/notes/tform/