import 'package:flutter/material.dart';
import 'package:bankomat/pages/home_page.dart';
import 'package:bankomat/bloc/main_bloc_provider.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MainBlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bankomat',
        home: HomePage(),
      ),
    );
  }
}
