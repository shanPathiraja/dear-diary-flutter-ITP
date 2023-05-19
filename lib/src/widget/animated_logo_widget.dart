import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedLogo extends StatefulWidget {
  final double? width;

  const AnimatedLogo({super.key, this.width});

  @override
  State<StatefulWidget> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 10))
        ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        );
      },
      child: Image(
        image: const AssetImage("images/icon.png"),
        width: widget.width,
      ),
    );
  }
}
