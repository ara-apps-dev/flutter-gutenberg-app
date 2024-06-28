import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constant/colors.dart';

class CustomSnakeNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomSnakeNavigationBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      behaviour: SnakeBarBehaviour.floating,
      snakeShape: SnakeShape.indicator,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      backgroundColor: aLightBackgroundColor,
      snakeViewColor: aLightPrimaryColor,
      height: 50,
      elevation: 7,
      selectedItemColor: aLightPrimaryColor,
      unselectedItemColor: aLightTextColor,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      currentIndex: currentIndex,
      onTap: onTap,
      items: _buildNavigationBarItems(),
      unselectedLabelStyle: _buildLabelStyle(aLightTextColor),
      selectedLabelStyle: _buildLabelStyle(aLightPrimaryColor),
    );
  }

  List<BottomNavigationBarItem> _buildNavigationBarItems() {
    return [
      _buildNavigationBarItem(
        icon: FontAwesomeIcons.swatchbook,
        label: 'Home',
      ),
      _buildNavigationBarItem(
        icon: FontAwesomeIcons.bookBookmark,
        label: 'Bookshelf',
      ),
      _buildNavigationBarItem(
        icon: FontAwesomeIcons.solidThumbsUp,
        label: 'Liked',
      ),
      _buildNavigationBarItem(
        icon: FontAwesomeIcons.gear,
        label: 'Settings',
      ),
    ];
  }

  BottomNavigationBarItem _buildNavigationBarItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: FaIcon(
        icon,
        size: 20.0,
        color: aLightTextColor,
      ),
      activeIcon: FaIcon(
        icon,
        size: 20.0,
        color: aLightPrimaryColor,
      ),
      label: label,
    );
  }

  TextStyle _buildLabelStyle(Color color) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: 10,
    );
  }
}
