import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:posts_repository/src/exceptions/exceptions.dart';
import 'package:posts_repository/src/interfaces/posts.dart';
import 'package:posts_repository/src/models/models.dart';

/// Implementation of the [PostsRepositoryInterface] that fetches data from the
/// JSONPlaceholder API.
class PostsRepository implements PostsRepositoryInterface {
  /// Creates a new [PostsRepository] with the given [baseUrl] and optional
  /// [httpClient].
  PostsRepository({
    this.baseUrl = 'https://jsonplaceholder.typicode.com',
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// Base URL for the API
  final String baseUrl;
  final http.Client _httpClient;

  @override
  Future<List<Post>> getPosts() async {
    try {
      final response = await _httpClient.get(Uri.parse('$baseUrl/posts'));

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body) as List<dynamic>;
        return jsonList
            .map((json) => Post.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(
          'Failed to load posts',
          statusCode: response.statusCode,
          source: response.body,
        );
      }
    } on http.ClientException catch (e) {
      throw NetworkException('Network error while fetching posts', e);
    } catch (e) {
      debugPrint('Error: $e');
      if (e is ApiException || e is NetworkException) rethrow;
      throw DataParsingException('Error parsing posts data', e);
    }
  }

  @override
  Future<Post> getPostById(int id) async {
    try {
      final response = await _httpClient.get(Uri.parse('$baseUrl/posts/$id'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return Post.fromJson(json);
      } else {
        throw ApiException(
          'Failed to load post with id $id',
          statusCode: response.statusCode,
          source: response.body,
        );
      }
    } on http.ClientException catch (e) {
      throw NetworkException('Network error while fetching post $id', e);
    } catch (e) {
      if (e is ApiException || e is NetworkException) {
        rethrow;
      }
      throw DataParsingException('Error parsing post data', e);
    }
  }

  @override
  Future<List<Post>> getPostsByUserId(int userId) async {
    try {
      final response =
          await _httpClient.get(Uri.parse('$baseUrl/posts?userId=$userId'));

      if (response.statusCode == 200) {
        final jsonList =
            json.decode(response.body) as List<Map<String, dynamic>>;
        return jsonList.map(Post.fromJson).toList();
      } else {
        throw ApiException(
          'Failed to load posts for user $userId',
          statusCode: response.statusCode,
          source: response.body,
        );
      }
    } on http.ClientException catch (e) {
      throw NetworkException(
        'Network error while fetching posts for user $userId',
        e,
      );
    } catch (e) {
      if (e is ApiException || e is NetworkException) {
        rethrow;
      }
      throw DataParsingException(
        'Error parsing posts data for user $userId',
        e,
      );
    }
  }

  /// Cleanup resources
  void dispose() {
    _httpClient.close();
  }
}
