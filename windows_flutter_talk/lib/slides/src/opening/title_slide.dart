import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class TitleSlide extends FlutterDeckSlideWidget {
  const TitleSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(route: '/title'),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.3,
                ),
                children: [
                  const TextSpan(text: '開発PCが'),
                  TextSpan(
                    text: ' Windows ',
                    style: TextStyle(color: AppColors.blue),
                  ),
                  const TextSpan(text: 'の\nエンジニアに告ぐっ！'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Flutter 3.44の新機能はいいぞ！',
              style: TextStyle(fontSize: 48, color: Colors.white70),
            ),
            const SizedBox(height: 48),
            const Text(
              'Google I/O Extended 2026 Okayama',
              style: TextStyle(fontSize: 32, color: Colors.white38),
            ),
          ],
        ),
      ),
    );
  }
}
