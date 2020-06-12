import 'dart:convert';
import 'dart:io';
import 'package:form_validation/scr/model/producto_model.dart';
import 'package:form_validation/scr/providers/preferencia_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart' as mimeType;

class ProductProvider{

  final String _urlBase = "https://flutter-varios-12a63.firebaseio.com";
  final _prefs = PreferenciasUsuario();

  Future<bool> crearProducto(ProductoModel model) async{
    final url = "$_urlBase/productos.json?auth=${ _prefs.token}";
    final resp = await http.post(url, body: productoToJson(model));

    final decodedData = json.decode( resp.body);
    print(decodedData);
    return true;
   
  }

  Future<bool> editarProducto(ProductoModel model) async{
    final url = "$_urlBase/productos/${model.id}.json?auth=${ _prefs.token}";
    final resp = await http.put(url, body: productoToJson(model));

    final decodedData = json.decode( resp.body);
    print(decodedData);
    return true;
   
  }

  Future<List<ProductoModel>> cargarProductos() async{
    final _url = "$_urlBase/productos.json?auth=${ _prefs.token}";
    final resp = await http.get(_url);

    final Map<String, dynamic> decodedData = json.decode( resp.body );
    List<ProductoModel> models = List();

    print(" decodeData : $decodedData");

    if (decodedData == null)  return[];
    decodedData.forEach( (id, prod){

      final p = ProductoModel.fromJson(prod);
      p.id = id;
      models.add(p);

    });

    
    return models;

  } 

  Future<int> borrarProducto(String id) async{
    final _url = "$_urlBase/productos/$id.json?auth=${ _prefs.token}";
    final resp = await http.delete(_url);

    return 1;
    
  }

  

  Future<String> subirImage( File imagen ) async{
    final url = Uri.parse("https://api.cloudinary.com/v1_1/dkqzeynks/image/upload");
    final _mime = mimeType.mime (imagen.path).split("/");

    final imageUploadRequesr = http.MultipartRequest(
      "POST", 
      url,
    )..fields["upload_preset"] = "cmugkyuq" ;

    final file = await http.MultipartFile.fromPath('file', imagen.path,
    contentType: MediaType( _mime[0], _mime[1] )
    );

    imageUploadRequesr.files.add(file);
    
    final streamResponse = await imageUploadRequesr.send();
    final resp = await http.Response.fromStream(streamResponse);

    if( resp.statusCode != 200 && resp.statusCode != 201){
      print("error al subir imagen");
      print( resp.body );
      return null;
    }

    final respData = json.decode(resp.body);
    return respData["secure_url"];

  }

}