import 'package:e_commerce_app/logic/cubits/category_cubits/category_cubit.dart';
import 'package:e_commerce_app/logic/cubits/category_cubits/category_state.dart';
import 'package:e_commerce_app/presentations/screens/product/category_product_screen.dart';
import 'package:e_commerce_app/presentations/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  static const String routeName = "CategoryScreen";

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
      if (state is CategoryLoadingState && state.categories.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is CategoryErrorState && state.categories.isEmpty) {
        return Center(
          child: Text(state.message.toString()),
        );
      }

      final availableCategories = state.categories;

      // return ListView.builder(
      //   itemCount: state.categories.length,
      //   itemBuilder: (context, index) {
      //     final category = state.categories[index];

      //     return ListTile(
      //       onTap: () {
      //         Navigator.pushNamed(context, CategoryProductScreen.routeName,
      //             arguments: category);
      //       },
      //       leading: const Icon(Icons.category),
      //       title: Text("${category.title}"),
      //       trailing: const Icon(Icons.keyboard_arrow_right),
      //     );

      //   },
      // );

      return GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
            )
        ],
      );
    });
  }
}
