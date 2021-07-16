import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mic_ui/app/card_scroll/constants.dart';
import 'package:flutter_mic_ui/app/input_fields/regex_constants.dart';

class CustomPasswordUx extends StatefulWidget {
  const CustomPasswordUx({Key? key}) : super(key: key);

  @override
  _CustomPasswordUxState createState() => _CustomPasswordUxState();
}

class _CustomPasswordUxState extends State<CustomPasswordUx>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; //<-- Create a controller
  late Animation<double> progress;
  late AnimateIconController animateCon;
  late TextEditingController _pass;

  bool typeIn = false;
  bool hidePass = true;
  bool passChar = false;
  bool passNum = false;
  bool isStrong = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      //<-- initialize a controller
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    progress = CurvedAnimation(curve: Curves.linear, parent: _controller);
    animateCon = AnimateIconController();
    _pass = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          if (_pass.text.length >= 1) {
            setState(() {
              typeIn = true;
            });
          } else {
            setState(() {
              typeIn = false;
            });
          }
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFF32594F),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Hello there \u{1F44B}',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: kTextColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                    height: 1.5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Set Your Password',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: kFloatingButton,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                    height: 1.5,
                  ),
                ),
              ),
              Container(
                height: 80.0,
                padding: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 7.0, top: 4.0, bottom: 0.0),
                          child: AnimateIcons(
                            startIcon: Icons.visibility_off,
                            endIcon: Icons.visibility,
                            size: 30.0,
                            controller: animateCon,
                            onStartIconPress: () {
                              print("Clicked on Add Icon");
                              setState(() {
                                hidePass = false;
                              });
                              return true;
                            },
                            onEndIconPress: () {
                              print("Clicked on Close Icon");
                              setState(() {
                                hidePass = true;
                              });
                              return true;
                            },
                            duration: Duration(milliseconds: 500),
                            startIconColor:
                                typeIn ? kFloatingButton : kTextColor,
                            endIconColor: typeIn ? kFloatingButton : kTextColor,
                            clockwise: false,
                          ),
                        ),
                        SizedBox(width: 6.0),
                        Container(
                            width: 0.5,
                            height: 45.0,
                            color:
                                typeIn == true ? kFloatingButton : kTextColor),
                        SizedBox(width: 14.0),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            textCapitalization: TextCapitalization.none,
                            controller: _pass,
                            obscureText: hidePass,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: kFloatingButton,
                            ),
                            onTap: () => typeIn = true,
                            onChanged: (value) {
                              checkPassWord(value);
                            },
                            cursorColor: kTextColor,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusColor: kTextColor,
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: kTextColor,
                                fontFamily: 'Gilroy',
                                fontSize: 20.0,
                                letterSpacing: 0.1,
                                fontWeight: FontWeight.w300,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 2.1,
                      height: 0.5,
                      color: typeIn == true ? kFloatingButton : kTextColor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              UxInsight(
                inClude: passChar,
                inSight: 'Add one special sign',
              ),
              UxInsight(
                inClude: passNum,
                inSight: 'Add one number',
              ),
              UxInsight(
                inClude: isStrong,
                inSight: 'Type more 8 characters',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkPassWord(value) {
    if (passSpecial.hasMatch(value)) {
      setState(() {
        passChar = true;
      });
    } else {
      setState(() {
        passChar = false;
      });
    }

    if (passNumber.hasMatch(value)) {
      setState(() {
        passNum = true;
      });
    } else {
      setState(() {
        passNum = false;
      });
    }

    if (_pass.text.length >= 8) {
      setState(() {
        isStrong = true;
      });
    } else {
      setState(() {
        isStrong = false;
      });
    }
  }
}

class UxInsight extends StatefulWidget {
  const UxInsight({Key? key, required this.inClude, required this.inSight})
      : super(key: key);

  final bool inClude;
  final String inSight;

  @override
  _UxInsightState createState() => _UxInsightState();
}

class _UxInsightState extends State<UxInsight> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15.0,
            backgroundColor: widget.inClude ? kFloatingButton : kTextColor,
            child: Center(
              child: Icon(
                widget.inClude ? Icons.check : null,
                size: 15.0,
                color: Color(0xFF32594F),
              ),
            ),
          ),
          SizedBox(width: 15.0),
          Text(
            widget.inSight,
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: widget.inClude ? kFloatingButton : kTextColor,
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
