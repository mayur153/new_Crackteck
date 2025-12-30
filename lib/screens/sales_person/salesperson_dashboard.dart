import 'dart:math' as math;
import 'package:final_crackteck/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../widgets/bottom_navigation.dart';

class SalespersonDashboard extends StatefulWidget {
  final int roleId;
  final String roleName;

  const SalespersonDashboard({Key? key, required this.roleId, required this.roleName})
      : super(key: key);

  @override
  State<SalespersonDashboard> createState() => _SalespersonDashboardState();
}

class _SalespersonDashboardState extends State<SalespersonDashboard> {
  static const darkGreen = Color(0xFF145A00);
  static const midGreen = Color(0xFF1F7A05);
  int _navIndex = 0;
  bool _moreOpen = false;

  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to logout?"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Logout"),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.roleSelection,
            (route) => false,
      );
    }
  }


  String _reportValue = "Today's Sales Report";

 double target = 10000;
 double achieved = 9000;
 double pending = 1000;

 // Dummy data for tasks on dashboard
  final List<_MiniTaskData> _dashboardTasks = [
    _MiniTaskData(
      type: "Meeting",
      secondLabel: "Meeting ID",
      secondValue: "M-001",
      leadId: "L-001",
      number: "+91 **** ****",
      location: "ABC Corp HQ",
    ),
    _MiniTaskData(
      type: "Follow Up",
      secondLabel: "Follow up ID",
      secondValue: "F-010",
      leadId: "L-002",
      number: "+91 **** ****",
      location: "Client Location",
    ),
    _MiniTaskData(
      type: "Meeting",
      secondLabel: "Meeting ID",
      secondValue: "M-003",
      leadId: "L-003",
      number: "+91 **** ****",
      location: "Office Visit",
    ),
    _MiniTaskData(
      type: "Follow Up",
      secondLabel: "Follow up ID",
      secondValue: "F-014",
      leadId: "L-004",
      number: "+91 **** ****",
      location: "ABC Corp HQ",
    ),
  ];



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
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
        titleSpacing: 18,
        title: Row(
          children: const [
            Icon(Icons.bolt, color: Colors.white, size: 22),
            SizedBox(width: 6),
            Text(
              "CRACKTECK",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: "Attendance",
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.SalesPersonAttendanceScreen,
                arguments: SalesattendanceArguments(
                  roleId: widget.roleId,
                  roleName: widget.roleName,
                ),
              );
            },
            icon: const Icon(Icons.how_to_reg_outlined, color: Colors.white),
          ),

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

          IconButton(
            tooltip: "Logout",
            onPressed: _confirmLogout,
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
          ),

          const SizedBox(width: 8),
        ],
      ),


      body: Transform.translate(
        offset: const Offset(0, -18),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                _TodayTaskHeader(
                  roleId: widget.roleId,
                  roleName: widget.roleName,
                ),

                const SizedBox(height: 10),

                // Updated to use local list and handle delete
                SizedBox(
                  height: 155,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _dashboardTasks.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final item = _dashboardTasks[index];

                      return _TaskCard(
                        title: item.type,
                        leadId: item.leadId,
                        secondLabel: item.secondLabel,
                        secondValue: item.secondValue,
                        number: item.number,
                        location: item.location,
                        onView: () {
                          if (item.type == "Follow Up") {
                            showFollowUpDialog(
                              context,
                              widget.roleId,
                              widget.roleName,
                              onDelete: () {
                                setState(() {
                                  _dashboardTasks.removeAt(index);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Follow-up deleted")),
                                );
                              },
                            );
                          } else {
                            showMeetingDialog(
                              context,
                              widget.roleId,
                              widget.roleName,
                              onDelete: () {
                                setState(() {
                                  _dashboardTasks.removeAt(index);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Meeting deleted")),
                                );
                              },
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),


                SalesOverviewSection(
                  reportValue: _reportValue,
                  onReportChange: (v) {
                    setState(() {
                      _reportValue = v;

                      if (v == "Today's Sales Report") {
                        target = 10000;
                        achieved = 9000;
                        pending = 1000;
                      } else if (v == "This Week") {
                        target = 70000;
                        achieved = 52000;
                        pending = 18000;
                      } else {
                        target = 300000;
                        achieved = 210000;
                        pending = 90000;
                      }
                    });
                  },
                  target: target,
                  achieved: achieved,
                  pending: pending,
                  onDetails: () {},

                  roleId: widget.roleId,
                  roleName: widget.roleName,
                ),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CrackteckBottomSwitcher(
        isMoreOpen: _moreOpen,
        currentIndex: _navIndex,
        roleId: widget.roleId,
        roleName: widget.roleName,

        onHome: () {},
        onProfile: () {},
        onMore: () => setState(() => _moreOpen = true),
        onLess: () => setState(() => _moreOpen = false),

        onFollowUp: () {},
        onMeeting: () {},
        onQuotation: () {},
      ),

    );
  }
}

class _TodayTaskHeader extends StatelessWidget {
  final int roleId;
  final String roleName;

  const _TodayTaskHeader({
    super.key,
    required this.roleId,
    required this.roleName,
  });

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF145A00);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Today’s Task",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.TaskScreen,
              arguments: TaskArguments(
                roleId: roleId,
                roleName: roleName,
              ),
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: darkGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("View All", style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(width: 6),
              Icon(Icons.chevron_right, size: 18),
            ],
          ),
        ),
      ],
    );
  }
}

