import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class IosBuildWallSlide extends FlutterDeckSlideWidget {
  const IosBuildWallSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/ios-build-wall',
            header: FlutterDeckHeaderConfiguration(title: '😱 iOSビルドの壁'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(80, 48, 80, 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: [
                  const TextSpan(text: 'Windowsエンジニアが直面する '),
                  TextSpan(
                    text: '「iOSビルドの壁」',
                    style: TextStyle(color: AppColors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                _WallCard(
                  icon: Icons.cloud,
                  title: 'GitHub Actions',
                  body: 'サーバー上のmacOSでビルド。\n1回約20分、失敗したら最初からやり直し。',
                ),
                const SizedBox(width: 32),
                _WallCard(
                  icon: Icons.block,
                  title: 'Ruby / CocoaPods',
                  body: 'Ruby, Gemfile, pod install…\n複雑な依存チェーン。Windows環境では特にセットアップで詰まりやすい。',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WallCard extends StatelessWidget {
  const _WallCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
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
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              body,
              style: const TextStyle(fontSize: 17, color: Colors.white70, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
