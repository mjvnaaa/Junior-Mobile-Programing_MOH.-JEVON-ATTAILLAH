import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const BreadApp());
}

class BreadApp extends StatelessWidget {
  const BreadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Roti Attaillah',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: HomePage(),
      routes: {
      },
    );
  }
}