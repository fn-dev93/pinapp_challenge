import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_repository/posts_repository.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit({
    required CommentsRepository postsRepository,
  })  : _postsRepository = postsRepository,
        super(const CommentsState());

  final CommentsRepository _postsRepository;

  /// Fetches comments for a given post id.
  Future<void> getComments(int postId) async {
    emit(state.copyWith(status: CommentsStatus.loading));
    try {
      final comments = await _postsRepository.getCommentsByPostId(postId);
      emit(
        state.copyWith(
          status: CommentsStatus.loaded,
          comments: comments,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: CommentsStatus.error));
    }
  }
}
