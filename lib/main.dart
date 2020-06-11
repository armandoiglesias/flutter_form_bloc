import 'package:flutter/material.dart';
import 'package:form_validation/scr/bloc/provider.dart';
import 'package:form_validation/scr/pages/home_page.dart';
import 'package:form_validation/scr/pages/login_pae.dart';
import 'package:form_validation/scr/pages/producto_page.dart';
import 'package:form_validation/scr/pages/registro_page.dart';
import 'package:form_validation/scr/providers/preferencia_usuario.dart';
 
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    runApp(MyApp());

}
  
 
class MyApp extends StatelessWidget {

  final _prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Provider(
          child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: _prefs.token != "" ? "home": "login",
        routes: {
          "login" : (_) => LoginPage(),
          "home" : (_) => HomePage(),
          "producto" : (_) => ProductoPage(),
          "registro" : (_) => RegistroPage(),

        },

        
      ),
    );
  }
}