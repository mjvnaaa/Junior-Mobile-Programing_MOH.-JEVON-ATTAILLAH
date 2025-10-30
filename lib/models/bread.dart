class Bread {
  final int id;
  final String name;
  final int price;

  Bread({required this.id, required this.name, required this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}