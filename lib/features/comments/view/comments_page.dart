import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp_challenge/features/comments/cubit/comments_cubit.dart';
import 'package:pinapp_challenge/features/comments/widgets/widget.dart';
import 'package:pinapp_challenge/l10n/l10n.dart';
import 'package:pinapp_challenge/widgets/widgets.dart';
import 'package:posts_repository/posts_repository.dart';

///A widget that represents the Comments page of the app
class CommentsPage extends StatelessWidget {
  const CommentsPage({
    required this.post,
    super.key,
  });

  final Post post;

  ///The name of the page
  static String get name => 'Comments';

  ///The name of the path
  static String get path => '/Comments';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentsCubit(
        postsRepository: context.read<CommentsRepository>(),
      )..getComments(post.id),
      child: CommentsView(post: post),
    );
  }
}

///A widget that represents the Comments view of the [CommentsPage]
class CommentsView extends StatelessWidget {
  const CommentsView({
    required this.post,
    super.key,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        final status = state.status;
        return Scaffold(
          appBar: AppBar(
            title: Text('${l10n.post} #${post.id}'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: Navigator.of(context).pop,
            ),
          ),
          body: switch (status) {
            CommentsStatus.error => RetryButton(
                errorMessage: l10n.failedLoadingComments,
                onRetry: () =>
                    context.read<CommentsCubit>().getComments(post.id),
              ),
            CommentsStatus.loading => const Loader(),
            CommentsStatus.loaded => Column(
                children: [
                  PostTitleCard(post: post),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.comments.length,
                      itemBuilder: (context, index) {
                        final comment = state.comments[index];
                        return CommentCard(comment: comment);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }
}
