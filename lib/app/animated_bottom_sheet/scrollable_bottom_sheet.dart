import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';

const double minHeight = 120;
const double iconStartSize = 44; //<-- add edge values
const double iconEndSize = 120; //<-- add edge values
const double iconStartMarginTop = 36; //<-- add edge values
const double iconEndMarginTop = 80; //<-- add edge values
const double iconsVerticalSpacing = 24; //<-- add edge values
const double iconsHorizontalSpacing = 16; //<-- add edge values

class ScrollableBottomSheet extends StatefulWidget {
  const ScrollableBottomSheet({Key? key}) : super(key: key);

  @override
  _ScrollableBottomSheetState createState() => _ScrollableBottomSheetState();
}

class _ScrollableBottomSheetState extends State<ScrollableBottomSheet>
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

  double? get iconLeftBorderRadius =>
      itemBorderRadius; //<-- Left border radius stays the same

  double? get iconRightBorderRadius =>
      lerp(8, 0); //<-- Right border radius lerps to 0 instead.

  double? get iconSize =>
      lerp(iconStartSize, iconEndSize); //<-- increase icon size

  double? iconTopMargin(int index) =>
      lerp(iconStartMarginTop,
          iconEndMarginTop + index * (iconsVerticalSpacing + iconEndSize))! +
      headerTopMargin!; //<-- calculate top margin based on header margin, and size of all of icons above (from small to big)

  double? iconLeftMargin(int index) => lerp(
      index * (iconsHorizontalSpacing + iconStartSize),
      0); //<-- calculate left margin (from big to small)

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
                          SheetHeader(
                            fontSize: headerFontSize!,
                            topMargin: headerTopMargin!,
                          ),
                          for (Event event in events)
                            _buildFullItem(event), //<-- Add FullItems
                          for (Event event in events)
                            _buildIcon(event), //<-- Add icons to the stack
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

  Widget _buildIcon(Event event) {
    int index = events.indexOf(event); //<-- Get index of the event.
    return Positioned(
      height: iconSize, //<-- Specify icon's size
      width: iconSize, //<-- Specify icon's size
      top: iconTopMargin(index), //<-- Specify icon's top margin
      left: iconLeftMargin(index), //<-- Specify icon's left margin
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(
          left:
              Radius.circular(iconLeftBorderRadius!), //<-- update border radius
          right: Radius.circular(
              iconRightBorderRadius!), //<-- update border radius
        ),
        child: Image.asset(
          'assets/images/${event.assetName}',
          fit: BoxFit.cover,
          alignment: Alignment(
              lerp(1, 0)!, 0), //<-- Play with alignment for extra style points
        ),
      ),
    );
  }

  Widget _buildFullItem(Event event) {
    int index = events.indexOf(event);
    return ExpandedEventItem(
      topMargin:
          iconTopMargin(index), //<--provide margins and height same as for icon
      leftMargin: iconLeftMargin(index)!,
      height: iconSize,
      isVisible:
          _controller.status == AnimationStatus.completed, //<--set visibility
      borderRadius: itemBorderRadius, //<-- pass border radius
      title: event.title, //<-- data to be displayed
      date: event.date, //<-- data to be displayed
    );
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

class SheetHeader extends StatelessWidget {
  final double fontSize;
  final double topMargin;

  const SheetHeader({Key? key, required this.fontSize, required this.topMargin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      child: Text(
        'Booked Tickets',
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

final List<Event> events = [
  Event('citi1.jpg', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('citi2.jpg', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('citi3.jpg', 'Dawan District Guangdong Hong Kong', '4.28-31'),
];

class Event {
  // model class
  final String assetName;
  final String title;
  final String date;

  Event(this.assetName, this.title, this.date);
}

class ExpandedEventItem extends StatelessWidget {
  final double? topMargin;
  final double? leftMargin;
  final double? height;
  final bool? isVisible;
  final double? borderRadius;
  final String? title;
  final String? date;

  const ExpandedEventItem(
      {Key? key,
      required this.topMargin,
      required this.leftMargin,
      required this.height,
      required this.isVisible,
      required this.borderRadius,
      required this.title,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      left: leftMargin,
      right: 0,
      height: height,
      child: AnimatedOpacity(
        opacity: isVisible! ? 1 : 0,
        duration: Duration(milliseconds: 200),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius!),
            color: Colors.white,
          ),
          padding: EdgeInsets.only(left: height!).add(EdgeInsets.all(8)),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: <Widget>[
        Text(title!, style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Row(
          children: <Widget>[
            Text(
              '1 ticket',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(width: 8),
            Text(
              date!,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Spacer(),
        Row(
          children: <Widget>[
            Icon(
              Icons.place,
              color: Colors.grey.shade400,
              size: 16,
            ),
            Text(
              'Science Park 10 25A',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
