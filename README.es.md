# PinApp Challenge

El `PinApp Challenge` es una aplicación Flutter que demuestra el uso de repositorios para manejar datos de publicaciones y comentarios desde una API.

## Instalación

1. Clona el repositorio:
    ```sh
    git clone https://github.com/yourusername/pinapp_challenge.git
    cd pinapp_challenge
    ```

2. Obtén las dependencias:
    ```sh
    flutter pub get
    ```

## Uso

### Ejecutar la Aplicación

Para ejecutar la aplicación en un emulador o dispositivo físico, usa el siguiente comando:
```sh
flutter run
```

### Estructura del Proyecto

El proyecto está estructurado de la siguiente manera:

- `lib/`: Contiene el código principal de la aplicación.
  - `app/`: Contiene el widget principal de la aplicación.
  - `bootstrap/`: Contiene la lógica de arranque de la aplicación.
  - `config/`: Contiene la configuración del enrutador de la aplicación.
  - `features/`: Contiene las diferentes características de la aplicación (por ejemplo, publicaciones, comentarios).
  - `main_development.dart`: Punto de entrada para el entorno de desarrollo.

- `packages/`: Contiene los paquetes Dart utilizados en la aplicación.
  - `posts_repository/`: Contiene el repositorio para manejar datos de publicaciones y comentarios.

### PostsRepository

El `PostsRepository` se utiliza para obtener datos de publicaciones desde la API.

```dart
import 'package:posts_repository/posts_repository.dart';

void main() async {
  final postsRepository = PostsRepository();

  // Obtener todas las publicaciones
  final posts = await postsRepository.getPosts();
  print(posts);

  // Obtener una publicación por ID
  final post = await postsRepository.getPostById(1);
  print(post);

  // Obtener publicaciones por ID de usuario
  final userPosts = await postsRepository.getPostsByUserId(1);
  print(userPosts);
}
```

### CommentsRepository

El `CommentsRepository` se utiliza para obtener datos de comentarios desde la API.

```dart
import 'package:posts_repository/posts_repository.dart';

void main() async {
  final commentsRepository = CommentsRepository();

  // Obtener comentarios por ID de publicación
  final comments = await commentsRepository.getCommentsByPostId(1);
  print(comments);
}
```

Puedes ver la version en ingles [here](README.md).

## Licencia

Este proyecto está licenciado bajo la licencia MIT. Consulta el archivo LICENSE para más detalles.
