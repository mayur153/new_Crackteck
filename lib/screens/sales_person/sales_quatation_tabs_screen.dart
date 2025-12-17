import 'package:flutter/material.dart';

import '../../widgets/bottom_navigation.dart';

class SalesPersonQuotationScreen extends StatefulWidget {
  final int roleId;
  final String roleName;

  const SalesPersonQuotationScreen({
    super.key,
    required this.roleId,
    required this.roleName,
  });

  @override
  State<SalesPersonQuotationScreen> createState() =>
      _SalesPersonQuotationScreenState();
}

class _SalesPersonQuotationScreenState
    extends State<SalesPersonQuotationScreen> {
  static const Color midGreen = Color(0xFF1F8B00);
  static const Color darkGreen = Color(0xFF145A00);

  bool _moreOpen = false;
  int _navIndex = 0;

  final TextEditingController _searchCtrl = TextEditingController();

  // Filter popup selections (Draft/Sent/Accepted/Viewed/Rejected)
  final Set<String> _statusFilters = <String>{};

  // Demo list (replace with API later)
  final List<_QuotationItem> _items = const [
    _QuotationItem(
      leadId: "L-001",
      quotationId: "QTN-001",
      clientName: "Khushi Yadav",
      createdDate: "May 30, 2025 – 11:00 AM",
      updatedDate: "ABC Corp HQ",
      status: "Draft",
      pill: "Confirmed", // for top status pill on card
    ),
    _QuotationItem(
      leadId: "L-001",
      quotationId: "QTN-001",
      clientName: "Khushi Yadav",
      createdDate: "May 30, 2025 – 11:00 AM",
      updatedDate: "ABC Corp HQ",
      status: "Draft",
      pill: "Pending",
    ),
    _QuotationItem(
      leadId: "L-001",
      quotationId: "QTN-001",
      clientName: "Khushi Yadav",
      createdDate: "May 30, 2025 – 11:00 AM",
      updatedDate: "ABC Corp HQ",
      status: "Draft",
      pill: "Canceled",
    ),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<_QuotationItem> get _filteredItems {
    final q = _searchCtrl.text.trim().toLowerCase();

    return _items.where((x) {
      final matchesSearch = q.isEmpty ||
          x.leadId.toLowerCase().contains(q) ||
          x.quotationId.toLowerCase().contains(q) ||
          x.clientName.toLowerCase().contains(q) ||
          x.createdDate.toLowerCase().contains(q) ||
          x.updatedDate.toLowerCase().contains(q) ||
          x.status.toLowerCase().contains(q) ||
          x.pill.toLowerCase().contains(q);

      final matchesStatus =
          _statusFilters.isEmpty || _statusFilters.contains(x.status);

      return matchesSearch && matchesStatus;
    }).toList();
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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
                              label: "Draft",
                              checked: temp.contains("Draft"),
                              onTap: () => setModalState(() {
                                temp.contains("Draft")
                                    ? temp.remove("Draft")
                                    : temp.add("Draft");
                              }),
                            ),
                          ),
                          Expanded(
                            child: checkboxItem(
                              label: "Sent",
                              checked: temp.contains("Sent"),
                              onTap: () => setModalState(() {
                                temp.contains("Sent")
                                    ? temp.remove("Sent")
                                    : temp.add("Sent");
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
                              label: "Accepted",
                              checked: temp.contains("Accepted"),
                              onTap: () => setModalState(() {
                                temp.contains("Accepted")
                                    ? temp.remove("Accepted")
                                    : temp.add("Accepted");
                              }),
                            ),
                          ),
                          Expanded(
                            child: checkboxItem(
                              label: "Viewed",
                              checked: temp.contains("Viewed"),
                              onTap: () => setModalState(() {
                                temp.contains("Viewed")
                                    ? temp.remove("Viewed")
                                    : temp.add("Viewed");
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

  Future<void> _openViewPopup(_QuotationItem item) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (ctx) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(ctx).size.width * 0.86,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 22,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _kvRow("Lead ID", item.leadId),
                  _kvRow("Quotation ID", "QTN - 01"),
                  _kvRow("Client Name", "Ms. ${item.clientName}"),
                  _kvRow("Created Date", "01-06-2025"),
                  _kvRow("Updated Date", "02-06-2025"),
                  const SizedBox(height: 12),

                  // Table header
                  Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: darkGreen,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Row(
                      children: [
                        SizedBox(width: 34, child: Text("QTY", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12))),
                        Expanded(child: Text("Description", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12))),
                        SizedBox(width: 70, child: Text("HSN code", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12))),
                        SizedBox(width: 80, child: Text("Unit Price", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Table rows (demo)
                  _tableRow(qty: "01", desc: "Laptop", hsn: "02", price: "12000.0"),
                  _tableRow(qty: "03", desc: "Amc", hsn: "02", price: "12000.0"),
                  _tableRow(qty: "02", desc: "Laptop", hsn: "02", price: "12000.0"),
                  _tableRow(qty: "02", desc: "Laptop", hsn: "02", price: "12000.0"),

                  const SizedBox(height: 10),
                  const Divider(height: 1),

                  const SizedBox(height: 10),
                  _totalRow("Subtotal", "₹ 48,000"),
                  _totalRow("Sales Tax", "₹ 30,000"),
                  const SizedBox(height: 6),
                  _totalHighlight("Total", "₹ 68,000"),

                  const SizedBox(height: 14),

                  _bigGreenButton(
                    label: "Submit",
                    onTap: () {
                      Navigator.pop(ctx);
                      _snack("Submit tapped");
                    },
                  ),
                  const SizedBox(height: 10),
                  _bigGreenButton(
                    label: "Download",
                    onTap: () {
                      Navigator.pop(ctx);
                      _snack("Download tapped");
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _kvRow(String k, String v) {
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

  static Widget _tableRow({
    required String qty,
    required String desc,
    required String hsn,
    required String price,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      child: Row(
        children: [
          SizedBox(width: 34, child: Text(qty, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12))),
          Expanded(child: Text(desc, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
          SizedBox(width: 70, child: Text(hsn, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
          SizedBox(width: 80, child: Text(price, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
        ],
      ),
    );
  }

  static Widget _totalRow(String k, String v) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: 120, child: Text(k, style: const TextStyle(fontWeight: FontWeight.w700))),
        SizedBox(width: 90, child: Text(v, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w800))),
      ],
    );
  }

  static Widget _totalHighlight(String k, String v) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE9FFE6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 120, child: Text(k, style: const TextStyle(fontWeight: FontWeight.w900))),
          SizedBox(width: 90, child: Text(v, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w900))),
        ],
      ),
    );
  }

  Widget _bigGreenButton({required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 46,
        width: double.infinity,
        decoration: BoxDecoration(
          color: darkGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
      ),
    );
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
          "Quotation",
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
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _QuotationCard(
                    item: list[index],
                    onView: () => _openViewPopup(list[index]),
                    onEdit: () => _snack("Edit ${list[index].quotationId}"),
                  );
                },
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

class _QuotationCard extends StatelessWidget {
  final _QuotationItem item;
  final VoidCallback onView;
  final VoidCallback onEdit;

  const _QuotationCard({
    required this.item,
    required this.onView,
    required this.onEdit,
  });

  static const Color darkGreen = Color(0xFF145A00);

  @override
  Widget build(BuildContext context) {
    final pill = _pillStyle(item.pill);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          // Top row: View / Edit / Status pill

          _kv("Lead ID", item.leadId),
          _kv("Quotation ID", item.quotationId),
          _kv("Client Name", item.clientName),
          _kv("Created Date", item.createdDate),
          _kv("Updated Date", item.updatedDate),
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
                child: Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: pill.bg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    item.pill,
                    style: TextStyle(
                      color: pill.fg,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
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
      case "Confirmed":
        return const _PillStyle(bg: darkGreen, fg: Colors.white);
      case "Pending":
        return const _PillStyle(bg: Color(0xFFEDEDED), fg: Colors.black87);
      case "Canceled":
        return const _PillStyle(bg: Color(0xFFFFE0E0), fg: Colors.red);
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

class _QuotationItem {
  final String leadId;
  final String quotationId;
  final String clientName;
  final String createdDate;
  final String updatedDate;

  /// Filter uses this
  final String status;

  /// Top pill (Confirmed / Pending / Canceled)
  final String pill;

  const _QuotationItem({
    required this.leadId,
    required this.quotationId,
    required this.clientName,
    required this.createdDate,
    required this.updatedDate,
    required this.status,
    required this.pill,
  });
}
