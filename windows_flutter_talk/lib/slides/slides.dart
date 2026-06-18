import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/slides/src/opening/title_slide.dart';
import 'package:windows_flutter_talk/slides/src/me/who_am_i_slide.dart';
import 'package:windows_flutter_talk/slides/src/opening/summary_slide.dart';
import 'package:windows_flutter_talk/slides/src/opening/windows_perspective_slide.dart';
import 'package:windows_flutter_talk/slides/src/spm/ios_build_wall_slide.dart';
import 'package:windows_flutter_talk/slides/src/spm/spm_default_slide.dart';
import 'package:windows_flutter_talk/slides/src/spm/cicd_slide.dart';
import 'package:windows_flutter_talk/slides/src/spm/comparison_slide.dart';
import 'package:windows_flutter_talk/slides/src/stylus/stylus_support_slide.dart';
import 'package:windows_flutter_talk/slides/src/stylus/desktop_possibilities_slide.dart';
import 'package:windows_flutter_talk/slides/src/stylus/demo_slide.dart';
import 'package:windows_flutter_talk/slides/src/closing/closing_slide.dart';
import 'package:windows_flutter_talk/slides/src/closing/references_slide.dart';

List<FlutterDeckSlideWidget> get slides => [
  // オープニング
  const TitleSlide(),
  const WhoAmISlide(),
  const SummarySlide(),
  const WindowsPerspectiveSlide(),

  // SPM
  const IosBuildWallSlide(),
  const SpmDefaultSlide(),
  const CicdSlide(),
  const ComparisonSlide(),

  // スタイラス
  const StylusSupportSlide(),
  const DesktopPossibilitiesSlide(),
  const DemoSlide(),

  // クロージング
  const ClosingSlide(),
  const ReferencesSlide(),
];
