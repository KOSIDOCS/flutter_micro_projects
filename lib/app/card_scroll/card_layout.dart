import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_mic_ui/app/card_scroll/card_slide.dart';
import 'package:flutter_mic_ui/app/card_scroll/customBottomBar.dart';

class CardLayout extends StatefulWidget {
  const CardLayout({Key? key}) : super(key: key);

  @override
  _CardLayoutState createState() => _CardLayoutState();
}

class _CardLayoutState extends State<CardLayout> {
  final iconList = List<IconData>.unmodifiable([
    FeatherIcons.home,
    FeatherIcons.search,
    FeatherIcons.user,
  ]);

  int active = 0;

  final List<Widget> cards = [
    CardSlide(
      name: 'Gold Fashion',
      assetName: 'model-in-gold-fashion.jpg',
      offset: 2 - 1,
      hashtags: ['#GoldFashion', '#FashionModel'],
    ),
    CardSlide(
      name: 'Round Red Sun Glass',
      assetName: 'blonde-model-portrait.jpg',
      offset: 2 - 1,
      hashtags: ['#RedRoundSunGlass', '#SunGlass'],
    ),
    CardSlide(
      name: 'Red Suit Fashion',
      assetName: 'fashion-model-in-red-suit.jpg',
      offset: 2 - 1,
      hashtags: ['#RedSuitFashion', '#RedSuit'],
    ),
  ]; // pass offset)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView(
            children: cards,
          ),
          Positioned(
            bottom: 40.0,
            width: 375.0,
            height: 65.0,
            left: 25.0,
            child: CustomBottomBar(
              icons: iconList,
              activeIndex: active,
              onPressed: (i) {
                setState(() {
                  active = i;
                });
              },
              margin: false,
            ),
          ),
        ],
      ),
    );
  }
}
