import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'dart:math' as math;

import 'package:flutter_mic_ui/app/card_scroll/customBottomBar.dart';

class SlidingCardsView extends StatefulWidget {
  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  late PageController pageController;
  double pageOffset = 0;

  final iconList = List<IconData>.unmodifiable([
    FeatherIcons.home,
    FeatherIcons.search,
    FeatherIcons.user,
  ]);

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.55, // set height of the card
              child: PageView(
                controller: pageController,
                children: <Widget>[
                  SlidingCard(
                    name: 'Cherry tomato on the vine',
                    date: '4.20-30',
                    assetName: 'tomato.jpg',
                    offset: pageOffset, // pass offset
                    price: 90.00,
                  ),
                  SlidingCard(
                    name: 'Grilled chicken with vegetables',
                    date: '4.28-31',
                    assetName: 'chicken.jpg',
                    offset: pageOffset - 1, //<-- pass offset - indexOfCard
                    price: 50.00,
                  ),
                  SlidingCard(
                    name: 'Fresh carrot - China, 500gm',
                    date: '4.28-31',
                    assetName: 'carrots.jpg',
                    offset: pageOffset - 1, //<-- pass offset - indexOfCard
                    price: 60.00,
                  ),
                ],
              ),
            ),
            CustomBottomBar(
              icons: iconList,
              activeIndex: 0,
              onPressed: (i) async {},
              margin: true,
            ),
          ],
        ),
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name; // title of the event
  final String date; // date of the event
  final String assetName; // name of the image to be displayed
  final double offset; //<-- How far is page from being displayed
  final double price;
  const SlidingCard({
    Key? key,
    required this.name,
    required this.date,
    required this.assetName,
    required this.offset,
    required this.price,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) /
        0.08)); //<--caluclate Gaussian function
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign,
          0), //<-- Translate the cards to make space between them
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              // clipping image
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              child: Image.asset(
                // main image
                'assets/images/$assetName',
                height: MediaQuery.of(context).size.height * 0.3,
                width: 330.0,
                alignment: Alignment(-offset.abs(), 0), //<-- Set the alignment
                fit: BoxFit.none,
                scale: 2.0,
                filterQuality: FilterQuality.high,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: CardContent(
                name: name,
                date: date,
                offset: gauss, //<-- Pass the gauss as offset
                price: price,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;
  final double offset;
  final double price; //<-- add the offset
  const CardContent(
      {Key? key,
      required this.name,
      required this.date,
      required this.offset,
      required this.price})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset, 0), //<-- translate the name label
            child: Text(name, style: TextStyle(fontSize: 20)),
          ),
          SizedBox(height: 8),
          Transform.translate(
            offset: Offset(32 * offset, 0), //<-- translate the name label
            child: Text(date, style: TextStyle(color: Colors.grey)),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Transform.translate(
                offset: Offset(48 * offset, 0), //<-- translate the button
                child: RaisedButton(
                  color: Color(0xFF162A49),
                  child: Transform.translate(
                    offset: Offset(
                        24 * offset, 0), //<-- and even the text in the button!
                    child: Text('Reserve'),
                  ),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  onPressed: () {},
                ),
              ),
              Spacer(),
              Transform.translate(
                offset: Offset(32 * offset, 0), //<-- translate the price label
                child: Text(
                  '$price \$',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          )
        ],
      ),
    );
  }
}
