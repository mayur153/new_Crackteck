import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/bottom_navigation.dart';

class SalesPersonMoreScreen extends StatefulWidget {
  final String userName;
  final int roleId;
  final String roleName;

  const SalesPersonMoreScreen({
    super.key,
    this.userName = "Jenny Doe",
    required this.roleId,
    required this.roleName,
  });

  @override
  State<SalesPersonMoreScreen> createState() => _SalesPersonMoreScreenState();
}

class _SalesPersonMoreScreenState extends State<SalesPersonMoreScreen> {
  static const Color midGreen = Color(0xFF1F8B00);
  static const Color darkGreen = Color(0xFF145A00);
  bool _moreOpen = false;
  int _navIndex = 0; // 0=Home, 2=Profile

  // ✅ State values (you can update these later from API)
  String loginTime = "00:00 AM";
  String logoutTime = "00:00 PM";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 76,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [midGreen, darkGreen],
            ),
          ),
        ),
        titleSpacing: 18,
        title: Text(
          "Hi, ${widget.userName}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.NotificationScreen,
                arguments: NotificationArguments(
                  roleId: widget.roleId,
                  roleName: widget.roleName,
                ),
              );
            },
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
          child: Column(
            children: [
            //   // Login / Logout cards
            //   Container(
            //     padding: const EdgeInsets.all(12),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       border: Border.all(color: Colors.black12),
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: Row(
            //       children: [
            //         // Expanded(
            //         //   child: _TimeCard(
            //         //     title: "Login",
            //         //     time: loginTime,
            //         //     bg: const Color(0xFFE9FFE6),
            //         //     iconBg: const Color(0xFF2E7D32),
            //         //     icon: Icons.access_time,
            //         //     titleColor: const Color(0xFF2E7D32),
            //         //     onTap: () {
            //         //       // ✅ example: update state
            //         //       setState(() {
            //         //         loginTime = "09:30 AM";
            //         //       });
            //         //     },
            //         //   ),
            //         // ),
            //         // const SizedBox(width: 12),
            //         // Expanded(
            //         //   child: _TimeCard(
            //         //     title: "Logout",
            //         //     time: logoutTime,
            //         //     bg: const Color(0xFFFFE9E9),
            //         //     iconBg: const Color(0xFFD32F2F),
            //         //     icon: Icons.access_time,
            //         //     titleColor: const Color(0xFFD32F2F),
            //         //     onTap: () {
            //         //       // ✅ example: update state
            //         //       setState(() {
            //         //         logoutTime = "06:45 PM";
            //         //       });
            //         //     },
            //         //   ),
            //         // ),
            //       ],
            //     ),
            //   ),

              const SizedBox(height: 16),

              _OptionTile(
                icon: Icons.info_outline,
                label: "Personal info",
                onTap: () { Navigator.pushNamed(
                  context,
                  AppRoutes.SalesPersonPersonalInfoScreen,
                  arguments: SalespersonalinfoArguments(roleId:  widget.roleId, roleName: widget.roleName),
                );
                },
              ),
              const SizedBox(height: 12),

              _OptionTile(
                icon: Icons.fact_check_outlined,
                label: "Attendance",
                onTap: () { Navigator.pushNamed(
                  context,
                  AppRoutes.SalesPersonAttendanceScreen,
                  arguments: SalesattendanceArguments(roleId:  widget.roleId, roleName: widget.roleName),
                );
                },
              ),
              const SizedBox(height: 12),

              _OptionTile(
                icon: Icons.verified_user_outlined,
                label: "KYC Log",
                onTap: () {
                  // TODO: navigate
                },
              ),
              const SizedBox(height: 12),

              _OptionTile(
                icon: Icons.support_agent_outlined,
                label: "Help & Support",
                onTap: () {
                  // TODO: navigate
                },
              ),
              const SizedBox(height: 12),

              _OptionTile(
                icon: Icons.privacy_tip_outlined,
                label: "Privacy policy",
                onTap: () { Navigator.pushNamed(
                  context,
                  AppRoutes.PrivacyPolicyScreen,
                  arguments: SalespolicyArguments(roleId:  widget.roleId, roleName: widget.roleName),
                );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CrackteckBottomSwitcher(
        isMoreOpen: _moreOpen,
        currentIndex: _navIndex,
        roleId: widget.roleId,
        roleName: widget.roleName,

        onHome: () { /* your home navigation */ },
        onProfile: () { /* your profile navigation */ },
        onMore: () => setState(() => _moreOpen = true),
        onLess: () => setState(() => _moreOpen = false),

        onFollowUp: () {},
        onMeeting: () {},
        onQuotation: () {},
      ),

    );
  }
}

class _TimeCard extends StatelessWidget {
  final String title;
  final String time;
  final Color bg;
  final Color iconBg;
  final IconData icon;
  final Color titleColor;
  final VoidCallback onTap;

  const _TimeCard({
    required this.title,
    required this.time,
    required this.bg,
    required this.iconBg,
    required this.icon,
    required this.titleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 74,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 12),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              time,
              style: TextStyle(
                color: titleColor.withOpacity(0.28),
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _OptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  static const Color darkGreen = Color(0xFF145A00);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward, color: darkGreen, size: 20),
          ],
        ),
      ),
    );
  }
}
