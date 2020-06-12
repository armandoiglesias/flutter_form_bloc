

import 'dart:io';

import 'package:form_validation/scr/model/producto_model.dart';
import 'package:form_validation/scr/providers/product_provider.dart';
import 'package:rxdart/rxdart.dart';

class ProductoBloc{

  final _prodController = BehaviorSubject<List<ProductoModel>>();
  final _loadingController = BehaviorSubject<bool>();

  final _pp = ProductProvider();

  Stream<List<ProductoModel>> get productosStream => _prodController.stream;

  Stream<bool> get loading => _loadingController.stream;

  void cargarProductos() async{
    final productos = await _pp.cargarProductos();
    _prodController.sink.add(productos);
  }

  void agregarProducto( ProductoModel model ) async{
    _loadingController.sink.add(true);
    await _pp.crearProducto(model);
    _loadingController.sink.add(false);

  }

  void editarProducto( ProductoModel model ) async{
    _loadingController.sink.add(true);
    await _pp.crearProducto(model);
    _loadingController.sink.add(false);

  }

  void borrarProducto( String id ) async{
    _loadingController.sink.add(true);
    await _pp.borrarProducto(id);
    _loadingController.sink.add(false);

  }

  Future<String> subirFoto( File model ) async{
    _loadingController.sink.add(true);
    final fotoUrl = await _pp.subirImage(model);

    _loadingController.sink.add(false);

    return fotoUrl;

  }

  dispose(){
    _prodController.close();
    _loadingController.close();
  }

}