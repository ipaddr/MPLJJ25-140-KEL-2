import 'package:flutter/material.dart';
import '../layanan/layanan_auth.dart';

class LayarLupaSandi extends StatefulWidget {
  const LayarLupaSandi({super.key});

  @override
  State<LayarLupaSandi> createState() => _LayarLupaSandiState();
}

class _LayarLupaSandiState extends State<LayarLupaSandi> {
  final TextEditingController _emailController = TextEditingController();
  final LayananAuth _layananAuth = LayananAuth();

  void _kirimReset() async {
    String email = _emailController.text.trim();
    String? hasil = await _layananAuth.lupaKataSandi(email);

    if (hasil == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email reset telah dikirim.")),
      );
      Navigator.pop(context);
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
      appBar: AppBar(title: const Text("Lupa Kata Sandi")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Masukkan email akun Anda untuk menerima tautan reset kata sandi.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _kirimReset,
              child: const Text('Kirim Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
