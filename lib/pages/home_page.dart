import 'package:flutter/material.dart';
import 'order_page.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> breads = [
    {'name': 'Roti Coklat', 'price': 10000},
    {'name': 'Roti Keju', 'price': 12000},
    {'name': 'Kue Lapis', 'price': 15000},
    {'name': 'Roti Pisang', 'price': 11000},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Toko Roti Attaillah')),
      body: ListView.builder(
        itemCount: breads.length,
        itemBuilder: (context, index) {
          final bread = breads[index];
          return ListTile(
            title: Text(bread['name']),
            subtitle: Text('Rp ${bread['price']}'),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderPage(breadName: bread['name']),
                  ),
                );
              },
              child: Text('Beli'),
            ),
          );
        },
      ),
    );
  }
}