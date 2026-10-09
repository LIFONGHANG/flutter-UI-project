import 'package:flutter/material.dart';

import 'package:flutter_ui_project_salait/products/homepage.dart';
import 'package:flutter_ui_project_salait/screens/cart_screen.dart';
import 'package:flutter_ui_project_salait/screens/employee/employee_screen.dart';
import 'package:flutter_ui_project_salait/screens/setting_screen.dart';
import 'package:flutter_ui_project_salait/screens/wishlist_screen.dart';
import 'package:flutter_ui_project_salait/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,

        children: const [
          // 0 - Home
          Homepage(),

          // 1 - Wishlist
          WishlistScreen(),

          // 2 - Cart
          CartScreen(),

          // 3 - Employee
          // This replaces SearchScreen
          EmployeeScreen(),

          // 4 - Setting
          SettingScreen(),
        ],
      ),

      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}