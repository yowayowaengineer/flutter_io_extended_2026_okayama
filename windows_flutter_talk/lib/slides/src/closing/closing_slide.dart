import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class ClosingSlide extends FlutterDeckSlideWidget {
  const ClosingSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(route: '/closing'),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Windowsから、',
              style: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: '世界',
                    style: TextStyle(color: AppColors.blue),
                  ),
                  const TextSpan(
                    text: 'を変えよう。',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'もう「Windowsだから」と諦める必要はありません。',
              style: TextStyle(fontSize: 28, color: Colors.white60),
            ),
            const SizedBox(height: 60),
            const Text(
              'ご清聴ありがとうございました！',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
            const SizedBox(height: 12),
            const Text(
              'Questions & Discussion',
              style: TextStyle(fontSize: 20, color: Colors.white38),
            ),
          ],
        ),
      ),
    );
  }
}