class _MiniTaskData {
  final String type;
  final String secondLabel;
  final String secondValue;
  final String leadId;
  final String number;
  final String location;

  const _MiniTaskData({
    required this.type,
    required this.secondLabel,
    required this.secondValue,
    required this.leadId,
    required this.number,
    required this.location,
  });
}


class _TaskCard extends StatelessWidget {
  final String title, leadId, secondValue, number, location;
  final String secondLabel;
  final VoidCallback onView;

  const _TaskCard({
    super.key,
    required this.title,
    required this.leadId,
    required this.secondValue,
    required this.number,
    required this.location,
    this.secondLabel = "Follow up ID",
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF145A00);

    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
              ),

              InkWell(
                onTap: onView,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: darkGreen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.remove_red_eye_outlined, size: 16, color: Colors.white),
                      SizedBox(width: 6),
                      Text("View", style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _kv("Lead ID", leadId),
          _kv(secondLabel, secondValue),
          _kv("Number", number),
          _kv("Location", location),
        ],
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 86,
            child: Text(k, style: const TextStyle(fontSize: 11, color: Colors.black54)),
          ),
          Expanded(
            child: Text(
              v,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}



class SalesOverviewSection extends StatelessWidget {
  static const darkGreen = Color(0xFF145A00);
  static const lightGreen = Color(0xFFB9D9B0);

  final String reportValue;
  final ValueChanged<String> onReportChange;

  final double target;
  final double achieved;
  final double pending;
  final int roleId;
  final String roleName;
  final VoidCallback onDetails;

  const SalesOverviewSection({
    super.key,
    required this.reportValue,
    required this.onReportChange,
    required this.target,
    required this.achieved,
    required this.pending,
    required this.onDetails,
    required this.roleId,
    required this.roleName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Sales Overview",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: 42,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: reportValue,
                          isExpanded: true,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),

                          icon: Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: darkGreen),
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 18,
                              color: darkGreen,
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "Today's Sales Report",
                              child: Text("Today’s Sales Report"),
                            ),
                            DropdownMenuItem(
                              value: "Monthly Sales Report",
                              child: Text("Monthly Sales Report"),
                            ),
                            DropdownMenuItem(
                              value: "Yearly Sales Report",
                              child: Text("Yearly Sales Report"),
                            ),
                          ],
                          onChanged: (v) {
                            if (v != null) onReportChange(v);
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LegendDot(label: "Achivement", color: darkGreen),
                      SizedBox(height: 8),
                      _LegendDot(label: "Target Pending", color: lightGreen),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  children: [
                    Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final s = math.min(270.0, constraints.maxWidth);
                          return SizedBox(
                            width: s,
                            height: s,
                            child: _DonutChart(
                              target: target,
                              achieved: achieved,
                              pending: pending,
                              achievedColor: darkGreen,
                              pendingColor: lightGreen,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "28-06-25",
                      style: TextStyle(
                        color: darkGreen,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.SalesOverviewScreen,
                arguments: SalesOverviewArguments(
                  roleId: roleId,
                  roleName: roleName,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: darkGreen,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            child: const Text("Details"),
          ),
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final String label;
  final Color color;
  const _LegendDot({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _DonutChart extends StatelessWidget {
  final double target, achieved, pending;
  final Color achievedColor, pendingColor;

  const _DonutChart({
    required this.target,
    required this.achieved,
    required this.pending,
    required this.achievedColor,
    required this.pendingColor,
  });

  @override
  Widget build(BuildContext context) {
    final achievedPct = (achieved / target).clamp(0.0, 1.0);
    final pendingPct = (pending / target).clamp(0.0, 1.0);

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        CustomPaint(
          painter: _DonutPainter(
            achievedPct: achievedPct,
            pendingPct: pendingPct,
            achievedColor: achievedColor,
            pendingColor: pendingColor,
          ),
          size: const Size(double.infinity, double.infinity),
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Target",
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w800),
            ),
            Text(
              target.toStringAsFixed(0),
              style: TextStyle(
                color: achievedColor,
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
          ],
        ),

        Positioned(
          left: 0,
          bottom: 54,
          child: _ValueLabel(value: achieved, percent: achievedPct, alignLeft: true),
        ),
        Positioned(
          right: 0,
          bottom: 48,
          child: _ValueLabel(value: pending, percent: pendingPct, alignLeft: false),
        ),
      ],
    );
  }
}

class _ValueLabel extends StatelessWidget {
  final double value, percent;
  final bool alignLeft;
  const _ValueLabel({
    required this.value,
    required this.percent,
    required this.alignLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          value.toStringAsFixed(0),
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
        ),
        Text(
          "${(percent * 100).toStringAsFixed(1)}%",
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w700,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double achievedPct, pendingPct;
  final Color achievedColor, pendingColor;

  _DonutPainter({
    required this.achievedPct,
    required this.pendingPct,
    required this.achievedColor,
    required this.pendingColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 54;

    const stroke = 34.0;

    final bgPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = Colors.black12;

    final achievedPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt
      ..color = achievedColor;

    final pendingPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt
      ..color = pendingColor;

    canvas.drawCircle(center, radius, bgPaint);

    final start = -math.pi / 2 + 0.35;

    final achievedSweep = 2 * math.pi * achievedPct;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      achievedSweep,
      false,
      achievedPaint,
    );

    final pendingSweep = 2 * math.pi * pendingPct;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start + achievedSweep,
      pendingSweep,
      false,
      pendingPaint,
    );

    final holePaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius - 42, holePaint);
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) {
    return oldDelegate.achievedPct != achievedPct ||
        oldDelegate.pendingPct != pendingPct ||
        oldDelegate.achievedColor != achievedColor ||
        oldDelegate.pendingColor != pendingColor;
  }
}




const Color kDarkGreen = Color(0xFF145A00);

/// =======================
/// OPENERS
/// =======================
void showFollowUpDialog(BuildContext context, int roleId, String roleName, {VoidCallback? onDelete}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.35),
    builder: (_) => _FollowUpCenterDialog(roleId: roleId, roleName: roleName, onDelete: onDelete),
  );
}

void showMeetingDialog(BuildContext context, int roleId, String roleName, {VoidCallback? onDelete}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.35),
    builder: (_) => _MeetingCenterDialog(roleId: roleId, roleName: roleName, onDelete: onDelete),
  );
}

