// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:io';
import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/_window.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runWidget(const MyApp());
}

class _MainWindowDelegate with RegularWindowControllerDelegate {
  @override
  void onWindowDestroyed() {
    super.onWindowDestroyed();
    exit(0);
  }
}

class _CallbackRegularWindowDelegate with RegularWindowControllerDelegate {
  _CallbackRegularWindowDelegate({required this.onDestroyed});
  final VoidCallback onDestroyed;

  @override
  void onWindowDestroyed() {
    onDestroyed();
    super.onWindowDestroyed();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final RegularWindowController _controller = RegularWindowController(
    preferredSize: const Size(800, 600),
    title: 'Flutter 3.44 Stylus Demo',
    delegate: _MainWindowDelegate(),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RegularWindow(
      controller: _controller,
      child: WindowManager(
        child: MaterialApp(
          title: 'Stylus Demo',
          theme: ThemeData(colorSchemeSeed: Colors.blue),
          home: const StylusCanvas(),
        ),
      ),
    );
  }
}

class StrokePoint {
  final Offset position;
  final double pressure;
  final double orientation;
  final double tilt;

  const StrokePoint({
    required this.position,
    required this.pressure,
    required this.orientation,
    required this.tilt,
  });
}

class StylusCanvas extends StatefulWidget {
  const StylusCanvas({super.key});

