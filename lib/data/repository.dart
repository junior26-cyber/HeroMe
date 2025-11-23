import 'dart:convert';
// import 'package:flutter/foundation.dart' show kIsWeb; // inutilisé, commenté
import 'package:herome/data/model/superhero_response.dart';
import 'package:http/http.dart' as http;

class Repository {
  static const String githubApiUrl =
      'https://raw.githubusercontent.com/akabab/superhero-api/master/api/all.json';

  // Récupère la liste complète et filtre côté client sur 'name'
  Future<SuperheroResponse?> fetchSuperHero(String name) async {
    try {
      final uri = Uri.parse(githubApiUrl);
      final res = await http.get(uri);
      if (res.statusCode != 200) return null;
      final List<dynamic> list = json.decode(res.body) as List<dynamic>;
      final filtered = list.where((e) {
        final n = (e['name'] ?? '').toString().toLowerCase();
        return n.contains(name.toLowerCase());
      }).toList();
      return SuperheroResponse.fromAkababList(filtered);
    } catch (e) {
      return null;
    }
  }

  // Récupère tout (utile pour suggestions / cache local)
  Future<List<Map<String, dynamic>>?> fetchAllRaw() async {
    try {
      final res = await http.get(Uri.parse(githubApiUrl));
      if (res.statusCode != 200) return null;
      final List<dynamic> list = json.decode(res.body) as List<dynamic>;
      return List<Map<String, dynamic>>.from(list.cast<Map>());
    } catch (e) {
      return null;
    }
  }
}
