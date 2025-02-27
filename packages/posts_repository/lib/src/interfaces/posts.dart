import 'package:posts_repository/src/models/models.dart';

/// Interface for the PostsRepository
///
/// This interface defines the methods that the PostsRepository must implement
/// in order to be used by the application.
abstract class PostsRepositoryInterface {
  /// Fetches all posts from the API
  Future<List<Post>> getPosts();

  /// Fetches a single post by ID
  Future<Post> getPostById(int id);

  /// Fetches posts by user ID
  Future<List<Post>> getPostsByUserId(int userId);
}
