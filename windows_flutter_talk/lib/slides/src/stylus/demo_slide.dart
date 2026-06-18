import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class DemoSlide extends FlutterDeckSlideWidget {
  const DemoSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(route: '/demo'),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: 'Demo: ',
                    style: TextStyle(color: AppColors.blue),
                  ),
                  const TextSpan(
                    text: '手書きUIの魔法',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Row(
              children: [
                _DemoStep(
                  icon: Icons.edit,
                  step: '1. 書く',
                  body: '液タブでコミュニティ名を書く。\n筆圧による滑らかなストローク。',
                ),
                const SizedBox(width: 32),
                _DemoStep(
                  icon: Icons.link,
                  step: '2. 繋ぐ',
                  body: 'その手書きパスがそのまま\nインタラクティブなボタンに。',
                ),
                const SizedBox(width: 32),
                _DemoStep(
                  icon: Icons.people,
                  step: '3. 誘う',
                  body: 'クリックしてコミュニティサイトへ！',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoStep extends StatelessWidget {
  const _DemoStep({
    required this.icon,
    required this.step,
    required this.body,
  });

  final IconData icon;
  final String step;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2332),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.blue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.blue, size: 32),
            ),
            const SizedBox(height: 20),
            Text(
              step,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              body,
              style: const TextStyle(fontSize: 20, color: Colors.white60, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
