import 'package:admin/animation/text_load_animation.dart';
import 'package:admin/screens/explore/widgets/github_users.dart';
import 'package:admin/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'widgets/header.dart';

class ExploreScreen extends StatefulWidget {
    const ExploreScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  @override
  Widget build(BuildContext context) {
    return GithubUsers();
  }
}
