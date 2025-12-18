import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../widgets/bottom_navigation.dart';

class SalesPersonAttendanceScreen extends StatefulWidget {
  final int roleId;
  final String roleName;

  const SalesPersonAttendanceScreen({
    super.key,
    required this.roleId,
    required this.roleName,
  });

  @override
  State<SalesPersonAttendanceScreen> createState() =>
      _SalesPersonAttendanceScreenState();
}

class _SalesPersonAttendanceScreenState
    extends State<SalesPersonAttendanceScreen> {
  static const Color midGreen = Color(0xFF1F8B00);
  static const Color darkGreen = Color(0xFF145A00);

  bool _moreOpen = false;
  int _navIndex = 1;

  String loginTime = '00:00 AM';
  String logoutTime = '00:00 PM';

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
          'Attendance',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Column(
          children: [
            /// PROFILE
            Stack(
              children: [
                const CircleAvatar(
                  radius: 42,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            const Text(
              'Sales Person',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 16),

            /// CHECK-IN / CHECK-OUT BUTTONS
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: midGreen,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        loginTime = '09:00 AM';
                      });
                    },
                    child: Column(
                      children: [
                        const Text(
                          'Check In',
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          loginTime,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFEAEA),
                      foregroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        logoutTime = '05:00 PM';
                      });
                    },
                    child: Column(
                      children: [
                        const Text(
                          'Check Out',
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          logoutTime,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// ATTENDANCE LIST (STATIC)
            _attendanceCard(day: '17', month: 'April'),
            _attendanceCard(day: '16', month: 'April'),
          ],
        ),
      ),

      /// FLOATING CALENDAR BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: midGreen,
        onPressed: _pickDate,
        child: const Icon(Icons.calendar_today),
      ),

      /// BOTTOM NAV
      bottomNavigationBar: CrackteckBottomSwitcher(
        isMoreOpen: _moreOpen,
        currentIndex: _navIndex,
        roleId: widget.roleId,
        roleName: widget.roleName,
        onHome: () => setState(() => _navIndex = 0),
        onProfile: () => setState(() => _navIndex = 2),
        onMore: () => setState(() => _moreOpen = true),
        onLess: () => setState(() => _moreOpen = false),
        onFollowUp: () {},
        onMeeting: () {},
        onQuotation: () {},
      ),
    );
  }

  /// ATTENDANCE CARD
  Widget _attendanceCard({
    required String day,
    required String month,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(day,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              Text(month,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Login & Out',
                    style:
                    TextStyle(fontSize: 12, color: Colors.black54)),
                Text('09:00 AM - 05:00 PM',
                    style: TextStyle(
                        color: midGreen,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 6),
                Text('Service ID',
                    style:
                    TextStyle(fontSize: 12, color: Colors.black54)),
                Text('#UORD65858DYE'),
                SizedBox(height: 6),
                Text('Status',
                    style:
                    TextStyle(fontSize: 12, color: Colors.black54)),
                Text('Completed'),
                SizedBox(height: 6),
                Text('Working Hours',
                    style:
                    TextStyle(fontSize: 12, color: Colors.black54)),
                Text('06:00:00 hrs'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// CALENDAR PICKER
  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Attendance for ${date.day}-${date.month}-${date.year}',
          ),
        ),
      );
    }
  }
}
