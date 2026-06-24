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
        padding: const EdgeInsets.fromLTRB(96, 48, 96, 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
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
            const SizedBox(height: 12),
            const Text(
              'CodeDoctorDE 氏による驚異の貢献',
              style: TextStyle(fontSize: 20, color: Colors.white38),
            ),
            const SizedBox(height: 48),
            Row(
              children: [
                _FeatureCard(
                  icon: Icons.water_drop_outlined,
                  title: '筆圧感知',
                  subtitle: 'Pressure',
                  body: '強弱をリアルに再現。\n軽いタッチから力強い線まで。',
                ),
                const SizedBox(width: 24),
                _FeatureCard(
                  icon: Icons.rotate_right,
                  title: '回転',
                  subtitle: 'Rotation',
                  body: 'ペンの傾きを正確に追跡。\n自然な描き心地を実現。',
                ),
                const SizedBox(width: 24),
                _FeatureCard(
                  icon: Icons.devices,
                  title: '対応デバイス',
                  subtitle: 'Devices',
                  body: '液タブ・Surface・\nWindows タブレット全般。',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.blue.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.blue.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.blue, size: 36),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14, color: Colors.white38),
            ),
            const SizedBox(height: 12),
            Text(
              body,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white60,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
