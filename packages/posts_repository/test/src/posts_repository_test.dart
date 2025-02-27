// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:posts_repository/posts_repository.dart';
import 'package:posts_repository/src/exceptions/exceptions.dart';

class MockHttpClient extends Mock implements http.Client {}

class UriFake extends Fake implements Uri {}

void main() {
  setUpAll(() {
    registerFallbackValue(UriFake());
  });

  group('PostsRepository', () {
    late http.Client httpClient;
    late PostsRepository postsRepository;

    setUp(() {
      httpClient = MockHttpClient();
      postsRepository = PostsRepository(httpClient: httpClient);
    });

    test('can be instantiated', () {
      expect(PostsRepository(), isNotNull);
    });

    group('getPosts', () {
      test('returns list of posts if the http call completes successfully',
          () async {
        final response = jsonEncode([
          {
            'userId': 1,
            'id': 1,
            'title': 'Test Post',
            'body': 'This is a test post',
          },
        ]);

        when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response(response, 200),
        );

        final posts = await postsRepository.getPosts();
        expect(posts, isA<List<Post>>());
        expect(posts.length, 1);
        expect(posts.first.title, 'Test Post');
      });

      test('throws ApiException if the http call completes with an error',
          () async {
        when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        expect(postsRepository.getPosts(), throwsA(isA<ApiException>()));
      });
    });

    group('getPostById', () {
      test('returns a post if the http call completes successfully', () async {
        final response = jsonEncode({
          'userId': 1,
          'id': 1,
          'title': 'Test Post',
          'body': 'This is a test post',
        });

        when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response(response, 200),
        );

        final post = await postsRepository.getPostById(1);
        expect(post, isA<Post>());
        expect(post.title, 'Test Post');
      });

      test('throws ApiException if the http call completes with an error',
          () async {
        when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        expect(postsRepository.getPostById(1), throwsA(isA<ApiException>()));
      });
    });

    group('getPostsByUserId', () {
      test('returns list of posts if the http call completes successfully',
          () async {
        final response = jsonEncode([
          {
            'userId': 1,
            'id': 1,
            'title': 'Test Post',
            'body': 'This is a test post',
          },
        ]);

        when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response(response, 200),
        );

        final posts = await postsRepository.getPostsByUserId(1);
        expect(posts, isA<List<Post>>());
        expect(posts.length, 1);
        expect(posts.first.title, 'Test Post');
      });

      test('throws ApiException if the http call completes with an error',
          () async {
        when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        expect(
          postsRepository.getPostsByUserId(1),
          throwsA(isA<ApiException>()),
        );
      });
    });
  });
}
