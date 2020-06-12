import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_validation/scr/bloc/provider.dart';
import 'package:form_validation/scr/model/producto_model.dart';
import 'package:form_validation/scr/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  File foto;
  bool isSaving = false;

  ProductoModel model = ProductoModel();
  ProductoBloc productoBloc;

  @override
  Widget build(BuildContext context) {



    productoBloc = Provider.productoBloc(context);
    final ProductoModel args = ModalRoute.of(context).settings.arguments;
    if (args != null) {
      model = args;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Producto"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponibleSwitch(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: model.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: "Producto"),
      onSaved: (value) {
        model.title = value;
      },
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: model.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: "Precio"),
      onSaved: (value) {
        model.valor = double.parse(value);
      },
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return "Debe ingresar solo numeros";
        }
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      icon: Icon(
        Icons.save,
      ),
      label: Text(
        "Guardar",
      ),
      onPressed: isSaving ? null : _submit,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
    );
  }

  void _submit( ) async {
    if (!formKey.currentState.validate()) {
      return;
    }

    formKey.currentState.save();

    setState(() {
      isSaving = true;
    });

    if (foto != null) {
      model.photoUrl = await productoBloc.subirFoto(foto);
    }

    print(model.photoUrl);

    

    if (model.id != null) {
      productoBloc.editarProducto(model);
    } else {
      productoBloc.agregarProducto(model);
    }

    setState(() {
      isSaving = false;
    });
    mostrarSnackBar("Registro Guardado");
    Navigator.of(context).pop();
  }

  Widget _crearDisponibleSwitch() {
    return SwitchListTile(
      value: model.disponible,
      title: Text("Disponible"),
      onChanged: (value) {
        model.disponible = value;
        setState(() {});
      },
    );
  }

  void mostrarSnackBar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  _mostrarFoto() {
    if (model.photoUrl != null) {
      return Container(
        height: 300.0,
        child: FadeInImage(
          fit: BoxFit.contain,
          height: 300.0,
          placeholder: AssetImage("assets/original.gif"),
          image: NetworkImage(model.photoUrl),
        ),
      );
    } else {
      return Image(
        image: AssetImage(foto?.path ?? "assets/no-image.png"),
        fit: BoxFit.cover,
        height: 300.0,
      );
    }
  }

  void _seleccionarFoto() async {
    _procesarImage(ImageSource.gallery);
  }

  _procesarImage(ImageSource source) async {
    foto = await ImagePicker.pickImage(
      source: source,
    );

    if (foto != null) {
      model.photoUrl = null;
    }

    setState(() {});
  }

  void _tomarFoto() async {
    _procesarImage(ImageSource.camera);
  }
}
