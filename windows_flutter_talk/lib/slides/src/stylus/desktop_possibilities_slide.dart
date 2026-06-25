import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class DesktopPossibilitiesSlide extends FlutterDeckSlideWidget {
  const DesktopPossibilitiesSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/desktop-possibilities',
            header: FlutterDeckHeaderConfiguration(title: '🤔 で、需要は？'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(80, 32, 80, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              children: [
                const TextSpan(
                  text: 'ぶっちゃけ、',
                  style: TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: '需要はあるのか？',
                  style: TextStyle(color: AppColors.blue),
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),
          const _DemandRow(
            label: 'WindowsユーザーがFlutterでスタイラス開発したい',
            level: 0.04,
            verdict: '少ない',
            verdictColor: Colors.orange,
          ),
          const SizedBox(height: 24),
          const _DemandRow(
            label: '液タブを持っているFlutterエンジニア',
            level: 0.06,
            verdict: '少ない',
            verdictColor: Colors.orange,
          ),
          const SizedBox(height: 24),
          const _DemandRow(
            label: '現場でスタイラス入力が要件になっている',
            level: 0.02,
            verdict: 'かなり少ない',
            verdictColor: Colors.redAccent,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            decoration: BoxDecoration(
              color: AppColors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.blue.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                const Text('💡', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'ただし「ペイントツール」「デザインアプリ」文脈で考えると、話が変わる',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_rounded, color: AppColors.blue, size: 28),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DemandRow extends StatelessWidget {
  const _DemandRow({
    required this.label,
    required this.level,
    required this.verdict,
    required this.verdictColor,
  });

  final String label;
  final double level;
  final String verdict;
  final Color verdictColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 26, color: Colors.white70),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: [
                    Container(height: 20, color: Colors.white10),
                    FractionallySizedBox(
                      widthFactor: level,
                      child: Container(
                        height: 20,
                        color: verdictColor.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 140,
              child: Text(
                verdict,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: verdictColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
