import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed

/// The Comment model is an immutable class that uses the freezed package to
/// generate the necessary boilerplate code for the class.
/// The class is annotated with @freezed, which generates the necessary
/// code to make the class immutable and to generate the necessary
/// serialization code.
class Comment with _$Comment {
  /// The factory constructor for the Comment class is annotated with @freezed,
  const factory Comment({
    required int postId,
    required int id,
    required String name,
    required String email,
    required String body,
  }) = _Comment;

  /// A private constructor
  const Comment._();

  /// A necessary factory constructor for creating a new Comment instance
  /// from a map. We pass the map to the generated _$CommentFromJson
  /// constructor.
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
