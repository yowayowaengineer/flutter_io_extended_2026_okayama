import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class WindowsPerspectiveSlide extends FlutterDeckSlideWidget {
  const WindowsPerspectiveSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/windows-perspective',
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
      padding: const EdgeInsets.all(80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: 'Windows ',
                  style: TextStyle(color: AppColors.blue),
                ),
                const TextSpan(text: 'ユーザーの視点'),
              ],
            ),
          ),
          const SizedBox(height: 48),
          const Text(
            'Google I/Oはいつも Mac 一色...',
            style: TextStyle(fontSize: 28, color: Colors.white70),
          ),
          const SizedBox(height: 24),
          _BulletPoint('「デモはいつも MacBook Pro」'),
          _BulletPoint('「iOSの話ばかり盛り上がる」'),
          _BulletPoint('「Windowsは二の次なのか？」'),
          const SizedBox(height: 40),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 28),
              children: [
                const TextSpan(
                  text: 'いいえ、',
                  style: TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: '3.44は違います。',
                  style: TextStyle(
                    color: AppColors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  const _BulletPoint(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const SizedBox(width: 24),
          const Text('• ', style: TextStyle(color: Colors.white54, fontSize: 24)),
          Text(
            text,
            style: const TextStyle(color: Colors.white54, fontSize: 24),
          ),
        ],
      ),
    );
  }
}
