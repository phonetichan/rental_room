import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageKitHelper {
  // ImageKit Account Configurations
  static const String _imageKitEndpoint = "https://ik.imagekit.io/vzgbgc1cr";
  static const String _publicKey = "public_n+IkzacE0sr7YQzUTHobU7reH68="; // e.g., public_xxxxxx
  static const String _privateKey = "private_WKSIqu7lxdpOFFM58SoaokJapbI="; // e.g., private_xxxxxx

  /// 1. Uploads local images directly from Flutter using ImageKit's Upload API
  static Future<List<String>> uploadImages({
    required List<XFile> localFiles,
    required String ownerId,
    required String roomId,
  }) async {
    final List<String> uploadedUrls = [];
    // Define target folder (e.g., RentalApp/rooms/<roomId>)
    String rawFolder = "/RentalApp/rooms/$roomId";

    // Sanitize: Ensure leading slash and replace spaces with underscores
    String sanitizedFolder = rawFolder.replaceAll(' ', '_');
    if (!sanitizedFolder.startsWith('/')) {
      sanitizedFolder = '/$sanitizedFolder';
    }
    // Encode privateKey for standard HTTP Basic Auth header (privateKey as username, empty password)
    final String basicAuthHeader = 'Basic ${base64Encode(utf8.encode('$_privateKey:'))}';

    if (localFiles.isEmpty) {
      debugPrint('⚠️ [ImageKitHelper] No files provided for upload.');
      return [];
    }

    for (int i = 0; i < localFiles.length; i++) {
      final XFile file = localFiles[i];

      try {
        final uri = Uri.parse('https://upload.imagekit.io/api/v1/files/upload');
        final request = http.MultipartRequest('POST', uri)
          ..headers['Authorization'] = basicAuthHeader
          ..fields['fileName'] = file.name
          ..fields['folder'] = sanitizedFolder
          ..fields['useUniqueFileName'] = 'true'
          ..fields['publicKey'] = _publicKey
          ..files.add(await http.MultipartFile.fromPath('file', file.path));

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);
          final String cdnUrl = data['url'] as String;
          uploadedUrls.add(cdnUrl);
          debugPrint('✅ [ImageKitHelper] Uploaded: $cdnUrl');
        } else {
          debugPrint('❌ [ImageKitHelper] Upload Error (${response.statusCode}): ${response.body}');
          throw Exception('ImageKit upload failed: ${response.body}');
        }
      } catch (e) {
        debugPrint('❌ [ImageKitHelper] Exception uploading file ${file.name}: $e');
        rethrow;
      }
    }

    return uploadedUrls;
  }

  /// 2. Generates transformed ImageKit URLs with automatic sanitization
  static String getUrl(String filePath, {int width = 600, int quality = 80}) {
    final String trimmed = filePath.trim();

    // Handle empty or null-like input
    if (trimmed.isEmpty) {
      final fallback = "$_imageKitEndpoint/default-image.jpg?tr=w-$width,q-$quality,f-auto";
      debugPrint('⚠️ [ImageKitHelper] Empty path provided. Returning fallback: $fallback');
      return fallback;
    }

    // Handle complete absolute URLs
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      if (trimmed.contains('?tr=')) return trimmed; // Already transformed
      final separator = trimmed.contains('?') ? '&' : '?';
      return "$trimmed${separator}tr=w-$width,q-$quality,f-auto";
    }

    // Clean leading slashes
    String cleanedPath = trimmed;
    while (cleanedPath.startsWith('/')) {
      cleanedPath = cleanedPath.substring(1);
    }

    // Return final transformed CDN URL
    return "$_imageKitEndpoint/$cleanedPath?tr=w-$width,q-$quality,f-auto";
  }

  /// Uploads or updates a user profile image on ImageKit.
  static Future<String> uploadProfileImage({
    required XFile localFile,
    required String userId,
  }) async {
    final String folder = "/RentalApp/users/$userId";
    final String basicAuthHeader =
        'Basic ${base64Encode(utf8.encode('$_privateKey:'))}';

    try {
      final uri = Uri.parse('https://upload.imagekit.io/api/v1/files/upload');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = basicAuthHeader
        ..fields['fileName'] = 'profile_${DateTime.now().millisecondsSinceEpoch}'
        ..fields['folder'] = folder
        ..fields['useUniqueFileName'] = 'true'
        ..fields['publicKey'] = _publicKey
        ..files.add(await http.MultipartFile.fromPath('file', localFile.path));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String cdnUrl = data['url'] as String;
        debugPrint('✅ [ImageKitHelper] Profile image uploaded: $cdnUrl');
        return cdnUrl;
      } else {
        debugPrint('❌ [ImageKitHelper] Upload Error (${response.statusCode}): ${response.body}');
        throw Exception('ImageKit upload failed: ${response.body}');
      }
    } catch (e) {
      debugPrint('❌ [ImageKitHelper] Exception uploading profile image: $e');
      rethrow;
    }
  }
}