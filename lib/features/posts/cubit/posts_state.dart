part of 'posts_cubit.dart';

enum PostsStatus {
  initial,
  loading,
  loaded,
  error;

  bool get isInitial => this == PostsStatus.initial;
  bool get isLoading => this == PostsStatus.loading;
  bool get isLoaded => this == PostsStatus.loaded;
  bool get isError => this == PostsStatus.error;
}

class PostsState extends Equatable {
  const PostsState({
    this.status = PostsStatus.initial,
    this.posts = const [],
  });

  final PostsStatus status;
  final List<Post> posts;

  PostsState copyWith({
    PostsStatus? status,
    List<Post>? posts,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object> get props => [
        status,
        posts,
      ];
}
