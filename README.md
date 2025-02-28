
# PinApp Challenge

The `PinApp Challenge` is a Flutter application that demonstrates the use of repositories to manage post and comment data from an API.

[▶ Watch Video](https://drive.google.com/file/d/1Mje_WxAQY5E_xi8C4UnPqfarMZ-qtmP0/view?usp=sharing)

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/pinapp_challenge.git
    cd pinapp_challenge
    ```

2. Get the dependencies:
    ```sh
    flutter pub get
    ```

## Usage

### Running the App

To run the app on an emulator or physical device, use the following command:
```sh
flutter run
```

### Project Structure

The project is structured as follows:

- `lib/`: Contains the main application code.
  - `app/`: Contains the main app widget.
  - `bootstrap/`: Contains the bootstrap logic for the app.
  - `config/`: Contains the app router configuration.
  - `features/`: Contains the different features of the app (e.g., posts, comments).
  - `main_development.dart`: Entry point for the development environment.

- `packages/`: Contains the Dart packages used in the app.
  - `posts_repository/`: Contains the repository for managing post and comment data.

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

You can read the spanish version [here](README.es.md).


## License

This project is licensed under the MIT License. See the LICENSE file for more details.
