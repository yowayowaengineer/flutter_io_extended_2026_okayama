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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 左: 会社ロゴ + 社名
            SizedBox(
              width: 320,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ロゴ（画像を assets/images/people_software_logo.png に置いたら差し替え）
                  Container(
                    width: 260,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/people_software_logo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => const Center(
                          child: Text(
                            'LOGO',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white24,
                              letterSpacing: 4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'ピープルソフトウェア\n株式会社',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
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
              height: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              color: Colors.white12,
            ),

            // 右: 役職 + ハイライト
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 役職（取り消し線ネタ）
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 26, height: 1.6),
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
                      style: const TextStyle(fontSize: 20, height: 1.6),
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
                  const SizedBox(height: 32),

                  // ハイライト
                  _Highlight(
                    icon: '🏆',
                    text: 'Flutterアプリコンテスト開催をきっかけにFlutterと出会う',
                  ),
                  const SizedBox(height: 14),
                  _Highlight(
                    icon: '📱',
                    text: '大手有名企業のFlutterアプリ開発に携わる',
                  ),
                  const SizedBox(height: 14),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(icon, style: const TextStyle(fontSize: 22)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
