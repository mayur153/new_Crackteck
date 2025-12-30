enum OrdersTab { total, pending, cancelled }

class OrderItem {
  OrderItem({
    required this.id,
    required this.date,
    required this.time,
    required this.from,
    required this.to,
    this.accepted = false,
    required this.status,
  });

  final String id;
  final String date;
  final String time;
  final String from;
  final String to;

  bool accepted;
  final OrdersTab status;
}
