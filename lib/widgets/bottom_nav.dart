import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/constants/app_assets.dart';
import '../constants/app_constants.dart';
import '../theme/app_theme.dart';

class BottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const BottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.bg,
        border: Border(top: BorderSide(color: AppTheme.border, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              _NavItem(
                icon: GetBottomNavIcon(
                  assetPath: AppAssets.nutritionSvgIcon,
                  isActive: selectedIndex == 0,
                ),
                label: AppStrings.home,
                active: selectedIndex == 0,
                onTap: () => onTap(0),
              ),
              _NavItem(
                icon: GetBottomNavIcon(
                  assetPath: AppAssets.planSvgIcon,
                  isActive: selectedIndex == 1,
                ),
                label: AppStrings.plan,
                active: selectedIndex == 1,
                onTap: () => onTap(1),
              ),
              _NavItem(
                icon: GetBottomNavIcon(
                  assetPath: AppAssets.moodSvgIcon,
                  isActive: selectedIndex == 2,
                ),
                label: AppStrings.mood,
                active: selectedIndex == 2,
                onTap: () => onTap(2),
              ),
              _NavItem(
                icon: GetBottomNavIcon(
                  assetPath: AppAssets.profileSvgIcon,
                  isActive: selectedIndex == 3,
                ),
                label: AppStrings.profile,
                active: selectedIndex == 3,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: active ? AppTheme.white : AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GetBottomNavIcon extends StatelessWidget {
  final String assetPath;
  final bool isActive;
  const GetBottomNavIcon({
    super.key,
    required this.assetPath,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return SvgPicture.asset(
        assetPath,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(AppTheme.white, BlendMode.srcIn),
      );
    }
    return SvgPicture.asset(assetPath, width: 24, height: 24);
  }
}
