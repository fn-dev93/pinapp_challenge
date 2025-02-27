import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinapp_challenge/features/comments/cubit/comments_cubit.dart';
import 'package:posts_repository/posts_repository.dart';

class MockCommentsRepository extends Mock implements CommentsRepository {}

void main() {
  group('CommentsCubit', () {
    late CommentsRepository commentsRepository;
    late CommentsCubit commentsCubit;

    setUp(() {
      commentsRepository = MockCommentsRepository();
      commentsCubit = CommentsCubit(postsRepository: commentsRepository);
    });

    test('initial state is CommentsState', () {
      expect(commentsCubit.state, const CommentsState());
    });

    blocTest<CommentsCubit, CommentsState>(
      'emits [loading, loaded] when getComments succeeds',
      build: () {
        when(() => commentsRepository.getCommentsByPostId(any()))
            .thenAnswer((_) async => []);
        return commentsCubit;
      },
      act: (cubit) => cubit.getComments(1),
      expect: () => [
        const CommentsState(),
        const CommentsState(status: CommentsStatus.loaded),
      ],
    );

    blocTest<CommentsCubit, CommentsState>(
      'emits [loading, error] when getComments fails',
      build: () {
        when(() => commentsRepository.getCommentsByPostId(any()))
            .thenThrow(Exception('oops'));
        return commentsCubit;
      },
      act: (cubit) => cubit.getComments(1),
      expect: () => [
        const CommentsState(),
        const CommentsState(status: CommentsStatus.error),
      ],
    );
  });
}
