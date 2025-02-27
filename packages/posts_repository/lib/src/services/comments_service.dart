import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:posts_repository/src/exceptions/exceptions.dart';

/// Service for invoking methods on the platform channel
///
/// This service is responsible for invoking methods on the platform channel
/// and handling the results.
class PlatformChannelService {
  /// Creates a new [PlatformChannelService] with the given [channelName].
  PlatformChannelService({
    required String channelName,
  }) : _channel = MethodChannel(channelName);

  final MethodChannel _channel;

  /// Invokes a method on the platform channel and returns the
  /// result as a JSON string
  Future<String> invokeMethod(
    String method,
    Map<String, dynamic> arguments,
  ) async {
    try {
      final result = await _channel.invokeMethod<String>(method, arguments);

      if (result == null) {
        throw PlatformChannelException('Null result from platform channel');
      }

      return result;
    } on PlatformException catch (e) {
      throw PlatformChannelException(
        'Platform exception: ${e.message}',
        {'code': e.code, 'details': e.details},
      );
    } catch (e) {
      throw PlatformChannelException('Failed to invoke platform method', e);
    }
  }

  /// Invokes a method on the platform channel and decodes the result as a
  /// List of JSON objects
  Future<List<dynamic>> invokeMethodAndDecodeList(
    String method,
    Map<String, dynamic> arguments,
  ) async {
    final jsonString = await invokeMethod(method, arguments);

    try {
      final decodedList = json.decode(jsonString) as List<dynamic>;
      return decodedList;
    } catch (e) {
      throw DataParsingException('Failed to decode JSON list', e);
    }
  }

  /// Invokes a method on the platform channel and decodes the result as a
  /// single JSON object
  Future<Map<String, dynamic>> invokeMethodAndDecodeObject(
    String method,
    Map<String, dynamic> arguments,
  ) async {
    final jsonString = await invokeMethod(method, arguments);

    try {
      final decodedObject = json.decode(jsonString) as Map<String, dynamic>;
      return decodedObject;
    } catch (e) {
      throw DataParsingException('Failed to decode JSON object', e);
    }
  }
}
