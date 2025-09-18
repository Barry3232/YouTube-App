import 'package:flutter/foundation.dart';

class VideoHelper {
  /// Check if the video URL is valid and supported
  static bool isValidVideoUrl(String url) {
    if (url.isEmpty) return false;
    
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    
    // Check for common video formats
    final supportedFormats = ['.mp4', '.webm', '.mov', '.avi', '.mkv'];
    final urlLower = url.toLowerCase();
    
    return supportedFormats.any((format) => urlLower.contains(format));
  }

  /// Get user-friendly error message for video errors
  static String getErrorMessage(dynamic error) {
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('mediacodec')) {
      return 'Video codec not supported. Try a different video format.';
    } else if (errorString.contains('network')) {
      return 'Network error. Check your internet connection.';
    } else if (errorString.contains('timeout')) {
      return 'Video loading timeout. Please try again.';
    } else if (errorString.contains('format')) {
      return 'Video format not supported.';
    } else if (errorString.contains('permission')) {
      return 'Permission denied. Check app permissions.';
    } else {
      return 'Unable to play video. Please try again.';
    }
  }

  /// Check if running on Android and provide specific guidance
  static String getPlatformSpecificMessage() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'Android detected: Some video formats may not be supported due to codec limitations.';
    }
    return '';
  }

  /// Validate video URL and provide suggestions
  static Map<String, dynamic> validateVideoUrl(String url) {
    final result = {
      'isValid': false,
      'suggestions': <String>[],
      'error': '',
    };

    if (url.isEmpty) {
      result['error'] = 'Video URL is empty';
      return result;
    }

    final uri = Uri.tryParse(url);
    if (uri == null) {
      result['error'] = 'Invalid URL format';
      (result['suggestions'] as List<String>).add('Check if the URL is properly formatted');
      return result;
    }

    if (!uri.hasScheme || (!uri.scheme.startsWith('http'))) {
      result['error'] = 'URL must start with http:// or https://';
      (result['suggestions'] as List<String>).add('Use a valid HTTP/HTTPS URL');
      return result;
    }

    // Check for common video formats
    final supportedFormats = ['.mp4', '.webm', '.mov', '.avi', '.mkv'];
    final urlLower = url.toLowerCase();
    final hasSupportedFormat = supportedFormats.any((format) => urlLower.contains(format));

    if (!hasSupportedFormat) {
      result['error'] = 'Video format may not be supported';
      (result['suggestions'] as List<String>).addAll([
        'Try using MP4 format for better compatibility',
        'Ensure the video uses H.264 codec',
        'Check if the video file is accessible'
      ]);
    }

    result['isValid'] = true;
    return result;
  }
}
