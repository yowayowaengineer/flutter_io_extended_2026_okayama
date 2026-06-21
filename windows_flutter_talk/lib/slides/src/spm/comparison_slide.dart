import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class ComparisonSlide extends FlutterDeckSlideWidget {
  const ComparisonSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/comparison',
            header: FlutterDeckHeaderConfiguration(title: '⚖️ CocoaPods vs SPM'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(80, 24, 80, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                children: [
                  const TextSpan(
                    text: '依存関係管理の ',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(
                    text: '比較',
                    style: TextStyle(color: AppColors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _ComparisonTable(),
          ],
        ),
      ),
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          _TableHeader(),
          _TableRow('外部依存', 'Ruby, Gem, CocoaPods', 'なし（Xcode標準）', isEven: true),
          _TableRow('CI構築難易度', '高い（Gemfile管理必須）', '低い（ネイティブのみ）'),
          _TableRow('ビルド速度', '普通（pod indexing）', '高速（Xcode optimized）', isEven: true),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.blue.withValues(alpha: 0.3),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: const [
          Expanded(flex: 2, child: Text('項目', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
          Expanded(flex: 3, child: Text('CocoaPods (Legacy)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
          Expanded(flex: 3, child: Text('SwiftPM (3.44+)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
        ],
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  const _TableRow(this.label, this.legacy, this.spm, {this.isEven = false});

  final String label;
  final String legacy;
  final String spm;
  final bool isEven;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      color: isEven ? Colors.white.withValues(alpha: 0.03) : Colors.transparent,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontSize: 18, color: Colors.white70)),
          ),
          Expanded(
            flex: 3,
            child: Text(legacy, style: const TextStyle(fontSize: 18, color: Colors.white38)),
          ),
          Expanded(
            flex: 3,
            child: Text(spm, style: const TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
