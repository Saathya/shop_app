import 'package:floating_navbar/floating_navbar.dart';
import 'package:floating_navbar/floating_navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:shop_spp/Screens/home_screen.dart';
import 'package:shop_spp/Screens/shops_screen.dart';

import 'account_screen.dart';
import 'cart_screen.dart';


class MainScreen extends StatefulWidget {
  static const String id = "main-screen";
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingNavBar(
          color: const Color(0xFF111111),
          hapticFeedback: false,
          horizontalPadding: 26,
          borderRadius: 20,
          selectedIconColor: Colors.purpleAccent,
          unselectedIconColor: Colors.grey,
          items: [
            FloatingNavBarItem(
                title: 'Home', page: const HomeScreen(), iconData: Icons.home),
            FloatingNavBarItem(
                title: 'Home',
                page: const ShopsScreen(),
                iconData: Icons.shop_2),
            FloatingNavBarItem(
                title: 'Home',
                page: const CartScreen(),
                iconData: Icons.shopping_bag_outlined),
            FloatingNavBarItem(
                title: 'Home',
                page: const AccountScreen(),
                iconData: Icons.person),
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Navigator.pushNamed(
      //     //   context,
      //     //   FeedbackForm.id,
      //   },
      //   backgroundColor: Colors.redAccent,
      //   child: const CircleAvatar(
      //     backgroundColor: Colors.white,
      //     child: Icon(Icons.call),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   notchMargin: 10,
      //   child: SizedBox(
      //       height: 60,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Row(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               MaterialButton(
      //                 minWidth: 40,
      //                 onPressed: () {
      //                   setState(() {
      //                     _index = 0;
      //                     _currentScreen = const HomeScreen();
      //                   });
      //                 },
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Icon(_index == 0 ? Icons.home : Icons.home_outlined),
      //                     Text(
      //                       'HOME',
      //                       style: TextStyle(
      //                           color: _index == 0 ? color : Colors.black,
      //                           fontWeight: _index == 0
      //                               ? FontWeight.bold
      //                               : FontWeight.normal,
      //                           fontSize: 12),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               MaterialButton(
      //                 minWidth: 40,
      //                 onPressed: () {
      //                   setState(() {
      //                     _index = 1;
      //                     _currentScreen = const ShopsScreen();
      //                   });
      //                 },
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Icon(_index == 1
      //                         ? Icons.shop_2_outlined
      //                         : Icons.shop_2_outlined),
      //                     Text(
      //                       'Shops',
      //                       style: TextStyle(
      //                           color: _index == 1 ? color : Colors.black,
      //                           fontWeight: _index == 1
      //                               ? FontWeight.bold
      //                               : FontWeight.normal,
      //                           fontSize: 12),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //           Row(
      //             children: [
      //               MaterialButton(
      //                 minWidth: 40,
      //                 onPressed: () {
      //                   setState(() {
      //                     _index = 2;
      //                     _currentScreen = const CartScreen();
      //                   });
      //                 },
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Icon(_index == 2
      //                         ? IconlyLight.bag2
      //                         : IconlyLight.bag2),
      //                     Text(
      //                       'Cart',
      //                       style: TextStyle(
      //                           color: _index == 2 ? color : Colors.black,
      //                           fontWeight: _index == 2
      //                               ? FontWeight.bold
      //                               : FontWeight.normal,
      //                           fontSize: 12),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               MaterialButton(
      //                 minWidth: 40,
      //                 onPressed: () {
      //                   setState(() {
      //                     _index = 3;
      //                     _currentScreen = const AccountScreen();
      //                   });
      //                 },
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Icon(_index == 3
      //                         ? IconlyLight.profile
      //                         : IconlyLight.profile),
      //                     Text(
      //                       'Account',
      //                       style: TextStyle(
      //                           color: _index == 3 ? color : Colors.black,
      //                           fontWeight: _index == 3
      //                               ? FontWeight.bold
      //                               : FontWeight.normal,
      //                           fontSize: 12),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       )),
      // ),
    );
  }
}
