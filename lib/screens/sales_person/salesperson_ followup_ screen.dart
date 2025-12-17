import 'package:flutter/material.dart';

import '../../widgets/bottom_navigation.dart';

class SalesPersonFollowUpScreen extends StatefulWidget {
  final int roleId;
  final String roleName;

  const SalesPersonFollowUpScreen({
    super.key,
    required this.roleId,
    required this.roleName,
  });

  @override
  State<SalesPersonFollowUpScreen> createState() =>
      _SalesPersonFollowUpScreenState();
}

class _SalesPersonFollowUpScreenState extends State<SalesPersonFollowUpScreen> {
  static const Color midGreen = Color(0xFF1F8B00);
  static const Color darkGreen = Color(0xFF145A00);

  bool _moreOpen = false;
  int _navIndex = 0;

  final TextEditingController _searchCtrl = TextEditingController();

  // Filter values shown in popup (like screenshot)
  final Set<String> _statusFilters = <String>{};

  // Demo list (replace with API later)
  final List<_FollowUpItem> _items = const [
    _FollowUpItem(
      leadId: "L-001",
      name: "Khushi Yadav",
      number: "+91 **** ** ****",
      date: "02/04/2025",
      time: "11:00 AM",
      company: "ABCD Ltd",
      industry: "Pharma",
      status: "Pending",
      actionStatus: "Canceled",
    ),
    _FollowUpItem(
      leadId: "L-002",
      name: "Riya Sharma",
      number: "+91 **** ** ****",
      date: "03/04/2025",
      time: "03:30 PM",
      company: "XYZ Pvt",
      industry: "Retail",
      status: "Pending",
      actionStatus: "Canceled",
    ),
    _FollowUpItem(
      leadId: "L-003",
      name: "Aman Verma",
      number: "+91 **** ** ****",
      date: "05/04/2025",
      time: "01:00 PM",
      company: "QWER Ltd",
      industry: "Healthcare",
      status: "Completed",
      actionStatus: "Canceled",
    ),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<_FollowUpItem> get _filteredItems {
    final q = _searchCtrl.text.trim().toLowerCase();

    return _items.where((x) {
      final matchesSearch = q.isEmpty ||
          x.leadId.toLowerCase().contains(q) ||
          x.name.toLowerCase().contains(q) ||
          x.number.toLowerCase().contains(q) ||
          x.company.toLowerCase().contains(q) ||
          x.industry.toLowerCase().contains(q) ||
          x.status.toLowerCase().contains(q);

      final matchesStatus =
          _statusFilters.isEmpty || _statusFilters.contains(x.status);

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
                  width: MediaQuery.of(ctx).size.width * 0.78,
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
                              label: "Completed",
                              checked: temp.contains("Completed"),
                              onTap: () => setModalState(() {
                                temp.contains("Completed")
                                    ? temp.remove("Completed")
                                    : temp.add("Completed");
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
                              label: "Rejected",
                              checked: temp.contains("Rejected"),
                              onTap: () => setModalState(() {
                                temp.contains("Rejected")
                                    ? temp.remove("Rejected")
                                    : temp.add("Rejected");
                              }),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
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
          "Follow-Up",
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
                  // list
                  ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _FollowUpCard(
                        item: list[index],
                        onView: () => _snack("View ${list[index].leadId}"),
                        onEdit: () => _snack("Edit ${list[index].leadId}"),
                        onCancel: () => _snack("Cancelled ${list[index].leadId}"),
                      );
                    },
                  ),

                  // Add Follow-Up button (bottom-right style like screenshot)
                  Positioned(
                    right: 16,
                    bottom: 18,
                    child: InkWell(
                      onTap: () => _snack("Add Follow-Up"),
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
                              "Add Follow-Up",
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

class _FollowUpCard extends StatelessWidget {
  final _FollowUpItem item;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onCancel;

  const _FollowUpCard({
    required this.item,
    required this.onView,
    required this.onEdit,
    required this.onCancel,
  });

  static const Color darkGreen = Color(0xFF145A00);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          _kv("Lead ID", item.leadId),
          _kv("Name", item.name),
          _kv("Number", item.number),
          _kv("Date", item.company),
          _kv("Time", item.industry),
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
                child: _SmallButton(
                  bg: const Color(0xFFFFE0E0),
                  fg: Colors.red,
                  label: "Canceled",
                  icon: Icons.close,
                  onTap: onCancel,
                ),
              ),
            ],
          ),
        ],
      ),
    );
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

class _FollowUpItem {
  final String leadId;
  final String name;
  final String number;
  final String date;
  final String time;
  final String company;
  final String industry;
  final String status;
  final String actionStatus;

  const _FollowUpItem({
    required this.leadId,
    required this.name,
    required this.number,
    required this.date,
    required this.time,
    required this.company,
    required this.industry,
    required this.status,
    required this.actionStatus,
  });
}
