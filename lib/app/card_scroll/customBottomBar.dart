import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mic_ui/app/card_scroll/constants.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    required this.icons,
    required this.onPressed,
    required this.activeIndex,
    required this.margin,
  });

  final List<IconData> icons;
  final Function(int) onPressed;
  final int activeIndex;
  final bool margin;

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin == true ? EdgeInsets.only(top: 770.0) : null,
      height: 65.0,
      padding: EdgeInsets.only(left: 40.0, right: 40.0),
      decoration: BoxDecoration(
        color: widget.margin == true ? Color(0xFF162A49) : kBodyColor,
        border: Border.all(color: kBodyColor, width: 2.0),
        borderRadius: BorderRadius.all(
          Radius.circular(19.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 0; i < widget.icons.length; i++)
            GestureDetector(
              onTap: () => widget.onPressed(i),
              child: Icon(
                widget.icons[i],
                // color: i == widget.activeIndex ? kButtonColor : kSidenoteGrey,
                color: i == widget.activeIndex ? Colors.white : kSidenoteGrey,
              ),
            ),
        ],
      ),
    );
  }
}
