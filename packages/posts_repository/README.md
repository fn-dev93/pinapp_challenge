
# Posts Repository

The `posts_repository` package provides a repository for managing post and comment data from an API.

## Installation

Add `posts_repository` to your `pubspec.yaml` file:

```yaml
dependencies:
  posts_repository:
    path: packages/posts_repository
```

## Usage

### PostsRepository

The `PostsRepository` is used to fetch post data from the API.

```dart
import 'package:posts_repository/posts_repository.dart';

void main() async {
  final postsRepository = PostsRepository();

  // Fetch all posts
  final posts = await postsRepository.getPosts();
  print(posts);

  // Fetch a post by ID
  final post = await postsRepository.getPostById(1);
  print(post);

  // Fetch posts by user ID
  final userPosts = await postsRepository.getPostsByUserId(1);
  print(userPosts);
}
```

### CommentsRepository

The `CommentsRepository` is used to fetch comment data from the API.

```dart
import 'package:posts_repository/posts_repository.dart';

void main() async {
  final commentsRepository = CommentsRepository();

  // Fetch comments by post ID
  final comments = await commentsRepository.getCommentsByPostId(1);
  print(comments);
}
```

Read the spanish version [here](README.es.md).

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
