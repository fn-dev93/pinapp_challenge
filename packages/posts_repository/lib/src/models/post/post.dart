import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed

/// The Post model is an immutable class that uses the freezed package to
/// generate the necessary boilerplate code for the class.
/// The class is annotated with @freezed, which generates the necessary
/// code to make the class immutable and to generate the necessary
/// serialization code.
class Post with _$Post {
  /// The factory constructor for the Post class is annotated with @freezed,
  const factory Post({
    required int userId,
    required int id,
    required String title,
    required String body,
    @Default('') String? email,
  }) = _Post;
  const Post._();

  /// A necessary factory constructor for creating a new Post instance
  /// from a map. We pass the map to the generated _$PostFromJson constructor.
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
