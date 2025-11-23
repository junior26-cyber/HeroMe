# HeroMe - Application Flutter de Recherche de Superhéros

Une application Flutter moderne et élégante pour découvrir et explorer des superhéros du monde entier. Recherchez vos héros préférés, consultez leurs statistiques de combat détaillées et admirez leurs images en haute définition.

**Plateforme :** Android | iOS | Web  
**Langage :** Dart / Flutter  
**API :** Superhero API  

---

##  Fonctionnalités

###  Recherche Intelligente
- Recherche en temps réel de superhéros par nom
- Résultats instantanés avec affichage en cartes élégantes
- États vides et d'erreur bien gérés avec icônes

###  Statistiques Détaillées
Visualisez 6 statistiques de combat avec barres colorées :
- **Puissance** (Rouge)
- **Intelligence** (Bleu)
- **Force** (Orange)
- **Vitesse** (Vert)
- **Durabilité** (Violet)
- **Combat** (Indigo)

###  Design Moderne
- Gradient AppBar bleu → violet
- Cartes avec animations Hero
- Interface intuitive et fluide
- Totalement en français

###  Multi-plateforme
-  Android (APK)
-  iOS (IPA)
-  Web (Chrome)

---

##  Installation & Utilisation

### Prérequis
- Flutter 3.5.1+
- Dart 3.5.1+

### Cloner le projet
```bash
git clone https://github.com/votre-username/herome.git
cd herome
```

### Installer les dépendances
```bash
flutter pub get
```

### Lancer l'application

**Android :**
```bash
flutter run -d android
```

**iOS :**
```bash
flutter run -d ios
```

**Web :**
```bash
flutter run -d chrome
```

### Générer l'APK Release
```bash
flutter build apk --release
```
L'APK sera disponible à : `build/app/outputs/flutter-apk/app-release.apk`

---

## Structure du Projet

```
lib/
├── main.dart                              # Point d'entrée
├── screens/
│   ├── superhero_search_screen.dart      # Écran de recherche
│   └── superhero_detail_screen.dart      # Détails du héros
└── data/
    ├── repository.dart                   # Requêtes API
    └── model/
        ├── superhero_response.dart       # Wrapper de réponse
        └── superhero_detail_response.dart # Modèle du héros
```

---

## 📦 Dépendances

```yaml
dependencies:
  flutter: sdk
  http: ^1.4.0

dev_dependencies:
  flutter_lints: ^4.0.0
  flutter_launcher_icons: ^0.10.0
```

---

## 🔌 API

L'application utilise la [Superhero API](https://superheroapi.com/) :

**Endpoint :**
```
GET https://superheroapi.com/api/{API_KEY}/search/{superhero_name}
```

**Réponse exemple :**
```json
{
  "response": "success",
  "results": [
    {
      "id": "1",
      "name": "Superman",
      "image": { "url": "https://..." },
      "biography": { "full-name": "Clark Kent" },
      "powerstats": {
        "intelligence": "81",
        "strength": "100",
        "speed": "100",
        "durability": "100",
        "power": "100",
        "combat": "85"
      }
    }
  ]
}
```

---

##  Support Web

Pour éviter les erreurs **CORS** sur le web, l'application utilise un proxy public :
- **Proxy :** `api.allorigins.win`
- **Détecte automatiquement :** `kIsWeb` pour basculer le mode

---

##  Héros à Tester

Essayez ces noms pour voir l'app en action :
- Superman
- Batman
- Iron Man
- Spider-Man
- Wonder Woman
- The Flash
- Aquaman

---

## Captures d'Écran

| Recherche | Détails |
|-----------|---------|
| <img src="screenshots/search.png" width="250" alt="Écran de recherche"> | <img src="screenshots/detail.png" width="250" alt="Écran de détails"> |

---

##  Customization

### Changer la couleur du gradient
Modifiez dans `superhero_search_screen.dart` et `superhero_detail_screen.dart` :
```dart
LinearGradient(
  colors: [Colors.blue.shade700, Colors.purple.shade600],
)
```

### Changer l'icône
Remplacez `assets/icon.png` et exécutez :
```bash
flutter pub run flutter_launcher_icons:main
```

---

##  Troubleshooting

### Les images ne s'affichent pas ?
- Vérifiez votre connexion Internet
- L'API peut retourner une URL vide pour certains héros
- L'application affiche une icône d'erreur en cas de problème

### Erreur CORS sur le web ?
- Le proxy `api.allorigins.win` est utilisé automatiquement
- Si le proxy est down, essayez un autre service : `cors-anywhere.herokuapp.com`

### Erreurs de build Android ?
```bash
flutter clean
flutter pub get
flutter build apk --release
```

---

##  Distribuer l'Appli

### Android
```bash
# Générer l'APK
flutter build apk --release

# Ou l'App Bundle pour Google Play
flutter build appbundle --release
```

### iOS (nécessite macOS)
```bash
flutter build ios --release
```

---

##  Licence

MIT License - Libre d'utilisation

---

## Contribuer

Les contributions sont les bienvenues ! 
1. Fork le projet
2. Créez une branche (`git checkout -b feature/amazing-feature`)
3. Commit vos changements (`git commit -m 'Add amazing feature'`)
4. Push la branche (`git push origin feature/amazing-feature`)
5. Ouvrez une Pull Request

---





---


