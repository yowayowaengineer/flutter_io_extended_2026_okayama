import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class ReferencesSlide extends FlutterDeckSlideWidget {
  const ReferencesSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/references',
            header: FlutterDeckHeaderConfiguration(title: '📚 参考資料'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const _ReferencesContent(),
    );
  }
}

class _ReferencesContent extends StatelessWidget {
  const _ReferencesContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(96, 80, 96, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _RefItem(
            label: '公式ブログ（I/O 2026 Flutter ラップアップ）',
            title: "That's a wrap: Everything Flutter at Google I/O 2026",
            url: 'https://blog.flutter.dev/thats-a-wrap-everything-flutter-at-google-i-o-2026-f316e57186e3',
          ),
          const SizedBox(height: 40),
          _RefItem(
            label: '公式リリースノート',
            title: 'Flutter 3.44.0 release notes',
            url: 'https://docs.flutter.dev/release/release-notes/release-notes-3.44.0',
          ),
          const SizedBox(height: 40),
          _RefItem(
            label: '技術解説記事（Dev.to）',
            title: 'Flutter 3.44 Highlights From Google I/O 2026: What\'s New and What Matters',
            url: 'https://dev.to/ianjasperrr/flutter-344-highlights-from-google-io-2026-whats-new-and-what-matters-g6f',
          ),
        ],
      ),
    );
  }
}

class _RefItem extends StatelessWidget {
  const _RefItem({
    required this.label,
    required this.title,
    required this.url,
  });

  final String label;
  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => launchUrl(Uri.parse(url)),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.blue,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.blue,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          url,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white38,
          ),
        ),
      ],
    );
  }
}
