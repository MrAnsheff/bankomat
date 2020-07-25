import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Background extends StatelessWidget {
  const Background({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        SizedBox(width:sizeWidth, child: SvgPicture.asset('assets/top_bg.svg', allowDrawingOutsideViewBox: false, fit: BoxFit.fill,)),
        Align(
          alignment: Alignment(1.0, 1.0),
          child: SizedBox(width:sizeWidth, child: SvgPicture.asset('assets/bottom_bg.svg', allowDrawingOutsideViewBox: false, fit: BoxFit.fill,))),
      ],
    );
  }
}