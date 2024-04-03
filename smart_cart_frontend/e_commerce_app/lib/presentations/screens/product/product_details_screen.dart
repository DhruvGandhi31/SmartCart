import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/ui.dart';
import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/logic/cubits/cart_cubits/cart_cubit.dart';
import 'package:e_commerce_app/logic/cubits/cart_cubits/cart_state.dart';
import 'package:e_commerce_app/logic/services/formatter.dart';
import 'package:e_commerce_app/logic/services/wishlist_service.dart';
import 'package:e_commerce_app/presentations/widgets/gap_widget.dart';
import 'package:e_commerce_app/presentations/widgets/primary_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailsScreen({super.key, required this.productModel});

  static const routeName = "product_details";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isInWishlist = false;

  @override
  void initState() {
    super.initState();
    // isInWishlist = widget.productModel.isInWishlist ?? false;
  }

  // Method to add product to wishlist
  void addToWishlist() {
    WishlistService.addToWishlist(widget.productModel);
  }

  // Method to remove product from wishlist
  void removeFromWishlist() {
    WishlistService.removeFromWishlist(widget.productModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.productModel.title}"),
        actions: [
          IconButton(
            onPressed: () {
              // Toggle isInWishlist status
              setState(() {
                isInWishlist = !isInWishlist;
              });
              // Add or remove the product from the wishlist
              if (isInWishlist) {
                addToWishlist(); // Call method to add to wishlist
              } else {
                removeFromWishlist(); // Call method to remove from wishlist
              }
            },
            icon: Icon(
              isInWishlist ? Icons.favorite : Icons.favorite_border,
              color: isInWishlist ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width,
              child: CarouselSlider.builder(
                itemCount: widget.productModel.images?.length ?? 0,
                slideBuilder: (index) {
                  String url = widget.productModel.images![index];

                  return CachedNetworkImage(
                    imageUrl: url,
                  );
                },
              ),
            ),
            const GapWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.productModel.title}",
                    style: TextStyles.heading3,
                  ),
                  Text(
                    Formatter.formatPrice(widget.productModel.price!),
                    style: TextStyles.heading2,
                  ),
                  const GapWidget(size: 10),
                  BlocBuilder<CartCubit, CartState>(builder: (context, state) {
                    bool isInCart = BlocProvider.of<CartCubit>(context)
                        .cartContains(widget.productModel);

                    return PrimaryButton(
                        onPressed: () {
                          print('isInCart before addToCart: $isInCart');
                          if (isInCart) {
                            return;
                          }

                          BlocProvider.of<CartCubit>(context)
                              .addToCart(widget.productModel, 1);
                        },
                        color:
                            (isInCart) ? AppColors.textLight : AppColors.accent,
                        text: (isInCart)
                            ? "Product added to cart"
                            : "Add to Cart");
                  }),
                  const GapWidget(size: 10),
                  Text(
                    "Description",
                    style:
                        TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.productModel.description}",
                    style: TextStyles.body1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
