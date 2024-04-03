import 'package:e_commerce_app/data/models/category_model.dart';
import 'package:e_commerce_app/data/repositories/product_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  final CategoryModel category;
  CategoryProductCubit(this.category) : super(CategoryProductInitialState()) {
    _initialize();
  }

  final ProductRepository _productRepository = ProductRepository();

  void _initialize() async {
    emit(CategoryProductLoadingState([])); // Clear previous products
    try {
      final products = await _productRepository
          .fetchProductsByCategory(category.sId!); // Use category id
      emit(CategoryProductLoadedState(products));
    } catch (ex) {
      emit(CategoryProductErrorState(
          ex.toString(), [])); // Notify error with empty products list
    }
  }
}
