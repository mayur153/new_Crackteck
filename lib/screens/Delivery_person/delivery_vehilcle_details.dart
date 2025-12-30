import 'package:flutter/material.dart';

class VehicleDetailsScreen extends StatefulWidget {
  const VehicleDetailsScreen({super.key});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  static const Color darkGreen = Color(0xFF145A00);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController brandCtrl = TextEditingController();
  final TextEditingController modelCtrl = TextEditingController();
  final TextEditingController regCtrl = TextEditingController();

  String? fuelType;

  final List<String> fuelOptions = [
    "Petrol",
    "Electric",
    "CNG",
  ];

  void _save() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vehicle details saved")),
      );
    }
  }

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
          "Vehicle Details",
          style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none,color: Colors.white),
          ),
        ],
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Label("Brand"),
              _InputField(
                controller: brandCtrl,
                hint: "",
              ),

              const SizedBox(height: 16),

              _Label("Model"),
              _InputField(
                controller: modelCtrl,
                hint: "",
              ),

              const SizedBox(height: 16),

              _Label("Registration number"),
              _InputField(
                controller: regCtrl,
                hint: "",
              ),

              const SizedBox(height: 16),

              _Label("Fuel type"),
              _FuelDropdown(
                value: fuelType,
                items: fuelOptions,
                onChanged: (v) {
                  setState(() => fuelType = v);
                },
              ),
            ],
          ),
        ),
      ),

      // 🔹 Save Button
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _save,
            style: ElevatedButton.styleFrom(
              backgroundColor: darkGreen,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Save",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),

      // 🔹 Bottom Navigation
      bottomNavigationBar: const _BottomNav(),
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

/// ================= INPUT FIELD =================
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _InputField({
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black12),
        ),
      ),
      validator: (v) => v == null || v.isEmpty ? "Required" : null,
    );
  }
}

/// ================= FUEL DROPDOWN =================
class _FuelDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _FuelDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      icon: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.green),
        ),
        child: const Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 18,
          color: Colors.green,
        ),
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black12),
        ),
      ),
      hint: const Text("Select"),
      items: items
          .map(
            (e) => DropdownMenuItem(
          value: e,
          child: Text(e),
        ),
      )
          .toList(),
      onChanged: onChanged,
      validator: (v) => v == null ? "Select fuel type" : null,
    );
  }
}

/// ================= BOTTOM NAV =================
class _BottomNav extends StatelessWidget {
  static const Color darkGreen = Color(0xFF145A00);

  const _BottomNav();

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
        children: const [
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
    final color = selected ? _BottomNav.darkGreen : Colors.black54;

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
