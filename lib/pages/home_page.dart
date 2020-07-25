import 'package:flutter/material.dart';
import 'package:bankomat/widgets/custom_appbar.dart';
import 'package:bankomat/widgets/background_painter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        children: <Widget>[
          CustomPaint(
                  size: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height),
            painter:BackgroundPainter()),

        ],
      ),
    );
  }
}