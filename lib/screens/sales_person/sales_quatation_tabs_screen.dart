import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
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

  // ✅ Date filter (single date like your screenshot)
  DateTime? _selectedDate;

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

  // ✅ Parse "May 30, 2025 – 11:00 AM" to a DateTime (date-only)
  DateTime? _parseCreatedDate(String raw) {
    try {
      final parts = raw.split(RegExp(r'\s[–-]\s'));
      final datePart = parts.isNotEmpty ? parts.first.trim() : raw.trim();

      final byComma = datePart.split(',');
      if (byComma.length < 2) return null;

      final left = byComma[0].trim(); // e.g. "May 30"
      final year = int.parse(byComma[1].trim());

      final leftParts = left.split(RegExp(r'\s+'));
      if (leftParts.length < 2) return null;

      final month = _monthNumber(leftParts[0].trim());
      final day = int.parse(leftParts[1].trim());
      if (month == null) return null;

      return DateTime(year, month, day);
    } catch (_) {
      return null;
    }
  }

  int? _monthNumber(String m) {
    final key = m.toLowerCase();
    const map = {
      "jan": 1,
      "january": 1,
      "feb": 2,
      "february": 2,
      "mar": 3,
      "march": 3,
      "apr": 4,
      "april": 4,
      "may": 5,
      "jun": 6,
      "june": 6,
      "jul": 7,
      "july": 7,
      "aug": 8,
      "august": 8,
      "sep": 9,
      "sept": 9,
      "september": 9,
      "oct": 10,
      "october": 10,
      "nov": 11,
      "november": 11,
      "dec": 12,
      "december": 12,
    };
    return map[key];
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _formatShortDate(DateTime d) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return "${d.day.toString().padLeft(2, '0')} ${months[d.month - 1]} ${d.year}";
  }

  List<_QuotationItem> get _filteredItems {
    final q = _searchCtrl.text.trim().toLowerCase();

    final list = _items.where((x) {
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

      // ✅ Date filter (single date)
      final matchesDate = _selectedDate == null
          ? true
          : (() {
        final d = _parseCreatedDate(x.createdDate);
        if (d == null) return false;
        return _isSameDay(d, _selectedDate!);
      })();

      return matchesSearch && matchesStatus && matchesDate;
    }).toList();

    // ✅ Sort by created date (latest first)
    list.sort((a, b) {
      final da = _parseCreatedDate(a.createdDate);
      final db = _parseCreatedDate(b.createdDate);
      if (da == null && db == null) return 0;
      if (da == null) return 1;
      if (db == null) return -1;
      return db.compareTo(da);
    });

    return list;
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _openFilterPopup() async {
    final temp = Set<String>.from(_statusFilters);

    // ✅ temp date inside popup
    DateTime? tempDate = _selectedDate;

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

            Future<void> pickDate() async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: ctx,
                initialDate: tempDate ?? now,
                firstDate: DateTime(now.year - 5),
                lastDate: DateTime(now.year + 5),
                helpText: "Select date",
              );

              if (picked != null) {
                setModalState(() => tempDate = picked);
              }
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

                      const SizedBox(height: 16),

                      // ✅ Date (matches your screenshot UI)
                      const Text(
                        "Date",
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
                            child: InkWell(
                              onTap: pickDate,
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: 46,
                                padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      color: darkGreen,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        tempDate == null
                                            ? "Select date"
                                            : _formatShortDate(tempDate!),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Colors.black54,
                                      size: 22,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          InkWell(
                            onTap: () => setModalState(() => tempDate = null),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 46,
                              width: 84,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFE0E0),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Clear",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
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

                                  // ✅ save selected date
                                  _selectedDate = tempDate;
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

                  Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: darkGreen,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Row(
                      children: [
                        SizedBox(
                            width: 34,
                            child: Text("QTY",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12))),
                        Expanded(
                            child: Text("Description",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12))),
                        SizedBox(
                            width: 70,
                            child: Text("HSN code",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12))),
                        SizedBox(
                            width: 80,
                            child: Text("Unit Price",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

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
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 34,
            child: Text(qty,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
          ),
          Expanded(
            child: Text(desc,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
          ),
          SizedBox(
            width: 70,
            child: Text(hsn,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
          ),
          SizedBox(
            width: 80,
            child: Text(price,
                textAlign: TextAlign.right,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  static Widget _totalRow(String k, String v) {
    return Row(
      children: [
        Expanded(
          child: Text(k,
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ),
        Text(v, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
      ],
    );
  }

  static Widget _totalHighlight(String k, String v) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE9FFE6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(k,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
          ),
          Text(v, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  static Widget _bigGreenButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 42,
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
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return _QuotationCard(
                        item: item,
                        onView: () => _openViewPopup(item),
                        onEdit: () => _snack("Edit ${item.quotationId}"),
                        onStatusTap: () => _snack("Status ${item.status}"),
                      );
                    },
                  ),

                  // ✅ ADD QUOTATION BUTTON (your exact code)
                  Positioned(
                    right: 16,
                    bottom: 18,
                    child: InkWell(
                      onTap: () => _snack("Add Quotation"),
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
                              "Add Quotation",
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

class _QuotationCard extends StatelessWidget {
  final _QuotationItem item;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onStatusTap;

  const _QuotationCard({
    required this.item,
    required this.onView,
    required this.onEdit,
    required this.onStatusTap,
  });

  static const Color darkGreen = Color(0xFF145A00);

  @override
  Widget build(BuildContext context) {
    final pillStyle = _pill(item.pill);

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
                child: InkWell(
                  onTap: onStatusTap,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: pillStyle.bg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.pill,
                      style: TextStyle(
                        color: pillStyle.fg,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _Pill _pill(String s) {
    switch (s) {
      case "Confirmed":
        return const _Pill(bg: darkGreen, fg: Colors.white);
      case "Pending":
        return const _Pill(bg: Color(0xFFEDEDED), fg: Colors.black87);
      case "Canceled":
        return const _Pill(bg: Color(0xFFFFE0E0), fg: Colors.red);
      default:
        return const _Pill(bg: Color(0xFFEDEDED), fg: Colors.black87);
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

class _Pill {
  final Color bg;
  final Color fg;
  const _Pill({required this.bg, required this.fg});
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

class _QuotationItem {
  final String leadId;
  final String quotationId;
  final String clientName;
  final String createdDate;
  final String updatedDate;
  final String status;
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
