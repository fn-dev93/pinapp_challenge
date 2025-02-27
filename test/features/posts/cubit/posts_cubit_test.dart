import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinapp_challenge/features/posts/cubit/posts_cubit.dart';
import 'package:posts_repository/posts_repository.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

class FakePost extends Fake implements Post {
  @override
  int get id => 1;
  @override
  int get userId => 1;
  @override
  String get title => 'Test Post';
  @override
  String get body => 'Test Body';

  @override
  bool operator ==(Object other) {
    if (other is FakePost) {
      return id == other.id;
    }
    return false;
  }
}

void main() {
  late PostsCubit postsCubit;
  late MockPostsRepository mockPostsRepository;

  setUp(() {
    mockPostsRepository = MockPostsRepository();
    postsCubit = PostsCubit(postsRepository: mockPostsRepository);
  });

  group('PostsCubit', () {
    final posts = [FakePost()];
    test('initial state is PostsState', () {
      expect(postsCubit.state, const PostsState());
    });

    blocTest<PostsCubit, PostsState>(
      'emits [loading, loaded] when getPosts succeeds',
      build: () {
        when(() => mockPostsRepository.getPosts()).thenAnswer((_) async => []);
        return postsCubit;
      },
      act: (cubit) => cubit.getPosts(),
      expect: () => [
        const PostsState(status: PostsStatus.loading),
        const PostsState(status: PostsStatus.loaded),
      ],
    );

    blocTest<PostsCubit, PostsState>(
      'emits [loading, error] when getPosts fails',
      build: () {
        when(() => mockPostsRepository.getPosts())
            .thenThrow(Exception('error'));
        return postsCubit;
      },
      act: (cubit) => cubit.getPosts(),
      expect: () => [
        const PostsState(status: PostsStatus.loading),
        const PostsState(status: PostsStatus.error),
      ],
    );

    blocTest<PostsCubit, PostsState>(
      'emits [loading, loaded] when getPostById succeeds',
      build: () {
        when(() => mockPostsRepository.getPostById(any<int>()))
            .thenAnswer((_) async => FakePost());
        return postsCubit;
      },
      act: (cubit) => cubit.getPostById(1),
      expect: () => [
        const PostsState(status: PostsStatus.loading),
        PostsState(status: PostsStatus.loaded, posts: [FakePost()]),
      ],
    );

    blocTest<PostsCubit, PostsState>(
      'emits [loading, error] when getPostById fails',
      build: () {
        when(() => mockPostsRepository.getPostById(1))
            .thenThrow(Exception('error'));
        return postsCubit;
      },
      act: (cubit) => cubit.getPostById(1),
      expect: () => [
        const PostsState(status: PostsStatus.loading),
        const PostsState(status: PostsStatus.error),
      ],
    );

    blocTest<PostsCubit, PostsState>(
      'emits [loading, loaded] when getPosts returns posts',
      build: () {
        when(() => mockPostsRepository.getPosts())
            .thenAnswer((_) async => posts);
        return postsCubit;
      },
      act: (cubit) => cubit.getPosts(),
      expect: () => [
        const PostsState(status: PostsStatus.loading),
        PostsState(status: PostsStatus.loaded, posts: posts),
      ],
    );
  });
}
