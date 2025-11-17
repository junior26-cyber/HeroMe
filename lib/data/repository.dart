import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:herome/data/model/superhero_response.dart';
import 'package:http/http.dart' as http;

class Repository {
  // API GitHub akabab/superhero-api - retourne tous les héros
  static const String githubApiUrl =
      'https://raw.githubusercontent.com/akabab/superhero-api/master/api/all.json';

  Future<SuperheroResponse?> fetchSuperHero(String name) async {
    Uri requestUri;

    // Sur le web, utiliser un proxy CORS pour éviter les blocages
    if (kIsWeb) {
      final proxy = 'https://api.allorigins.win/raw?url=${Uri.encodeComponent(githubApiUrl)}';
      requestUri = Uri.parse(proxy);
    } else {
      requestUri = Uri.parse(githubApiUrl);
    }

    try {
      final response = await http.get(requestUri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decodeJson = jsonDecode(response.body);

        // L'API retourne directement une liste de héros
        final allHeroes = decodeJson is List ? decodeJson : decodeJson['results'] ?? [];

        // Filtrer les héros par nom (case-insensitive)
        final filtered = allHeroes.where((hero) {
          final heroName = (hero['name'] ?? '').toString().toLowerCase();
          return heroName.contains(name.toLowerCase());
        }).toList();

        // Formater la réponse au format attendu par SuperheroResponse
        final formattedResponse = {
          'response': 'success',
          'results': filtered,
        };

        return SuperheroResponse.fromJson(formattedResponse);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
