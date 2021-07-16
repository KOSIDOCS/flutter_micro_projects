import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_mic_ui/app/card_scroll/constants.dart';

const double minWidth = 20;
const double maxWidth = 120;

class BottomBarTextOpen extends StatefulWidget {
  const BottomBarTextOpen({Key? key}) : super(key: key);

  @override
  _BottomBarTextOpenState createState() => _BottomBarTextOpenState();
}

class _BottomBarTextOpenState extends State<BottomBarTextOpen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; //<-- Create a controller

  final iconList = List<IconData>.unmodifiable([
    FeatherIcons.home,
    FeatherIcons.search,
    FeatherIcons.heart,
    FeatherIcons.user,
  ]);

  int activeIcon = 0;
  bool isOn = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      //<-- initialize a controller
      vsync: this,
      duration: Duration(milliseconds: 600),
    )
      ..addStatusListener((status) {
        print(status);
        if (status == AnimationStatus.forward) {
          setState(() {
            isOn = true;
          });
        } else if (status == AnimationStatus.dismissed) {
          setState(() {
            isOn = false;
          });
        }
      })
      ..addListener(() {
        print(_controller.status);
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); //<-- and remember to dispose it!
    super.dispose();
  }

  double? lerp(double min, double max) => lerpDouble(
      min, max, _controller.value); //<-- lerp any value based on the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF32594F),
      body: CustomBottomBar(
          icons: iconList,
          onPressed: (i) {
            _controller.reverse();
            Timer(Duration(seconds: 1), () {
              _toggle();
              setState(() {
                activeIcon = i;
                print('clicked icon $i');
              });
            });
          },
          activeIndex: activeIcon,
          margin: true,
          controller: _controller,
          isOn: isOn,
          lerp: lerp(minWidth, maxWidth)!),
    );
  }

  void _toggle() {
    final bool isOpen = _controller.status == AnimationStatus.completed;
    _controller.fling(
        velocity: isOpen ? -2 : 2); //<-- snap the sheet in proper direction
    print('this is open $isOpen');
  }
}

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    required this.icons,
    required this.onPressed,
    required this.activeIndex,
    required this.margin,
    required this.controller,
    required this.isOn,
    required this.lerp,
  });

  final List<IconData> icons;
  final Function(int) onPressed;
  final int activeIndex;
  final bool margin;
  final AnimationController controller;
  final bool isOn;
  final double lerp;

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  double? lerp(double min, double max) => lerpDouble(min, max,
      widget.controller.value); //<-- lerp any value based on the controller

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          height: 80.0, //<-- update height value to scale with controller
          left: 0,
          right: 0,
          top: 60.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32), bottom: Radius.circular(32)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < widget.icons.length; i++)
                  AnimatedBuilder(
                    animation: widget.controller,
                    builder: (context, child) {
                      return GestureDetector(
                        onTap: () => widget.onPressed(i),
                        child: Container(
                          height: 48.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: i == widget.activeIndex && widget.isOn
                                ? Color(0x6632594F)
                                : const Color(0x0032594F),
                          ),
                          child: Icon(
                            widget.icons[i],
                            color: i == widget.activeIndex && widget.isOn
                                ? Colors.white
                                : kSidenoteGrey,
                          ),
                          width: i == widget.activeIndex && widget.isOn
                              ? lerp(minWidth, maxWidth)
                              : 20.0,
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
        Positioned(
          height: 100.0, //<-- update height value to scale with controller
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < widget.icons.length; i++)
                  AnimatedBuilder(
                    animation: widget.controller,
                    builder: (context, child) {
                      return GestureDetector(
                        onTap: () => widget.onPressed(i),
                        child: Container(
                          height: 48.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: i == widget.activeIndex && widget.isOn
                                ? Color(0x6632594F)
                                : const Color(0x0032594F),
                          ),
                          child: Icon(
                            widget.icons[i],
                            color: i == widget.activeIndex && widget.isOn
                                ? Colors.white
                                : kSidenoteGrey,
                          ),
                          width: i == widget.activeIndex && widget.isOn
                              ? lerp(minWidth, maxWidth)
                              : 20.0,
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
