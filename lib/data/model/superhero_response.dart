import 'package:herome/data/model/superhero_detail_response.dart';

class SuperheroResponse {
  final String response;
  final List<SuperheroDetailResponse>? result;

  SuperheroResponse({required this.response, this.result});

  factory SuperheroResponse.fromJson(Map<String, dynamic> json) {
    List<SuperheroDetailResponse> heroList = [];
    
    final results = json["results"];
    if (results != null && results is List) {
      heroList = results
          .map((hero) => SuperheroDetailResponse.fromJson(hero as Map<String, dynamic>))
          .toList();
    }

    return SuperheroResponse(response: json["response"] ?? "error", result: heroList);
  }
}
