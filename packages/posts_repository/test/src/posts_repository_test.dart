// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:posts_repository/posts_repository.dart';

void main() {
  group('PostsRepository', () {
    test('can be instantiated', () {
      expect(PostsRepository(), isNotNull);
    });
  });
}
