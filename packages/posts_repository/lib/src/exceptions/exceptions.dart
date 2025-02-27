/// Base class for all repository exceptions
///
/// This class is not meant to be instantiated directly.
abstract class RepositoryException implements Exception {
  /// Creates a new [RepositoryException] with the given [message] and optional
  /// [source].
  RepositoryException(this.message, [this.source]);

  /// The exception message
  final String message;

  /// The source of the exception
  final dynamic source;

  @override
  String toString() {
    if (source != null) {
      return '$runtimeType: $message (Source: $source)';
    }
    return '$runtimeType: $message';
  }
}

/// Exception thrown when the API returns an error
class ApiException extends RepositoryException {
  /// Creates a new [ApiException] with the given [message], [statusCode] and
  /// optional [source].
  ApiException(String message, {this.statusCode, dynamic source})
      : super(message, source);

  /// The status code of the response
  final int? statusCode;

  @override
  String toString() {
    if (statusCode != null) {
      final runtimeType = this.runtimeType;
      return '$runtimeType: $message (Status Code: $statusCode,'
          ' Source: $source)';
    }
    return super.toString();
  }
}

/// Exception thrown when there is a network error
class NetworkException extends RepositoryException {
  /// Creates a new [NetworkException] with the given [message] and optional
  /// [source].
  NetworkException(super.message, [super.source]);
}

/// Exception thrown when there is an error parsing data
class DataParsingException extends RepositoryException {
  /// Creates a new [DataParsingException] with the given [message] and optional
  /// [source].
  DataParsingException(super.message, [super.source]);
}

/// Exception thrown when a platform channel operation fails
class PlatformChannelException extends RepositoryException {
  /// Creates a new [PlatformChannelException] with the given [message] and
  /// optional [source].
  PlatformChannelException(super.message, [super.source]);
}
