import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String model;
  String des;
  String cat;
  double price;
  String photo;
  int quantity;

  Product(
      {required this.id,
      required this.model,
      required this.des,
      required this.cat,
      required this.price,
      required this.photo,
      required this.quantity});

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map; // explain this line please ?
    return Product(
      id: doc.id,
      model: data['model'] ?? "",
      des: data['des'] ?? "",
      cat: data['cat'] ?? "",
      price: (data['price'] ?? 0.0).toDouble(),
      photo: data['photo'] ?? "",
      quantity: data['quantity'] ?? 0,
    );
  }
}
