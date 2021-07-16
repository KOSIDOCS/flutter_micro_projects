import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({Key? key}) : super(key: key);

  @override
  _ThemeButtonState createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controllerBtn;
  late Animation<Color?> _animation;
  bool isDark = true;

  @override
  void initState() {
    super.initState();
    _controllerBtn = AnimationController(
      //<-- initialize a controller
      vsync: this,
      duration: Duration(milliseconds: 600),
      lowerBound: 0.0,
      upperBound: 1.0,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        print(status);

        if (status == AnimationStatus.forward) {
          isDark = false;
        }

        if (status == AnimationStatus.reverse) {
          setState(() {
            isDark = true;
          });
        }
      });

    _animation = ColorTween(begin: Color(0xFF0A0D1E), end: Colors.white)
        .animate(_controllerBtn);
  }

  @override
  void dispose() {
    super.dispose();
    _controllerBtn.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _animation.value,
      body: SafeArea(
        child: Center(
          child: Container(
            height: 50.0,
            width: 120.0,
            decoration: const BoxDecoration(
              color: Color(0xFF1A1D2E),
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 15.0,
                  left: 15.0,
                  child: Icon(
                    FeatherIcons.moon,
                    color: Colors.white,
                    size: 18.0,
                  ),
                ),
                Positioned(
                  top: 15.0,
                  left: 88.0,
                  child: Icon(
                    FeatherIcons.sun,
                    color: Colors.white,
                    size: 18.0,
                  ),
                ),
                InkWell(
                  enableFeedback: false,
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                  onTap: () {
                    print('tapped ${_controllerBtn.status}');
                    switch (_controllerBtn.status) {
                      case AnimationStatus.completed:
                        _controllerBtn.reverse();
                        break;
                      case AnimationStatus.dismissed:
                        _controllerBtn.forward();
                        break;
                      default:
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Transform.translate(
                      offset: Offset(68.0 * _controllerBtn.value, 5.5),
                      child: Container(
                        alignment: Alignment(-0.83, -1.0),
                        child: CircleAvatar(
                          radius: 19.0,
                          backgroundColor: Color(0xFFE1E2E4),
                          child: Icon(
                            isDark ? Icons.nights_stay : FeatherIcons.sun,
                            color: Color(0xFF0F44E9),
                            size: 25.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
