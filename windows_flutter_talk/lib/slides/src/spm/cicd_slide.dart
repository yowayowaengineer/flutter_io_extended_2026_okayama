import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class CicdSlide extends FlutterDeckSlideWidget {
  const CicdSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/cicd',
            header: FlutterDeckHeaderConfiguration(title: '🔄 CI/CDで解決'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(80, 48, 80, 48),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      children: [
                        const TextSpan(text: 'CI/CDが'),
                        TextSpan(
                          text: '「楽」',
                          style: TextStyle(color: AppColors.blue),
                        ),
                        const TextSpan(text: 'になる'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'GitHub Actionsのワークフローが激変します。',
                    style: TextStyle(fontSize: 26, color: Colors.white70),
                  ),
                  const SizedBox(height: 24),
                  _CheckItem('setup-ruby 不要', 'ステップ削減'),
                  _CheckItem('pod install 不要', 'ビルド時間短縮'),
                  _CheckItem('キャッシュ安定', 'Xcode標準のキャッシュ'),
                  const SizedBox(height: 28),
                  const Text(
                    'Windowsメインの開発者でも、iOSビルドの\nパイプライン維持が圧倒的に低コストに。',
                    style: TextStyle(fontSize: 24, color: Colors.white54, height: 1.6),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 60),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/build_time.png',
                      fit: BoxFit.cover,
                    ),
                    Container(color: Colors.black.withValues(alpha: 0.5)),
                    Center(
                      child: Icon(
                        Icons.check_circle_outline,
                        size: 140,
                        color: AppColors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckItem extends StatelessWidget {
  const _CheckItem(this.title, this.subtitle);
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Text('✓', style: TextStyle(color: Color(0xFF4CAF50), fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(width: 14),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$title  ',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: subtitle,
                  style: const TextStyle(fontSize: 24, color: Colors.white54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
