import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class BottomDetails extends StatefulWidget {
  BottomDetails({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  _BottomDetailsState createState() => _BottomDetailsState();
}

class _BottomDetailsState extends State<BottomDetails>
    with TickerProviderStateMixin {
  late AnimationController _controller; //<-- Create a controller
  late AnimationController _controllerBtn;
  late AnimationController _btnController;

  late double _scale;
  late double _btnScale;

  bool isOpen = false;

  int total = 0;

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

        if (status == AnimationStatus.completed) {
          _controllerBtn.reverse();
        }
      });
    _btnController = AnimationController(
      //<-- initialize a controller
      vsync: this,
      duration: Duration(milliseconds: 600),
      lowerBound: 0.0,
      upperBound: 1.0,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose(); //<-- and remember to dispose it!
    _controllerBtn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1.2 - _controller.value;
    _btnScale = 1.2 - _btnController.value;
    return Positioned(
      height: MediaQuery.of(context).size.height *
          0.6, //<-- update height value to scale with controller
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _priceDetails(),
                  SizedBox(
                    width: MediaQuery.of(context).size.height * 0.135,
                  ),
                  _cartBtn(),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  _productBox(icon: Icons.light, title: '10 watt'),
                  _productBox(icon: Icons.power, title: '30 kwh'),
                  _productBox(icon: FeatherIcons.maximize2, title: '10 sizes'),
                  _productBox(icon: Icons.palette, title: '12 colors'),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Container(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: _details(),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, left: 25.0),
              height: 90.0,
              child: ListView(
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _productImg(),
                  _productImg(),
                  _productImg(),
                  _productImg(),
                  _productImg(),
                  _productImg(),
                  _productImg(),
                  _productImg(),
                  _productImg(),
                  _productImg(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 25.0, right: 45.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _cancleBtn(),
                  _buyBtn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buyBtn() {
    return GestureDetector(
      onTapDown: _btnDown,
      onTapUp: _btnUp,
      child: Transform.scale(
        scale: _btnScale,
        child: Container(
          width: 264.0,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
          decoration: BoxDecoration(
            color: Color(0xFFFC6E20),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              'BUY NOW',
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cancleBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Color(0x66323232),
        ),
      ),
      child: Center(
        child: Icon(
          Icons.close,
          color: Color(0xFF1B1B1B),
        ),
      ),
    );
  }

  Widget _productImg() {
    return Card(
      margin: EdgeInsets.only(left: 0.0, right: 8, bottom: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: ClipRRect(
        // clipping image
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
        child: Image.asset(
          // main image
          'assets/images/lamp.jpg',
          width: 70.0,
          fit: BoxFit.cover,
          scale: 2.0,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }

  Widget _details() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rado Lamp',
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: Color(0xFF1B1B1B),
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTapDown: _tapDown,
              onTapUp: _tapUp,
              child: Transform.scale(
                scale: _scale,
                child: Icon(
                  Icons.favorite,
                  color: Color(0xFFFC6E20),
                  size: 16.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Text(
          "The inspiration for the LYHTY pendant lamp came to me from the old lanterns and oil lamps. One of old lantern.",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: Color(0x66323232),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Photos ',
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: Color(0xFF1B1B1B),
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '1/10',
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: Color(0xFF1B1B1B),
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _productBox({required IconData icon, required String title}) {
    return Container(
      padding: EdgeInsets.only(right: 21.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Stack(
        children: [
          Positioned(
            child: Container(
              height: 70.0,
              margin: EdgeInsets.only(left: 20.0),
              width: 60.0,
              decoration: const BoxDecoration(
                color: Color(0xFFFFE7D0),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            left: 6.0,
            child: Icon(
              icon,
              color: Color(0xFF1B1B1B),
            ),
          ),
          Positioned(
            top: 40.0,
            left: 5.0,
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: Color(0xFF1B1B1B),
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartBtn() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0x40323232),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 30.5, right: 20.5, top: 1.0, bottom: 1.0),
            child: Text(
              'CART',
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: Color(0xFF1B1B1B),
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => widget.onPressed(total),
            onTapDown: _tapDownBtn,
            child: Transform.translate(
              offset: Offset(-100.0 * _controllerBtn.value, 0.0),
              child: CircleAvatar(
                radius: 19.0,
                backgroundColor: Color(0xFF1B1B1B),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 10.0),
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child: Transform.translate(
                offset: Offset(5, -4),
                child: Text(
                  '\$',
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Color(0xFFFC6E20),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            TextSpan(
              text: '\t129',
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: Color(0xFF1B1B1B),
                fontSize: 23.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            WidgetSpan(
              child: Transform.translate(
                offset: Offset(14, 1),
                child: Text(
                  '39 reviewes',
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Color(0xFFFC6E20),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _btnDown(TapDownDetails details) {
    _btnController.forward();
  }

  void _btnUp(TapUpDetails details) {
    _btnController.reverse();
  }

  void _tapDownBtn(TapDownDetails details) {
    total += 1;
    _controllerBtn.forward();
    print('clicked this now.');
  }
}
