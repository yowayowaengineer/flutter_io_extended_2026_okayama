import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class StylusSupportSlide extends FlutterDeckSlideWidget {
  const StylusSupportSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/stylus-support',
            header: FlutterDeckHeaderConfiguration(title: '✏️ Windowsスタイラスサポート'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(80),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2332),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    '// TODO: スタイラスデモ動画 or キャプチャ',
                    style: TextStyle(color: Colors.white38, fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 60),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Windows、',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: 'スタイラス',
                          style: TextStyle(color: AppColors.blue),
                        ),
                        const TextSpan(
                          text: ' 完全サポート',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'CodeDoctorDE氏による驚異の貢献',
                    style: TextStyle(fontSize: 20, color: Colors.white54),
                  ),
                  const SizedBox(height: 32),
                  _Feature('筆圧感知 (Pressure)', '強弱をリアルに再現', AppColors.blue),
                  _Feature('回転 (Rotation)', 'ペンの傾きを正確に追跡', AppColors.blue),
                  _Feature('液タブ・Surfaceユーザーへの最高な回答', '', Colors.white70),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  const _Feature(this.title, this.subtitle, this.color);
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: Colors.white38, fontSize: 22)),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: TextStyle(fontSize: 22, color: color, fontWeight: FontWeight.w600),
                  ),
                  if (subtitle.isNotEmpty)
                    TextSpan(
                      text: ': $subtitle',
                      style: const TextStyle(fontSize: 22, color: Colors.white54),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
