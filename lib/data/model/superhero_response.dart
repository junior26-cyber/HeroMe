import 'superhero_detail_response.dart';

class SuperheroResponse {
  final List<SuperheroDetailResponse> items;
  SuperheroResponse({required this.items});

  // Factory pour akabab all.json
  factory SuperheroResponse.fromAkababList(List<dynamic> list) {
    final items = list.map((e) => SuperheroDetailResponse.fromAkababJson(e as Map<String, dynamic>)).toList();
    return SuperheroResponse(items: items);
  }
}
