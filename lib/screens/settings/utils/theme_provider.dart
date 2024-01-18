import 'package:admin/theme/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin/screens/settings/utils/platform_utils.dart';
import 'package:admin/screens/settings/utils/settings_theme.dart';

class ThemeProvider {
  static SettingsThemeData getTheme({
    required BuildContext context,
    required DevicePlatform platform,
    required Brightness brightness,
  }) {
    if(platform == DevicePlatform.device)
    throw Exception(
      'You can\'t use the DevicePlatform.device in this context. '
      'Incorrect platform: ThemeProvider.getTheme',
    );

    return _iosTheme(context: context, brightness: brightness);
  }

  static SettingsThemeData _iosTheme({
    required BuildContext context,
    required Brightness brightness,
  }) {
    final lightSettingsListBackground = AppTheme.bgColor;
    final darkSettingsListBackground = AppTheme.bgColor;

    final lightSettingSectionColor = AppTheme.secondaryColor;
    final darkSettingSectionColor = AppTheme.secondaryColor;

    final lightSettingsTitleColor = AppTheme.white;
    final darkSettingsTitleColor = AppTheme.white;

    final lightDividerColor = AppTheme.bgColor;
    final darkDividerColor = AppTheme.bgColor;

    final lightTrailingTextColor = AppTheme.white;
    final darkTrailingTextColor = AppTheme.white;

    final lightTileHighlightColor = AppTheme.white;
    final darkTileHighlightColor = AppTheme.white;

    final lightSettingsTileTextColor = AppTheme.white;
    final darkSettingsTileTextColor = AppTheme.white;

    final lightLeadingIconsColor = CupertinoColors.inactiveGray;
    final darkLeadingIconsColor = CupertinoColors.inactiveGray;

    final isLight = brightness == Brightness.light;

    final listBackground =
        isLight ? lightSettingsListBackground : darkSettingsListBackground;

    final sectionBackground =
        isLight ? lightSettingSectionColor : darkSettingSectionColor;

    final titleTextColor =
        isLight ? lightSettingsTitleColor : darkSettingsTitleColor;

    final settingsTileTextColor =
        isLight ? lightSettingsTileTextColor : darkSettingsTileTextColor;

    final dividerColor = isLight ? lightDividerColor : darkDividerColor;

    final trailingTextColor =
        isLight ? lightTrailingTextColor : darkTrailingTextColor;

    final tileHighlightColor =
        isLight ? lightTileHighlightColor : darkTileHighlightColor;

    final leadingIconsColor =
        isLight ? lightLeadingIconsColor : darkLeadingIconsColor;

    return SettingsThemeData(
      tileHighlightColor: tileHighlightColor,
      settingsListBackground: listBackground,
      settingsSectionBackground: sectionBackground,
      titleTextColor: titleTextColor,
      dividerColor: dividerColor,
      trailingTextColor: trailingTextColor,
      settingsTileTextColor: settingsTileTextColor,
      leadingIconsColor: leadingIconsColor,
      inactiveTitleColor: CupertinoColors.inactiveGray,
      inactiveSubtitleColor: CupertinoColors.inactiveGray,
    );
  }
}
