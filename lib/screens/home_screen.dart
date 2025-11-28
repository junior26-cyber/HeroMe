import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:herome/screens/superhero_search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _anim;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _scale = Tween<double>(begin: 0.92, end: 1.0).animate(CurvedAnimation(parent: _anim, curve: Curves.easeOutBack));
    _anim.forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryA = theme.colorScheme.primary;
    final primaryB = theme.colorScheme.primary.withAlpha((0.85 * 255).round());
    return Scaffold(
      // Gradient background pour un rendu moderne
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryA.withAlpha((0.08 * 255).round()), primaryB.withAlpha((0.04 * 255).round()), theme.colorScheme.surface],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Text(
                  'HeroMe',
                  style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Bienvenue dans l’univers des Héros...',
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withAlpha((0.8 * 255).round())),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Center(
                    child: ScaleTransition(
                      scale: _scale,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            // Image principale
                            Semantics(
                              label: 'Illustration HeroMe',
                              child: Image.asset('assets/default_hero.png', fit: BoxFit.contain, width: 520),
                            ),
                            // Overlay dégradé pour contraste texte si besoin
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.transparent, Colors.black.withAlpha((0.06 * 255).round())],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Features - chips look
               
                const SizedBox(height: 24),
                // CTA en gradient avec ombre
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SuperheroSearchScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 10,
                      backgroundColor: Colors.transparent,
                      shadowColor: theme.colorScheme.primary.withAlpha((0.35 * 255).round()),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [theme.colorScheme.primary, theme.colorScheme.primary.withAlpha((0.9 * 255).round())]),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Container(
                        height: 52,
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search, color: Colors.white),
                            SizedBox(width: 10),
                            Text('Commencer la recherche', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}