import 'package:flutter/material.dart';
import 'package:bankomat/helpers/color_helpers.dart';
import '../../../bloc/main_bloc.dart';
import '../../../bloc/main_bloc_provider.dart';
import '../../../helpers/color_helpers.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BodyCreator extends StatelessWidget {
  final TextEditingController moneyFieldController;
  const BodyCreator(this.moneyFieldController, {Key key}) : super(key: key);

  Widget customDivider() {
    return Container(
      height: 10,
      width: double.infinity,
      color: colorFromHex('#F3F2FB'),
    );
  }

  @override
  Widget build(BuildContext context) {
    MainBloc mainBloc = MainBlocProvider.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 150,
        ),
        // Divider(),
        Expanded(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Expanded(child: Container()),
                SizedBox(
                  width: screenHeight>600?200:150,
                  height: screenHeight>600?60:40,
                  child: RaisedButton(
                    onPressed: () {
                      mainBloc.summInner(moneyFieldController.text);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(
                        color: const Color(0xffe61ead),
                      ),
                    ),
                    color: const Color(0xffe61ead),
                    child: Text(
                      'Выдать сумму',
                      style: TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontSize: 16,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Expanded(child: Container()),
                customDivider(),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder(
                      stream: mainBloc.cashOut,
                      builder:
                          (context, AsyncSnapshot<Map<String, int>> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text(
                              'Банкомат готов к работе',
                              style: TextStyle(
                                fontFamily: 'SF Pro Text',
                                fontSize: 18,
                                color: const Color(0xffe61ead),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        if (snapshot.data.isEmpty) {
                          return Center(
                            child: Text(
                              'Банкомат не может выдать, \nзапрашиваемую сумму',
                              style: TextStyle(
                                fontFamily: 'SF Pro Text',
                                fontSize: 18,
                                color: const Color(0xffe61ead),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Банкомат выдал следующие купюры',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Text',
                                  fontSize: 13,
                                  color: const Color(0xffa3a2ac),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              moneyTable(snapshot.data, context)
                            ],
                          ),
                        );
                      }),
                ),
                customDivider(),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder(
                      stream: mainBloc.balanceOut,
                      initialData: mainBloc.limits,
                      builder:
                          (context, AsyncSnapshot<Map<String, int>> snapshot) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Баланс банкомата',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Text',
                                  fontSize: 13,
                                  color: const Color(0xffa3a2ac),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              moneyTable(snapshot.data, context)
                            ],
                          ),
                        );
                      }),
                ),
                customDivider(),
              ],
            ),
          ),
        ),
        SizedBox(height: screenHeight>600? 15:5 ),
        screenHeight > 600
            ? SizedBox(
                width: screenWidth,
                child: SvgPicture.asset(
                  'assets/bottom_bg.svg',
                  allowDrawingOutsideViewBox: false,
                  fit: BoxFit.fill,
                ))
            : ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.5,
                  child: SizedBox(
                      width: screenWidth,
                      child: SvgPicture.asset(
                        'assets/bottom_bg.svg',
                        allowDrawingOutsideViewBox: false,
                        fit: BoxFit.fill,
                      )),
                ),
              ),
      ],
    );
  }

  Widget moneyTable(Map<String, int> data, BuildContext context) {
    List<Text> column1 = [];
    List<Text> column2 = [];

    Text rowBuilder(String bill, int amount) {
      return Text(
        "${amount.toString()} Х $bill рублей",
        style: TextStyle(
          fontFamily: 'SF Pro Text',
          fontSize: 14,
          color: const Color(0xff3827b4),
          fontWeight: FontWeight.w500,
        ),
      );
    }

    data.forEach((key, value) {
      if (value != 0) {
        if (column1.length < 3) {
          column1.add(rowBuilder(key, value));
        } else {
          column2.add(rowBuilder(key, value));
        }
      }
    });

    //Чтобы было красиво, сделаем колонки одинаковой длины

    if (column1.length < 3)
      for (int i = 3 - column1.length; i <= 3 - column1.length; i++)
        column1.add(Text(" "));
    if (column2.length < 3)
      for (int i = 3 - column2.length; i <= 3 - column2.length; i++)
        column2.add(Text(" "));

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2 - 20,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[...column1],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2 - 20,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[...column2],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
