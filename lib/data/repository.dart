import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:herome/data/model/superhero_response.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<SuperheroResponse?> fetchSuperHero(String name) async {
    final apiUrl = 'https://superheroapi.com/api/f21bbed3e10a6c9851b4ea07106e5fff/search/$name';

    // Sur le web, beaucoup d'APIs bloquent les requêtes CORS. Utiliser un proxy public
    // pour le développement afin d'éviter l'erreur "Failed to fetch" dans le navigateur.
    // Remarque: pour la production, héberger un simple proxy côté serveur.
    Uri requestUri;
    if (kIsWeb) {
      final proxy = 'https://api.allorigins.win/raw?url=${Uri.encodeComponent(apiUrl)}';
      requestUri = Uri.parse(proxy);
    } else {
      requestUri = Uri.parse(apiUrl);
    }

    final response = await http.get(requestUri);

    if (response.statusCode == 200) {
      final decodeJson = jsonDecode(response.body);
      return SuperheroResponse.fromJson(decodeJson);
    } else {
      return null;
    }
  }
}
