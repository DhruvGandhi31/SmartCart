import 'package:e_commerce_app/data/models/user_model.dart';
import 'package:e_commerce_app/logic/cubits/user_cubits/user_cubits.dart';
import 'package:e_commerce_app/logic/cubits/user_cubits/user_state.dart';
import 'package:e_commerce_app/presentations/screens/home/category_screen.dart';
import 'package:e_commerce_app/presentations/screens/home/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
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
        return drawer(state.userModel);
      }

      return const Center(
        child: Text("An error occured!"),
      );
    });
  }

  Widget drawer(UserModel? userModel) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/drawer.jpg'),
                ),
              ),
              padding: EdgeInsets.all(0),
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    if (userModel != null) ...[
                      CircleAvatar(
                        radius: 42,
                        backgroundColor: const Color.fromARGB(255, 195, 1, 1),
                        // child: Text(
                        //   userModel.fullName?.isNotEmpty ?? false
                        //       ? userModel.fullName![0].toUpperCase()
                        //       : '?',
                        //   style: const TextStyle(fontSize: 42 * 0.7),
                        // ),
                        child: Text(
                          'J',
                          style: const TextStyle(fontSize: 42 * 0.7),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        // Fetch Username to be implemented,
                        "John Smith",
                        style: GoogleFonts.sanchez(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        userModel.email!,
                        style: GoogleFonts.sanchez(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ] else ...[
                      const SizedBox(
                        height: 50, // Adjust height as needed
                      ),
                      Text(
                        'User not logged in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Navigate to profile screen
                // You can replace 'ProfileScreen' with the actual route name
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
                // Navigator.pushNamed(context, 'ProfileScreen');
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categories'),
              onTap: () {
                // Navigate to categories screen
                // You can replace 'CategoriesScreen' with the actual route name
                // Navigator.pushNamed(context, 'CategoryScreen');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CategoryScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text('My Orders'),
              onTap: () {
                // Navigate to my orders screen
                // You can replace 'MyOrdersScreen' with the actual route name
                Navigator.pushNamed(context, 'my_orders');
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              onTap: () {
                // Navigate to cart screen
                // You can replace 'CartScreen' with the actual route name
                Navigator.pushNamed(context, 'cart');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Logout user
                // You can replace 'LogoutScreen' with the actual route name
                // Navigator.pushNamed(context, 'LogoutScreen');
                BlocProvider.of<UserCubit>(context).signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
