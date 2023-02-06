import 'package:flutter/material.dart';

class HalamanNotifikasi extends StatefulWidget {
  const HalamanNotifikasi({super.key});

  @override
  State<HalamanNotifikasi> createState() => _HalamanNotifikasiState();
}

class _HalamanNotifikasiState extends State<HalamanNotifikasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Container(
          // color: Colors.yellow,
          child: Text("Halaman Notifikasi"),
        ),
      ),
    );
  }
}