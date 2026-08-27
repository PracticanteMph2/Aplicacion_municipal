import 'package:flutter/material.dart';
import '../models/models.dart';
import '../data/mock_data.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// Pantalla de noticias (equivalente a NoticiasScreen). Usada como pestaña.
class NoticiasScreen extends StatelessWidget {
  const NoticiasScreen({super.key});

  void _openNews(BuildContext context, NewsItem n) {
    showPhSheet(
      context,
      title: n.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (n.img != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(n.img!,
                  height: 160, width: double.infinity, fit: BoxFit.cover),
            ),
          const SizedBox(height: 16),
          Text(n.body,
              style: const TextStyle(
                  fontSize: 14, color: PhColors.gray600, height: 1.5)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final featured = kNews.first;

    return Column(
      children: [
        const ScreenHeader(title: 'Noticias'),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              GestureDetector(
                onTap: () => _openNews(context, featured),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.asset(
                          featured.img ?? 'assets/images/news-plaza.png',
                          height: 176,
                          width: double.infinity,
                          fit: BoxFit.cover),
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.75),
                                Colors.transparent
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(featured.title.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    height: 1.3,
                                    color: Colors.white)),
                            const SizedBox(height: 4),
                            const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Leer más',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                                Icon(Icons.chevron_right,
                                    size: 14, color: Colors.white),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Todas las noticias',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: PhColors.gray900)),
              const SizedBox(height: 12),
              ...kNews.map((n) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () => _openNews(context, n),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: PhColors.gray100),
                    ),
                    child: Row(
                      children: [
                        if (n.img != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(n.img!,
                                width: 64, height: 64, fit: BoxFit.cover),
                          ),
                        if (n.img != null) const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(n.title,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3,
                                      color: PhColors.gray900)),
                              const SizedBox(height: 4),
                              const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Leer más',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: PhColors.blue)),
                                  Icon(Icons.chevron_right,
                                      size: 12, color: PhColors.blue),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }
}
