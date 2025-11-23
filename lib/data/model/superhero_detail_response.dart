class SuperheroDetailResponse {
  final int? id;
  final String? name;
  final String? imageUrl;

  // biography
  final String? fullName;
  final List<String>? aliases;
  final String? placeOfBirth;

  // appearance
  final List<String>? height;
  final List<String>? weight;
  final String? eyeColor;
  final String? hairColor;

  // powerstats
  final int? intelligence;
  final int? strength;
  final int? speed;
  final int? durability;
  final int? power;
  final int? combat;

  // connections
  final String? groupAffiliation;
  final String? relatives;

  SuperheroDetailResponse({
    this.id,
    this.name,
    this.imageUrl,
    this.fullName,
    this.aliases,
    this.placeOfBirth,
    this.height,
    this.weight,
    this.eyeColor,
    this.hairColor,
    this.intelligence,
    this.strength,
    this.speed,
    this.durability,
    this.power,
    this.combat,
    this.groupAffiliation,
    this.relatives,
  });

  factory SuperheroDetailResponse.fromAkababJson(Map<String, dynamic> json) {
    final image = json['images'];
    String? imgUrl;
    if (image is Map<String, dynamic>) {
      imgUrl = image['md'] ?? image['lg'] ?? image['sm'] ?? image['xs'];
    }
    final power = json['powerstats'] ?? {};
    final bio = json['biography'] ?? {};
    final appearance = json['appearance'] ?? {};
    final connections = json['connections'] ?? {};

    int parseInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      return int.tryParse(v.toString()) ?? 0;
    }

    return SuperheroDetailResponse(
      id: (json['id'] is int) ? json['id'] as int : int.tryParse(json['id']?.toString() ?? ''),
      name: json['name']?.toString(),
      imageUrl: imgUrl,
      fullName: bio['fullName']?.toString() ?? bio['full-name']?.toString(),
      aliases: (bio['aliases'] is List) ? List<String>.from(bio['aliases'].map((e) => e.toString())) : null,
      placeOfBirth: bio['placeOfBirth']?.toString() ?? bio['place-of-birth']?.toString(),
      height: (appearance['height'] is List) ? List<String>.from(appearance['height'].map((e) => e.toString())) : null,
      weight: (appearance['weight'] is List) ? List<String>.from(appearance['weight'].map((e) => e.toString())) : null,
      eyeColor: appearance['eyeColor']?.toString(),
      hairColor: appearance['hairColor']?.toString(),
      intelligence: parseInt(power['intelligence']),
      strength: parseInt(power['strength']),
      speed: parseInt(power['speed']),
      durability: parseInt(power['durability']),
      power: parseInt(power['power']),
      combat: parseInt(power['combat']),
      groupAffiliation: connections['groupAffiliation']?.toString(),
      relatives: connections['relatives']?.toString(),
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
