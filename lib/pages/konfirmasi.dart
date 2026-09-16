import 'package:flutter/material.dart';

class HalamanKonfirmasi extends StatelessWidget {
  const HalamanKonfirmasi({super.key, required this.nama, required this.kota});

  final String nama;
  final String kota;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Pendaftaran')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Terima kasih, $nama dari $kota telah mendaftar.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
