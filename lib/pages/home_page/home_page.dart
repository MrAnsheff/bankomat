import 'package:flutter/material.dart';
import 'package:bankomat/widgets/custom_appbar.dart';
import 'package:bankomat/widgets/background.dart';
import 'package:bankomat/pages/home_page/home_page_widgets/header.dart';
import 'package:bankomat/pages/home_page/home_page_widgets/body.dart';

import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController moneyFieldController =
        MoneyMaskedTextController(
            decimalSeparator: '.', thousandSeparator: ' ');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(),
      body: Stack(
        children: <Widget>[
          Background(),
          HeaderCreator(moneyFieldController),
          BodyCreator(moneyFieldController),
        ],
      ),
    );
  }
}
