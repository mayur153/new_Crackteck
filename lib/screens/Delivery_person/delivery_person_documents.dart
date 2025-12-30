import 'package:flutter/material.dart';
import 'delivery_edit_License_card.dart';
import 'delivery_edit_adhar_card.dart';
import 'delivery_edit_pan_card.dart';
import 'delivery_vehilcle_details.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  static const Color darkGreen = Color(0xFF145A00);
  static const Color lightGrey = Color(0xFFF3F3F3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔹 AppBar
      appBar: AppBar(
        backgroundColor: darkGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Documents",
          style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none,color: Colors.white),
          ),
        ],
      ),

      // 🔹 Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================= Aadhaar =================
            const _Label("Aadhar no."),
            const _MaskedField(value: "*******121"),
            const SizedBox(height: 10),
            _DocImageRow(
              onEdit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AadhaarEditScreen()),
                );
              },
            ),

            const SizedBox(height: 20),

            /// ================= PAN =================
            const _Label("PAN no."),
            const _MaskedField(value: "*****121"),
            const SizedBox(height: 10),
            _DocImageRow(
              onEdit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PancardEditScreen()),
                );
              },
            ),

            const SizedBox(height: 20),

            /// ================= License =================
            const _Label("Licenses No."),
            const _MaskedField(value: "*********121"),
            const SizedBox(height: 10),
            _DocImageRow(
              onEdit: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LicenseEditScreen()),
            );
      },
            ),

            const SizedBox(height: 24),

            /// ================= Vehicle Details =================
            const Text(
              "Vehicle Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),

            const _Label("Brand"),
            const _InputBox(value: "TATA"),

            const SizedBox(height: 12),
            const _Label("Model"),
            const _InputBox(value: "********121"),

            const SizedBox(height: 12),
            const _Label("Vehicle No."),
            const _InputBox(value: "********121"),

            const SizedBox(height: 12),
            const _Label("Fuel type"),
            const _InputBox(value: "Disel"),

            const SizedBox(height: 6),
            // 🔹 Edit Option
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VehicleDetailsScreen()),
              );
            },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Edit",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.edit, size: 14, color: Colors.red),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 🔹 Bottom Navigation
      bottomNavigationBar: _BottomNav(),
    );
  }
}

/// ================= LABEL =================
class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 12, color: Colors.black54),
    );
  }
}

/// ================= MASKED FIELD =================
class _MaskedField extends StatelessWidget {
  final String value;
  const _MaskedField({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}

/// ================= INPUT BOX =================
class _InputBox extends StatelessWidget {
  final String value;
  const _InputBox({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}

/// ================= DOCUMENT IMAGE ROW =================
class _DocImageRow extends StatelessWidget {
  final VoidCallback onEdit;
  const _DocImageRow({required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            _DocImageBox(),
            const SizedBox(width: 12),
            _DocImageBox(),
          ],
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: onEdit,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                "Edit",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 4),
              Icon(Icons.edit, size: 14, color: Colors.red),
            ],
          ),
        ),
      ],
    );
  }
}

/// ================= IMAGE PLACEHOLDER =================
class _DocImageBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: const Text(
          "IMAGE",
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black54),
        ),
      ),
    );
  }
}

/// ================= BOTTOM NAV =================
class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: Icons.home_outlined, label: "Home"),
          _NavItem(icon: Icons.chat_bubble_outline, label: "Chat"),
          _NavItem(
            icon: Icons.person,
            label: "Profile",
            selected: true,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const _NavItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? DocumentsScreen.darkGreen : Colors.black54;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
