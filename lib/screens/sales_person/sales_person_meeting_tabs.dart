import 'package:flutter/material.dart';

import '../../widgets/bottom_navigation.dart';

class SalesPersonMeetingScreen extends StatefulWidget {
  final int roleId;
  final String roleName;

  const SalesPersonMeetingScreen({
    super.key,
    required this.roleId,
    required this.roleName,
  });

  @override
  State<SalesPersonMeetingScreen> createState() =>
      _SalesPersonMeetingScreenState();
}

class _SalesPersonMeetingScreenState extends State<SalesPersonMeetingScreen> {
  static const Color midGreen = Color(0xFF1F8B00);
  static const Color darkGreen = Color(0xFF145A00);
  bool _moreOpen = false;
  int _navIndex = 0;

  final TextEditingController _searchCtrl = TextEditingController();

  // Popup filter values (like screenshot)
  final Set<String> _statusFilters = <String>{};

  final List<_MeetingItem> _items = const [
    _MeetingItem(
      leadId: "L-001",
      meetingId: "M-001",
      title: "+91 **** ** ****",
      dateTime: "May 30, 2025 – 11:00 AM",
      location: "ABC Corp HQ",
      status: "Scheduled",
      pillStatus: "Pending", // top row gray button in image
    ),
    _MeetingItem(
      leadId: "L-001",
      meetingId: "M-001",
      title: "+91 **** ** ****",
      dateTime: "May 30, 2025 – 11:00 AM",
      location: "ABC Corp HQ",
      status: "Scheduled",
      pillStatus: "Cancelled", // red button in card
    ),
    _MeetingItem(
      leadId: "L-002",
      meetingId: "M-004",
      title: "+91 **** ** ****",
      dateTime: "Jun 01, 2025 – 02:15 PM",
      location: "Zoom Link",
      status: "Confirmed",
      pillStatus: "Pending",
    ),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<_MeetingItem> get _filteredItems {
    final q = _searchCtrl.text.trim().toLowerCase();

    return _items.where((x) {
      final matchesSearch = q.isEmpty ||
          x.leadId.toLowerCase().contains(q) ||
          x.meetingId.toLowerCase().contains(q) ||
          x.title.toLowerCase().contains(q) ||
          x.dateTime.toLowerCase().contains(q) ||
          x.location.toLowerCase().contains(q) ||
          x.status.toLowerCase().contains(q) ||
          x.pillStatus.toLowerCase().contains(q);

      final matchesStatus =
          _statusFilters.isEmpty || _statusFilters.contains(x.pillStatus);

      return matchesSearch && matchesStatus;
    }).toList();
  }

  Future<void> _openFilterPopup() async {
    final temp = Set<String>.from(_statusFilters);

    await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            Widget checkboxItem({
              required String label,
              required bool checked,
              required VoidCallback onTap,
            }) {
              return InkWell(
                onTap: onTap,
                child: Row(
                  children: [
                    Icon(
                      checked ? Icons.check_box : Icons.check_box_outline_blank,
                      color: checked ? darkGreen : const Color(0xFFBDBDBD),
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(ctx).size.width * 0.82,
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Status",
                        style: TextStyle(
                          color: darkGreen,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: checkboxItem(
                              label: "Pending",
                              checked: temp.contains("Pending"),
                              onTap: () => setModalState(() {
                                temp.contains("Pending")
                                    ? temp.remove("Pending")
                                    : temp.add("Pending");
                              }),
                            ),
                          ),
                          Expanded(
                            child: checkboxItem(
                              label: "Scheduled",
                              checked: temp.contains("Scheduled"),
                              onTap: () => setModalState(() {
                                temp.contains("Scheduled")
                                    ? temp.remove("Scheduled")
                                    : temp.add("Scheduled");
                              }),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: checkboxItem(
                              label: "Confirmed",
                              checked: temp.contains("Confirmed"),
                              onTap: () => setModalState(() {
                                temp.contains("Confirmed")
                                    ? temp.remove("Confirmed")
                                    : temp.add("Confirmed");
                              }),
                            ),
                          ),
                          Expanded(
                            child: checkboxItem(
                              label: "Cancelled",
                              checked: temp.contains("Cancelled"),
                              onTap: () => setModalState(() {
                                temp.contains("Cancelled")
                                    ? temp.remove("Cancelled")
                                    : temp.add("Cancelled");
                              }),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => Navigator.pop(ctx),
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 44,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFE0E0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Close",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _statusFilters
                                    ..clear()
                                    ..addAll(temp);
                                });
                                Navigator.pop(ctx);
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 44,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDFFFD7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                    color: darkGreen,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final list = _filteredItems;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
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
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Meeting",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _snack("Notifications"),
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            // Search + Filter row
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.black45, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchCtrl,
                              decoration: const InputDecoration(
                                hintText: "Search",
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              onChanged: (_) => setState(() {}),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: _openFilterPopup,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 50,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: const Icon(Icons.filter_alt_outlined, color: darkGreen),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 130),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _MeetingCard(
                        item: list[index],
                        onView: () => _snack("View ${list[index].meetingId}"),
                        onEdit: () => _snack("Edit ${list[index].meetingId}"),
                        onStatusTap: () => _snack("Status ${list[index].pillStatus}"),
                      );
                    },
                  ),

                  // Calendar button
                  Positioned(
                    right: 16,
                    bottom: 74,
                    child: InkWell(
                      onTap: () => _snack("Calendar"),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: darkGreen,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.14),
                              blurRadius: 14,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_month_outlined,
                                color: Colors.white, size: 18),
                            SizedBox(width: 8),
                            Text(
                              "Calendar",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Add Meeting button
                  Positioned(
                    right: 16,
                    bottom: 18,
                    child: InkWell(
                      onTap: () => _snack("Add Meeting"),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: darkGreen,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.14),
                              blurRadius: 14,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color: Colors.white, size: 18),
                            SizedBox(width: 8),
                            Text(
                              "Add Meeting",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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

// =================== CARD ===================

class _MeetingCard extends StatelessWidget {
  final _MeetingItem item;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onStatusTap;

  const _MeetingCard({
    required this.item,
    required this.onView,
    required this.onEdit,
    required this.onStatusTap,
  });

  static const Color darkGreen = Color(0xFF145A00);

  @override
  Widget build(BuildContext context) {
    final pill = _pillStyle(item.pillStatus);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          // TOP small buttons row (View / Edit / Pending) like screenshot

          _kv("Lead ID", item.leadId),
          _kv("Meeting ID", item.meetingId),
          _kv("Title", item.title),
          _kv("Date & Time", item.dateTime),
          _kv("Location", item.location),
          _kv("Status", item.status),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _SmallButton(
                  bg: const Color(0xFFE9FFE6),
                  fg: darkGreen,
                  label: "View",
                  icon: Icons.remove_red_eye_outlined,
                  onTap: onView,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _SmallButton(
                  bg: const Color(0xFFFFE6D6),
                  fg: Colors.deepOrange,
                  label: "Edit",
                  icon: Icons.edit_outlined,
                  onTap: onEdit,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: onStatusTap,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: pill.bg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.pillStatus,
                      style: TextStyle(
                        color: pill.fg,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  _PillStyle _pillStyle(String s) {
    switch (s) {
      case "Cancelled":
        return const _PillStyle(bg: Color(0xFFFFE0E0), fg: Colors.red);
      case "Pending":
        return const _PillStyle(bg: Color(0xFFEDEDED), fg: Colors.black87);
      case "Scheduled":
        return const _PillStyle(bg: Color(0xFFE7F2FF), fg: Color(0xFF0057B7));
      case "Confirmed":
        return const _PillStyle(bg: darkGreen, fg: Colors.white);
      default:
        return const _PillStyle(bg: Color(0xFFEDEDED), fg: Colors.black87);
    }
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              k,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
          Text(
            v,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _PillStyle {
  final Color bg;
  final Color fg;
  const _PillStyle({required this.bg, required this.fg});
}

class _SmallButton extends StatelessWidget {
  final Color bg;
  final Color fg;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _SmallButton({
    required this.bg,
    required this.fg,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: fg),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(color: fg, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}

// =================== MODEL ===================

class _MeetingItem {
  final String leadId;
  final String meetingId;
  final String title;
  final String dateTime;
  final String location;
  final String status;

  /// This is what the popup filters (Pending / Scheduled / Confirmed / Cancelled)
  final String pillStatus;

  const _MeetingItem({
    required this.leadId,
    required this.meetingId,
    required this.title,
    required this.dateTime,
    required this.location,
    required this.status,
    required this.pillStatus,
  });
}
