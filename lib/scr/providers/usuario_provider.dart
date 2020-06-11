import 'dart:convert';

import 'package:form_validation/scr/providers/preferencia_usuario.dart';
import "package:http/http.dart" as http;


class UsuarioProvider{

  final String _firebaseToken = "AIzaSyAZo9k8CaBxOzVFBso93mB4iqQHRr8NJB4";

  final _prefs = PreferenciasUsuario();

  Future<Map<String, dynamic>> login( String email, String password ) async{

    String url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken";
    final authData = {
      "email" : email,
      "password" : password,
      "returnSecureToken": true
    };

    final resp = await http.post(url, 
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print( decodedResp );

    

    if( decodedResp.containsKey("idToken")){

      _prefs.token = decodedResp["idToken"];
      // Salvar el token
      return {
        "ok" : true,
        "token": decodedResp["idToken"]
      };
    }
    else{
      return {
        "ok" : false,
        "mensaje" :decodedResp["error"]["message"],
      };
    }
  }

  Future<Map<String, dynamic>> nuevoUSuario( String email, String password  ) async {

  String url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken";


    final authData = {
      "email" : email,
      "password" : password,
      "returnSecureToken": true

    };

    final resp = await http.post(url, 
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print( decodedResp );
    
    if( decodedResp.containsKey("idToken")){
      // Salvar el token
      _prefs.token = decodedResp["idToken"];

      return {
        "ok" : true,
        "token": decodedResp["idToken"]
      };
    }
    else{
      return {
        "ok" : false,
        "mensaje" :decodedResp["error"]["message"],
      };
    }
    

  }

}