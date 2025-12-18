import 'package:flutter/material.dart';

class NewLeadScreen extends StatefulWidget {
  const NewLeadScreen({super.key});

  @override
  State<NewLeadScreen> createState() => _NewLeadScreenState();
}

class _NewLeadScreenState extends State<NewLeadScreen> {
  static const Color midGreen = Color(0xFF1F8B00);
  static const Color darkGreen = Color(0xFF145A00);

  final _formKey = GlobalKey<FormState>();

  // Dropdown values
  String? source;
  String? urgency;
  String? requirementType;
  String? industryType;
  String? leadStatus;
  String? type;

  // Controllers
  final nameCtrl = TextEditingController();
  final companyCtrl = TextEditingController();
  final designationCtrl = TextEditingController();
  final numberCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final budgetCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: midGreen,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'New Leads',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.white),
          SizedBox(width: 12),
        ],
      ),

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _input('Full Name', nameCtrl),
              _input('Company Name ( Optional )', companyCtrl),
              _input('Designation ( Optional )', designationCtrl),
              _input('Number', numberCtrl,
                  prefix: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('+91'),
                  )),
              _input('Email', emailCtrl),
              _input('Address', addressCtrl),
              _input('Budget Range', budgetCtrl),

              _dropdown(
                label: 'Source',
                value: source,
                items: ['Referral', 'Website', 'Walk-in'],
                onChanged: (v) => setState(() => source = v),
              ),

              _dropdown(
                label: 'Urgency',
                value: urgency,
                items: ['Low', 'Medium', 'High'],
                onChanged: (v) => setState(() => urgency = v),
              ),

              _dropdown(
                label: 'Requirement Type',
                value: requirementType,
                items: ['CCTV', 'Networking', 'Biometric'],
                onChanged: (v) => setState(() => requirementType = v),
              ),

              _dropdown(
                label: 'Industry Type',
                value: industryType,
                items: ['Pharma', 'School', 'Manufacturing'],
                onChanged: (v) => setState(() => industryType = v),
              ),

              _dropdown(
                label: 'Lead Status',
                value: leadStatus,
                items: ['Hold', 'Converted', 'Lost'],
                onChanged: (v) => setState(() => leadStatus = v),
              ),

              _dropdown(
                label: 'Type',
                value: type,
                items: ['AMC'],
                onChanged: (v) => setState(() => type = v),
              ),

              const SizedBox(height: 12),

              /// UPLOAD PHOTO
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 22),
                decoration: BoxDecoration(
                  border: Border.all(color: midGreen),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: const [
                    Icon(Icons.upload, color: midGreen),
                    SizedBox(height: 6),
                    Text(
                      'Click to upload',
                      style: TextStyle(
                        color: midGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Aadhar Card Image in PNG or JPG (max. 2Mb)',
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// SUBMIT BUTTON
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: midGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Lead submitted (static demo)'),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// TEXT INPUT
  Widget _input(
      String label,
      TextEditingController controller, {
        Widget? prefix,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  /// DROPDOWN
  Widget _dropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.keyboard_arrow_down, color: midGreen),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        items: items
            .map(
              (e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ),
        )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