  @override
  State<StylusCanvas> createState() => _StylusCanvasState();
}

class _StylusCanvasState extends State<StylusCanvas>
    with SingleTickerProviderStateMixin {
  final List<List<StrokePoint>> _strokes = [];
  List<StrokePoint> _currentStroke = [];

  double _lastRawPressure = 0.0;
  String _lastKind = '-';

  Timer? _linkTimer;
  bool _isLinkMode = false;

  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  WindowRegistry? _windowRegistry;
  WindowEntry? _clearWindowEntry;
  RegularWindowController? _clearWindowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..addListener(() {
        setState(() {});
      });
    _glowAnimation = Tween<double>(begin: 4.0, end: 16.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _windowRegistry = WindowRegistry.maybeOf(context);
  }

  @override
  void dispose() {
    _linkTimer?.cancel();
    _glowController.dispose();
    _clearWindowController?.destroy();
    super.dispose();
  }

  bool _isDrawingDevice(PointerEvent event) {
    return event.kind == PointerDeviceKind.stylus ||
        event.kind == PointerDeviceKind.invertedStylus ||
        event.kind == PointerDeviceKind.mouse;
  }

  void _onPointerDown(PointerEvent event) {
    if (!_isDrawingDevice(event)) return;
    _linkTimer?.cancel();
    if (_isLinkMode) {
      _glowController.stop();
    }
    setState(() {
      _isLinkMode = false;
      _currentStroke = [_toStrokePoint(event)];
      _updateDebugInfo(event);
    });
  }

  void _onPointerMove(PointerEvent event) {
    if (!_isDrawingDevice(event)) return;
    setState(() {
      _currentStroke.add(_toStrokePoint(event));
      _updateDebugInfo(event);
    });
  }

  void _onPointerUp(PointerEvent event) {
    if (!_isDrawingDevice(event)) return;
    setState(() {
      if (_currentStroke.isNotEmpty) {
        _strokes.add(List.from(_currentStroke));
      }
      _currentStroke = [];
    });

    if (_strokes.isNotEmpty) {
      _linkTimer?.cancel();

      final isStylus = event.kind == PointerDeviceKind.stylus ||
          event.kind == PointerDeviceKind.invertedStylus;

      if (isStylus) {
        _linkTimer = Timer(const Duration(seconds: 20), () {
          setState(() {
            _isLinkMode = true;
          });
          _glowController.repeat(reverse: true);
        });
      } else {
        _linkTimer = Timer(const Duration(seconds: 10), () {
          if (mounted) _openClearWindow();
        });
      }
    }
  }

  void _openClearWindow() {
    if (_clearWindowEntry != null || _windowRegistry == null) return;

    late final WindowEntry entry;
    late final RegularWindowController controller;

    controller = RegularWindowController(
      preferredSize: const Size(320, 160),
      title: 'キャンバスをリセット',
      delegate: _CallbackRegularWindowDelegate(
        onDestroyed: () {
          _clearWindowEntry = null;
          _clearWindowController = null;
        },
      ),
    );

    entry = WindowEntry(
      controller: controller,
      builder: (BuildContext context) => _ClearWindowContent(
        onClear: _clearCanvas,
      ),
    );

    _windowRegistry!.register(entry);
    _clearWindowEntry = entry;
    _clearWindowController = controller;
  }

  // Flutter on Windows reports pressureMax=2.0 for this device, which is wrong.
  // The actual range is 0–1024 (standard Wacom pressure levels).
  static const _kPressureMax = 1024.0;

  double _normalizePressure(PointerEvent event) {
    return (event.pressure / _kPressureMax).clamp(0.0, 1.0);
  }

  StrokePoint _toStrokePoint(PointerEvent event) {
    return StrokePoint(
      position: event.localPosition,
      pressure: _normalizePressure(event),
      orientation: event.orientation,
      tilt: event.tilt,
    );
  }

  void _updateDebugInfo(PointerEvent event) {
    _lastRawPressure = event.pressure;
    _lastKind = event.kind.name;
  }

  void _clearCanvas() {
    _linkTimer?.cancel();
    _glowController.stop();
    final controller = _clearWindowController;
    _clearWindowEntry = null;
    _clearWindowController = null;
    controller?.destroy();
    setState(() {
      _strokes.clear();
      _currentStroke = [];
      _isLinkMode = false;
    });
  }

  Future<void> _openCommunityLink() async {
    final uri = Uri.parse('https://okayama-dot-flutter.connpass.com/event/393552/');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    // リンクを開いた後、編集モードに戻る
    _glowController.stop();
    setState(() {
      _isLinkMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 3.44 Stylus Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'クリア',
            onPressed: _clearCanvas,
          ),
        ],
      ),
      body: Column(
        children: [
          // デバッグ情報パネル
          Container(
            width: double.infinity,
            color: Colors.grey[900],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _DebugLabel('種別', _lastKind),
                _DebugLabel('筆圧', _lastRawPressure.toStringAsFixed(3)),
              ],
            ),
          ),
          // キャンバス
          Expanded(
            child: MouseRegion(
              cursor: _isLinkMode
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              child: Listener(
                onPointerDown: _isLinkMode ? null : _onPointerDown,
                onPointerMove: _isLinkMode ? null : _onPointerMove,
                onPointerUp: _isLinkMode ? null : _onPointerUp,
                child: GestureDetector(
                  onTap: _isLinkMode ? _openCommunityLink : null,
                  child: CustomPaint(
                    size: Size.infinite,
                    foregroundPainter: StrokePainter(
                      strokes: List.from(_strokes),
                      currentStroke: List.from(_currentStroke),
                      isLinkMode: _isLinkMode,
                      glowRadius: _glowAnimation.value,
                    ),
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClearWindowContent extends StatelessWidget {
  const _ClearWindowContent({required this.onClear});
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('マウスで描画しました'),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.delete_outline),
                label: const Text('キャンバスをクリア'),
                onPressed: onClear,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DebugLabel extends StatelessWidget {
  final String label;
  final String value;

  const _DebugLabel(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class StrokePainter extends CustomPainter {
  final List<List<StrokePoint>> strokes;
  final List<StrokePoint> currentStroke;
  final bool isLinkMode;
  final double glowRadius;

  StrokePainter({
    required this.strokes,
    required this.currentStroke,
    required this.isLinkMode,
    required this.glowRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in [...strokes, currentStroke]) {
      _drawStroke(canvas, stroke);
    }
  }

  void _drawStroke(Canvas canvas, List<StrokePoint> stroke) {
    if (stroke.length < 2) return;

    for (int i = 0; i < stroke.length - 1; i++) {
      final p1 = stroke[i];
      final p2 = stroke[i + 1];

      final strokeWidth = 2.0 + p1.pressure * 18.0;

      if (isLinkMode) {
        // グロー層
        final glowPaint = Paint()
          ..color = Colors.cyanAccent.withValues(alpha: 0.6)
          ..strokeWidth = strokeWidth + glowRadius
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowRadius);
        canvas.drawLine(p1.position, p2.position, glowPaint);

        // 線本体
        final linePaint = Paint()
          ..color = Colors.lightBlueAccent
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke;
        canvas.drawLine(p1.position, p2.position, linePaint);
      } else {
        // 通常描画
        final paint = Paint()
          ..color = Colors.black
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke;
        canvas.drawLine(p1.position, p2.position, paint);
      }
    }
  }

  @override
  bool shouldRepaint(StrokePainter oldDelegate) => true;
}
