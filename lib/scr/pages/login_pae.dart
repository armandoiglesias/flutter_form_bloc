import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: <Color>[Colors.blue, Colors.purple])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.09)),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(
          child: circulo,
          left: 30.0,
          top: 90.0,
        ),
        Positioned(
          child: circulo,
          right: -30.0,
          top: -40.0,
        ),
        Positioned(
          child: circulo,
          left: -10.0,
          bottom: -50.0,
        ),
        Positioned(
          child: circulo,
          right: -30.0,
          bottom: 20.0,
        ),
        Container(
          padding: EdgeInsets.only(top: 90.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.person_pin_circle,
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text(
                "Armando Iglesias",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 210.0,
          ),
          SafeArea(
            child: Container(
              //height: 40.0,
              width: size.width * 0.85,
              // margin: EdgeInsets.symmetric(vertical: 30.0),
              padding: EdgeInsets.symmetric(vertical: 50.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      spreadRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                    )
                  ]),
              child: Column(
                children: <Widget>[
                  Text(
                    "Ingreso",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _crearEmail(),
                  SizedBox(
                    height: 30.0,
                  ),
                  _crearPwdField(),
                  SizedBox(
                    height: 30.0,
                  ),
                  _crearBoton(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text("¿Olvido su contraseña?"),
          SizedBox(
            height: 100.0,
          ),
          
        ],
      ),
    );
  }

  Widget _crearEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress ,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.deepPurple,),
          hintText: "ejemplo@correo.com",
          labelText: "correo electronico"
        ),
      ),
    );
  }

  Widget _crearPwdField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        keyboardType: TextInputType.text ,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: Colors.deepPurple,),
          labelText: "Contraseña"
        ),
      ),
    );
  }

  Widget _crearBoton() {
    return RaisedButton(
      onPressed: () {  },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text("Ingresar"),
      ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5.0),

  ),
  elevation: 0.0,
  color: Colors.deepPurple,
  textColor: Colors.white,
    );
    
  }
}
