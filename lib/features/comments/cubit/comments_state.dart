part of 'comments_cubit.dart';

enum CommentsStatus {
  initial,
  loading,
  loaded,
  error;

  bool get isInitial => this == initial;
  bool get isLoading => this == loading;
  bool get isLoaded => this == loaded;
  bool get isError => this == error;
}

class CommentsState extends Equatable {
  const CommentsState({
    this.status = CommentsStatus.loading,
    this.comments = const [],
  });

  final CommentsStatus status;
  final List<Comment> comments;

  CommentsState copyWith({
    CommentsStatus? status,
    List<Comment>? comments,
  }) {
    return CommentsState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object> get props => [
        status,
        comments,
      ];
}
