import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp_challenge/features/posts/cubit/posts_cubit.dart';
import 'package:pinapp_challenge/features/comments/view/comments_page.dart';
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
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        final status = state.status;
        return Scaffold(
          body: switch (status) {
            PostsStatus.initial => const Center(child: Text('Initial')),
            PostsStatus.error => const Center(child: Text('Error')),
            PostsStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
            PostsStatus.loaded => ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () => Navigator.of(context).pushNamed(
                        CommentsPage.path,
                        arguments: post.id,
                      ),
                      title: Text(
                        post.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(post.body),
                    ),
                  );
                },
              ),
          },
        );
      },
    );
  }
}
