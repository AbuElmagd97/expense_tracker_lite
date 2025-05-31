// Custom Bottom Navigation Bar
import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onAddPressed;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_filled,
            index: 0,
            isSelected: currentIndex == 0,
          ),
          _buildNavItem(
            icon: Icons.bar_chart,
            index: 1,
            isSelected: currentIndex == 1,
          ),
          // Add button in the center
          GestureDetector(
            onTap: onAddPressed,
            child: Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          _buildNavItem(
            icon: Icons.receipt_long,
            index: 2,
            isSelected: currentIndex == 2,
          ),
          _buildNavItem(
            icon: Icons.person,
            index: 3,
            isSelected: currentIndex == 3,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Icon(
          icon,
          color: isSelected ? AppColors.primary : Colors.grey[400],
          size: 24,
        ),
      ),
    );
  }
}