# Hacker Books
### Lector Simple de PDF para IOS
--------------------------------

## Descripción

Esta aplicación permite leer libros de contenido técnico en formato pdf. La lista se presenta en un **TableView** ordenado por secciones (categorías de los libros).

Cuando se selecciona un libro se muestra una vista con su portada y la posibilidad de leerlo en PDF o marcarlo como favorito. Si hay libros marcados como favoritos, el Table View principal mostrará una primera categoría 'Favoritos' con los libros marcados. Si no hay ningún libro marcado como favorito, dicha categoría (*Sección*) no aparecerá en el Table View.

## Cuestiones

**1 - ¿En el procesado del JSON con qué métodos podemos trabajar? ¿is, as?**

> Para gestionar el parámetro devuelto se puede usar is para comparar según el tipo. Por contra con as nos ayuda a realizar un casting entre tipos según nos convenga con los tipos que trabajamos.

> En esta solución se utiliza as para hacer la conversión del dato leído a String. Seguidamente se utiliza esos String para construir los datos de todos los atributos de las clase **Book** del modelo.

**2 - ¿Dónde guardarías los datos de portada y pdf que el usuario solicita al consultar cualquier libro?**

> Yo los he guardado en el directorio 'documents' del sandbox de la aplicación.


**3 - ¿Cómo guardarías la información de los libros favoritos? ¿Se te ocurre más de una forma de hacerlo?**

> Yo lo he hecho añadiéndole un atributo *booleano* al modelo de libros. Cuando la aplicación carga procesa estos datos y los muestra en el TableView.

> Se podría también haber usado los UserDefaults para guardar esta información de manera que podamos persistir los libros favoritos entre diferentes ejecuciones de la aplicación.

> Por último también podríamos contemplar la persistencia en bases de datos. Aunque quizás dado el pequeño tamaño de la misma no sería muy rentable.


**4 - ¿Cómo enviarías información de un libro favorito (Book) al LibraryViewController? ¿Se te ocurre más de una forma de hacerlo?**

> Yo lo he hecho usando notificaciones. Cuando el usuario hace favorito un libro el **BookViewController** notifica al **LibraryViewController**, de manera que este último procesa dicha información y la persiste en el TableView.

> También podríamos haber utilizado un sistema de delegación en el que el **LibraryViewController** fuera delegado del **BookViewController**.

**5 - El método reloadData (de UITableView) hace que vuelva a pedir datos del DataSource. Esto es una aberración desde el punto de vista de rendimiento? ¿Por qué no es así? ¿Hay alguna forma alternativa? Cuando crees que vale la pena usarlo?**

> Yo pienso que no es una aberración siempre porque el catálogo de libros (contenido del MultiDictionary - Clase **Library** del modelo) no es muy grande. Para casos en los que haya muchos datos habrá sí sería mejor utilizar otros métodos más óptimos.

> Esto puede ser muy pesado si disponemos de un gran volumen de datos. En caso de no ser una buena opción sería más interesante implementar un sistema que implemente algún tipo de *carga perezosa* (Lazy Loading), de manera que solo se cargue los datos que se van a mostrar en el table view. Con este enfoque reduciríamos enormemente el problema.

**6 - Cuando el usuario cambia en la tabla del libro seleccionado, el PDF ViewController debe actualizarse. ¿Cómo lo harías?**

> He utilizado el sistema de notificaciones. En este caso desde la LibraryTableViewController al PDFViewController. La idea es enviar el modelo que se ha seleccionado y actualizar la vista del controlador que muestra los PDF.


**7 - ¿Qué funcionalidades le añadirías antes de subirla al App Store? ¿Algo que puedas monetizar?**

> La primera mejora que incluiría es dotar a la aplicación de asincronismo para realizar las descargas (ahora no lo tiene) lo cual repercutiría en la experiencia de usuario.

> Podría ser una buena opción incluir algún tipo de contenido en venta en modo in-App Purchase.

> También se le podría incluir funcionalidades como la posibilidad de marcar páginas, incluir notas, subrayar o marcar texto relevante o compartir porciones de texto o libros completos con otras personas (redes sociales, email, etc).
