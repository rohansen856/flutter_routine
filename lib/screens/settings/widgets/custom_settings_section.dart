import 'package:flutter/material.dart';
import 'package:admin/screens/settings/widgets/abstract_settings_section.dart';

class CustomSettingsSection extends AbstractSettingsSection {
  const CustomSettingsSection({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
