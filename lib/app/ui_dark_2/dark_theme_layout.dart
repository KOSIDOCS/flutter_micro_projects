import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_mic_ui/app/card_scroll/constants.dart';

class DarkThemeLayout extends StatefulWidget {
  const DarkThemeLayout({Key? key}) : super(key: key);

  @override
  _DarkThemeLayoutState createState() => _DarkThemeLayoutState();
}

class _DarkThemeLayoutState extends State<DarkThemeLayout>
    with TickerProviderStateMixin {
  late AnimationController _controllerAc;
  late Animation<Color?> _animation;
  late Animation<Color?> _boxColor;
  late Animation<Color?> _tepText;
  late Animation<Color?> _headerText;
  late Animation<SystemUiOverlayStyle> _statusBar;
  bool isDark = true;

  @override
  void initState() {
    super.initState();
    _controllerAc = AnimationController(
      //<-- initialize a controller
      vsync: this,
      duration: Duration(milliseconds: 600),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    _boxColor = ColorTween(
      begin: Color(0xFF1A1D2E),
      end: Colors.white,
    ).animate(_controllerAc);

    _tepText = ColorTween(
      begin: kBodyColor,
      end: Color(0xFF0A0D1E),
    ).animate(_controllerAc);

    _headerText = ColorTween(
      begin: kBodyColor,
      end: Color(0xFF0A0D1E),
    ).animate(_controllerAc);

    _statusBar = Tween<SystemUiOverlayStyle>(
      begin: SystemUiOverlayStyle.light,
      end: SystemUiOverlayStyle.dark,
    ).animate(
      CurvedAnimation(
        parent: _controllerAc,
        curve: const Interval(
          0.925,
          0.950,
          curve: Curves.linear,
        ),
      ),
    );

    _animation = ColorTween(
      begin: Color(0xFF0A0D1E),
      end: Color(0xFFEBECF2),
    ).animate(_controllerAc)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controllerAc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _animation.value,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: _controllerAc.isDismissed
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        child: SafeArea(
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
                // _displayBox(),
                AnimatedBuilder(animation: _controllerAc, builder: _displayBox),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 32.0, top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Devices',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          color: kSidenoteGrey.withOpacity(0.8),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'View All',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          color: kSidenoteGrey.withOpacity(0.5),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    _deviceBox(
                        title: 'AC', subTitle: 'Consuming 5kwh', img: 'ac.png'),
                    _deviceBox(
                        title: 'Lights',
                        subTitle: 'Consumes 1 KWh',
                        img: 'lightbulb.png'),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                DarkThemeBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _deviceBox(
      {required String title, required String subTitle, required String img}) {
    return Container(
      width: 170.0,
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      margin: EdgeInsets.only(
        left: 16.0,
        // right: 32.0,
        top: MediaQuery.of(context).size.height * 0.03,
      ),
      decoration: BoxDecoration(
        // color: Color(0xFF1A1D2E),
        color: _boxColor.value,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          Center(
            child: Image.asset(
              'assets/images/$img',
              height: 80.0,
            ),
          ),
          SizedBox(height: 10.0),
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: _tepText.value,
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Center(
            child: Text(
              subTitle,
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: kSidenoteGrey.withOpacity(0.7),
                fontSize: 12.0,
                height: 1.9,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 10.0),
            child: Center(
              child: ToggleBtn(),
            ),
          ), // Switch
        ],
      ),
    );
  }

  Widget _displayBox(BuildContext context, Widget? child) {
    return Container(
      child: Container(
        padding:
            EdgeInsets.only(top: 10.0, left: 35.0, right: 35.0, bottom: 10.0),
        margin: EdgeInsets.only(
          left: 13.0,
          right: 32.0,
          top: MediaQuery.of(context).size.height * 0.05,
        ),
        decoration: BoxDecoration(
          // color: Color(0xFF1A1D2E),
          color: _boxColor.value,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/sun.png',
                  scale: 6.0,
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _tempText(),
                    SizedBox(height: 3.0),
                    Text(
                      'Thunderstorm',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        color: kSidenoteGrey,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Cardiff, UK',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        color: kSidenoteGrey.withOpacity(0.5),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Divider(
              color: kSidenoteGrey,
              thickness: 0.2,
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cloudDetails(
                  percent: '10 km/h',
                  type: 'Wind',
                  icon: FeatherIcons.wind,
                ),
                _cloudDetails(
                  percent: '90%',
                  type: 'Precipitation',
                  icon: FeatherIcons.sunrise,
                ),
                _cloudDetails(
                  percent: '45%',
                  type: 'Humidity',
                  icon: FeatherIcons.thermometer,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cloudDetails(
      {required String percent, required IconData icon, required String type}) {
    return Container(
      child: Column(
        children: [
          Icon(
            icon,
            size: 20.0,
            color: kSidenoteGrey.withOpacity(0.5),
          ),
          Text(
            percent,
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: kSidenoteGrey,
              fontSize: 15.0,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            type,
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: kSidenoteGrey.withOpacity(0.5),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tempText() {
    return IntrinsicHeight(
      child: Row(
        children: [
          Text(
            '\t29',
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: _tepText.value,
              fontSize: 43.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w800,
            ),
          ),
          Transform.translate(
            offset: Offset(2, -11),
            child: Icon(
              FeatherIcons.circle,
              color: _tepText.value,
              size: 8.0,
            ),
          ),
          Transform.translate(
            offset: Offset(2, -8),
            child: Text(
              'C',
              textScaleFactor: 1.0,
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: _tepText.value,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(1, -8),
            child: Container(
              height: 20.0,
              child: VerticalDivider(
                color: kSidenoteGrey,
                thickness: 0.3,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(2, -11),
            child: Icon(
              FeatherIcons.circle,
              color: kSidenoteGrey.withOpacity(0.5),
              size: 8.0,
            ),
          ),
          Transform.translate(
            offset: Offset(5, -9),
            child: Text(
              'F',
              textScaleFactor: 1.0,
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: kSidenoteGrey.withOpacity(0.5),
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
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
              color: _headerText.value,
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
                  print('tapped ${_controllerAc.status}');
                  switch (_controllerAc.status) {
                    case AnimationStatus.completed:
                      _controllerAc.reverse();
                      break;
                    case AnimationStatus.dismissed:
                      _controllerAc.forward();
                      break;
                    default:
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: AnimatedBuilder(
                    animation: _controllerAc,
                    builder: (BuildContext context, Widget? child) {
                      return Transform.translate(
                        offset: Offset(68.0 * _controllerAc.value, 5.5),
                        child: Container(
                          alignment: Alignment(-0.83, -1.0),
                          child: CircleAvatar(
                            radius: 19.0,
                            backgroundColor: Color(0xFFE1E2E4),
                            child: Icon(
                              _controllerAc.isCompleted
                                  ? FeatherIcons.sun
                                  : Icons.nights_stay,
                              color: Color(0xFF0F44E9),
                              size: 25.0,
                            ),
                          ),
                        ),
                      );
                    },
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

class ToggleBtn extends StatefulWidget {
  const ToggleBtn({Key? key}) : super(key: key);

  @override
  _ToggleBtnState createState() => _ToggleBtnState();
}

class _ToggleBtnState extends State<ToggleBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controllerAc;

  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();

    _controllerAc = AnimationController(
      //<-- initialize a controller
      vsync: this,
      duration: Duration(milliseconds: 600),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    _animation = ColorTween(
      begin: Color(0xFFE1E2E4),
      end: Color(0xFF0F44E9),
    ).animate(_controllerAc)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controllerAc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: _animation.value,
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Container(
        height: 18.0,
        width: 50.0,
        decoration: BoxDecoration(
          color: Color(0xFF1A1D2E),
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Stack(
          children: [
            InkWell(
              enableFeedback: false,
              borderRadius: BorderRadius.all(Radius.circular(32)),
              onTap: () {
                print('tapped ${_controllerAc.status}');
                switch (_controllerAc.status) {
                  case AnimationStatus.completed:
                    _controllerAc.reverse();
                    break;
                  case AnimationStatus.dismissed:
                    _controllerAc.forward();
                    break;
                  default:
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: AnimatedBuilder(
                  animation: _controllerAc,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(29.0 * _controllerAc.value, 1.6),
                      child: Container(
                        alignment: Alignment(-0.83, -0.6),
                        child: CircleAvatar(
                          radius: 6.0,
                          backgroundColor: _animation.value,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DarkThemeBar extends StatefulWidget {
  const DarkThemeBar({Key? key}) : super(key: key);

  @override
  _DarkThemeBarState createState() => _DarkThemeBarState();
}

class _DarkThemeBarState extends State<DarkThemeBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int activeIndex = 0;
  final iconList = List<IconData>.unmodifiable([
    FeatherIcons.home,
    FeatherIcons.layers,
    FeatherIcons.mic,
    FeatherIcons.video,
    FeatherIcons.bell,
  ]);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      //<-- initialize a controller
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); //<-- and remember to dispose it!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: const BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 0; i < iconList.length; i++)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      activeIndex = i;
                    });
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(
                        iconList[i],
                        color: i == activeIndex
                            ? Color(0xFF0F44E9)
                            : kSidenoteGrey,
                      ),
                      i == activeIndex
                          ? Positioned(
                              top: 33.0,
                              left: 10.0,
                              child: Container(
                                height: 6.0,
                                width: 6.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0F44E9),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32)),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
