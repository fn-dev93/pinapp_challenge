import 'package:posts_repository/src/exceptions/exceptions.dart';
import 'package:posts_repository/src/interfaces/interfaces.dart';
import 'package:posts_repository/src/models/models.dart';
import 'package:posts_repository/src/services/comments_service.dart';

/// Repository for fetching comments data
///
/// This repository is responsible for fetching comments data from the platform
/// channel service.
class CommentsRepository implements CommentsRepositoryInterface {
  /// Creates a new [CommentsRepository] with the given
  /// [platformChannelService].
  CommentsRepository({
    required PlatformChannelService platformChannelService,
  }) : _platformChannelService = platformChannelService;

  final PlatformChannelService _platformChannelService;

  @override
  Future<List<Comment>> getCommentsByPostId(int postId) async {
    try {
      final jsonList =
          await _platformChannelService.invokeMethodAndDecodeList('comments', {
        'postId': postId,
      });

      return jsonList
          .map((json) => Comment.fromJson(json as Map<String, dynamic>))
          .toList();
    } on PlatformChannelException catch (_) {
      rethrow;
    } on DataParsingException catch (_) {
      rethrow;
    } catch (e) {
      throw DataParsingException('Error parsing comments data', e);
    }
  }
}
