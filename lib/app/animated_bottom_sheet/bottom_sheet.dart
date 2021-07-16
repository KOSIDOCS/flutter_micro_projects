import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';

const double minHeight = 120;

class AnimatedBottomSheet extends StatefulWidget {
  const AnimatedBottomSheet({Key? key}) : super(key: key);

  @override
  _AnimatedBottomSheetState createState() => _AnimatedBottomSheetState();
}

class _AnimatedBottomSheetState extends State<AnimatedBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; //<-- Create a controller
  late Animation<double> _myAnimation; //<-- Animation for menu icon.

  double get maxHeight =>
      MediaQuery.of(context).size.height; //<-- Get max height of the screen

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      //<-- initialize a controller
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _myAnimation = CurvedAnimation(curve: Curves.linear, parent: _controller);
  }

  @override
  void dispose() {
    _controller.dispose(); //<-- and remember to dispose it!
    super.dispose();
  }

  double? get headerTopMargin =>
      lerp(20, 20 + MediaQuery.of(context).padding.top); //<-- Add new property

  double? get headerFontSize => lerp(14, 24); //<-- Add new property

  double? get itemBorderRadius => lerp(8, 24); //<-- increase item border radius

  double? lerp(double min, double max) => lerpDouble(
      min, max, _controller.value); //<-- lerp any value based on the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              children: [
                Positioned(
                  height: lerp(minHeight,
                      maxHeight), //<-- update height value to scale with controller
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: _toggle, //<-- on tap
                    onVerticalDragUpdate:
                        _handleDragUpdate, //<-- Add verticalDragUpdate callback
                    onVerticalDragEnd:
                        _handleDragEnd, //<-- Add verticalDragEnd callback
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      decoration: const BoxDecoration(
                        color: Color(0xFF32594F),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(32)),
                      ),
                      child: Stack(
                        children: [
                          MenuButton(
                            progress: _myAnimation,
                          ), //<-- With a menu button
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  // List<String?> allNull = ['come', null, 'home'];
  // List<String>? nonNulla;

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta! /
        maxHeight; //<-- Update the controller.value by the movement done by user.
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }

  void _toggle() {
    final bool isOpen = _controller.status == AnimationStatus.completed;
    _controller.fling(
        velocity: isOpen ? -2 : 2); //<-- snap the sheet in proper direction
  }
}

class MenuButton extends StatelessWidget {
  final Animation<double> progress;
  MenuButton({Key? key, required this.progress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      //<-- Align the icon to bottom right corner
      right: 0,
      bottom: 24,
      child: AnimatedIcon(
        progress: progress,
        icon: AnimatedIcons.menu_close,
        size: 40,
        color: Colors.white,
      ),
    );
  }
}
