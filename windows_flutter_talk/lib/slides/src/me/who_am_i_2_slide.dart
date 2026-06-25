import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class WhoAmI2Slide extends FlutterDeckSlideWidget {
  const WhoAmI2Slide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/who-am-i-2',
            header: FlutterDeckHeaderConfiguration(title: '🏢 ちなみに所属は...'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(80, 32, 80, 32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 左: 会社ロゴ + 社名
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 320,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/people_software_logo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => const Center(
                          child: Text(
                            'LOGO',
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.white24,
                              letterSpacing: 6,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'ピープルソフトウェア\n株式会社',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // 縦仕切り線
            Container(
              width: 1,
              margin: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
              color: Colors.white12,
            ),

            // 右: 役職 + ハイライト
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 28, height: 1.6),
                      children: [
                        const TextSpan(
                          text: '部長',
                          style: TextStyle(
                            color: Colors.white30,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.white30,
                          ),
                        ),
                        const TextSpan(
                          text: '  Flutterアーキテクト & リードエンジニア',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 26, height: 1.6),
                      children: [
                        const TextSpan(
                          text: '管理監督者',
                          style: TextStyle(
                            color: Colors.white30,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.white30,
                          ),
                        ),
                        TextSpan(
                          text: '  受託開発の技術支援',
                          style: TextStyle(color: AppColors.blue),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  _Highlight(
                    icon: '🏆',
                    text: 'Flutterアプリコンテスト開催をきっかけにFlutterと出会う',
                  ),
                  const SizedBox(height: 20),
                  _Highlight(
                    icon: '📱',
                    text: '大手有名企業のFlutterアプリ開発に携わる',
                  ),
                  const SizedBox(height: 20),
                  _Highlight(
                    icon: '🥉',
                    text: 'FlutterKaigi スポンサー（ブロンズ）',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Highlight extends StatelessWidget {
  const _Highlight({required this.icon, required this.text});

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(icon, style: const TextStyle(fontSize: 28)),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 26,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
