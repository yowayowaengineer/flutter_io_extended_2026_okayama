import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windows_flutter_talk/slides/slides.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      builder: (context, child) => FlutterDeckApp(
        slides: slides,
        lightTheme: FlutterDeckThemeData(
          brightness: Brightness.light,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.deckBackground,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.blue,
              brightness: Brightness.light,
              surface: AppColors.deckBackground,
              onSurface: AppColors.deckText,
            ),
          ),
          textTheme: const FlutterDeckTextTheme().apply(
            color: AppColors.deckText,
          ),
        ),
        darkTheme: FlutterDeckThemeData(
          brightness: Brightness.dark,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.deckBackground,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.blue,
              brightness: Brightness.dark,
              surface: AppColors.deckBackground,
              onSurface: AppColors.deckText,
            ),
          ),
          textTheme: const FlutterDeckTextTheme().apply(
            color: AppColors.deckText,
          ),
        ),
        configuration: FlutterDeckConfiguration(
          background: const FlutterDeckBackgroundConfiguration(
            light: FlutterDeckBackground.solid(AppColors.deckBackground),
            dark: FlutterDeckBackground.solid(AppColors.deckBackground),
          ),
          controls: const FlutterDeckControlsConfiguration(
            presenterToolbarVisible: true,
            gestures: FlutterDeckGesturesConfiguration.mobileOnly(),
            shortcuts: FlutterDeckShortcutsConfiguration(
              enabled: true,
              nextSlide: {SingleActivator(LogicalKeyboardKey.arrowRight)},
              previousSlide: {SingleActivator(LogicalKeyboardKey.arrowLeft)},
              toggleMarker: {SingleActivator(
                LogicalKeyboardKey.keyM,
                control: true,
                meta: true,
              )},
              toggleNavigationDrawer: {SingleActivator(
                LogicalKeyboardKey.period,
                control: true,
                meta: true,
              )},
            ),
          ),
          transition: const FlutterDeckTransition.fade(),
          footer: const FlutterDeckFooterConfiguration(
            showSlideNumbers: true,
            widget: _AnimatedFooterWidget(),
          ),
        ),
      ),
    );
  }
}

class _AnimatedFooterWidget extends StatefulWidget {
  const _AnimatedFooterWidget();

  @override
  State<_AnimatedFooterWidget> createState() => _AnimatedFooterWidgetState();
}

class _AnimatedFooterWidgetState extends State<_AnimatedFooterWidget>
    with SingleTickerProviderStateMixin {
  static DateTime? _startTime;
  static const _totalDuration = Duration(minutes: 30);
  static const _idleImagePath = 'assets/images/player-idle.png';

  final List<String> _imagePaths = [
    'assets/images/player-walk-left.gif',
    'assets/images/player-walk-right.gif',
  ];

  late Ticker _ticker;
  double _t = 0.0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) {
      if (_startTime == null || !mounted) return;
      final elapsedMs =
          DateTime.now().difference(_startTime!).inMilliseconds %
          _totalDuration.inMilliseconds;
      setState(() => _t = elapsedMs / _totalDuration.inMilliseconds);
    })..start();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_startTime == null) {
      final slideIndex = context.flutterDeck.router.currentSlideIndex;
      if (slideIndex >= 1) {
        _startTime = DateTime.now();
      }
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const imageSize = 50.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final footerTop = screenHeight * 0.89;
    const logoWidth = 100.0;
    const logoPosition = logoWidth;
    const rightMargin = 100.0;
    final rightEndPosition = screenWidth - rightMargin;

    final bool started = _startTime != null;

    double position;
    String imagePath;

    if (started) {
      if (_t <= 0.5) {
        final progress = _t * 2.0;
        position =
            rightEndPosition -
            (rightEndPosition - logoPosition + imageSize) * progress;
        imagePath = _imagePaths[0];
      } else {
        final progress = (_t - 0.5) * 2.0;
        position =
            logoPosition -
            imageSize +
            (rightEndPosition - logoPosition + imageSize) * progress;
        imagePath = _imagePaths[1];
      }
    } else {
      position = rightEndPosition;
      imagePath = _idleImagePath;
    }

    return UnconstrainedBox(
      constrainedAxis: Axis.horizontal,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo_512x512.png',
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: position,
              top: footerTop - (screenHeight * 0.9),
              child: Image.asset(
                imagePath,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: Container(
                      color: Colors.grey.withValues(alpha: 0.3),
                      child: const Icon(Icons.image, size: 20),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
