import 'package:flutter/material.dart';

import 'package:final_crackteck/widgets/delivery_man_bottom_navigation.dart';

import '../../widgets/placeholder.dart';
import 'delivery_home_tab.dart';
import 'delivery_profile_tab.dart';

class DeliveryDashboard extends StatefulWidget {
  final int roleId;
  final String roleName;

  const DeliveryDashboard({
    super.key,
    required this.roleId,
    required this.roleName,
  });

  @override
  State<DeliveryDashboard> createState() => _DeliveryDashboardState();
}

class _DeliveryDashboardState extends State<DeliveryDashboard> {
  /// 0 = Home, 1 = Chat / Orders, 2 = Profile
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      /// 🏠 HOME
      DeliveryPersonHomeTab(
        roleId: widget.roleId,
        roleName: widget.roleName,
      ),

      /// 💬 CHAT / ORDERS
      ComingSoonScreen(
        roleId: widget.roleId,
        roleName: widget.roleName,
      ),

      /// 👤 PROFILE (temporary)
      DeliveryProfileScreen(
        roleId: widget.roleId,
        roleName: widget.roleName,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      bottomNavigationBar: DeliveryBottomNavigation(
        currentIndex: _currentIndex,

        onHome: () {
          setState(() => _currentIndex = 0);
        },

        onChat: () {
          setState(() => _currentIndex = 1);
        },

        onProfile: () {
          setState(() => _currentIndex = 2);
        },
      ),
    );
  }
}
