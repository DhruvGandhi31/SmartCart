import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  // final List<ProductModel> wishlistItems;

  static const routeName = "wishlist";
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: Center(
        child: Text('Wishlist Screen'),
      ),
    );
  }
}
