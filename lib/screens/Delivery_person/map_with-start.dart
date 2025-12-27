import 'package:flutter/material.dart';

class DeliverypickupparcelScreen extends StatelessWidget {
  final int roleId;
  final String roleName;

  const DeliverypickupparcelScreen({
    super.key,
    required this.roleId,
    required this.roleName,
  });

  static const Color green = Color(0xFF1E7C10);
  static const Color lightGreen = Color(0xFFEFF7EE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Map",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              // TODO: navigate to notification
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // ---------------- MAP PLACEHOLDER ----------------
          Expanded(
            child: Stack(
              children: [
                // 🔹 MAP IMAGE PLACEHOLDER
                Positioned.fill(
                  child: Image.asset(
                    'assets/map_placeholder.png', // 👈 add any image here
                    fit: BoxFit.cover,
                  ),
                ),

                // 🔹 DISTANCE / TIME CARD
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        _InfoItem(label: "Distance", value: "01 km"),
                        SizedBox(width: 20),
                        _InfoItem(label: "Time", value: "5 minute"),
                      ],
                    ),
                  ),
                ),

                // 🔹 RE-LOCATE BUTTON
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      // TODO: relocate logic
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x22000000),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.my_location, color: green),
                          SizedBox(height: 4),
                          Text(
                            "Re-locate",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
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

          // ---------------- BOTTOM CARD ----------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
            decoration: const BoxDecoration(
              color: lightGreen,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "ID:  #12345678",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),

                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Swati Shah",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    // 📞 CALL
                    _CircleAction(
                      icon: Icons.call,
                      onTap: () {
                        // TODO: call
                      },
                    ),
                    const SizedBox(width: 10),

                    // 💬 CHAT
                    _CircleAction(
                      icon: Icons.chat_bubble,
                      onTap: () {
                        // TODO: chat
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      TextSpan(text: "Let’s "),
                      TextSpan(
                        text: "Start",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      TextSpan(text: " to pick the parcel !"),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // 🔹 START BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: start delivery
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Start",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- SMALL WIDGETS ----------------

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem({
    required this.label,
    required this.value,
  });

  static const Color green = Color(0xFF1E7C10);

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
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: green,
          ),
        ),
      ],
    );
  }
}

class _CircleAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleAction({
    required this.icon,
    required this.onTap,
  });

  static const Color green = Color(0xFF1E7C10);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: green,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
