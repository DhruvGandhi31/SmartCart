part of 'wishlist_cubit.dart';

@immutable
abstract class WishlistState {
  const WishlistState();
}

class WishlistInitial extends WishlistState {
  const WishlistInitial();
}

class WishlistUpdated extends WishlistState {
  final List<ProductModel> wishlistItems;

  const WishlistUpdated(this.wishlistItems);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WishlistUpdated &&
        listEquals(other.wishlistItems, wishlistItems);
  }

  @override
  int get hashCode => wishlistItems.hashCode;
}
