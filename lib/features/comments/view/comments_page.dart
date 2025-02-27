import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp_challenge/features/comments/cubit/comments_cubit.dart';
import 'package:posts_repository/posts_repository.dart';

///A widget that represents the Comments page of the app
class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  ///The name of the page
  static String get name => 'Comments';

  ///The name of the path
  static String get path => '/Comments';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentsCubit(
        postsRepository: context.read<CommentsRepository>(),
      )..getComments(1),
      child: const CommentsView(),
    );
  }
}

///A widget that represents the Comments view of the [CommentsPage]
class CommentsView extends StatelessWidget {
  const CommentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        final status = state.status;
        return Scaffold(
          body: switch (status) {
            CommentsStatus.initial => const Center(child: Text('Initial')),
            CommentsStatus.error => const Center(child: Text('Error')),
            CommentsStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
            CommentsStatus.loaded => ListView.builder(
                itemCount: state.comments.length,
                itemBuilder: (context, index) {
                  final comment = state.comments[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                        'comment.name',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        comment.email,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
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
