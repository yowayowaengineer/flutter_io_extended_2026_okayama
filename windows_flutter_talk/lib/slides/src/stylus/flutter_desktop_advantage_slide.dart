import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class FlutterDesktopAdvantageSlide extends FlutterDeckSlideWidget {
  const FlutterDesktopAdvantageSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/flutter-desktop-advantage',
            header: FlutterDeckHeaderConfiguration(
              title: '⚡ 描画アプリで考えると話が変わる',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(80, 32, 80, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                children: [
                  const TextSpan(
                    text: 'ペイントツール・デザインツールで ',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(
                    text: '比較する',
                    style: TextStyle(color: AppColors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Card(
                    icon: '🌐',
                    title: 'Electron',
                    highlight: false,
                    rows: const [
                      _Row('描画エンジン', 'WebView (Chromium)', ok: false),
                      _Row('スタイラス入力', 'Web Pointer Events 経由', ok: false),
                      _Row('レイテンシ', '高い', ok: false),
                    ],
                  ),
                  const SizedBox(width: 16),
                  _Card(
                    icon: '🦀',
                    title: 'Tauri',
                    highlight: false,
                    rows: const [
                      _Row('描画エンジン', 'WebView (OS標準)', ok: false),
                      _Row('スタイラス入力', 'Web Pointer Events 経由', ok: false),
                      _Row('レイテンシ', '高い', ok: false),
                    ],
                  ),
                  const SizedBox(width: 16),
                  _Card(
                    icon: '💙',
                    title: 'Flutter',
                    highlight: true,
                    rows: const [
                      _Row('描画エンジン', 'Impeller（ネイティブ直描画）', ok: true),
                      _Row('スタイラス入力', 'Win32 API 直アクセス', ok: true),
                      _Row('レイテンシ', '低い', ok: true),
                    ],
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

class _Row {
  const _Row(this.label, this.value, {required this.ok});
  final String label;
  final String value;
  final bool ok;
}

class _Card extends StatelessWidget {
  const _Card({
    required this.icon,
    required this.title,
    required this.highlight,
    required this.rows,
  });

  final String icon;
  final String title;
  final bool highlight;
  final List<_Row> rows;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: highlight
              ? AppColors.blue.withValues(alpha: 0.1)
              : const Color(0xFF1A2332),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: highlight
                ? AppColors.blue.withValues(alpha: 0.6)
                : Colors.white12,
            width: highlight ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(icon, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: highlight ? AppColors.blue : Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ...rows.map((row) => _RowWidget(row: row)),
          ],
        ),
      ),
    );
  }
}

class _RowWidget extends StatelessWidget {
  const _RowWidget({required this.row});
  final _Row row;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            row.label,
            style: const TextStyle(fontSize: 13, color: Colors.white38),
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                row.ok ? '✓' : '✗',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: row.ok ? const Color(0xFF4CAF50) : Colors.red,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  row.value,
                  style: TextStyle(
                    fontSize: 17,
                    color: row.ok ? Colors.white : Colors.white38,
                    fontWeight:
                        row.ok ? FontWeight.w600 : FontWeight.normal,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
