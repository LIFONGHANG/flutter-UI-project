import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;

  final ValueChanged<int> onTap;

  static const Color pinkColor =
      Color(0xFFF83758);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,

        boxShadow: [
          BoxShadow(
            color: Color(0x15000000),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),

      child: SafeArea(
        top: false,

        child: SizedBox(
          height: 70,

          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,

            children: [
              // 0 - Home
              _navItem(
                index: 0,
                icon: Icons.home_outlined,
                label: 'Home',
              ),

              // 1 - Wishlist
              _navItem(
                index: 1,
                icon: Icons.favorite_border,
                label: 'Wishlist',
              ),

              // 2 - Cart
              _cartButton(),

              // 3 - Employee
              _navItem(
                index: 3,
                icon: Icons.people_outline,
                label: 'Employee',
              ),

              // 4 - Setting
              _navItem(
                index: 4,
                icon: Icons.settings_outlined,
                label: 'Setting',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // NORMAL NAV ITEM
  // ==========================================================

  Widget _navItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected =
        currentIndex == index;

    return InkWell(
      onTap: () {
        onTap(index);
      },

      borderRadius:
          BorderRadius.circular(10),

      child: SizedBox(
        width: 60,
        height: 60,

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Icon(
              icon,
              size: 25,
              color: isSelected
                  ? pinkColor
                  : Colors.black,
            ),

            const SizedBox(height: 4),

            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected
                    ? pinkColor
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // CART BUTTON
  // ==========================================================

  Widget _cartButton() {
    final bool isSelected =
        currentIndex == 2;

    return InkWell(
      onTap: () {
        onTap(2);
      },

      borderRadius:
          BorderRadius.circular(40),

      child: Transform.translate(
        offset: const Offset(0, -10),

        child: Column(
          mainAxisSize:
              MainAxisSize.min,

          children: [
            Container(
              width: 52,
              height: 52,

              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,

                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.black.withValues(
                      alpha: 0.15,
                    ),
                    blurRadius: 10,
                    offset:
                        const Offset(0, 2),
                  ),
                ],
              ),

              child: Icon(
                Icons.shopping_cart_outlined,
                size: 26,
                color: isSelected
                    ? pinkColor
                    : Colors.black,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              'Cart',
              style: TextStyle(
                fontSize: 11,
                color: isSelected
                    ? pinkColor
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}