// ignore_for_file: prefer_const_constructors

import 'package:comments_repository/comments_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CommentsRepository', () {
    test('can be instantiated', () {
      expect(CommentsRepository(), isNotNull);
    });
  });
}
