import 'package:flutter/material.dart';
import 'package:form_validation/scr/bloc/provider.dart';
import 'package:form_validation/scr/model/producto_model.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);

    final productoBloc = Provider.productoBloc(context);
    productoBloc.cargarProductos();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: _crearListado(productoBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () {
        Navigator.pushNamed(context, "producto");
      },
    );
  }

  Widget _crearListado( ProductoBloc p ) {
    return StreamBuilder(
      stream: p.productosStream  ,
      //initialData: InitialData,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (BuildContext context, int index) {
              return _crearItem(context, productos[index], p);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel model, ProductoBloc p) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        p.borrarProducto(model.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            model.photoUrl == null 
              ? Image( image: AssetImage("assets/no-image.png"), ) 
              : FadeInImage(image: NetworkImage(model.photoUrl) , placeholder: AssetImage("assets/original.gif"), height: 300.0, width: double.infinity, fit: BoxFit.cover) ,
             
ListTile(
        title: Text("${model.title} - ${model.valor}"),
        subtitle: Text(model.id),
        onTap: () {
          Navigator.pushNamed(context, "producto", arguments: model);
        },
      ),
          ],
        ),
      )
    );
  }

  

 
}
