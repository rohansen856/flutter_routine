import 'package:admin/screens/settings/widgets/abstract_settings_tile.dart';
import 'package:admin/screens/settings/widgets/settings_tile.dart';
import 'package:admin/screens/settings/utils/settings_theme.dart';
import 'package:flutter/material.dart';
import 'package:admin/screens/settings/widgets/ios_settings_tile.dart';

class IOSSettingsSection extends StatelessWidget {
  const IOSSettingsSection({
    required this.tiles,
    required this.margin,
    required this.title,
    Key? key,
  }) : super(key: key);

  final List<AbstractSettingsTile> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    final theme = SettingsTheme.of(context);
    final isLastNonDescriptive = tiles.last is SettingsTile &&
        (tiles.last as SettingsTile).description == null;
    final scaleFactor = MediaQuery.of(context).textScaler;

    return Padding(
      padding: margin ??
          EdgeInsets.only(
            top: scaleFactor.scale(14.0),
            bottom: isLastNonDescriptive ? scaleFactor.scale(27) : scaleFactor.scale(10),
            left: 16,
            right: 16,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 18,
                bottom: scaleFactor.scale(5),
              ),
              child: DefaultTextStyle(
                style: TextStyle(
                  color: theme.themeData.titleTextColor,
                  fontSize: 13,
                ),
                child: title!,
              ),
            ),
          buildTileList(),
        ],
      ),
    );
  }

  Widget buildTileList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tiles.length,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final tile = tiles[index];

        var enableTop = false;

        if (index == 0 ||
            (index > 0 &&
                tiles[index - 1] is SettingsTile &&
                (tiles[index - 1] as SettingsTile).description != null)) {
          enableTop = true;
        }

        var enableBottom = false;

        if (index == tiles.length - 1 ||
            (index < tiles.length &&
                tile is SettingsTile &&
                (tile).description != null)) {
          enableBottom = true;
        }

        return IOSSettingsTileAdditionalInfo(
          enableTopBorderRadius: enableTop,
          enableBottomBorderRadius: enableBottom,
          needToShowDivider: index != tiles.length - 1,
          child: tile,
        );
      },
    );
  }
}
