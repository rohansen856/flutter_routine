import 'package:flutter/material.dart';

abstract class AbstractSettingsTile extends StatelessWidget {
  const AbstractSettingsTile({Key? key}) : super(key: key);
}


class CustomSettingsTile extends AbstractSettingsTile {
  const CustomSettingsTile({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
