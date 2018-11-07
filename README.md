# nine-mans-morris

Vorbedingungen:
"annähernd" Vogelperspektive - ~30° Winkel
Hintergrund: einfärbig, guter Kontrast zu Spielfeld

Pipeline:
Treshhold - Hintergrund erkennen, zu Binärbild, Transformationsmatrix ausrechnen durch Seitenlängen
Geometrische Transformation
Spielfeld ausschneiden
Canny - Kantenerkennung
Hough - Spielsteine finden

Geometrische Transformation und Canny beide notwendig?