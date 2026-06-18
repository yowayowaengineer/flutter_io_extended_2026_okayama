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
        padding: const EdgeInsets.all(80),
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
                  const TextSpan(text: '地方エンジニアが直面する '),
                  TextSpan(
                    text: '「iOSビルドの壁」',
                    style: TextStyle(color: AppColors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 56),
            Row(
              children: [
                _WallCard(
                  icon: Icons.cloud,
                  title: 'GitHub Actions',
                  body: 'サーバー上のmacOSでビルド。\n環境構築がとにかく地獄。',
                ),
                const SizedBox(width: 32),
                _WallCard(
                  icon: Icons.block,
                  title: 'Ruby / CocoaPods',
                  body: '環境差異による謎のビルドエラー。\nWindows勢には馴染みのないRubyの呪縛。',
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
            const SizedBox(height: 24),
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
              style: const TextStyle(fontSize: 20, color: Colors.white70, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
