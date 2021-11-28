# MOVIES FINDER

Un buscador de películas donde puede consultar información, copiarla y guardar la portada de sus películas favoritas.

## Tecnologías usadas

- IDE: Xcode 13.1 
- Lenguaje: Swift
- Framework: UIKit
- Interfaz: Ficheros XIB para la creación de las vistas.
- URLSession para las peticiones de red. Consultas a la API de OMDb.
- Arquitectura MVC

## Anotaciones

- Al pulsar la portada de la película se abre a pantalla completa y se puede guardar en el dispositivo. 
- Al pulsar en la información de la película (título, duración, género, sinopsis...) se muestra un menú para copiar el texto en el portapapeles.
- No he podido encontrar películas que tengan un enlace web, por lo que no he podido probar la función de abrir la url de la web en el navegador. Aunque debería funcionar.

![main-capture](https://user-images.githubusercontent.com/33114106/143756213-d2a2c515-2d30-45da-92c2-5459cfbb56da.png)
![detail-capture](https://user-images.githubusercontent.com/33114106/143756234-1f039aa5-7d9e-4153-ac25-4cb256acaab2.png)
