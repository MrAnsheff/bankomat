import 'package:bankomat/services/ioc_service.dart';
import 'package:flutter/material.dart';
import 'package:bankomat/pages/home_page/home_page.dart';
import 'package:bankomat/bloc/main_bloc_provider.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    iocLocator();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainBlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bankomat',
        home: HomePage(),
      ),
    );
  }
}
