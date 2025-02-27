import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:posts_repository/src/exceptions/exceptions.dart';
import 'package:posts_repository/src/interfaces/interfaces.dart';
import 'package:posts_repository/src/models/models.dart';

/// Repository for fetching comments data
///
/// This repository is responsible for fetching comments data from the platform
/// channel service.
class CommentsRepository implements CommentsRepositoryInterface {
  /// Creates a new [CommentsRepository].
  CommentsRepository({
    this.baseUrl = 'https://jsonplaceholder.typicode.com',
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// Base URL for the API
  final String baseUrl;
  final http.Client _httpClient;

  @override
  Future<List<Comment>> getCommentsByPostId(int postId) async {
    try {
      final response =
          await _httpClient.get(Uri.parse('$baseUrl/posts/$postId/comments'));

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body) as List<dynamic>;
        return jsonList
            .map((json) => Comment.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(
          'Failed to load comments for post with id $postId',
          statusCode: response.statusCode,
          source: response.body,
        );
      }
    } on http.ClientException catch (e) {
      throw NetworkException('Network error while fetching comments', e);
    } catch (e) {
      if (e is ApiException || e is NetworkException) rethrow;
      throw DataParsingException('Error parsing comments data', e);
    }
  }
}
