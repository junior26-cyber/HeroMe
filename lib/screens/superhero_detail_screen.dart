import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:herome/data/model/superhero_detail_response.dart';

class SuperheroDetailScreen extends StatelessWidget {
  final SuperheroDetailResponse hero;
  const SuperheroDetailScreen({super.key, required this.hero});

  Widget _statLine(String label, int value, Color color) {
    final percent = (value.clamp(0, 100)) / 100;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(label)),
          Expanded(
            child: LinearPercentIndicator(
              lineHeight: 12,
              percent: percent,
              progressColor: color,
              backgroundColor: color.withAlpha((0.2 * 255).round()),
            ),
          ),
          const SizedBox(width: 8),
          Text('$value'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(hero.name ?? 'Détail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: hero.imageUrl ?? '',
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, __) => const SizedBox(height: 260, child: Center(child: CircularProgressIndicator())),
              errorWidget: (_, __, ___) => SizedBox(
                height: 260,
                width: double.infinity,
                child: Image.asset('assets/default_hero.png', fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 12),
            AutoSizeText(hero.name ?? '', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _statLine('Intelligence', hero.intelligence ?? 0, Colors.blue),
                    _statLine('Force', hero.strength ?? 0, Colors.red),
                    _statLine('Vitesse', hero.speed ?? 0, Colors.green),
                    _statLine('Durabilité', hero.durability ?? 0, Colors.purple),
                    _statLine('Pouvoir', hero.power ?? 0, Colors.orange),
                    _statLine('Combat', hero.combat ?? 0, Colors.indigo),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            ExpandablePanel(
              header: const Text('Biographie', style: TextStyle(fontWeight: FontWeight.bold)),
              collapsed: Text(hero.fullName ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nom complet: ${hero.fullName ?? 'N/A'}'),
                  Text('Alias: ${(hero.aliases ?? []).join(', ')}'),
                  Text('Lieu de naissance: ${hero.placeOfBirth ?? 'N/A'}'),
                  Text('Taille: ${(hero.height ?? []).join(', ')}'),
                  Text('Poids: ${(hero.weight ?? []).join(', ')}'),
                  Text('Yeux: ${hero.eyeColor ?? 'N/A'}'),
                  Text('Cheveux: ${hero.hairColor ?? 'N/A'}'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ExpandablePanel(
              header: const Text('Connexions', style: TextStyle(fontWeight: FontWeight.bold)),
              collapsed: Text(hero.groupAffiliation ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Affiliations: ${hero.groupAffiliation ?? 'N/A'}'),
                  Text('Relatifs: ${hero.relatives ?? 'N/A'}'),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
