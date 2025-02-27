import 'package:posts_repository/src/models/models.dart';

/// Interface for the comments repository
abstract class CommentsRepositoryInterface {
  /// Fetches all comments for a specific post
  Future<List<Comment>> getCommentsByPostId(int postId);
}
