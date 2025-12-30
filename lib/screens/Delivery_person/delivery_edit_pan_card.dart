import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class PancardEditScreen extends StatefulWidget {
  const PancardEditScreen({super.key});

  @override
  State<PancardEditScreen> createState() => _PancardEditScreenState();
}

class _PancardEditScreenState extends State<PancardEditScreen> {
  static const Color darkGreen = Color(0xFF145A00);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameCtrl =
  TextEditingController(text: "Jenny Doe");
  final TextEditingController numberCtrl =
  TextEditingController(text: "+91 **** ** ****");
  final TextEditingController aadhaarCtrl =
  TextEditingController(text: "******121");

  final ImagePicker _picker = ImagePicker();

  Future<void> _showPickerOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                await _picker.pickImage(source: ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                await _picker.pickImage(source: ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file),
              title: const Text('File'),
              onTap: () async {
                Navigator.pop(context);
                await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['jpg', 'pdf', 'png'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      // TODO: API call
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Aadhaar details saved")),
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
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Pan Card details",
          style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Label("Name"),
              _InputField(
                controller: nameCtrl,
                hint: "Enter name",
              ),

              const SizedBox(height: 16),

              const _Label("Number"),
              _InputField(
                controller: numberCtrl,
                hint: "Enter mobile number",
                keyboard: TextInputType.phone,
              ),

              const SizedBox(height: 16),

              const _Label("Pan no."),
              _InputField(
                controller: aadhaarCtrl,
                hint: "Enter Pan number",
                keyboard: TextInputType.number,
              ),

              const SizedBox(height: 20),

              /// Aadhaar Front
              _UploadBox(
                label: "Pan Card Front Image",
                onTap: _showPickerOptions,
              ),

              const SizedBox(height: 16),

              /// Aadhaar Back
              _UploadBox(
                label: "Pan Card Back Image",
                onTap: _showPickerOptions,
              ),

              const SizedBox(height: 28),

              /// Save Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
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
            ],
          ),
        ),
      ),

      /// Bottom Navigation

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

/// ================= INPUT =================
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboard;

  const _InputField({
    required this.controller,
    required this.hint,
    this.keyboard = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        hintText: hint,
        border: const UnderlineInputBorder(),
        isDense: true,
      ),
      validator: (v) => v == null || v.isEmpty ? "Required" : null,
    );
  }
}

/// ================= UPLOAD BOX =================
class _UploadBox extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _UploadBox({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.upload_outlined, color: Colors.green),
                SizedBox(width: 12),
                Icon(Icons.camera_alt_outlined, color: Colors.green),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Click to upload or take a photo",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "PNG or JPG (max. 2Mb)",
              style: TextStyle(fontSize: 11, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= BOTTOM NAV =================
class _BottomNav extends StatelessWidget {
  static const Color darkGreen = Color(0xFF145A00);

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
