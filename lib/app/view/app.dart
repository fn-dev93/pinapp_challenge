import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp_challenge/features/comments/view/comments_page.dart';
import 'package:pinapp_challenge/features/posts/view/posts_page.dart';
import 'package:pinapp_challenge/l10n/l10n.dart';
import 'package:posts_repository/posts_repository.dart';

class App extends StatelessWidget {
  const App({
    required PostsRepository postsRepository,
    required CommentsRepository commentsRepository,
    super.key,
  })  : _postsRepository = postsRepository,
        _commentsRepository = commentsRepository;

  final PostsRepository _postsRepository;
  final CommentsRepository _commentsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _postsRepository),
        RepositoryProvider.value(value: _commentsRepository),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: PostsPage(),
        routes: {
          PostsPage.path: (context) => PostsPage(),
          CommentsPage.path: (context) => CommentsPage(),
        },
      ),
    );
  }
}
