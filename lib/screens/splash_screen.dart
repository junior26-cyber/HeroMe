import 'dart:async';
import 'package:flutter/material.dart';
import 'package:herome/screens/superhero_search_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
    _scaleAnim = Tween<double>(begin: 0.8, end: 1.05).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
    Timer(const Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const SuperheroSearchScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(24), child: Image.asset('assets/icon.png', width: 200, height: 200, fit: BoxFit.cover)),
                  const SizedBox(height: 20),
                  const Text('HeroMe', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}