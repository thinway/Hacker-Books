# Hacker Books
## Lector Simple de PDF para IOS
--------------------------------

**1 - El JSON recibido contiene un array de libros. Al serializar utilizando JSONSerialization, devuelve un parámetro Any. Podemos obtener el tipo devuelto con type(of:). ¿en qué otros modos podemos trabajar? ¿is, as?**

> Para gestionar el parámetro devuelto se puede usar is para comparar según el tipo. Por contra con as podríamos realizar un casting según nos convenga con los tipos que trabajamos.

**2) ¿Dónde guardarías los datos de portada y pdf que el usuario solicita al consultar cualquier libro?**

> Yo los he guardado en el directorio 'documents' del sandbox de la aplicación.


**3) Cómo harías que la información de si un libro es favorito, persiste? ¿Se te ocurre más de una forma de hacerlo? Decisión de diseño.**

> Yo lo he hecho añadiéndole un atributo booleano al modelo de libros. Cuando la aplicación carga procesa estos datos y los muestra en el TableView.

> Se podría también haber usado los UserDefaults para guardar esta información de manera que podamos persistir los libros favoritos entre diferentes ejecuciones de la aplicación.

> Por último también podríamos contemplar la persistencia en bases de datos. Aunque quizás dado el pequeño tamaño de la misma no sería muy rentable.


**4) Cómo harías para enviar información de un libro favorito (Book) al LibraryViewController (esto ocurre cuando un usuario cambia el valor de la propiedad isFavourite al pinchar al botón de favorito). Se te ocurre alguna forma más de hacerlo?**

> Yo lo he hecho usando notificaciones. Cuando el usuario hace favorito un libro el BookViewController notifica al LibraryViewController, de manera que este último procesa dicha información y la persiste en el TableView.

> También podríamos haber utilizado un sistema de delegación en el que el LibraryViewController fuera delegado del BookViewController.

**5) Sobre el reloadData de la UITableView que hace que vuelva a pedir datos del DataSource. Esto es una aberración desde el punto de vista de rendimiento? Porque no es así? Hay alguna forma alternativa? Cuando crees que vale la pena usarlo?**

> Yo pienso que no es una aberración siempre y cuando no haya muchos datos que actualizar cada vez (en este caso es tan solo añadir un libro a favoritos), en caso de haber muchos si sería mejor utilizar otros métodos personalizados como por ejemplo actualizar tan solo el IndexPath deseado.

> Esto puede ser muy pesado si disponemos de un gran volumen de datos. En caso de no ser una buena opción sería más interesante implementar un sistema que procese solo los datos que se vean en el table view.

**6) Cuando el usuario cambia en la tabla del libro seleccionado, el PDF ViewController debe actualizarse. Como lo harías?**

> He utilizado el sistema de notificaciones. En este caso desde la LibraryTableViewController al PDFViewController. La idea es enviar el modelo que se ha seleccionado y actualizar la vista del controlador que muestra los PDF.


**7) Qué funcionalidades le añadirías antes de subirla al App Store? ¿Algo que puedas monetizar?**

> La primera mejora que incluiría es dotar a la aplicación de asincronismo para realizar las descargas (ahora no lo tiene) lo cual repercutiría en la experiencia de usuario.

> Tal vez podría ser una buena opción incluir algún tipo de contenido en venta en modo in-App Purchase.

> También se le podría incluir nuevas funcionalidades como marcar páginas, incluir notas o compartir porciones de texto o libros completos con otras personas (redes sociales, email, etc).
