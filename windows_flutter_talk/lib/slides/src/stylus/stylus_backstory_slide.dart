import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class StylusBackstorySlide extends FlutterDeckSlideWidget {
  const StylusBackstorySlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/stylus-backstory',
            header: FlutterDeckHeaderConfiguration(title: '📜 数年越しの悲願'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(80, 36, 80, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: 'なぜ Flutter 3.44 ',
                    style: TextStyle(color: AppColors.blue),
                  ),
                  const TextSpan(
                    text: 'まで待つことになったのか',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _StoryCard(
                    year: '2020〜2022',
                    icon: '🐛',
                    iconColor: Colors.redAccent,
                    title: '放置された問題',
                    body:
                        'Windowsでスタイラスを使うと\n筆圧・傾きが取れず、\n単なるマウス左クリックとして処理。\n\n'
                        '最悪の場合は入力を完全に無視。',
                    footnote: 'Issue #65248 / #102836',
                    footnoteColor: Colors.redAccent,
                  ),
                  _Arrow(),
                  _StoryCard(
                    year: 'ある日',
                    icon: '👨‍💻',
                    iconColor: Colors.orange,
                    title: '一人が立ち上がる',
                    body:
                        'CodeDoctorDE 氏（ドイツ）\n'
                        'Flutter製ノートアプリ\n「Linwood Butterfly」の作者。\n\n'
                        'Googleの対応を待たず、自らC++エンジン\n（Win32イベント処理）を解読・書き換え。',
                    footnote: 'コミュニティの力',
                    footnoteColor: Colors.orange,
                  ),
                  _Arrow(),
                  _StoryCard(
                    year: 'Flutter 3.44',
                    icon: '🎉',
                    iconColor: const Color(0xFF4CAF50),
                    title: '悲願達成',
                    body:
                        'Win32 ネイティブ API を正しくハンドリングし、\n筆圧・回転を完全サポート。\n\n'
                        'PR #165323 が本家にマージ。\n数年越しの issue がついてに閉じる。',
                    footnote: 'PR #165323',
                    footnoteColor: const Color(0xFF4CAF50),
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

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    required this.year,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.body,
    required this.footnote,
    required this.footnoteColor,
  });

  final String year;
  final String icon;
  final Color iconColor;
  final String title;
  final String body;
  final String footnote;
  final Color footnoteColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2332),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: iconColor.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              year,
              style: TextStyle(
                fontSize: 13,
                color: iconColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            Text(icon, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Text(
                body,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white60,
                  height: 1.65,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                footnote,
                style: TextStyle(
                  fontSize: 13,
                  color: iconColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Arrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Center(
        child: Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white24,
          size: 32,
        ),
      ),
    );
  }
}
