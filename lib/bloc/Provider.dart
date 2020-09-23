import 'package:flash_chat/bloc/bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final bloc = Bloc();
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
/*
  static Bloc of(BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType(Provider) as Provider.of(context).bloc);
  }*/
}
