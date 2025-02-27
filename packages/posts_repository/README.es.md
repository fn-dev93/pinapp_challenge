# Repositorio de Publicaciones

El paquete `posts_repository` proporciona un repositorio para manejar datos de publicaciones y comentarios desde una API.

## Instalación

Agrega `posts_repository` a tu archivo `pubspec.yaml`:

```yaml
dependencies:
  posts_repository:
    path: packages/posts_repository
```

## Uso

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

## Licencia

Este proyecto está licenciado bajo la licencia MIT. Consulta el archivo LICENSE para más detalles.
