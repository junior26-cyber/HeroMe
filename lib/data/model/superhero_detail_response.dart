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
    // Support pour les deux formats d'API :
    // 1. superheroapi.com : { image: { url: "..." }, biography: { "full-name": "..." } }
    // 2. akabab/superhero-api : { images: { md: "..." }, biography: "..." }

    // Récupération sécurisée de l'image (format superheroapi.com)
    var imageUrl = json["image"]?["url"]?.toString() ?? "";

    // Fallback: format akabab (images.md)
    if (imageUrl.isEmpty) {
      imageUrl = json["images"]?["md"]?.toString() ?? "";
    }

    // Fallback: format akabab (thumbnail)
    if (imageUrl.isEmpty) {
      imageUrl = json["images"]?["sm"]?.toString() ?? "";
    }

    // Récupération du nom réel
    var realName = json["biography"]?["full-name"]?.toString() ?? "";

    // Fallback: format akabab
    if (realName.isEmpty || realName == "N/A") {
      realName = json["biography"]?.toString() ?? "N/A";
      // Extraire seulement le texte pertinent si c'est une description
      if (realName.contains(" is ")) {
        realName = realName.split(" is ")[0];
      }
    }

    return SuperheroDetailResponse(
      id: (json["id"] ?? json["slug"] ?? "")?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      url: imageUrl,
      realName: realName.isEmpty ? "N/A" : realName,
      powerStatsResponse:
          PowerStatsResponse.fromJson(json["powerstats"] ?? json["stats"] ?? {}),
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
    // Support pour les deux formats :
    // superheroapi.com : { intelligence: "94", strength: "100", ... }
    // akabab : { intelligence: 94, strength: 100, ... } (nombres, pas chaînes)
    
    return PowerStatsResponse(
      intelligence: (json["intelligence"] ?? 0).toString(),
      strength: (json["strength"] ?? 0).toString(),
      speed: (json["speed"] ?? 0).toString(),
      durability: (json["durability"] ?? 0).toString(),
      power: (json["power"] ?? 0).toString(),
      combat: (json["combat"] ?? 0).toString(),
    );
  }
}
