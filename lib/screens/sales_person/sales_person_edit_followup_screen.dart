import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class EditFollowUpScreen extends StatefulWidget {
  final int roleId;
  final String roleName;

  const EditFollowUpScreen({
    Key? key,
    required this.roleId,
    required this.roleName,
  }) : super(key: key);

  @override
  State<EditFollowUpScreen> createState() => _EditFollowUpScreenState();
}

class _EditFollowUpScreenState extends State<EditFollowUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final leadIdCtrl = TextEditingController();
  final contactCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final timeCtrl = TextEditingController();
  final clientNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final remarksCtrl = TextEditingController();

  // State
  String? statusValue;

  final List<String> statusOptions = const ["Hold", "Converted", "Lost"];

  // Theme-ish colors similar to your UI
  static const Color midGreen = Color(0xFF1F8B00);
  static const Color darkGreen = Color(0xFF145A00);

  @override
  void initState() {
    super.initState();

    // ✅ Dummy "existing follow-up" data (static demo)
    leadIdCtrl.text = "LD-10021";
    contactCtrl.text = "9876543210"; // 🔒 locked
    dateCtrl.text = "23/12/2025";
    timeCtrl.text = "4:30 PM";
    statusValue = "Hold";
    clientNameCtrl.text = "Rahul Sharma";
    emailCtrl.text = "rahul.sharma@example.com"; // 🔒 locked
    remarksCtrl.text = "Client asked for revised quotation. Call again tomorrow.";
  }

  @override
  void dispose() {
    leadIdCtrl.dispose();
    contactCtrl.dispose();
    dateCtrl.dispose();
    timeCtrl.dispose();
    clientNameCtrl.dispose();
    emailCtrl.dispose();
    remarksCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(2035, 12, 31),
    );
    if (picked != null) {
      final dd = picked.day.toString().padLeft(2, "0");
      final mm = picked.month.toString().padLeft(2, "0");
      final yyyy = picked.year.toString();
      setState(() => dateCtrl.text = "$dd/$mm/$yyyy");
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => timeCtrl.text = picked.format(context));
    }
  }

  void _update() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Follow-Up updated (static demo)")),
    );
  }

  InputDecoration _decor(
      String hint, {
        Widget? suffixIcon,
        Widget? prefixIcon,
        bool disabled = false,
      }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
      filled: true,
      fillColor: disabled ? Colors.black.withOpacity(0.03) : Colors.white,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blue, width: 1.6),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 1.6),
      ),
      prefixIcon: prefixIcon,
      prefixIconConstraints: const BoxConstraints(minWidth: 52),
      suffixIcon: suffixIcon,
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _textField({
    required String label,
    required TextEditingController controller,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    bool enabled = true,
    VoidCallback? onTap,
    Widget? suffixIcon,
    Widget? prefixIcon,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    final disabled = !enabled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          enabled: enabled,
          onTap: onTap,
          maxLines: maxLines,
          decoration: _decor(
            hint ?? "",
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            disabled: disabled,
          ),
          validator: validator,
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _statusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label("Status"),
        DropdownButtonFormField<String>(
          value: statusValue,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: darkGreen),
          decoration: _decor(
            "Select",
            suffixIcon: const Padding(
              padding: EdgeInsets.only(right: 6),
              child: Icon(Icons.keyboard_arrow_down_rounded, color: darkGreen),
            ),
          ),
          hint: const Text(
            "Select",
            style: TextStyle(color: Colors.black38, fontSize: 13),
          ),
          items: statusOptions.map((s) {
            return DropdownMenuItem<String>(
              value: s,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  s,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            );
          }).toList(),
          dropdownColor: const Color(0xFFF2F2F2),
          onChanged: (val) => setState(() => statusValue = val),
          validator: (v) => (v == null || v.isEmpty) ? "Please select status" : null,
        ),
        const SizedBox(height: 12),
      ],
    );
  }

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
          "Edit Follow-Up",
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _textField(
                  label: "Lead ID",
                  controller: leadIdCtrl,
                  hint: "",
                  validator: (v) => (v == null || v.trim().isEmpty) ? "Enter Lead ID" : null,
                ),

                // 🔒 Contact Number cannot be changed
                _textField(
                  label: "Contact Number",
                  controller: contactCtrl,
                  hint: "",
                  keyboardType: TextInputType.phone,
                  enabled: false,
                  prefixIcon: const SizedBox(
                    width: 52,
                    child: Center(
                      child: Text(
                        "+91",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                    ),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty) ? "Enter contact number" : null,
                ),

                _textField(
                  label: "Date",
                  controller: dateCtrl,
                  readOnly: true,
                  onTap: _pickDate,
                  suffixIcon: const Icon(Icons.calendar_month_outlined, color: Colors.black45),
                  validator: (v) => (v == null || v.trim().isEmpty) ? "Select date" : null,
                ),

                _textField(
                  label: "Time",
                  controller: timeCtrl,
                  readOnly: true,
                  onTap: _pickTime,
                  suffixIcon: const Icon(Icons.access_time_rounded, color: Colors.black45),
                  validator: (v) => (v == null || v.trim().isEmpty) ? "Select time" : null,
                ),

                _statusDropdown(),

                _textField(
                  label: "Client Name",
                  controller: clientNameCtrl,
                  hint: "",
                  validator: (v) => (v == null || v.trim().isEmpty) ? "Enter client name" : null,
                ),

                // 🔒 Email cannot be changed
                _textField(
                  label: "Email",
                  controller: emailCtrl,
                  hint: "",
                  keyboardType: TextInputType.emailAddress,
                  enabled: false,
                  validator: (v) {
                    final value = (v ?? "").trim();
                    if (value.isEmpty) return "Enter email";
                    if (!value.contains("@") || !value.contains(".")) return "Enter valid email";
                    return null;
                  },
                ),

                _textField(
                  label: "Remarks",
                  controller: remarksCtrl,
                  hint: "",
                  maxLines: 2,
                ),

                const SizedBox(height: 14),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _update,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Update",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
