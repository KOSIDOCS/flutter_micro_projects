import 'package:flutter/material.dart';
import 'dart:math' as math;

class CardSlide extends StatelessWidget {
  final String name; // title of the product
  final String assetName; // name of the product image to be displayed
  final double offset; //<-- How far is page from being displayed
  final List hashtags; //<-- List of hashtags for each product

  const CardSlide({
    Key? key,
    required this.name,
    required this.assetName,
    required this.offset,
    required this.hashtags,
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
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Stack(
          // fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/images/$assetName',
              fit: BoxFit.fill,
              filterQuality: FilterQuality.high,
            ),
            Positioned(
              top: 468.0,
              left: 20.0,
              child: Container(
                padding: EdgeInsets.only(left: 6.0),
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Open Sans',
                    fontSize: 25.0,
                    wordSpacing: 4.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 510.0,
              left: 28.0,
              child: Container(
                child: Text(
                  hashtags[0] + ' ' + hashtags[1],
                  style: TextStyle(
                    color: Colors.white70,
                    fontFamily: 'Open Sans',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 549.0,
              left: 20.0,
              child: Row(
                children: <Widget>[
                  customImg(context),
                  Column(
                    children: <Widget>[
                      Text(
                        'Yozmine',
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Open Sans',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.visibility,
                            color: Colors.white54,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            '435',
                            style: TextStyle(
                              color: Colors.white54,
                              fontFamily: 'Open Sans',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  customImg(BuildContext context) {
    return Card(
      //color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image.asset(
          'assets/images/blonde-model-portrait.jpg',
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.12,
          fit: BoxFit.cover,
          //color: Color(0xFF0C382E),
          filterQuality: FilterQuality.medium,
          colorBlendMode: BlendMode.color,
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  // final List<String> hastags;
  // final String userImg;
  // final String userName;
  // final int views;
  final double offset;

  const CardContent(
      {Key? key,
      required this.name,
      // required this.hastags,
      // required this.userImg,
      // required this.userName,
      // required this.views,
      required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));

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
            child: Text('2020-11-13', style: TextStyle(color: Colors.grey)),
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
                  '0.00 \$',
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
