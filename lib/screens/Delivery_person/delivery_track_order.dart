import 'package:flutter/material.dart';
import 'delivery_notification.dart';

class TotalDeliveryScreen extends StatefulWidget {
  final int roleId;
  final String roleName;

  const TotalDeliveryScreen({
    super.key,
    this.roleId = 0,
    this.roleName = "",
  });

  @override
  State<TotalDeliveryScreen> createState() => _TotalDeliveryScreenState();
}

class _TotalDeliveryScreenState extends State<TotalDeliveryScreen> {
  int selectedTab = 0;

  static const darkGreen = Color(0xFF145A00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: darkGreen,
        elevation: 0,
        toolbarHeight: selectedTab == 1 ? 80 : 60,
        title: Text(
          selectedTab == 1 ? "Let's Track Your Work\nAchievement" : "Total Delivery",
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeliveryNotificationScreen(
                    roleId: widget.roleId,
                    roleName: widget.roleName,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          /// 🔹 TOP TABS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _TopTab(
                  title: "857 orders",
                  subtitle: "Monthly Delivery",
                  icon: Icons.person_pin_outlined,
                  selected: selectedTab == 0,
                  onTap: () => setState(() => selectedTab = 0),
                ),
                _TopTab(
                  title: "63 hours",
                  subtitle: "Weekly work hours",
                  icon: Icons.timer_outlined,
                  selected: selectedTab == 1,
                  onTap: () => setState(() => selectedTab = 1),
                ),
                _TopTab(
                  title: "21.6k",
                  subtitle: "Past month",
                  icon: Icons.wallet_giftcard_outlined,
                  selected: selectedTab == 2,
                  onTap: () => setState(() => selectedTab = 2),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// 🔹 TAB CONTENT
          Expanded(
            child: IndexedStack(
              index: selectedTab,
              children: const [
                _MonthlyDeliveryTab(),
                _WeeklyWorkTab(),
                _ComingSoonTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Done",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopTab extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _TopTab({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: selected ? const Color(0xFF145A00) : Colors.black12,
              width: selected ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 32, color: const Color(0xFF145A00)),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Colors.black),
              ),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MonthlyDeliveryTab extends StatelessWidget {
  const _MonthlyDeliveryTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const Text("Current order",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        const SizedBox(height: 12),
        const _CurrentOrderCard(),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Recent order",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            InkWell(
              onTap: () {},
              child: Row(
                children: const [
                  Text("View all ",
                      style: TextStyle(color: Color(0xFF145A00), fontWeight: FontWeight.w600, fontSize: 12)),
                  Icon(Icons.arrow_forward, color: Color(0xFF145A00), size: 16),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const _RecentOrderTile(),
        const _RecentOrderTile(),
        const _RecentOrderTile(),
        const _RecentOrderTile(),
        const _RecentOrderTile(),
        const _RecentOrderTile(),
      ],
    );
  }
}

class _CurrentOrderCard extends StatelessWidget {
  const _CurrentOrderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF145A00)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("#HWDSF776567DS",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text("On the way  24 June",
                        style: TextStyle(fontSize: 12, color: Colors.black45)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward, color: Color(0xFF145A00), size: 20),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF145A00), size: 20),
              Expanded(child: Container(height: 2, color: const Color(0xFF145A00))),
              const Icon(Icons.check_circle, color: Color(0xFF145A00), size: 20),
              Expanded(child: Container(height: 2, color: const Color(0xFF145A00))),
              const Icon(Icons.check_circle, color: Color(0xFF145A00), size: 20),
              Expanded(
                child: Row(
                  children: List.generate(5, (index) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  )),
                ),
              ),
              const Icon(Icons.radio_button_unchecked, color: Colors.black26, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentOrderTile extends StatelessWidget {
  const _RecentOrderTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF145A00)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("#HWDSF776567DS",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text("Complete  24 June",
                    style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyWorkTab extends StatefulWidget {
  const _WeeklyWorkTab();

  @override
  State<_WeeklyWorkTab> createState() => _WeeklyWorkTabState();
}

class _WeeklyWorkTabState extends State<_WeeklyWorkTab> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectWeek(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF145A00),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      // Find the start of the week (Sunday)
      setState(() {
        selectedDate = picked.subtract(Duration(days: picked.weekday % 7));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final values = [0.9, 0.6, 0.35, 0.2, 0.75, 0.9, 0.6];
    final days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    
    final weekStart = selectedDate;
    final weekEnd = selectedDate.add(const Duration(days: 6));
    
    final months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    final dateRange = "${weekStart.day} ${months[weekStart.month - 1]} - ${weekEnd.day} ${months[weekEnd.month - 1]}";

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const Text("Current order",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("63 hours",
                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      Text(dateRange,
                          style: const TextStyle(fontSize: 12, color: Colors.black45)),
                    ],
                  ),
                  InkWell(
                    onTap: () => _selectWeek(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF145A00),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.calendar_month_outlined, color: Colors.white, size: 24),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 160,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(7, (i) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 130 * values[i],
                            width: 28,
                            decoration: BoxDecoration(
                              color: const Color(0xFF145A00),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(days[i],
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black87)),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const _AchievementItem(amount: "+ 2,000", date: "31 May 2025"),
        const _AchievementItem(amount: "+ 2,000", date: "30 may 2025"),
        const _AchievementItem(amount: "+ 2,000", date: "28 May 2025"),
        const _AchievementItem(amount: "+ 2,000", date: "31 May 2025"),
        const _AchievementItem(amount: "+ 2,000", date: "31 May 2025"),
        const _AchievementItem(amount: "+ 2,000", date: "31 May 2025"),
        const _AchievementItem(showAmount: false),
        const _AchievementItem(showAmount: false),
        const _AchievementItem(showAmount: false),
        const _AchievementItem(showAmount: false),
      ],
    );
  }
}

class _AchievementItem extends StatelessWidget {
  final String amount;
  final String date;
  final bool showAmount;
  const _AchievementItem({this.amount = "", this.date = "", this.showAmount = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF145A00)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("#HWDSF776567DS",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text("Complete  24 June",
                    style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          if (showAmount)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(amount,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.green)),
                Text(date,
                    style: const TextStyle(fontSize: 10, color: Colors.black45)),
              ],
            ),
        ],
      ),
    );
  }
}

class _ComingSoonTab extends StatelessWidget {
  const _ComingSoonTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Coming Soon 🚀",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black),
      ),
    );
  }
}
