import 'package:flutter/material.dart';
import 'package:form_validation/scr/bloc/provider.dart';
import 'package:form_validation/scr/pages/home_page.dart';
import 'package:form_validation/scr/pages/login_pae.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
          child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: "login",
        routes: {
          "login" : (_) => LoginPage(),
          "home" : (_) => HomePage(),
        },

        
      ),
    );
  }
}