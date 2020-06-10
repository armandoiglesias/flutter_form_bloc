import 'dart:convert';

ProductoModel productoFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    ProductoModel({
        this.id,
        this.title  ="",
        this.valor = 0.0,
        this.disponible = true,
        this.photoUrl,
    });

    String id;
    String title;
    double valor;
    bool disponible;
    String photoUrl;

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id: json["id"],
        title: json["title"],
        valor: json["valor"],
        disponible: json["disponible"],
        photoUrl: json["photo_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "valor": valor,
        "disponible": disponible,
        "photo_url": photoUrl,
    };
}
