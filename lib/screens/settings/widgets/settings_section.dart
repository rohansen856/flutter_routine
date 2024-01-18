import 'package:flutter/material.dart';
import 'package:admin/screens/settings/widgets/abstract_settings_section.dart';
import 'package:admin/screens/settings/widgets/ios_settings_section.dart';
import 'package:admin/screens/settings/widgets/abstract_settings_tile.dart';
import 'package:admin/screens/settings/utils/platform_utils.dart';
import 'package:admin/screens/settings/utils/settings_theme.dart';

class SettingsSection extends AbstractSettingsSection {
  const SettingsSection({
    required this.tiles,
    this.margin,
    this.title,
    Key? key,
  }) : super(key: key);

  final List<AbstractSettingsTile> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    final theme = SettingsTheme.of(context);
    if(theme.platform == DevicePlatform.device)
    throw Exception(
      'You can\'t use the DevicePlatform.device in this context. '
      'Incorrect platform: SettingsSection.build',
    );

    return IOSSettingsSection(
      title: title,
      tiles: tiles,
      margin: margin,
    );
  }
}
