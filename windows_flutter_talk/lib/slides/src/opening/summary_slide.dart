import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class SummarySlide extends FlutterDeckSlideWidget {
  const SummarySlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/summary',
            header: FlutterDeckHeaderConfiguration(title: '💎 Flutter @ Google I/O 2026'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const _SummaryContent(),
    );
  }
}

class _SummaryContent extends StatefulWidget {
  const _SummaryContent();

  @override
  State<_SummaryContent> createState() => _SummaryContentState();
}

class _SummaryContentState extends State<_SummaryContent> {
  bool _stamped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _stamped = true),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(96, 8, 96, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ── 45%: AI (大) ──────────────────────────────
                  _Section(
                    headingSize: 19,
                    bodySize: 13,
                    color: Colors.white,
                    heading: '🤖 1. AIと開発ワークフローの融合 (Agentic Workflows)',
                    body:
                        'Agentic Hot Reload (エージェント指向ホットリロード):\n'
                        'CursorなどのAIコーディングエージェントが、Dart/FlutterのMCP（Model Context Protocol）サーバーを介して実行中のアプリに自動接続。\n'
                        'AIがコードを修正すると、エンジニアが手を動かさずとも自動でホットリロードが走り、結果が手元で確認できるようになりました。\n'
                        'GenUI SDK & A2UI Protocol:\n'
                        'AIの返答をテキスト（Markdown）ではなく、実際のFlutterのウィジェットとして動的に組み立ててアプリ内にレンダリングするプロトコルが発表されました。',
                    stampLabel: '今日はやりません',
                    stampColor: Colors.redAccent,
                    stamped: _stamped,
                  ),

                  // ── 20%: Decoupling (中) ──────────────────────
                  _Section(
                    headingSize: 16,
                    bodySize: 12,
                    color: Colors.white,
                    heading: '📱 2. コアフレームワークの大分離（The Great Decoupling）',
                    body:
                        'Material / Cupertino のパッケージ化: これまでFlutter本体と密結合していたMaterialとCupertinoのUIライブラリが、コアリポジトリから凍結・分離され、\n'
                        'pub.dev上の独立したパッケージ（material_ui / cupertino_ui）へ移行が始まります。\n'
                        'これにより、独自のデザインシステムを持つチームは、不要なUIコードを抱えずに「純粋な描画キャンバス」としてFlutterを利用できるようになります。',
                    stampLabel: '今日はやりません',
                    stampColor: Colors.redAccent,
                    stamped: _stamped,
                  ),

                  // ── 25%: Platform (小) ────────────────────────
                  _Section(
                    headingSize: 14,
                    bodySize: 11,
                    color: Colors.white,
                    heading: '🔧 3. プラットフォームとパフォーマンスの成熟',
                    body:
                        'iOS/macOS: Swift Package Manager (SPM) がデフォルトに。CocoaPodsの呪縛から脱却し、CLIによる自動マイグレーションに対応。\n'
                        'Windows環境からGitHub Actions等を用いたiOSビルドの安定性が劇的に向上します。\n'
                        'Android: Hybrid Composition++ (HCPP) & Pure Impeller。Android 10以上でImpeller（Vulkan）が完全デフォルト化され、Skiaが削除。\n'
                        'さらにGoogle Mapsなどのネイティブビューを埋め込むPlatform Viewsの描画をOSの SurfaceControl に委ねる「HCPP」により、スクロールの引っかかりが根本から解消されました。',
                    stampLabel: '今日やります！',
                    stampColor: AppColors.blue,
                    stamped: _stamped,
                  ),

                  // ── 10%: Desktop (極小・オチ) ─────────────────
                  _Section(
                    headingSize: 12,
                    bodySize: 10,
                    color: Colors.white,
                    heading: '🖥️ 4. デスクトップ & 組み込み（Embedded）の強化',
                    body:
                        'Canonicalがデスクトップ全体のリードメンテナに。Ubuntuの開発元であるCanonicalが、LinuxだけでなくWindows、macOSを含むデスクトップ全体のロードマップとメンテナを引き受けました。\n'
                        'Windowsスタイラスペンのネイティブサポート: コミュニティ（CodeDoctorDE氏）の多大な貢献により、Windowsの液タブやタブレットPCでの筆圧感知・回転の正確なトラッキングに対応。\n'
                        '広がるエコシステム: 2026年型トヨタRAV4のインフォテインメントシステムへのFlutter採用や、LGのwebOS（スマートTV向け）公式SDKのプレビューなどが実機デモとともに紹介されました。',
                    stampLabel: '今日やります！',
                    stampColor: AppColors.blue,
                    stamped: _stamped,
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

class _Section extends StatelessWidget {
  const _Section({
    required this.headingSize,
    required this.bodySize,
    required this.color,
    required this.heading,
    required this.body,
    this.stampLabel,
    this.stampColor,
    this.stamped = false,
  });

  final double headingSize;
  final double bodySize;
  final Color color;
  final String heading;
  final String body;
  final String? stampLabel;
  final Color? stampColor;
  final bool stamped;

  // Lines ending with ":" become bold (standalone subheadings).
  // Lines starting with "Label: description" get a bold label prefix.
  List<InlineSpan> _parseBodySpans() {
    final lines = body.split('\n');
    final spans = <InlineSpan>[];
    final inlineLabelRegex = RegExp(r'^([^:]+:)\s(.+)$');

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final suffix = i < lines.length - 1 ? '\n' : '';

      if (line.trim().isEmpty) {
        spans.add(TextSpan(text: suffix));
        continue;
      }

      if (line.trimRight().endsWith(':')) {
        spans.add(TextSpan(
          text: '$line$suffix',
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ));
        continue;
      }

      final match = inlineLabelRegex.firstMatch(line);
      if (match != null) {
        spans.add(TextSpan(children: [
          TextSpan(
            text: match.group(1)!,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          TextSpan(text: '\n${match.group(2)!}$suffix'),
        ]));
        continue;
      }

      spans.add(TextSpan(text: '$line$suffix'));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
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
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: bodySize,
                  color: color.withValues(alpha: 0.75),
                  height: 1.5,
                ),
                children: _parseBodySpans(),
              ),
            ),
          ],
        ),
        if (stampLabel != null)
          Positioned(
            right: 32,
            top: 0,
            bottom: 0,
            child: Center(
              child: AnimatedScale(
                scale: stamped ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.elasticOut,
                child: Transform.rotate(
                  angle: -0.18,
                  child: _StampBadge(
                    label: stampLabel!,
                    color: stampColor!,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _StampBadge extends StatelessWidget {
  const _StampBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: color,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
