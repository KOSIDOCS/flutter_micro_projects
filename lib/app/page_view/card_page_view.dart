import 'package:flutter/material.dart';
import 'package:flutter_mic_ui/app/card_scroll/card_slide.dart';

class CardPageView extends StatefulWidget {
  const CardPageView({Key? key}) : super(key: key);

  @override
  _CardPageViewState createState() => _CardPageViewState();
}

class _CardPageViewState extends State<CardPageView> {
  late PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() =>
          pageOffset = pageController.page!); //<-- add listener and set state
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height * 0.55, // set height of the card
      child: PageView(
        controller: pageController,
        children: <Widget>[
          CardSlide(
            name: 'Gold Fashion',
            assetName: 'model-in-gold-fashion.jpg',
            offset: pageOffset, //<-- pass offset
            hashtags: ['#GoldFashion', '#FashionModel'],
          ),
          CardSlide(
            name: 'Round Red Sun Glass',
            assetName: 'blonde-model-portrait.jpg',
            offset: pageOffset - 1, //<-- pass offset - indexOfCard
            hashtags: ['#RedRoundSunGlass', '#SunGlass'],
          ),
          CardSlide(
            name: 'Red Suit Fashion',
            assetName: 'fashion-model-in-red-suit.jpg',
            offset: pageOffset - 2, //<-- pass offset - indexOfCard
            hashtags: ['#RedSuitFashion', '#RedSuit'],
          ),
        ],
      ),
    );
  }
}
