import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/logic/cubits/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/logic/cubits/product_cubit/product_state.dart';
import 'package:e_commerce_app/presentations/screens/product/product_details_screen.dart';
import 'package:e_commerce_app/presentations/widgets/product_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (query) {
                      setState(() {
                        _isSearching = false;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoadingState && state.products.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ProductErrorState && state.products.isEmpty) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                final List<ProductModel> filteredProducts = _filterProducts(
                  state.products,
                  _searchController.text.toLowerCase(),
                );

                if (_searchController.text.isEmpty) {
                  return const Center(
                    child: Text('Search for products'),
                  );
                }

                return ProductListView(products: filteredProducts);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<ProductModel> _filterProducts(
      List<ProductModel> products, String query) {
    return products
        .where((product) =>
            product.title!.toLowerCase().contains(query) ||
            product.category!.toLowerCase().contains(query))
        .toList();
  }

  void _onSearchChanged(String query) {
    setState(() {});
  }
}
