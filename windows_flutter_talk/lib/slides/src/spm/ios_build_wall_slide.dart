import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class IosBuildWallSlide extends FlutterDeckSlideWidget {
  const IosBuildWallSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/ios-build-wall',
            header: FlutterDeckHeaderConfiguration(
              title: '😱 Windowsエンジニア、iOSビルドに挑む',
            ),
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
  bool _punchlineVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _punchlineVisible = true),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(80, 16, 80, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // タイムライン
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _Item('10:00', '🟢', '「iOSのビルド対応、やってみよう！」', _ItemColor.good),
                  _Item('10:02', '❓', 'ruby: command not found', _ItemColor.warn),
                  _Item('10:20', '⏳', 'rbenv install 3.2.0...  bundle install...  pod install...', _ItemColor.warn),
                  _Item('11:30', '😤', 'やっとCI実行！20分待つ', _ItemColor.warn),
                  _Item('11:50', '❌', 'Build Failed（CocoaPodsのバージョン不一致）', _ItemColor.bad),
                  _Item('12:10', '❌', 'Build Failed（今度はRubyのバージョン）', _ItemColor.bad),
                  _Item('12:11', '🍵', 'お昼にする', _ItemColor.muted),
                  _Item('数日後', '🚨', 'You have exceeded your Actions minutes\n　macOSランナーは無料枠を 10倍 消費', _ItemColor.bad),
                ],
              ),
            ),
            // オチ
            const SizedBox(width: 32),
            AnimatedScale(
              scale: _punchlineVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.elasticOut,
              alignment: Alignment.center,
              child: _Punchline(),
            ),
          ],
        ),
      ),
    );
  }
}

enum _ItemColor { good, warn, bad, muted }

class _Item extends StatelessWidget {
  const _Item(this.time, this.icon, this.label, this.itemColor);

  final String time;
  final String icon;
  final String label;
  final _ItemColor itemColor;

  Color get _color {
    switch (itemColor) {
      case _ItemColor.good:
        return const Color(0xFF4CAF50);
      case _ItemColor.warn:
        return Colors.orange;
      case _ItemColor.bad:
        return Colors.redAccent;
      case _ItemColor.muted:
        return Colors.white38;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 56,
          child: Text(
            time,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 13, color: Colors.white38),
          ),
        ),
        const SizedBox(width: 12),
        Text(icon, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 15, color: _color, height: 1.5),
          ),
        ),
      ],
    );
  }
}

class _Punchline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.blue.withValues(alpha: 0.4)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('😇', style: TextStyle(fontSize: 40)),
          const SizedBox(height: 16),
          const Text(
            'Macユーザーに\n依頼して\nすぐリリース',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'END',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.blue,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
