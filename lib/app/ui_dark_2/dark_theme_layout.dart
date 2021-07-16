import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_mic_ui/app/card_scroll/constants.dart';

class DarkThemeLayout extends StatefulWidget {
  const DarkThemeLayout({Key? key}) : super(key: key);

  @override
  _DarkThemeLayoutState createState() => _DarkThemeLayoutState();
}

class _DarkThemeLayoutState extends State<DarkThemeLayout>
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
      backgroundColor: Color(0xFF0A0D1E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 13.0, right: 13.0),
                child: _topBar(),
              ),
              _welcomeMessage(),
              _displayBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayBox() {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(
        left: 13.0,
        right: 32.0,
        top: MediaQuery.of(context).size.height * 0.03,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1D2E),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/sun.png',
                scale: 6.0,
              )
            ],
          ),
          Row()
        ],
      ),
    );
  }

  Widget _welcomeMessage() {
    return Container(
      padding: EdgeInsets.only(
        left: 13.0,
        right: 13.0,
        top: MediaQuery.of(context).size.height * 0.03,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, Rifat!',
            style: TextStyle(
              fontFamily: 'Sofia Pro',
              color: kBodyColor,
              fontSize: 33.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 15.0),
          Text(
            'Here are what you have asked for',
            style: TextStyle(
              fontFamily: 'Sofia Pro',
              color: kSidenoteGrey,
              fontSize: 17.5,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
  }

  Widget _topBar() {
    return Row(
      children: [
        Container(
          height: 50.0,
          width: 50.0,
          padding: EdgeInsets.only(left: 13.0),
          decoration: const BoxDecoration(
            color: Color(0xFF1A1D2E),
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.003,
                width: MediaQuery.of(context).size.width * 0.06,
                color: Color(0xFFE1E2E4),
              ),
              SizedBox(height: 6.0),
              Container(
                height: MediaQuery.of(context).size.height * 0.003,
                width: MediaQuery.of(context).size.width * 0.04,
                color: Color(0xFFE1E2E4),
              ),
            ],
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.height * 0.2),
        Container(
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
      ],
    );
  }
}
