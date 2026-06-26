import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class SpmDefaultSlide extends FlutterDeckSlideWidget {
  const SpmDefaultSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/spm-default',
            header: FlutterDeckHeaderConfiguration(title: '📦 SPMがデフォルトに'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(80, 48, 80, 48),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'SPM ',
                          style: TextStyle(color: AppColors.blue),
                        ),
                        const TextSpan(
                          text: 'がデフォルトに！',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Swift Package Manager (SPM) 移行の衝撃',
                    style: TextStyle(fontSize: 26, color: Colors.white60),
                  ),
                  const SizedBox(height: 36),
                  _Bullet('CocoaPodsからの悲願の脱却'),
                  _Bullet('Xcodeに統合されたネイティブ管理'),
                  _Bullet('Ruby環境のインストールが不要に'),
                  _Bullet('CLIによる自動マイグレーション対応'),
                ],
              ),
            ),
            const SizedBox(width: 60),
            Expanded(
              child: _DiffBlock(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiffBlock extends StatelessWidget {
  const _DiffBlock();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // タイトルバー
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: const Row(
              children: [
                _DotButton(color: Color(0xFFFF5F57)),
                SizedBox(width: 8),
                _DotButton(color: Color(0xFFFFBD2E)),
                SizedBox(width: 8),
                _DotButton(color: Color(0xFF28C840)),
                SizedBox(width: 16),
                Text(
                  '.github/workflows/ios.yml',
                  style: TextStyle(color: Colors.white38, fontSize: 14),
                ),
              ],
            ),
          ),
          // diff 本体
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _DiffLine('-', 'uses: ruby/setup-ruby@v1', deleted: true),
                  _DiffLine('-', 'run: bundle install', deleted: true),
                  _DiffLine('-', 'run: pod install', deleted: true),
                  _DiffLine('-', 'uses: actions/cache@v3  # Pods', deleted: true),
                  const SizedBox(height: 16),
                  _DiffLine('+', 'run: flutter build ios', deleted: false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DotButton extends StatelessWidget {
  const _DotButton({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _DiffLine extends StatelessWidget {
  const _DiffLine(this.prefix, this.code, {required this.deleted});
  final String prefix;
  final String code;
  final bool deleted;

  @override
  Widget build(BuildContext context) {
    final color = deleted ? const Color(0xFFFF7B7B) : const Color(0xFF7BFFB0);
    final bgColor = deleted
        ? const Color(0x15FF0000)
        : const Color(0x1500FF44);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Text(
              prefix,
              style: TextStyle(
                fontSize: 22,
                color: color,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            code,
            style: TextStyle(
              fontSize: 22,
              color: color,
              fontFamily: 'monospace',
              decoration: deleted ? TextDecoration.lineThrough : null,
              decorationColor: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const Text('• ', style: TextStyle(color: Colors.white54, fontSize: 28)),
          Text(text, style: const TextStyle(color: Colors.white70, fontSize: 26)),
        ],
      ),
    );
  }
}
