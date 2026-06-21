import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class WindowsPerspectiveSlide extends FlutterDeckSlideWidget {
  const WindowsPerspectiveSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/windows-perspective',
            header: FlutterDeckHeaderConfiguration(title: '🪟 Windows開発者の視点'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const _Content(),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  int _revealCount = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (_revealCount < 3) setState(() => _revealCount++);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(48, 24, 48, 32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _Panel1(visible: _revealCount >= 1)),
            const _Divider(),
            Expanded(child: _Panel2(visible: _revealCount >= 2)),
            const _Divider(),
            Expanded(child: _Panel3(visible: _revealCount >= 3)),
          ],
        ),
      ),
    );
  }
}

// ── Panel 1: テキスト宣言 ────────────────────────────────────
class _Panel1 extends StatelessWidget {
  const _Panel1({required this.visible});
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeIn,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🪟', style: TextStyle(fontSize: 80)),
            const SizedBox(height: 16),
            const Text(
              'このPCは',
              style: TextStyle(fontSize: 32, color: Colors.white60),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
                children: [
                  TextSpan(
                    text: 'Windows',
                    style: TextStyle(color: AppColors.blue),
                  ),
                  const TextSpan(
                    text: ' です。',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '登壇中も。',
              style: TextStyle(fontSize: 24, color: Colors.white38),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Panel 2: スクショ + ハンコ ───────────────────────────────
class _Panel2 extends StatelessWidget {
  const _Panel2({required this.visible});
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeIn,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/build_time.png',
              fit: BoxFit.contain,
            ),
          ),
          AnimatedScale(
            scale: visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.elasticOut,
            child: Transform.rotate(
              angle: -0.15,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.92),
                  border: Border.all(color: Colors.black87, width: 4),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'ビルドはローカルで\nできません！',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.5,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Panel 3: Section 3 フォーカス ────────────────────────────
class _Panel3 extends StatelessWidget {
  const _Panel3({required this.visible});
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeIn,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.blue.withValues(alpha: 0.5),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🔧 3. プラットフォームとパフォーマンスの成熟',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.7,
                    color: Colors.white70,
                  ),
                  children: [
                    TextSpan(
                      text: 'iOS/macOS: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.blue,
                      ),
                    ),
                    const TextSpan(
                      text:
                          'Swift Package Manager (SPM) がデフォルトに。\n'
                          'Windows環境からのiOSビルドの安定性が\n劇的に向上します。',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Icon(Icons.arrow_forward_rounded, color: AppColors.blue),
                  const SizedBox(width: 8),
                  Text(
                    'これが今日の本題！',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── 仕切り線 ────────────────────────────────────────────────
class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white12,
    );
  }
}
