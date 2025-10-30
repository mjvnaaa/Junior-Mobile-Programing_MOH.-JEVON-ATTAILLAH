class Order {
  final int? id;
  final String customerName;
  final String phoneNumber; 
  final String breadName;
  final int quantity; 
  final double latitude;
  final double longitude;

  Order({
    this.id,
    required this.customerName,
    required this.phoneNumber,
    required this.breadName,
    required this.quantity,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'phoneNumber': phoneNumber,
      'breadName': breadName,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}