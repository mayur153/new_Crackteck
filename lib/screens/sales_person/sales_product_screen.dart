import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class ProductScreen extends StatefulWidget {
  final int roleId;
  final String roleName;

  const ProductScreen({
    super.key,
    required this.roleId,
    required this.roleName,
  });
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  static const Color midGreen = Color(0xFF1F8B00);
  static const Color darkGreen = Color(0xFF145A00);

  int qty = 1;

  // Demo data (replace with your API/model)
  final String title =
      "AURA EDITION Yoga Slim 7\nIntel, 35.56cms - Core Ultra 5\n(Luna Grey)";
  final String price = "₹1,09,990";
  final String discount = "28% off";
  final String description =
      "In stock • Express & free returns";

  final List<MapEntry<String, String>> specs = const [
    MapEntry("System Specs", ""),
    MapEntry(
      "Processor",
      "Intel® Core™ Ultra 5 125H Processor (LP-E cores up to 3.6GHz, P-cores up to 4.5GHz)",
    ),
    MapEntry("Operating System", "Windows 11 Home Single Language 64"),
    MapEntry("Graphics Card", "Integrated Intel® Arc™ Graphics 130V"),
    MapEntry("Memory", "32 GB LPDDR5X-8533MHz (Memory on Package)"),
    MapEntry("Storage", "1 TB SSD M.2 2242 PCIe Gen4 TLC"),
    MapEntry(
      "Display",
      "35.56cms (14\") WUXGA (1920×1200), OLED, Clear, Non-Touch, HDR 500 True Black, 400 nits, 60Hz",
    ),
    MapEntry("AC Adapter", "65W"),
    MapEntry("Pointing Device", "ClickPad"),
    MapEntry("Keyboard", "Backlit, Luna Grey – English (US)"),
    MapEntry("WIFI", "Wi-Fi 7 2×2 BE 320MHz & Bluetooth® 5.4"),
    MapEntry("Warranty", "1 Year PremiumCare"),
    MapEntry("Color", "Luna Grey"),
    MapEntry("Brand", "Lenovo YOGA"),
    MapEntry("Screen Resolution", "1920 × 1200"),
    MapEntry(
      "Software Preload",
      "Office Home 2024 + Lenovo AI Now",
    ),
    MapEntry("Services", "1YR Accidental Damage Protection"),
  ];

  void _inc() => setState(() => qty++);
  void _dec() => setState(() {
    if (qty > 1) qty--;
  });

  @override
  Widget build(BuildContext context) {
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
          "Product",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AspectRatio(
                          aspectRatio: 1.25,
                          child: Image.network(
                            "https://images.unsplash.com/photo-1555617981-dac3880eac6c?auto=format&fit=crop&w=900&q=80",
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Center(
                              child: Icon(Icons.image_not_supported_outlined, size: 40),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        height: 1.25,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          discount,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Specs section
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 6),
                          ..._buildSpecRows(specs),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom qty + submit bar
            Container(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.black12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _qtyButton(
                    icon: Icons.remove,
                    onTap: _dec,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 44,
                    height: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Text(
                      "$qty",
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _qtyButton(
                    icon: Icons.add,
                    onTap: _inc,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Submitted (Qty: $qty)")),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
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
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 44,
        height: 34,
        decoration: BoxDecoration(
          color: darkGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  List<Widget> _buildSpecRows(List<MapEntry<String, String>> list) {
    final widgets = <Widget>[];
    for (int i = 0; i < list.length; i++) {
      final k = list[i].key;
      final v = list[i].value;

      final isSection = v.trim().isEmpty;

      widgets.add(
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: i == list.length - 1 ? Colors.transparent : Colors.black12,
              ),
            ),
          ),
          child: isSection
              ? Text(
            k,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                k,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                v,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black87,
                  height: 1.25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return widgets;
  }
}
