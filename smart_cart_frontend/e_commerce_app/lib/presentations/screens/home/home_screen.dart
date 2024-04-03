import 'package:e_commerce_app/core/ui.dart';
import 'package:e_commerce_app/logic/cubits/cart_cubits/cart_cubit.dart';
import 'package:e_commerce_app/logic/cubits/cart_cubits/cart_state.dart';
import 'package:e_commerce_app/logic/cubits/user_cubits/user_cubits.dart';
import 'package:e_commerce_app/logic/cubits/user_cubits/user_state.dart';
import 'package:e_commerce_app/presentations/screens/cart/cart_screen.dart';
import 'package:e_commerce_app/presentations/screens/home/category_screen.dart';
import 'package:e_commerce_app/presentations/screens/home/profile_screen.dart';
import 'package:e_commerce_app/presentations/screens/home/search_screen.dart';
import 'package:e_commerce_app/presentations/screens/home/user_feed_screen.dart';
import 'package:e_commerce_app/presentations/screens/splash/splash_screen.dart';
import 'package:e_commerce_app/presentations/widgets/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = const [
    UserFeedScreen(),
    CategoryScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedOutState) {
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "SmartCart",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                },
                icon: const Icon(CupertinoIcons.search)),
            IconButton(onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            }, icon:
                BlocBuilder<CartCubit, CartState>(builder: (context, state) {
              return Badge(
                  label: Text("${state.items.length}"),
                  isLabelVisible: (state is CartLoadingState) ? false : true,
                  child: const Icon(CupertinoIcons.cart_fill));
            })),
            IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.profile_circled))
          ],
        ),
        drawer: MainDrawer(),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_sharp), label: "You"),
          ],
        ),
      ),
    );
  }
}
