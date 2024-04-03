import 'package:e_commerce_app/core/ui.dart';
import 'package:e_commerce_app/data/models/user_model.dart';
import 'package:e_commerce_app/logic/cubits/user_cubits/user_cubits.dart';
import 'package:e_commerce_app/logic/cubits/user_cubits/user_state.dart';
import 'package:e_commerce_app/presentations/screens/order/my_order_screen.dart';
import 'package:e_commerce_app/presentations/screens/user/edit_profile_screen.dart';
import 'package:e_commerce_app/presentations/widgets/link_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is UserLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is UserErrorState) {
        return Center(
          child: Text(state.message),
        );
      }

      if (state is UserLoggedInState) {
        return userProfile(state.userModel);
      }

      return const Center(
        child: Text("An error occured!"),
      );
    });
  }

  Widget userProfile(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Profile Card
        Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/drawer.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Circular Avatar
                CircleAvatar(
                  radius: 42,
                  backgroundColor: Color.fromARGB(255, 195, 1, 1),
                  // child: Text(
                  //   userModel.fullName?.isNotEmpty ?? false
                  //       ? userModel.fullName![0].toUpperCase()
                  //       : '?',
                  //   style: const TextStyle(fontSize: 42 * 0.7),
                  // ),
                  // Hardcoded 'J' for now, will be implemented in Future
                  child: Text(
                    'J',
                    style: TextStyle(fontSize: 42 * 0.7),
                  ),
                ),
                SizedBox(height: 16),
                // "Hi, username" Text
                Text(
                  // Fetch Username to be implemented,
                  "Hi, John Smith",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        // Button Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // My Orders Button
            _profileButton(
              onTap: () {
                Navigator.pushNamed(context, MyOrderScreen.routeName);
              },
              icon: CupertinoIcons.cube_box_fill,
              label: "My Orders",
            ),
            // Buy Again Button
            _profileButton(
              onTap: () {
                // Implement Buy Again functionality
              },
              icon: Icons.repeat,
              label: "Buy Again",
            ),
          ],
        ),
        SizedBox(height: 16),
        // Button Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Profile Button
            _profileButton(
              onTap: () {
                // Implement Profile functionality
              },
              icon: Icons.person,
              label: "Profile",
            ),
            // Wishlist Button
            _profileButton(
              onTap: () {
                // Implement Wishlist functionality
              },
              icon: Icons.favorite,
              label: "Wishlist",
            ),
          ],
        ),
        SizedBox(height: 16),
        // Sign Out Button
        ListTile(
          onTap: () {
            BlocProvider.of<UserCubit>(context).signOut();
          },
          contentPadding: EdgeInsets.zero,
          leading: const Icon(
            Icons.exit_to_app,
            color: Colors.red,
          ),
          title: Text(
            "Sign Out",
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

// Helper method to create profile buttons
  Widget _profileButton(
      {required VoidCallback onTap,
      required IconData icon,
      required String label}) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
