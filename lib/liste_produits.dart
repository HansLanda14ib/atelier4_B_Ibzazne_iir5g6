import 'package:atelier4_b_ibzazne_iir5g6/product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListeProduits extends StatefulWidget {
  @override
  _ListeProduitsState createState() => _ListeProduitsState();
}

class ProductItem extends StatelessWidget {
  ProductItem({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.des),
      subtitle: Text(product.model),
      trailing: Text(product.price.toString()),
    );
  }
}

class _ListeProduitsState extends State<ListeProduits> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('produits').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No products available'));
          }

          List<Product> products = snapshot.data!.docs.map((doc) {
            return Product.fromFirestore(doc);
          }).toList();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio:
                  0.7, // Adjust as needed for product card aspect ratio
            ),
            itemCount: products.length,
            itemBuilder: (context, index) =>
                ProductCard(product: products[index]),
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.des,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(product.model),
                Text('\$${product.price.toStringAsFixed(2)}'),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: 200, // Set the desired width
              height: 200, // Set the desired height
              child: AspectRatio(
                aspectRatio: 1, // Set the desired aspect ratio (e.g., 1 for a square)
                child: Image.network(
                  product.photo,
                  fit: BoxFit.cover, // Adjust the box fit as needed
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
