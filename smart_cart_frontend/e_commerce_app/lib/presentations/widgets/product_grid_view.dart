import 'dart:math';

import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/logic/cubits/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/logic/cubits/product_cubit/product_state.dart';
import 'package:e_commerce_app/presentations/screens/product/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductGridView extends StatefulWidget {
  const ProductGridView({super.key, this.deal = false, this.k = 0});

  final bool deal;
  final int k;
  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadingState && state.products.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ProductErrorState && state.products.isEmpty) {
          return Center(
            child: Text(state.message),
          );
        }

        return productView(state.products);
      },
    );
  }

  Widget productView(List products) {
    final x = ['50', '75', '25', '80'];

    return GridView.builder(
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 8.0, // Spacing between columns
        mainAxisSpacing: 8.0, // Spacing between rows
        childAspectRatio: 0.8, // Aspect ratio
      ),
      itemBuilder: (context, index) {
        final product = products[index + widget.k];

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                arguments: product);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            // de: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(12),
            // ),
            child: Column(
              children: [
                Image.network(
                  "${product.images?[0]}",
                  // width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.width * 0.4,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  // alignment: AlignmentDirectional.center,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Text(
                        'Failed to load image',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  },
                ),
                if (widget.deal)
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        color: Colors.red,
                        child: Text(
                          '${x[index]}% OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        "Limited time deal",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
