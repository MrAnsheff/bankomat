import 'package:flutter/material.dart';
import 'package:bankomat/widgets/custom_appbar.dart';
import 'package:bankomat/widgets/background.dart';
import 'package:bankomat/helpers/color_helpers.dart';
import '../../bloc/main_bloc.dart';
import '../../bloc/main_bloc_provider.dart';
import '../../helpers/color_helpers.dart';
import '../../helpers/digits_formatter.dart';
import 'package:flutter/services.dart';

import 'package:flutter_masked_text/flutter_masked_text.dart';



class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainBloc mainBloc = MainBlocProvider.of(context);
    TextEditingController moneyFieldController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ' ');

    Widget moneyField() {
      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Container()),
            SizedBox(
              width: 120,
              child: TextField(
                controller: moneyFieldController,
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
                    DigitsFormatter(maxDigits: 6),
                  ],
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
            Expanded(child: Container()),
          ],
        ),
      );
    }

    Widget customDivider() {
      return Container(
        height: 10,
        width: double.infinity,
        color: colorFromHex('#F3F2FB'),
      );
    }

    Widget moneyTable(Map<String, int> data) {
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

      for (String bill in data.keys) {
        switch (bill) {
          case "100":
            column1.add(rowBuilder(bill, data[bill]));
            break;
          case "200":
            column1.add(rowBuilder(bill, data[bill]));
            break;
          case "500":
            column2.add(rowBuilder(bill, data[bill]));
            break;
          case "1000":
            column2.add(rowBuilder(bill, data[bill]));
            break;
          case "2000":
            column1.add(rowBuilder(bill, data[bill]));
            break;
          case "5000":
            column2.add(rowBuilder(bill, data[bill]));
        }
      }

      return Container(
        padding: EdgeInsets.only(left: 18, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[...column1],
            ),
            SizedBox(
              width: 38,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[...column2],
            ),
          ],
        ),
      );
    }

    Widget headerCreator() {
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
            SizedBox(height: 4,),
            moneyField(),
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

    Widget bodyCreator() {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 190,
          ),
          SizedBox(
            width: 200,
            height: 60,
            child: RaisedButton(
              onPressed: () {},
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
          SizedBox(
            height: 20,
          ),
          customDivider(),
          Expanded(
            child: Container(
              width: double.infinity,
              padding:
                  EdgeInsets.only(top: 17, left: 17, right: 17, bottom: 20),
              child: StreamBuilder(
                  stream: mainBloc.cashOut,
                  builder: (context, AsyncSnapshot<Map<String, int>> snapshot) {
                    if (!snapshot.hasData || snapshot.data.isEmpty) {
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
                    return Column(
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
                      ],
                    );
                  }),
            ),
          ),
          customDivider(),
          Expanded(
            child: Container(
              width: double.infinity,
              padding:
                  EdgeInsets.only(top: 17, left: 17, right: 17, bottom: 20),
              child: StreamBuilder(
                  stream: mainBloc.balanceOut,
                  initialData: mainBloc.limits,
                  builder: (context, AsyncSnapshot<Map<String, int>> snapshot) {
                    return Column(
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
                        Expanded(child: moneyTable(snapshot.data))
                      ],
                    );
                  }),
            ),
          ),
          customDivider(),
          SizedBox(height: 143),
        ],
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(),
      body: Stack(
        children: <Widget>[
          Background(),
          headerCreator(),
          bodyCreator(),
        ],
      ),
    );
  }
}
