import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:badges/badges.dart' as badges;

import '../providers/cart_provider.dart';
import '../utils/colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) return const SizedBox.shrink();

        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              final isSelected = currentIndex == index;

              IconData icon;
              IconData activeIcon;
              String label;

              switch (index) {
                case 0:
                  icon = Icons.home_outlined;
                  activeIcon = Icons.home;
                  label = "Home";
                  break;
                case 1:
                  icon = Icons.store_outlined;
                  activeIcon = Icons.store;
                  label = "Shop";
                  break;
                case 2:
                  icon = Icons.shopping_cart_outlined;
                  activeIcon = Icons.shopping_cart;
                  label = "Cart";
                  break;
                case 3:
                  icon = Icons.favorite_outline;
                  activeIcon = Icons.favorite;
                  label = "Wishlist";
                  break;
                case 4:
                  icon = Icons.person_outline;
                  activeIcon = Icons.person;
                  label = "Profile";
                  break;
                default:
                  icon = Icons.circle;
                  activeIcon = Icons.circle;
                  label = "";
              }

              Widget iconWidget = Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? AppColors.primary : AppColors.grey,
                size: 26,
              );

              // Add cart badge
              // if (index == 2) {
              //   iconWidget = Consumer<CartProvider>(
              //     builder: (context, cart, child) {
              //       return Badge(
              //         position: badges.BadgePosition.topEnd(top: -12, end: -12),
              //         badgeStyle: badges.BadgeStyle(
              //           badgeColor: AppColors.accent,
              //           padding: const EdgeInsets.all(5),
              //         ),
              //         showBadge: cart.itemCount > 0,
              //         badgeContent: Text(
              //           cart.itemCount.toString(),
              //           style: const TextStyle(
              //             color: Colors.white,
              //             fontSize: 10,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         child: iconWidget,
              //       );
              //
              //     },
              //   );
              // }
              if (index == 2) {
                iconWidget = buildCartIcon(
                  context,
                  isSelected ? activeIcon : icon,
                  isSelected,
                );
              }

              return GestureDetector(
                onTap: () => onTap(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: isSelected
                      ? BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  )
                      : null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      iconWidget,
                      const SizedBox(height: 4),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? AppColors.primary : AppColors.grey,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
Widget buildCartIcon(BuildContext context, IconData icon, bool isSelected) {
  return Consumer<CartProvider>(
    builder: (context, cart, child) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : AppColors.grey,
            size: 26,
          ),
          if (cart.itemCount > 0)
            Positioned(
              right: -6,
              top: -6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                child: Text(
                  cart.itemCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      );
    },
  );
}
