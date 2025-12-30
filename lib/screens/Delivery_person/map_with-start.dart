import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../routes/app_routes.dart';

class DeliverypickupparcelScreen extends StatelessWidget {
  final int roleId;
  final String roleName;
  final String orderId;

  const DeliverypickupparcelScreen({
    super.key,
    required this.roleId,
    required this.roleName,
    required this.orderId,
  });

  static const Color green = Color(0xFF1E7C10);
  static const Color lightGreen = Color(0xFFEFF7EE);

  Future<void> _pickImageAndNavigate(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    try {
      // 📸 Open Camera
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        if (context.mounted) {
          // ✅ If photo is captured, navigate to DeliveryOtpScreen
          Navigator.pushNamed(
            context,
            AppRoutes.DeliveryOtpScreen,
            arguments: deliveryotpArguments(
              roleId: roleId,
              roleName: roleName,
              orderId: orderId,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Map",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.DeliveryNotificationScreen,
                arguments: deliverynotificationArguments(
                  roleId: roleId,
                  roleName: roleName,
                ),
              );
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
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/map_placeholder.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.map, size: 100, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),

                // 🔹 DISTANCE / TIME CARD
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                    onTap: () {},
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
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
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
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10), // Reduced bottom padding
            decoration: const BoxDecoration(
              color: lightGreen,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Wrap content tightly
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ID:  $orderId",
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                  ),
                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Swati Shah",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ),
                      _CircleAction(icon: Icons.call, onTap: () {}),
                      const SizedBox(width: 10),
                      _CircleAction(icon: Icons.chat_bubble, onTap: () {}),
                    ],
                  ),

                  const SizedBox(height: 6),

                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(text: "Let’s "),
                        TextSpan(text: "Start", style: TextStyle(fontWeight: FontWeight.w800)),
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
                      onPressed: () => _pickImageAndNavigate(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        "Start",
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  const _InfoItem({required this.label, required this.value});
  static const Color green = Color(0xFF1E7C10);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: green)),
      ],
    );
  }
}

class _CircleAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleAction({required this.icon, required this.onTap});
  static const Color green = Color(0xFF1E7C10);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(color: green, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
