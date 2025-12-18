import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../widgets/bottom_navigation.dart';

class SalesPersonPersonalInfoScreen extends StatefulWidget {
  final int roleId;
  final String roleName;

  const SalesPersonPersonalInfoScreen({
    Key? key,
    required this.roleId,
    required this.roleName,
  }) : super(key: key);

  @override
  State<SalesPersonPersonalInfoScreen> createState() =>
      _SalesPersonPersonalInfoScreenState();
}

class _SalesPersonPersonalInfoScreenState
    extends State<SalesPersonPersonalInfoScreen> {

  static const Color midGreen = Color(0xFF1F8B00);
  static const Color darkGreen = Color(0xFF145A00);

  /// ✅ STATE VARIABLES
  bool _moreOpen = false;
  int _navIndex = 2; // Profile tab selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// APP BAR
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 72,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [midGreen, darkGreen],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Personal info',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
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
          const SizedBox(width: 6),
        ],
      ),

      /// BODY
      body: Column(
        children: [
          const SizedBox(height: 18),

          /// PROFILE IMAGE
          const CircleAvatar(
            radius: 46,
            backgroundColor: Colors.black12,
            backgroundImage: AssetImage('assets/profile.jpg'),
          ),

          const SizedBox(height: 12),

          const Text(
            'Sales Person',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 24),

          /// INFO LIST
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: const [
                _InfoTile(label: 'Name', value: 'Jenny Doe'),
                _InfoTile(label: 'Number', value: '+91 **** ** ****'),
                _InfoTile(label: 'Email ID', value: 'jennydoe@mail.com'),
                _InfoTile(
                  label: 'Current Address',
                  value: '1213 B wing goregaon',
                ),
                _InfoTile(label: 'Aadhar no.', value: '**********'),
                _InfoTile(
                  label: 'PAN no.',
                  value: '********',
                  showDivider: false,
                ),
              ],
            ),
          ),

          /// EDIT BUTTON
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  // TODO: Edit action
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.edit, size: 16, color: Colors.red),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      /// BOTTOM NAVIGATION
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

/// SINGLE INFO ROW
class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final bool showDivider;

  const _InfoTile({
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        if (showDivider)
          const Divider(height: 1, thickness: 1),
        const SizedBox(height: 16),
      ],
    );
  }
}
