import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class SummarySlide extends FlutterDeckSlideWidget {
  const SummarySlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(route: '/summary'),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const _SummaryContent(),
    );
  }
}

class _SummaryContent extends StatelessWidget {
  const _SummaryContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Text(
                'Flutter 3.44、',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '盛りだくさんすぎる',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ── 45%: AI (大) ──────────────────────────────
                _Section(
                  headingSize: 24,
                  bodySize: 14,
                  color: Colors.white,
                  heading: '🤖 1. AIと開発ワークフローの融合 (Agentic Workflows)',
                  body:
                      'Agentic Hot Reload: CursorなどのAIコーディングエージェントが、Dart/FlutterのMCP（Model Context Protocol）サーバーを介して実行中のアプリに自動接続。AIがコードを修正すると、エンジニアが手を動かさずとも自動でホットリロードが走り、結果が手元で確認できるようになりました。\n'
                      'GenUI SDK & A2UI Protocol: AIの返答をテキスト（Markdown）ではなく、実際のFlutterのウィジェットとして動的に組み立ててアプリ内にレンダリングするプロトコルが発表されました。',
                ),

                // ── 25%: Platform (中) ────────────────────────
                _Section(
                  headingSize: 21,
                  bodySize: 12,
                  color: Colors.white70,
                  heading: '📱 2. コアフレームワークの大分離（The Great Decoupling）',
                  body:
                      'Material / Cupertino のパッケージ化: これまでFlutter本体と密結合していたMaterialとCupertinoのUIライブラリが、コアリポジトリから凍結・分離され、pub.dev上の独立したパッケージ（material_ui / cupertino_ui）へ移行が始まります。',
                ),

                // ── 20%: Decoupling (小) ──────────────────────
                _Section(
                  headingSize: 18,
                  bodySize: 11,
                  color: Colors.white54,
                  heading: '🔧 3. プラットフォームとパフォーマンスの成熟',
                  body:
                      'iOS/macOS: Swift Package Manager (SPM) がデフォルトに。CocoaPodsの呪縛から脱却し、CLIによる自動マイグレーションに対応。'
                      'Android: Hybrid Composition++ (HCPP) & Pure Impeller。Android 10以上でImpeller（Vulkan）が完全デフォルト化され、Skiaが削除。',
                ),

                // ── 10%: Desktop (極小・オチ) ─────────────────
                _Section(
                  headingSize: 16,
                  bodySize: 10,
                  color: Colors.white38,
                  heading: '🖥️ 4. デスクトップ & 組み込み（Embedded）の強化',
                  body:
                      'Canonicalがデスクトップ全体のリードメンテナに。Ubuntuの開発元であるCanonicalが、LinuxだけでなくWindows、macOSを含むデスクトップ全体のロードマップとメンテナを引き受けました。'
                      'Windowsスタイラスペンのネイティブサポート: コミュニティ（CodeDoctorDE氏）の多大な貢献により、Windowsの液タブやタブレットPCでの筆圧感知・回転の正確なトラッキングに対応。'
                      '広がるエコシステム: 2026年型トヨタRAV4のインフォテインメントシステムへのFlutter採用や、LGのwebOS（スマートTV向け）公式SDKのプレビューなどが実機デモとともに紹介されました。',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.headingSize,
    required this.bodySize,
    required this.color,
    required this.heading,
    required this.body,
  });

  final double headingSize;
  final double bodySize;
  final Color color;
  final String heading;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            fontSize: headingSize,
            fontWeight: FontWeight.bold,
            color: color,
            height: 1.4,
          ),
        ),
        Text(
          body,
          style: TextStyle(
            fontSize: bodySize,
            color: color.withValues(alpha: 0.75),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
