import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:herome/data/repository.dart';
import 'package:herome/data/model/superhero_detail_response.dart';
import 'package:herome/screens/superhero_detail_screen.dart';
import 'package:herome/theme_service.dart';

class SuperheroSearchScreen extends StatefulWidget {
  const SuperheroSearchScreen({super.key});

  @override
  State<SuperheroSearchScreen> createState() => _SuperheroSearchScreenState();
}

class _SuperheroSearchScreenState extends State<SuperheroSearchScreen> with SingleTickerProviderStateMixin {
  final _repo = Repository();
  final _controller = TextEditingController();
  Timer? _debounce;
  List<SuperheroDetailResponse> _results = [];
  final PageController _pageController = PageController(viewportFraction: 0.86);

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _search(String q) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () async {
      if (q.trim().isEmpty) {
        setState(() {
          _results = [];
        });
        return;
      }
      final res = await _repo.fetchSuperHero(q.trim());
      if (res == null) return;
      setState(() {
        _results = res.items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('HeroMe'),
        centerTitle: true,
        elevation: 0,
        actions: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (_, mode, __) {
              return IconButton(
                icon: Icon(mode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
                onPressed: () {
                  themeNotifier.value =
                      (themeNotifier.value == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha((0.06 * 255).round()), blurRadius: 12, offset: const Offset(0, 6)),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: theme.colorScheme.onSurface.withAlpha((0.6 * 255).round())),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: _search,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Rechercher un héros',
                        hintStyle: TextStyle(color: theme.colorScheme.onSurface.withAlpha((0.5 * 255).round())),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear, color: theme.colorScheme.onSurface.withAlpha((0.7 * 255).round())),
                    onPressed: () {
                      _controller.clear();
                      _search('');
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _results.isNotEmpty
                  ? PageView.builder(
                      controller: _pageController,
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        final h = _results[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              PageTransition(
                                child: SuperheroDetailScreen(hero: h),
                                type: PageTransitionType.rightToLeft,
                              ),
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                              elevation: 8,
                              clipBehavior: Clip.antiAlias,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: h.imageUrl ?? '',
                                    fit: BoxFit.cover,
                                    placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                                    errorWidget: (_, __, ___) => Image.asset(
                                      'assets/default_hero.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // dark overlay gradient bottom for text contrast
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    height: 120,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [Colors.black87, Colors.transparent],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 16,
                                    left: 16,
                                    right: 16,
                                    child: AutoSizeText(
                                      h.name ?? '',
                                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      minFontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: FadeIn(
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.supervised_user_circle, size: 64),
                            SizedBox(height: 8),
                            Text('Entrez un nom pour commencer'),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
