import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinapp_challenge/features/comments/view/comments_page.dart';
import 'package:pinapp_challenge/features/posts/cubit/posts_cubit.dart';
import 'package:pinapp_challenge/features/posts/widgets/widgets.dart';
import 'package:pinapp_challenge/l10n/l10n.dart';
import 'package:pinapp_challenge/widgets/widgets.dart';
import 'package:posts_repository/posts_repository.dart';

///A widget that represents the Posts page of the app
class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  ///The name of the page
  static String get name => 'Posts';

  ///The name of the path
  static String get path => '/Posts';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostsCubit(
        postsRepository: context.read<PostsRepository>(),
      )..getPosts(),
      child: const PostsView(),
    );
  }
}

///A widget that represents the Posts view of the [PostsPage]
class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        final status = state.status;
        return Scaffold(
          appBar: AppBar(
            title: Text(PostsPage.name),
            centerTitle: true,
          ),
          body: switch (status) {
            PostsStatus.error => RetryButton(
                errorMessage: l10n.failedLoadingPosts,
                onRetry: context.read<PostsCubit>().getPosts,
              ),
            PostsStatus.loading => const Loader(),
            PostsStatus.loaded => ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return PostCard(
                    post: post,
                    onTap: () => context.pushNamed(
                      CommentsPage.name,
                      extra: {
                        'post': post,
                      },
                    ),
                  );
                },
              ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }
}
