class SuperheroDetailResponse {
  final String id;
  final String name;
  final String url; // L'URL de l'image
  final String realName;
  final PowerStatsResponse powerStatsResponse;

  SuperheroDetailResponse({
    required this.id,
    required this.name,
    required this.url,
    required this.realName,
    required this.powerStatsResponse,
  });

  factory SuperheroDetailResponse.fromJson(Map<String, dynamic> json) {
    // Récupération sécurisée de l'image
    final imageUrl = json["image"]?["url"] ?? "";

    return SuperheroDetailResponse(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      url: imageUrl,
      realName: json["biography"]?["full-name"]?.toString() ?? "N/A",
      powerStatsResponse:
          PowerStatsResponse.fromJson(json["powerstats"] ?? {}),
    );
  }
}

class PowerStatsResponse {
  final String intelligence;
  final String strength;
  final String speed;
  final String durability;
  final String power;
  final String combat;

  PowerStatsResponse({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
  });

  factory PowerStatsResponse.fromJson(Map<String, dynamic> json) {
    return PowerStatsResponse(
      intelligence: json["intelligence"]?.toString() ?? "0",
      strength: json["strength"]?.toString() ?? "0",
      speed: json["speed"]?.toString() ?? "0",
      durability: json["durability"]?.toString() ?? "0",
      power: json["power"]?.toString() ?? "0",
      combat: json["combat"]?.toString() ?? "0",
    );
  }
}
