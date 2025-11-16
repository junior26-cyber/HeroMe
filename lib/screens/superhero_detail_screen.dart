import 'package:flutter/material.dart';
import 'package:herome/data/model/superhero_detail_response.dart';

class SuperheroDetailScreen extends StatelessWidget {
  final SuperheroDetailResponse superHero;

  const SuperheroDetailScreen({super.key, required this.superHero});

  @override
  Widget build(BuildContext context) {
    double safeParse(String value) {
      final parsed = double.tryParse(value);
      return parsed ?? 0.0;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(superHero.name),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade700, Colors.purple.shade600],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //  IMAGE DU HÉROS 
            Hero(
              tag: superHero.id,
              child: superHero.url.isNotEmpty
                  ? Image.network(
                      superHero.url,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 300,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 300,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.broken_image,
                                  size: 80, color: Colors.grey.shade400),
                              const SizedBox(height: 8),
                              const Text("Image non disponible",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        );
                      },
                    )
                  : Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image,
                              size: 80, color: Colors.grey.shade400),
                          const SizedBox(height: 8),
                          const Text("Image non disponible",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
            ),

            //  DETAILS DU HÉROS 

            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    superHero.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    superHero.realName,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    "Capacités",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildStatBar(
                      "Puissance",
                      safeParse(superHero.powerStatsResponse.power),
                      Colors.red),
                  const SizedBox(height: 12),
                  _buildStatBar(
                      "Intelligence",
                      safeParse(superHero.powerStatsResponse.intelligence),
                      Colors.blue),
                  const SizedBox(height: 12),
                  _buildStatBar(
                      "Force",
                      safeParse(superHero.powerStatsResponse.strength),
                      Colors.orange),
                  const SizedBox(height: 12),
                  _buildStatBar(
                      "Vitesse",
                      safeParse(superHero.powerStatsResponse.speed),
                      Colors.green),
                  const SizedBox(height: 12),
                  _buildStatBar(
                      "Durabilité",
                      safeParse(superHero.powerStatsResponse.durability),
                      Colors.purple),
                  const SizedBox(height: 12),
                  _buildStatBar(
                      "Combat",
                      safeParse(superHero.powerStatsResponse.combat),
                      Colors.indigo),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------- BARRE DE STATISTIQUES -----------

  Widget _buildStatBar(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(
              value.toInt().toString(),
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value / 100,
            minHeight: 8,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
