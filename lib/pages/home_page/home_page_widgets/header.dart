import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bankomat/helpers/digits_formatter.dart';

class HeaderCreator extends StatefulWidget {
  final TextEditingController moneyFieldController;
  const HeaderCreator(this.moneyFieldController, {Key key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState(moneyFieldController);
}

class _HeaderState extends State<HeaderCreator> {
  TextEditingController moneyFieldEditingController;
  double startFieldSize = 65;
  double actualFieldSize = 65;

  _HeaderState(this.moneyFieldEditingController);

  void fieldSizeChanger(String text) {
    if (text.length < 4) {
      actualFieldSize = startFieldSize;
    } else {
      setState(() {
        actualFieldSize = startFieldSize + (text.length - 3).toDouble() * 13;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 26,
          ),
          Text(
            'Введите сумму',
            style: TextStyle(
              fontFamily: 'SF Pro Text',
              fontSize: 15,
              color: const Color(0xffffffff),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            width: screenWidth,
            padding: EdgeInsets.symmetric(horizontal:20),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: actualFieldSize,
                    child: TextField(
                      controller: moneyFieldEditingController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        isDense: true,
                        border: InputBorder.none,
                      ),
                      textAlign: TextAlign.right,
                      cursorColor: Colors.white,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        DigitsFormatter(maxDigits: 10),
                      ],
                      onChanged: (text){
                        fieldSizeChanger(text);
                      },
                      style: TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontSize: 30,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                  Text(
                    ' руб',
                    style: TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 30,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.center,
                  ),
                 
                ],
              ),
            ),
          ),
          SizedBox(
            width: 164,
            child: Opacity(
                opacity: 0.3,
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                )),
          )
        ],
      ),
    );
  }
}
