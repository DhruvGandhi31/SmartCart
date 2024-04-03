import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  List<ProductModel> wishlistItems = [];

  void addToWishlist(ProductModel product) {
    wishlistItems.add(product);
    emit(WishlistUpdated(wishlistItems));
  }

  void removeFromWishlist(ProductModel product) {
    wishlistItems.remove(product);
    emit(WishlistUpdated(wishlistItems));
  }
}
