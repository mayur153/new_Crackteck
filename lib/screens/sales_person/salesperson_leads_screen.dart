import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/bottom_navigation.dart';

class SalesPersonLeadsScreen extends StatefulWidget {
  final int roleId;
  final String roleName;

  const SalesPersonLeadsScreen({
    super.key,
    required this.roleId,
    required this.roleName,
  });

  @override
  State<SalesPersonLeadsScreen> createState() => _SalesPersonLeadsScreenState();
}

class _SalesPersonLeadsScreenState extends State<SalesPersonLeadsScreen> {
  static const Color midGreen = Color(0xFF1F8B00);
  static const Color darkGreen = Color(0xFF145A00);

  bool _moreOpen = false;
  int _navIndex = 0;

  final TextEditingController _searchCtrl = TextEditingController();

  // ✅ Filters (dialog will update these)
  final Set<String> _industryFilters = <String>{};

  // ✅ Popup status filters (New/Lost/Qualified/Unqualified)
  final Set<String> _statusFiltersStr = <String>{};

  // ✅ Demo data with 3 status types (your app can replace later)
  final List<_LeadItem> _leads = const [
    _LeadItem(
      leadId: "L-001",
      name: "Khushi Yadav",
      number: "+91 **** ** ****",
      company: "ABCD Ltd",
      industry: "Pharma",
      urgency: "High",
      status: LeadStatus.confirmed,
    ),
    _LeadItem(
      leadId: "L-002",
      name: "Riya Sharma",
      number: "+91 **** ** ****",
      company: "XYZ Pvt",
      industry: "Retail",
      urgency: "Medium",
      status: LeadStatus.pending,
    ),
    _LeadItem(
      leadId: "L-003",
      name: "Aman Verma",
      number: "+91 **** ** ****",
      company: "QWER Ltd",
      industry: "Healthcare",
      urgency: "Low",
      status: LeadStatus.cancelled,
    ),
    _LeadItem(
      leadId: "L-004",
      name: "Nikita Patil",
      number: "+91 **** ** ****",
      company: "MNO Pvt",
      industry: "Manufacturer",
      urgency: "High",
      status: LeadStatus.pending,
    ),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  // ✅ Map your enum statuses to popup labels
  String _mapStatusToPopupLabel(LeadStatus s) {
    switch (s) {
      case LeadStatus.confirmed:
        return "Qualified";
      case LeadStatus.pending:
        return "New";
      case LeadStatus.cancelled:
        return "Lost";
    }
  }

  // ✅ SEARCH + FILTER logic
  List<_LeadItem> get _filteredLeads {
    final q = _searchCtrl.text.trim().toLowerCase();

    return _leads.where((lead) {
      final popupStatus = _mapStatusToPopupLabel(lead.status);

      // search match
      final matchesSearch = q.isEmpty ||
          lead.leadId.toLowerCase().contains(q) ||
          lead.name.toLowerCase().contains(q) ||
          lead.company.toLowerCase().contains(q) ||
          lead.industry.toLowerCase().contains(q) ||
          lead.urgency.toLowerCase().contains(q) ||
          lead.status.label.toLowerCase().contains(q) ||
          popupStatus.toLowerCase().contains(q);

      // industry filter match
      final matchesIndustry =
          _industryFilters.isEmpty || _industryFilters.contains(lead.industry);

      // status filter match (using popup labels)
      final matchesStatus = _statusFiltersStr.isEmpty ||
          _statusFiltersStr.contains(popupStatus);

      return matchesSearch && matchesIndustry && matchesStatus;
    }).toList();
  }

  // ✅ Open center popup like screenshot
  Future<void> _openFilterPopup() async {
    final tempIndustry = Set<String>.from(_industryFilters);
    final tempStatus = Set<String>.from(_statusFiltersStr);

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

            Widget twoColRow(Widget left, Widget right) {
              return Row(
                children: [
                  Expanded(child: left),
                  Expanded(child: right),
                ],
              );
            }

            return Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(ctx).size.width * 0.86,
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
                      // -------- Industry Type
                      const Text(
                        "Industry Type",
                        style: TextStyle(
                          color: darkGreen,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 10),

                      twoColRow(
                        checkboxItem(
                          label: "Pharma",
                          checked: tempIndustry.contains("Pharma"),
                          onTap: () => setModalState(() {
                            tempIndustry.contains("Pharma")
                                ? tempIndustry.remove("Pharma")
                                : tempIndustry.add("Pharma");
                          }),
                        ),
                        checkboxItem(
                          label: "Retail",
                          checked: tempIndustry.contains("Retail"),
                          onTap: () => setModalState(() {
                            tempIndustry.contains("Retail")
                                ? tempIndustry.remove("Retail")
                                : tempIndustry.add("Retail");
                          }),
                        ),
                      ),
                      const SizedBox(height: 12),

                      twoColRow(
                        checkboxItem(
                          label: "Manufacturer",
                          checked: tempIndustry.contains("Manufacturer"),
                          onTap: () => setModalState(() {
                            tempIndustry.contains("Manufacturer")
                                ? tempIndustry.remove("Manufacturer")
                                : tempIndustry.add("Manufacturer");
                          }),
                        ),
                        checkboxItem(
                          label: "Healthcare",
                          checked: tempIndustry.contains("Healthcare"),
                          onTap: () => setModalState(() {
                            tempIndustry.contains("Healthcare")
                                ? tempIndustry.remove("Healthcare")
                                : tempIndustry.add("Healthcare");
                          }),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // -------- Status
                      const Text(
                        "Status",
                        style: TextStyle(
                          color: darkGreen,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 10),

                      twoColRow(
                        checkboxItem(
                          label: "New",
                          checked: tempStatus.contains("New"),
                          onTap: () => setModalState(() {
                            tempStatus.contains("New")
                                ? tempStatus.remove("New")
                                : tempStatus.add("New");
                          }),
                        ),
                        checkboxItem(
                          label: "Lost",
                          checked: tempStatus.contains("Lost"),
                          onTap: () => setModalState(() {
                            tempStatus.contains("Lost")
                                ? tempStatus.remove("Lost")
                                : tempStatus.add("Lost");
                          }),
                        ),
                      ),
                      const SizedBox(height: 12),

                      twoColRow(
                        checkboxItem(
                          label: "Qualified",
                          checked: tempStatus.contains("Qualified"),
                          onTap: () => setModalState(() {
                            tempStatus.contains("Qualified")
                                ? tempStatus.remove("Qualified")
                                : tempStatus.add("Qualified");
                          }),
                        ),
                        checkboxItem(
                          label: "Unqualified",
                          checked: tempStatus.contains("Unqualified"),
                          onTap: () => setModalState(() {
                            tempStatus.contains("Unqualified")
                                ? tempStatus.remove("Unqualified")
                                : tempStatus.add("Unqualified");
                          }),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // -------- Buttons row
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
                                  _industryFilters
                                    ..clear()
                                    ..addAll(tempIndustry);

                                  _statusFiltersStr
                                    ..clear()
                                    ..addAll(tempStatus);
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

  @override
  Widget build(BuildContext context) {
    final visibleLeads = _filteredLeads;

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
          "Leads",
          style: TextStyle(
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
                          const Icon(Icons.search,
                              color: Colors.black45, size: 20),
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
                      child: const Icon(Icons.filter_alt_outlined,
                          color: darkGreen),
                    ),
                  ),
                ],
              ),
            ),

            // Leads list
            // Leads list + Add Follow-Up button
            Expanded(
              child: Stack(
                children: [
                  // ✅ Leads list (add bottom padding so button doesn't overlap last card)
                  visibleLeads.isEmpty
                      ? const Center(
                    child: Text(
                      "No leads found",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  )
                      : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 90), // ✅ was 16
                    itemCount: visibleLeads.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final lead = visibleLeads[index];
                      return _LeadCard(
                        lead: lead,
                        onView: () => _snack(context, "View ${lead.leadId}"),
                        onEdit: () => _snack(context, "Edit ${lead.leadId}"),
                        onStatusTap: () => _snack(
                          context,
                          "${lead.status.label} ${lead.leadId}",
                        ),
                      );
                    },
                  ),

                  // ✅ Add Follow-Up button (bottom-right)
                  Positioned(
                    right: 16,
                    bottom: 18,
                    child: InkWell(
                      onTap: () => _snack(context, "Add Follow-Up"),
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

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

// =======================
// CARD UI
// =======================
class _LeadCard extends StatelessWidget {
  final _LeadItem lead;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onStatusTap;

  const _LeadCard({
    required this.lead,
    required this.onView,
    required this.onEdit,
    required this.onStatusTap,
  });

  static const Color darkGreen = Color(0xFF145A00);

  @override
  Widget build(BuildContext context) {
    final statusStyle = _statusStyle(lead.status);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          _kv("Lead ID", lead.leadId),
          _kv("Name", lead.name),
          _kv("Number", lead.number),
          _kv("Company Name", lead.company),
          _kv("Industry", lead.industry),
          _kv("Urgency", lead.urgency),
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
                child: _StatusButton(
                  label: lead.status.label,
                  bg: statusStyle.bg,
                  fg: statusStyle.fg,
                  onTap: onStatusTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _StatusStyle _statusStyle(LeadStatus s) {
    switch (s) {
      case LeadStatus.confirmed:
        return const _StatusStyle(bg: darkGreen, fg: Colors.white);
      case LeadStatus.pending:
        return const _StatusStyle(bg: Color(0xFFFFF1CC), fg: Color(0xFF8A5A00));
      case LeadStatus.cancelled:
        return const _StatusStyle(bg: Color(0xFFFFE6E6), fg: Color(0xFFB00020));
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

class _StatusStyle {
  final Color bg;
  final Color fg;
  const _StatusStyle({required this.bg, required this.fg});
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

class _StatusButton extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;

  const _StatusButton({
    required this.label,
    required this.bg,
    required this.fg,
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
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: fg,
            fontWeight: FontWeight.w900,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

// =======================
// MODEL
// =======================
enum LeadStatus { confirmed, pending, cancelled }

extension LeadStatusX on LeadStatus {
  String get label {
    switch (this) {
      case LeadStatus.confirmed:
        return "Confirmed";
      case LeadStatus.pending:
        return "Pending";
      case LeadStatus.cancelled:
        return "Cancelled";
    }
  }
}

class _LeadItem {
  final String leadId;
  final String name;
  final String number;
  final String company;
  final String industry;
  final String urgency;
  final LeadStatus status;

  const _LeadItem({
    required this.leadId,
    required this.name,
    required this.number,
    required this.company,
    required this.industry,
    required this.urgency,
    required this.status,
  });
}
