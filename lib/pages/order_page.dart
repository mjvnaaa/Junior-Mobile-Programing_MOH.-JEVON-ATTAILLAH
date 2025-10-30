import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import '../db/database_helper.dart';
import '../models/order.dart';

class OrderPage extends StatefulWidget {
  final String breadName;
  const OrderPage({super.key, required this.breadName});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  bool _loading = false;

  Future<void> _saveOrder() async {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty || _quantityController.text.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Semua field wajib diisi.')));
        return;
    }

    setState(() => _loading = true);

    
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Aktifkan GPS terlebih dahulu.')));
      setState(() => _loading = false);
      return;
    }

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Izin lokasi ditolak.')));
      setState(() => _loading = false);
      return;
    }

    final pos = await Geolocator.getCurrentPosition();

    final order = Order(
      customerName: _nameController.text,
      phoneNumber: _phoneController.text,
      breadName: widget.breadName,
      quantity: int.tryParse(_quantityController.text) ?? 1,
      latitude: pos.latitude,
      longitude: pos.longitude,
    );

    await DatabaseHelper.instance.insertOrder(order.toMap());

    setState(() => _loading = false);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Pesanan ${widget.breadName} sebanyak ${order.quantity} disimpan!')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pesan ${widget.breadName}')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama Pelanggan'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Nomor Telepon'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 12),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Jumlah Pesanan'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(height: 20),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton.icon(
                    onPressed: _saveOrder,
                    icon: Icon(Icons.location_on),
                    label: Text('Pesan Sekarang (Ambil Lokasi)'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}