/// =======================
/// FOLLOW-UP CENTER POPUP
/// =======================
class _FollowUpCenterDialog extends StatelessWidget {
  final int roleId;
  final String roleName;
  final VoidCallback? onDelete;

  const _FollowUpCenterDialog({required this.roleId, required this.roleName, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 345,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Follow-Up",
                  style: TextStyle(
                    color: kDarkGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              const _KVRow(label: "Lead ID", value: "L-001"),
              const _KVRow(label: "Number", value: "+91 **** ****",),
              const _KVRow(label: "Name", value: "Khushi Yadav"),
              const _KVRow(label: "Email", value: "example@gmail.com"),
              const _KVRow(label: "Date", value: "02/04/2025"),
              const _KVRow(label: "Time", value: "11:00 AM"),
              const _KVRow(label: "Status", value: "Pending", statusRed: true),
              const _KVRow(
                label: "Remarks",
                value: "Interested in Mac\nsupport service",
                multiline: true,
              ),

              const SizedBox(height: 14),

              const _ThreeStepProgress(
                dates: ["20/03/25", "22/03/25", "25/03/25"],
                activeIndex: 1,
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _GreenButton(
                      icon: Icons.call,
                      label: "Call",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          AppRoutes.PlaceholderScreen,
                          arguments: PlaceholderArguments(
                            roleId: roleId,
                            roleName: roleName,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _GreenButton(
                      icon: Icons.chat_bubble_outline,
                      label: "Chat",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          AppRoutes.PlaceholderScreen,
                          arguments: PlaceholderArguments(
                            roleId: roleId,
                            roleName: roleName,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _SoftActionButton(
                      icon: Icons.edit_outlined,
                      label: "Edit",
                      bg: const Color(0xFFFFE6D6),
                      fg: Colors.deepOrange,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          AppRoutes.EditFollowUpScreen,
                          arguments: SaleseditfollowupArguments(
                            roleId: roleId,
                            roleName: roleName,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SoftActionButton(
                      icon: Icons.delete_outline,
                      label: "Delete",
                      bg: const Color(0xFFFFE6E6),
                      fg: Colors.red,
                      onTap: () {
                        if (onDelete != null) {
                          onDelete!();
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// =======================
/// MEETING CENTER POPUP
/// =======================
class _MeetingCenterDialog extends StatelessWidget {
  final int roleId;
  final String roleName;
  final VoidCallback? onDelete;

  const _MeetingCenterDialog({required this.roleId, required this.roleName, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 345,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Meeting",
                    style: TextStyle(
                      color: kDarkGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                const _KVRow(label: "Lead ID", value: "L-001"),
                const _KVRow(label: "Meeting ID", value: "M-001"),
                const _KVRow(label: "Name", value: "Khushi Yadav"),
                const _KVRow(label: "Title", value: "example@gmail.com"),
                const _KVRow(label: "Date", value: "02/04/2025"),
                const _KVRow(label: "Time", value: "11:00 AM"),
                const _KVRow(label: "Status", value: "Pending", statusRed: true),
                const _KVRow(label: "Type", value: "Interested in Mac"),
                const _KVRow(
                  label: "Location / Meeting Link",
                  value: "Interested in Mac",
                  multiline: true,
                ),
                const _KVRow(
                  label: "Meeting Agenda / Notes",
                  value: "Interested in Mac",
                  multiline: true,
                ),
                const _KVRow(
                  label: "Follow-up Task",
                  value: "Interested in Mac",
                  multiline: true,
                ),

                const SizedBox(height: 8),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 140,
                      child: Text(
                        "Attachments",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 86,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "IMAGE",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _GreenButton(
                        icon: Icons.call,
                        label: "Call",
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                            context,
                            AppRoutes.PlaceholderScreen,
                            arguments: PlaceholderArguments(
                              roleId: roleId,
                              roleName: roleName,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _GreenButton(
                        icon: Icons.chat_bubble_outline,
                        label: "Chat",
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                            context,
                            AppRoutes.PlaceholderScreen,
                            arguments: PlaceholderArguments(
                              roleId: roleId,
                              roleName: roleName,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _SoftActionButton(
                        icon: Icons.edit_outlined,
                        label: "Edit",
                        bg: const Color(0xFFFFE6D6),
                        fg: Colors.deepOrange,
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                            context,
                            AppRoutes.EditMeetingScreen,
                            arguments: SaleseditmeetingArguments(
                              roleId: roleId,
                              roleName: roleName,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SoftActionButton(
                        icon: Icons.delete_outline,
                        label: "Delete",
                        bg: const Color(0xFFFFE6E6),
                        fg: Colors.red,
                        onTap: () {
                          if (onDelete != null) {
                            onDelete!();
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// =======================
/// SHARED UI
/// =======================
class _KVRow extends StatelessWidget {
  final String label;
  final String value;
  final bool multiline;
  final bool statusRed;

  const _KVRow({
    required this.label,
    required this.value,
    this.multiline = false,
    this.statusRed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment:
        multiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: multiline ? 3 : 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: statusRed ? Colors.red : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GreenButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _GreenButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class _SoftActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;

  const _SoftActionButton({
    required this.icon,
    required this.label,
    required this.bg,
    required this.fg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: fg),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }
}

class _ThreeStepProgress extends StatelessWidget {
  final List<String> dates; // must be 3
  final int activeIndex; // 0..2

  const _ThreeStepProgress({
    required this.dates,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _Dot(active: activeIndex >= 0),
            Expanded(child: Container(height: 2, color: Colors.black12)),
            _Dot(active: activeIndex >= 1),
            Expanded(child: Container(height: 2, color: Colors.black12)),
            _Dot(active: activeIndex >= 2),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(dates[0],
                style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700)),
            Text(dates[1],
                style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700)),
            Text(dates[2],
                style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final bool active;
  const _Dot({required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? kDarkGreen : Colors.white,
        border: Border.all(color: active ? kDarkGreen : Colors.black26, width: 2),
      ),
      child: active ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
    );
  }
}
