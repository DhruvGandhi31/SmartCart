import 'package:e_commerce_app/presentations/screens/auth/providers/signup_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui.dart';
import '../../widgets/gap_widget.dart';
import '../../widgets/link_button.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static const String routeName = "signup";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignupProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text("SmartCart"),
      ),
      body: SafeArea(
        child: Form(
          key: provider.formKey,
          child: ListView(padding: const EdgeInsets.all(16), children: [
            Text("Create Account", style: TextStyles.heading2),
            const GapWidget(size: -10),
            (provider.error != "")
                ? Text(
                    provider.error,
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox(),
            const GapWidget(size: 5),
            PrimaryTextField(
              controller: provider.fullNameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Full Name is required!";
                }
                return null;
              },
              labelText: "Full Name",
            ),
            const GapWidget(),
            PrimaryTextField(
              controller: provider.emailController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Email address is required!";
                }
                if (!EmailValidator.validate(value.trim())) {
                  return "Invalid email address";
                }
                return null;
              },
              labelText: "Email Address",
            ),
            const GapWidget(),
            PrimaryTextField(
              controller: provider.phoneController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Phone number is required!";
                }
                // Add additional validation if necessary
                return null;
              },
              labelText: "Phone Number",
            ),
            const GapWidget(),
            PrimaryTextField(
              controller: provider.addressController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Address is required!";
                }
                // Add additional validation if necessary
                return null;
              },
              labelText: "Address",
            ),
            const GapWidget(),
            PrimaryTextField(
              controller: provider.cityController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "City is required!";
                }
                // Add additional validation if necessary
                return null;
              },
              labelText: "City",
            ),
            const GapWidget(),
            PrimaryTextField(
              controller: provider.stateController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "State is required!";
                }
                // Add additional validation if necessary
                return null;
              },
              labelText: "State",
            ),
            const GapWidget(),
            PrimaryTextField(
              controller: provider.passwordController,
              obscureText: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Password is required!";
                }
                return null;
              },
              labelText: "Password",
            ),
            const GapWidget(),
            PrimaryTextField(
              controller: provider.cPasswordController,
              obscureText: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Confirm your password!";
                }
                if (value.trim() != provider.passwordController.text.trim()) {
                  return "Passwords do not match!";
                }
                return null;
              },
              labelText: "Confirm Password",
            ),
            const GapWidget(),
            PrimaryButton(
              onPressed: provider.createAccount,
              text: (provider.isLoading) ? "..." : "Create Account",
            ),
            const GapWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?", style: TextStyles.body2),
                const GapWidget(),
                LinkButton(onPressed: () {}, text: "Log In")
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
