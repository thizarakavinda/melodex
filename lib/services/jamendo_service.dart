import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:melodex/models/song_model.dart';

class JamendoService {
  // Free Jamendo API — register at developer.jamendo.com for your own client_id
  // This uses the public demo client_id for development
  static const String _clientId = '04a32f59';
  static const String _baseUrl = 'https://api.jamendo.com/v3.0';

  // static Future<List<SongModel>> searchSongs(
  //   String query, {
  //   int limit = 20,
  // }) async {
  //   final uri = Uri.parse('$_baseUrl/tracks/').replace(
  //     queryParameters: {
  //       'client_id': _clientId,
  //       'format': 'json',
  //       'limit': limit.toString(),
  //       'search': query,
  //       'include': 'musicinfo',
  //       'audioformat': 'mp32',
  //     },
  //   );

  //   try {
  //     final res = await http.get(uri).timeout(const Duration(seconds: 10));
  //     if (res.statusCode == 200) {
  //       final data = jsonDecode(res.body);
  //       final results = data['results'] as List? ?? [];
  //       return results
  //           .map((t) => SongModel.fromJamendo(t))
  //           .where((s) => s.audioUrl.isNotEmpty)
  //           .toList();
  //     }
  //   } catch (e) {
  //     // ignore
  //   }
  //   return [];
  // }

  // static Future<List<SongModel>> getTrendingByGenre(
  //   String genre, {
  //   int limit = 20,
  // }) async {
  //   final uri = Uri.parse('$_baseUrl/tracks/').replace(
  //     queryParameters: {
  //       'client_id': _clientId,
  //       'format': 'json',
  //       'limit': limit.toString(),
  //       'tags': genre,
  //       'include': 'musicinfo',
  //       'audioformat': 'mp32',
  //       'order': 'popularity_total',
  //     },
  //   );

  //   try {
  //     final res = await http.get(uri).timeout(const Duration(seconds: 10));
  //     if (res.statusCode == 200) {
  //       final data = jsonDecode(res.body);
  //       final results = data['results'] as List? ?? [];
  //       return results
  //           .map((t) => SongModel.fromJamendo(t))
  //           .where((s) => s.audioUrl.isNotEmpty)
  //           .toList();
  //     }
  //   } catch (e) {
  //     // ignore
  //   }
  //   return [];
  // }

  static Future<List<SongModel>> getFeatured({int limit = 20}) async {
    final uri = Uri.parse('$_baseUrl/tracks/').replace(
      queryParameters: {
        'client_id': _clientId,
        'format': 'json',
        'limit': limit.toString(),
        'include': 'musicinfo',
        'audioformat': 'mp32',
        'order': 'popularity_week',
        'featured': '1',
      },
    );

    try {
      final res = await http.get(uri).timeout(const Duration(seconds: 10));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final results = data['results'] as List? ?? [];
        return results
            .map((t) => SongModel.fromJamendo(t))
            .where((s) => s.audioUrl.isNotEmpty)
            .toList();
      }
    } catch (e) {
      // ignore
    }
    return [];
  }
}
