import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class DesktopEraSlide extends FlutterDeckSlideWidget {
  const DesktopEraSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/desktop-era',
            header: FlutterDeckHeaderConfiguration(title: '🖥️ Flutterデスクトップ、本格始動'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const _DesktopEraContent(),
    );
  }
}

class _DesktopEraContent extends StatelessWidget {
  const _DesktopEraContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(96, 48, 96, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
              children: [
                const TextSpan(text: 'これまで冷遇気味だったデスクトップが、'),
                TextSpan(text: 'Flutter 3.44で大きく動きました。', style: TextStyle(color: AppColors.blue)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _Item(
            icon: Icons.engineering,
            title: 'Canonicalがリードメンテナに就任',
            body: 'Windows / macOS / Linux 全体のロードマップとメンテナンスを引き受けました。',
          ),
          const SizedBox(height: 20),
          _Item(
            icon: Icons.window,
            title: 'ネイティブ・マルチウィンドウ対応',
            body: 'エンジンレベルでのアーキテクチャ刷新。次のスライドで詳しく説明します。',
          ),
          const SizedBox(height: 20),
          _Item(
            icon: Icons.edit,
            title: 'Windowsスタイラスのネイティブサポート',
            body: '筆圧・回転の正確なトラッキングに対応。こちらも後ほど深掘りします。',
            highlight: true,
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.icon,
    required this.title,
    required this.body,
    this.highlight = false,
  });

  final IconData icon;
  final String title;
  final String body;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.blue.withValues(alpha: highlight ? 0.25 : 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.blue, size: 28),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: highlight ? 24 : 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(fontSize: 16, color: Colors.white60, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
