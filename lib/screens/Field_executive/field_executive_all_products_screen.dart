import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class FieldExecutiveAllProductsScreen extends StatelessWidget {
  final int roleId;
  final String roleName;

  const FieldExecutiveAllProductsScreen({
    super.key,
    required this.roleId,
    required this.roleName,
  });

  static const primaryGreen = Color(0xFF1E7C10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'All Products',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildProductCard(
            context,
            'Desktop Installation',
            'Visit charge of Rs 159 waived in final bill; spare part/ repair cost extra',
            '#LYCFF776567DS',
            'Kandivali (West)',
            'High',
          ),
          const SizedBox(height: 12),
          _buildProductCard(
            context,
            'Monitor Setup',
            'Standard installation for LED/LCD monitors',
            '#LYCFF776567DS',
            'Borivali (East)',
            'Medium',
          ),
          const SizedBox(height: 12),
          _buildProductCard(
            context,
            'UPS Installation',
            'Battery backup configuration and testing',
            '#LYCFF776567DS',
            'Malad (West)',
            'Low',
          ),
          const SizedBox(height: 12),
          _buildProductCard(
            context,
            'Keyboard and Mouse',
            'Wired/Wireless setup and driver installation',
            '#LYCFF776567DS',
            'Kandivali (West)',
            'Low',
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String title, String subtitle, String serviceId, String location, String priority) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.FieldExecutiveProductItemDetailScreen,
          arguments: fieldexecutiveproductitemdetailArguments(
            roleId: roleId,
            roleName: roleName,
            title: title,
            serviceId: serviceId,
            location: location,
            priority: priority,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Image.network(
                        'https://via.placeholder.com/60',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(fontSize: 10, color: Colors.black54),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const SizedBox(
                              width: 70,
                              child: Text('Service ID:', style: TextStyle(fontSize: 12, color: Colors.black54)),
                            ),
                            Text(serviceId, style: const TextStyle(fontSize: 12, color: primaryGreen, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const SizedBox(
                              width: 70,
                              child: Text('Location:', style: TextStyle(fontSize: 12, color: Colors.black54)),
                            ),
                            Text(location, style: const TextStyle(fontSize: 12, color: primaryGreen, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Priority Tag
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12)),
                ),
                child: Text(
                  priority,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
