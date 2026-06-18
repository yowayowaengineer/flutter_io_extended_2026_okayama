import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class DesktopPossibilitiesSlide extends FlutterDeckSlideWidget {
  const DesktopPossibilitiesSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/desktop-possibilities',
            header: FlutterDeckHeaderConfiguration(title: '🖥️ デスクトップの可能性'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(80),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
                    children: [
                      const TextSpan(
                        text: 'デスクトップの ',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: '可能性',
                        style: TextStyle(color: AppColors.blue),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                Text(
                  '100%',
                  style: TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue,
                  ),
                ),
                const Text(
                  'Native Precision',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 80),
            Expanded(
              child: const Text(
                'これまで「マウスの代わり」だったスタイラスが、真の入力デバイスとして覚醒。\n\nデザインツール、ホワイトボードアプリ、プロ向けツールの道が拓けました。',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white70,
                  height: 1.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
