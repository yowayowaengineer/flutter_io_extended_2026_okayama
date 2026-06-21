import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class MultiwindowSlide extends FlutterDeckSlideWidget {
  const MultiwindowSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/multiwindow',
            header: FlutterDeckHeaderConfiguration(title: '🪟🪟 ネイティブ・マルチウィンドウ'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const _MultiwindowContent(),
    );
  }
}

class _MultiwindowContent extends StatelessWidget {
  const _MultiwindowContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(96, 12, 96, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ① 神仕様
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.blue.withValues(alpha: 0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text('✨', style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 10),
                      Text(
                        'アーキテクチャ刷新：エンジン1つで、ウィンドウは複数',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'これまではウィンドウを増やすたびにFlutterエンジンを丸ごともう1つ起動していました。メモリが倍増し、ウィンドウ間の状態共有にMethodChannelが必須でした。',
                    style: const TextStyle(fontSize: 15, color: Colors.white60, height: 1.6),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.blue.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '3.44〜 : Dart Isolateは1つ。そこから複数ウィンドウに直接描画。\nRiverpod / Provider / Bloc がMethodChannelなしで別ウィンドウにシームレスに同期。',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.blue,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // ② 現実
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A1A1A),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.red.withValues(alpha: 0.4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Text('😅', style: TextStyle(fontSize: 20)),
                            const SizedBox(width: 8),
                            const Text(
                              '正直に言うと…',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _RealistItem(icon: Icons.science, color: Colors.orange, text: '実験的機能（flutter config --enable-windowing）'),
                        const SizedBox(height: 6),
                        _RealistItem(icon: Icons.bug_report, color: Colors.red, text: 'Windows 10 でウィンドウ操作時にクラッシュ報告あり'),
                        const SizedBox(height: 6),
                        _RealistItem(icon: Icons.device_unknown, color: Colors.orange, text: 'ウィンドウ閉じる挙動がOS間でまだ不統一'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2332),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.blue.withValues(alpha: 0.4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Text('💪', style: TextStyle(fontSize: 20)),
                            const SizedBox(width: 8),
                            const Text(
                              'だからこそ',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'OSのプロであるCanonicalがリードメンテナに就任。Win32/ウィンドウ制御の泥臭いバグを本気で潰しにきます。',
                          style: const TextStyle(fontSize: 15, color: Colors.white70, height: 1.6),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '今のうちにAPIに触れておく価値は十分あります。',
                          style: TextStyle(fontSize: 14, color: AppColors.blue, height: 1.6),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RealistItem extends StatelessWidget {
  const _RealistItem({required this.icon, required this.color, required this.text});
  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 14, color: color, height: 1.5)),
        ),
      ],
    );
  }
}
