import 'package:flutter/material.dart';
import 'package:form_validation/scr/bloc/login_bloc.dart';
export 'package:form_validation/scr/bloc/login_bloc.dart';

import 'package:form_validation/scr/bloc/producto_bloc.dart';
export 'package:form_validation/scr/bloc/producto_bloc.dart';


class Provider extends InheritedWidget{

 final loginBloc = LoginBloc();
 final _productoBloc = ProductoBloc();

  static Provider _instancia;

  factory Provider({  Key key, Widget child }){
    if (_instancia == null) {
      _instancia = Provider._internal(key: key, child: child);
    }

    return _instancia;
  } 

  Provider._internal({  Key key, Widget child }) : super(key: key, child : child );

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static ProductoBloc productoBloc ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productoBloc;
  }
  

}