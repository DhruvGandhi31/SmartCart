import 'dart:async';

import 'package:e_commerce_app/logic/cubits/user_cubits/user_cubits.dart';
import 'package:e_commerce_app/logic/cubits/user_cubits/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupProvider with ChangeNotifier {
  final BuildContext context;
  SignupProvider(this.context) {
    _listenToUserCubit();
  }

  bool isLoading = false;
  String error = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();
  final fullNameController = TextEditingController(); // New field
  final phoneController = TextEditingController(); // New field
  final addressController = TextEditingController(); // New field
  final cityController = TextEditingController(); // New field
  final stateController = TextEditingController(); // New field
  final formKey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

  void _listenToUserCubit() {
    _userSubscription =
        BlocProvider.of<UserCubit>(context).stream.listen((userState) {
      if (userState is UserLoadingState) {
        isLoading = true;
        error = "";
        notifyListeners();
      } else if (userState is UserErrorState) {
        isLoading = false;
        error = userState.message;
        notifyListeners();
      } else {
        isLoading = false;
        error = "";
        notifyListeners();
      }
    });
  }

  void createAccount() async {
    if (!formKey.currentState!.validate()) return;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String fullName = fullNameController.text.trim(); // New field
    String phone = phoneController.text.trim(); // New field
    String address = addressController.text.trim(); // New field
    String city = cityController.text.trim(); // New field
    String state = stateController.text.trim(); // New field

    BlocProvider.of<UserCubit>(context).createAccount(
      email: email,
      password: password,
      fullName: fullName, // New field
      phone: phone, // New field
      address: address, // New field
      city: city, // New field
      state: state, // New field
    );
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
