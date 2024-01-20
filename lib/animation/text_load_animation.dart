import 'package:admin/theme/theme_data.dart';
import 'package:flutter/material.dart';

class TextLoadingAnimation extends StatefulWidget {
  @override
  _TextLoadingAnimationState createState() =>
      _TextLoadingAnimationState();
}

class _TextLoadingAnimationState extends State<TextLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();

    // Set up animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // Set up position animation
    _positionAnimation = Tween<double>(begin: -20.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Set up width animation
    _widthAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 5.0, end: 20.0),
          weight: 1, // Represents the duration of the first part (5 to 20)
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 20.0, end: 5.0),
          weight: 1, // Represents the duration of the second part (20 to 5)
        ),
      ],
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Repeat the animation indefinitely
    _controller.repeat(reverse: true);

    // Repeat the animation indefinitely
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          height: 5.0,
          width: _widthAnimation.value,
          child: Transform.translate(
            offset: Offset(_positionAnimation.value, 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.deactivatedText,
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}