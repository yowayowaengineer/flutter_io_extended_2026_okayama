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
                        fontSize: 48,
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
                  const SizedBox(height: 40),
                  const Text(
                    'Swift Package Manager (SPM) 移行の衝撃',
                    style: TextStyle(fontSize: 22, color: Colors.white60),
                  ),
                  const SizedBox(height: 32),
                  _Bullet('CocoaPodsからの悲願の脱却'),
                  _Bullet('Xcodeに統合されたネイティブ管理'),
                  _Bullet('Ruby環境のインストールが不要に'),
                  _Bullet('CLIによる自動マイグレーション対応'),
                ],
              ),
            ),
            const SizedBox(width: 60),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2332),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    '// TODO: Xcodeスクリーンショット',
                    style: TextStyle(color: Colors.white38, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Text('• ', style: TextStyle(color: Colors.white54, fontSize: 22)),
          Text(text, style: const TextStyle(color: Colors.white70, fontSize: 22)),
        ],
      ),
    );
  }
}
