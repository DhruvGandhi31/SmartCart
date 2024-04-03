import 'package:e_commerce_app/data/models/product_model.dart';

class WishlistService {
  // List to store wishlist items
  static List<ProductModel> wishlistItems = [];

  // Method to check if a product is in the wishlist
  static bool isInWishlist(ProductModel product) {
    return wishlistItems.contains(product);
  }

  // Method to add product to wishlist
  static void addToWishlist(ProductModel product) {
    if (!wishlistItems.contains(product)) {
      wishlistItems.add(product);
    }
  }

  // Method to remove product from wishlist
  static void removeFromWishlist(ProductModel product) {
    wishlistItems.remove(product);
  }
}
