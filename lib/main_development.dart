import 'package:flutter/material.dart';
import 'package:pinapp_challenge/app/app.dart';
import 'package:pinapp_challenge/bootstrap.dart';
import 'package:posts_repository/posts_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  bootstrap(
    () => App(
      postsRepository: PostsRepository(),
      commentsRepository: CommentsRepository(),
    ),
  );
}
