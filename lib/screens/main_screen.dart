// import 'package:ecommerce_web/screens/profile.dart';
// import 'package:ecommerce_web/screens/wishlist.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart' as badges;
// import 'package:provider/provider.dart';
// import '../providers/cart_provider.dart';
// import '../utils/colors.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
// import 'home/home_screen.dart';
// import 'shop/shop_screen.dart';
// import 'cart/cart_screen.dart';
//
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0;
//
//   final List<Widget> _screens = [
//     const HomeScreen(),
//     const ShopScreen(),
//     const CartScreen(),
//     const WishlistScreen(),
//     const ProfileScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_currentIndex],
//       bottomNavigationBar:CustomBottomNavBar(
//       currentIndex: _currentIndex,
//       onTap: (index) {
//         setState(() {
//           _currentIndex = index;
//         });
//       },
//     ),
//
//
//     );
//   }
// }