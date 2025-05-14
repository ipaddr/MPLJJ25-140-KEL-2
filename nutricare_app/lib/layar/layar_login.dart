// File: lib/layar/layar_login.dart
import 'package:flutter/material.dart';
import '../layanan/layanan_auth.dart';

class LayarLogin extends StatefulWidget {
  const LayarLogin({super.key});

  @override
  State<LayarLogin> createState() => _LayarLoginState();
}

class _LayarLoginState extends State<LayarLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LayananAuth _layananAuth = LayananAuth();

  void _loginPengguna() async {
    String email = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String? hasil = await _layananAuth.masukDenganEmail(email, password);

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/aset/gambar/logo.png', height: 100),
              const SizedBox(height: 20),
              const Text("NutriCare", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Kata Sandi'),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/lupa-sandi'),
                    child: const Text('Lupa kata sandi?'),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _loginPengguna,
                child: const Text('Login'),
              ),
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/daftar'),
                child: const Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
