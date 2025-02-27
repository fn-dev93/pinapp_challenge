import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pinapp_challenge/app/view/app.dart';
import 'package:posts_repository/posts_repository.dart';

void main() {
  group('App', () {
    late PostsRepository postsRepository;
    late CommentsRepository commentsRepository;

    setUp(() {
      postsRepository = PostsRepository();
      commentsRepository = CommentsRepository();
    });

    testWidgets('renders MaterialApp', (tester) async {
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(value: postsRepository),
            RepositoryProvider.value(value: commentsRepository),
          ],
          child: App(
            postsRepository: postsRepository,
            commentsRepository: commentsRepository,
          ),
        ),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('provides PostsRepository and CommentsRepository',
        (tester) async {
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(value: postsRepository),
            RepositoryProvider.value(value: commentsRepository),
          ],
          child: App(
            postsRepository: postsRepository,
            commentsRepository: commentsRepository,
          ),
        ),
      );

      final context = tester.element(find.byType(App));
      expect(context.read<PostsRepository>(), postsRepository);
      expect(context.read<CommentsRepository>(), commentsRepository);
    });

    testWidgets('uses Material3 theme', (tester) async {
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(value: postsRepository),
            RepositoryProvider.value(value: commentsRepository),
          ],
          child: App(
            postsRepository: postsRepository,
            commentsRepository: commentsRepository,
          ),
        ),
      );

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.useMaterial3, true);
    });
  });
}
