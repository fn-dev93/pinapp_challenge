import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_repository/posts_repository.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit({
    required PostsRepository postsRepository,
  })  : _postsRepository = postsRepository,
        super(const PostsState());

  final PostsRepository _postsRepository;

  /// Fetches all posts.
  Future<void> getPosts() async {
    emit(state.copyWith(status: PostsStatus.loading));
    try {
      final posts = await _postsRepository.getPosts();
      emit(
        state.copyWith(
          status: PostsStatus.loaded,
          posts: posts,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: PostsStatus.error));
    }
  }

  /// Fetches a post by its id.
  Future<void> getPostById(int postId) async {
    emit(state.copyWith(status: PostsStatus.loading));
    try {
      final post = await _postsRepository.getPostById(postId);
      emit(
        state.copyWith(
          status: PostsStatus.loaded,
          posts: [post],
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: PostsStatus.error));
    }
  }
}
