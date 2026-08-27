import 'package:flutter/material.dart';
import '../theme.dart';
import 'validacion.dart';

/// Pantalla de bienvenida (equivalente a PortadaScreen).
class PortadaScreen extends StatelessWidget {
  const PortadaScreen({super.key});

  void _continue(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ValidacionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -size.width * 0.2,
            left: -size.width * 0.1,
            child: _CircleBackground(
              size: size.width * 0.8,
              color: PhColors.green,
            ),
          ),
          Positioned(
            top: -size.width * 0.1,
            right: -size.width * 0.2,
            child: _CircleBackground(
              size: size.width * 0.9,
              color: PhColors.blue,
            ),
          ),

          Center(
            child: SizedBox(
              width: size.width,
              height: size.height * 0.5,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    right: size.width * 0.08,
                    child: _LandscapeCircle(
                      size: 150,
                      image: 'assets/images/event-feria.png',
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: size.width * 0.05,
                    child: _LandscapeCircle(
                      size: 170,
                      image: 'assets/images/logo-ph.png',
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    right: size.width * 0.12,
                    child: _LandscapeCircle(
                      size: 140,
                      image: 'assets/images/event-reciclaje.png',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: size.width * 0.20,
                    child: _LandscapeCircle(
                      size: 120,
                      image: 'assets/images/news-plaza.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: Padding(
                    padding: const EdgeInsets.all(15),
                  child: Image.asset('assets/images/logo_aplicacion.png'),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Column(
              children: [
                _GradientButton(
                  label: 'Continuar',
                  colors: const [Color(0xFF005599), Color(0xFF0077CC)],
                  onPressed: () => _continue(context),
                ),
                const SizedBox(height: 16),
                _GradientButton(
                  label: 'Registrarme',
                  colors: const [Color(0xFF008844), Color(0xFF00AA66)],
                  onPressed: () => _continue(context),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 20, height: 6, decoration: BoxDecoration(color: PhColors.blue, borderRadius: BorderRadius.circular(3))),
                    const SizedBox(width: 4),
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: PhColors.gray300, shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: PhColors.gray300, shape: BoxShape.circle)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleBackground extends StatelessWidget{
  final double size;
  final Color color;
  const _CircleBackground({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.8),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _LandscapeCircle extends StatelessWidget{
  final double size;
  final String image;
  const _LandscapeCircle({required this.size, required this.image});

  @override
  Widget build(BuildContext context){
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final String label;
  final List<Color> colors;
  final VoidCallback onPressed;

  const _GradientButton({required this.label, required this.colors, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors, begin: Alignment.topCenter, end: Alignment.bottomCenter),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 3))],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}