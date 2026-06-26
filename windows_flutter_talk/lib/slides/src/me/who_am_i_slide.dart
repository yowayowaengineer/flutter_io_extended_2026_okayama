import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class WhoAmISlide extends FlutterDeckSlideWidget {
  const WhoAmISlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/who-am-i',
          header: FlutterDeckHeaderConfiguration(title: '👋 よわよわエンジニア is 誰'),
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final GlobalKey targetKey = GlobalKey();

    void showTutorial() {
      final targets = [
        TargetFocus(
          identify: 'person',
          keyTarget: targetKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              builder: (context, controller) {
                return Container(
                  constraints: const BoxConstraints(maxWidth: 460),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 15,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/me_400x400.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 320,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'よわよわエンジニア',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '🍩☕  岡山.Flutter の中の人',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text(
                                  '🐦',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '@yowayowa_engr',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue[600],
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
          shape: ShapeLightFocus.Circle,
        ),
      ];

      TutorialCoachMark(
        targets: targets,
        colorShadow: Colors.black.withValues(alpha: 0.8),
        textSkip: '閉じる',
        paddingFocus: 10,
        opacityShadow: 0.8,
      ).show(context: context);
    }

    return FlutterDeckSlide.blank(
      builder: (context) => GestureDetector(
        onTap: showTutorial,
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              Image.asset(
                'assets/images/FlutterKaigi2025.webp',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                left: constraints.maxWidth * 0.52,
                top: constraints.maxHeight * 0.68,
                child: SizedBox(
                  key: targetKey,
                  width: constraints.maxWidth * (40 / 1920),
                  height: constraints.maxHeight * (40 / 1080),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
