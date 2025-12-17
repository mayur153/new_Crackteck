import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final int roleId;
  final String roleName;
  const NotificationScreen({super.key, required this.roleId, required this.roleName});

  static const Color darkGreen = Color(0xFF145A00);
  static const Color midGreen = Color(0xFF1F7A05);

  @override
  Widget build(BuildContext context) {
    final notifications = <_NotificationItem>[
      _NotificationItem(
        title: "New Call",
        message:
        "How did we do? Let us know by rating your recent order and sharing your feedback.",
        time: "15 minutes ago",
        isUnread: true,
      ),
      _NotificationItem(
        title: "Service Rating",
        message:
        "How did we do? Let us know by rating your recent order and sharing your feedback.",
        time: "1 day ago",
      ),
      _NotificationItem(
        title: "Hungry? Try Our New Pizza Specials!",
        message:
        "Check out the latest additions to our menu and satisfy your cravings!",
        time: "2 days ago",
      ),
      _NotificationItem(
        title: "Don't Miss Out: Special Offer Just for You!",
        message:
        "Get 10% off your next order with code SAVE10. Limited time only!",
        time: "2hours ago",
      ),
    ];

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
          "Notification",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.notifications_none, color: Colors.white),
          // ),
          // const SizedBox(width: 8),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final n = notifications[index];
          return _NotificationCard(item: n);
        },
      ),
    );
  }
}

// -------------------- UI WIDGETS --------------------

class _NotificationCard extends StatelessWidget {
  final _NotificationItem item;

  const _NotificationCard({required this.item});

  static const Color darkGreen = Color(0xFF145A00);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: item.titleColor ?? darkGreen,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.message,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.time,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        // ✅ unread red dot
        if (item.isUnread)
          const Positioned(
            top: 10,
            right: 10,
            child: _UnreadDot(),
          ),
      ],
    );
  }
}

class _UnreadDot extends StatelessWidget {
  const _UnreadDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9,
      height: 9,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
    );
  }
}

// -------------------- MODEL --------------------

class _NotificationItem {
  final String title;
  final String message;
  final String time;
  final bool isUnread;
  final Color? titleColor;

  _NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    this.isUnread = false,
    this.titleColor,
  });
}
