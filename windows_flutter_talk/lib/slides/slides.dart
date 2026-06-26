import 'package:flutter_deck/flutter_deck.dart';
import 'package:windows_flutter_talk/slides/src/opening/event_title_slide.dart';
import 'package:windows_flutter_talk/slides/src/opening/title_slide.dart';
import 'package:windows_flutter_talk/slides/src/me/who_am_i_slide.dart';
import 'package:windows_flutter_talk/slides/src/me/who_am_i_2_slide.dart';
import 'package:windows_flutter_talk/slides/src/opening/summary_slide.dart';
import 'package:windows_flutter_talk/slides/src/opening/windows_perspective_slide.dart';
import 'package:windows_flutter_talk/slides/src/spm/ios_build_wall_slide.dart';
import 'package:windows_flutter_talk/slides/src/spm/spm_default_slide.dart';
import 'package:windows_flutter_talk/slides/src/spm/cicd_slide.dart';
import 'package:windows_flutter_talk/slides/src/spm/comparison_slide.dart';
import 'package:windows_flutter_talk/slides/src/stylus/desktop_era_slide.dart';
import 'package:windows_flutter_talk/slides/src/stylus/multiwindow_slide.dart';
import 'package:windows_flutter_talk/slides/src/stylus/stylus_backstory_slide.dart';
import 'package:windows_flutter_talk/slides/src/stylus/stylus_support_slide.dart';
import 'package:windows_flutter_talk/slides/src/stylus/desktop_possibilities_slide.dart';
import 'package:windows_flutter_talk/slides/src/stylus/flutter_desktop_advantage_slide.dart';
import 'package:windows_flutter_talk/slides/src/closing/closing_slide.dart';
import 'package:windows_flutter_talk/slides/src/closing/references_slide.dart';

List<FlutterDeckSlideWidget> get slides => [
  // オープニング
  const EventTitleSlide(),
  const WhoAmISlide(),
  const SummarySlide(),
  const WindowsPerspectiveSlide(),
  const TitleSlide(),
  const WhoAmI2Slide(),

  // SPM
  const IosBuildWallSlide(),
  const SpmDefaultSlide(),
  const CicdSlide(),
  const ComparisonSlide(),

  // スタイラス
  const DesktopEraSlide(),
  const MultiwindowSlide(),
  const StylusSupportSlide(),
  const StylusBackstorySlide(),
  const DesktopPossibilitiesSlide(),
  const FlutterDesktopAdvantageSlide(),

  // クロージング
  const ClosingSlide(),
  const ReferencesSlide(),
];
