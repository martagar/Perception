Proyecto desarrollado en colaboración con Francisco Gil Amorós ([@jostey](https://github.com/jostey)).
Para algunas funciones se ha usado además una librería desarrollada por el grupo de investigación SIC de la Universidad de Cádiz.

# catchFoodGame
Juego de recogida de alimentos con la voz y la mano. Reconoce voz (palabras de entrenamiento) y la piel. Está programado en Matlab.

# Introducción
Juego implementado mediante la interfaz gráfica de Matlab que usa de forma dinámica reconocimiento de audio y vídeo.
Consiste en un juego 2D en el que el jugador debe recoger con una cesta la comida que cae desde lo alto de la pantalla pudiendo mover la comida y la cesta mediante el audio y video.

![img1](/media/img1.png)

Mediante el reconocimiento de voz se identifica qué elemento de los que aparecen en pantalla se quiere desplazar (pizza, perrito, hamburguesa, helado, pollo, tarta, cesta).

Mediante el reconocimiento de vídeo se identifica el movimiento a realizar (izquierda o derecha) con el uso del dedo.

# Reconocimiento de audio

Para el reconocimiento de voz hemos utilizado el método basado en DTW sin grandes modificaciones.
El reconocimiento de audio se basa, tanto ‘test’ como en ‘training’, en patrones de 1 segundo de duración:
	Frecuencia de muestreo = 8000 muestras/s de 16 bits;
	Longitud de tramas = 100 muestras (12,5 ms) ;

# Reconocimiento de video

En este caso, el software reconocerá el dedo del jugador y según la posición podrá desplazar el elemento seleccionado por voz.
Primero, sacaría el objeto nuevo (en este caso la mano) de la foto. Esto se realiza restando:

![img2](/media/img2.png)

Filtro de Clausura 	"imclose(img, strel('disk',5));"

![img3](/media/img3.png)

Umbralización
![img4](/media/img4.png)

Filtro de Clausura 	"imclose(img, strel('disk',8));"
![img5](/media/img5.png)

Finalmente, tenemos el reconocimiento de la mano encuadrándolo y viendo el vector de dirección.
![img6](/media/img6.png)
