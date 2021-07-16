import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mic_ui/app/ui_dark_1/bottom_sheet.dart';

class CustomLayout extends StatefulWidget {
  const CustomLayout({Key? key}) : super(key: key);

  @override
  _CustomLayoutState createState() => _CustomLayoutState();
}

class _CustomLayoutState extends State<CustomLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; //<-- Create a controller
  late AnimateIconController animateCon;
  late Animation<double> progress;
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceInOut,
    reverseCurve: Curves.bounceInOut,
  );

  late double _scale;

  int added = 0;

  @override
  void initState() {
    _controller = AnimationController(
      //<-- initialize a controller
      vsync: this,
      duration: Duration(milliseconds: 600),
      lowerBound: 0.0,
      upperBound: 1.0,
    )..addListener(() {
        setState(() {});
      });

    animateCon = AnimateIconController();
    progress = CurvedAnimation(curve: Curves.linear, parent: _controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose(); //<-- and remember to dispose it!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1.2 - _controller.value;
    return Scaffold(
      backgroundColor: Color(0xFF1B1B1B),
      body: Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height *
                0.4, //<-- update height value to scale with controller
            left: 0,
            right: 0,
            top: 0.0,
            child: Container(
              // color: Colors.white,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/lamp.png',
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.05,
                    left: 20.0,
                    child: AnimateIcons(
                      startIcon: Icons.menu,
                      endIcon: Icons.close,
                      size: 30.0,
                      controller: animateCon,
                      onStartIconPress: () {
                        print("Clicked on Add Icon");

                        return true;
                      },
                      onEndIconPress: () {
                        print("Clicked on Close Icon");

                        return true;
                      },
                      duration: Duration(milliseconds: 500),
                      startIconColor: Colors.white,
                      endIconColor: Colors.white,
                      clockwise: false,
                    ),
                    // child: AnimatedIcon(
                    //   icon: AnimatedIcons.menu_close,
                    //   progress: progress,
                    //   size: 20,
                    //   color: Colors.white,
                    // ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.height * 0.41,
                    right: 0,
                    top: MediaQuery.of(context).size.height * 0.05,
                    child: Text(
                      '$added',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        color: Color(0xFFFC6E20),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    height: MediaQuery.of(context).size.height *
                        0.15, //<-- update height value to scale with controller
                    left: MediaQuery.of(context).size.height * 0.34,
                    right: 0,
                    top: 0.0,
                    child: GestureDetector(
                      onTapDown: _tapDown,
                      onTapUp: _tapUp,
                      child: Transform.scale(
                        scale: _scale,
                        child: Icon(
                          Icons.shopping_bag,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomDetails(
            onPressed: (i) {
              setState(() {
                added = i;
              });
            },
          ),
        ],
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
