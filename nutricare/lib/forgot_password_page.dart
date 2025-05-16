// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dart:async';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isOTPSent = false;
  bool isOTPVerified = false;
  String _message = '';
  int _secondsRemaining = 0;
  Timer? _timer;

  void startTimer() {
    _secondsRemaining = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void sendOTP() {
    String phone = phoneController.text;
    if (phone.isEmpty || phone.length < 10) {
      setState(() => _message = 'Masukkan nomor telepon yang valid.');
      return;
    }
    setState(() {
      isOTPSent = true;
      _message = 'Kode OTP telah dikirim.';
    });
    startTimer();
  }

  void verifyOTP() {
    if (otpController.text == '123456') {
      setState(() {
        isOTPVerified = true;
        _message = 'OTP berhasil diverifikasi.';
      });
    } else {
      setState(() {
        _message = 'OTP salah. Silakan coba lagi.';
      });
    }
  }

  void saveNewPassword() {
    String pass1 = newPasswordController.text;
    String pass2 = confirmPasswordController.text;
    if (pass1.isEmpty || pass2.isEmpty) {
      setState(() => _message = 'Isi semua kolom kata sandi.');
      return;
    }
    if (pass1 != pass2) {
      setState(() => _message = 'Kata sandi tidak cocok.');
      return;
    }
    setState(() => _message = 'Kata sandi berhasil diperbarui.');
    // Navigasi atau simpan permanen bisa ditambahkan di sini.
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E092),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF3CAD75),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'NutriCare',
                    style: TextStyle(
                      fontFamily: 'Shrikhand',
                      fontSize: 35,
                      color: Color(0xFFF3E092),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: _inputDecoration('Masukkan No. Telp'),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (_secondsRemaining == 0) ? sendOTP : null,
                      style: _buttonStyle(),
                      child: Text(
                        _secondsRemaining == 0
                            ? 'Kirim'
                            : 'Kirim ulang dalam $_secondsRemaining detik',
                      ),
                    ),
                  ),
                  if (isOTPSent) ...[
                    const SizedBox(height: 32),
                    TextField(
                      controller: otpController,
                      decoration: _inputDecoration('Masukkan OTP'),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: verifyOTP,
                        style: _buttonStyle(),
                        child: const Text('Verifikasi OTP'),
                      ),
                    ),
                  ],
                  if (isOTPVerified) ...[
                    const SizedBox(height: 32),
                    TextField(
                      controller: newPasswordController,
                      obscureText: true,
                      decoration: _inputDecoration('Kata Sandi Baru'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: _inputDecoration('Konfirmasi Kata Sandi'),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: saveNewPassword,
                        style: _buttonStyle(),
                        child: const Text('Simpan Kata Sandi'),
                      ),
                    ),
                  ],
                  if (_message.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        _message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sudah ingat kata sandi? Masuk di sini',
                      style: TextStyle(
                        color: Color(0xFF3CAD75),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black38, width: 1.4),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black87, width: 1.8),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF3CAD75),
      foregroundColor: Colors.white,
      shadowColor: Colors.black45,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.symmetric(vertical: 14),
    );
  }
}
