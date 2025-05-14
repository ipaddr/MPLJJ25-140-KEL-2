import 'package:flutter/material.dart';
import '../layanan/layanan_auth.dart';

class LayarDaftar extends StatefulWidget {
  const LayarDaftar({super.key});

  @override
  State<LayarDaftar> createState() => _LayarDaftarState();
}

class _LayarDaftarState extends State<LayarDaftar> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final TextEditingController _kataSandiController = TextEditingController();
  final TextEditingController _konfirmasiKataSandiController = TextEditingController();
  final LayananAuth _layananAuth = LayananAuth();

  void _daftarPengguna() async {
    String email = _emailController.text.trim();
    String password = _kataSandiController.text.trim();
    String konfirmasi = _konfirmasiKataSandiController.text.trim();

    if (password != konfirmasi) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kata sandi tidak cocok.")),
      );
      return;
    }

    String? hasil = await _layananAuth.daftarDenganEmail(email, password);
    if (hasil == null) {
      Navigator.pushReplacementNamed(context, '/beranda');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(hasil)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4B3),
      appBar: AppBar(title: const Text("Daftar Petugas Sekolah")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama Lengkap'),
            ),
            TextField(
              controller: _teleponController,
              decoration: const InputDecoration(labelText: 'No. Telepon'),
            ),
            TextField(
              controller: _kataSandiController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Kata Sandi'),
            ),
            TextField(
              controller: _konfirmasiKataSandiController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Konfirmasi Kata Sandi'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _daftarPengguna,
              child: const Text('Daftar'),
            )
          ],
        ),
      ),
    );
  }
}
