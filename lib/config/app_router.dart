import 'package:go_router/go_router.dart';
import 'package:pinapp_challenge/features/comments/view/comments_page.dart';
import 'package:pinapp_challenge/features/posts/view/posts_page.dart';
import 'package:posts_repository/posts_repository.dart';

class AppRouter {
  GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: PostsPage.path,
    routes: [
      GoRoute(
        path: PostsPage.path,
        name: PostsPage.name,
        builder: (context, state) => const PostsPage(),
        routes: [
          GoRoute(
            path: CommentsPage.path,
            name: CommentsPage.name,
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              final post = extra!['post'] as Post;
              return CommentsPage(post: post);
            },
          ),
        ],
      ),
    ],
  );
}
