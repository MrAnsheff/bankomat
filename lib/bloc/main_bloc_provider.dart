import 'package:flutter/material.dart';
import 'package:bankomat/bloc/main_bloc.dart';

class MainBlocProvider extends InheritedWidget{

  final Widget child;
  final MainBloc bloc;

  MainBlocProvider({Key key, this.child}) 
   : bloc = MainBloc(),
     super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static MainBloc of (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<MainBlocProvider>().bloc;
  }

}