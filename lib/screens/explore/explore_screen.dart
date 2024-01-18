import 'package:admin/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'header.dart';

class ExploreScreen extends StatefulWidget {
    const ExploreScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(AppTheme.defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: AppTheme.defaultPadding),
            ],
          ),
        ),
      );
  }
}
