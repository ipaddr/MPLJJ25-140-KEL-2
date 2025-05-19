import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:async';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
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
    if (!_formKey.currentState!.validate()) return;

    // TODO: panggil API untuk kirim OTP ke email
    setState(() {
      isOTPSent = true;
      _message = 'Kode OTP telah dikirim ke ${_emailController.text}';
    });
    startTimer();
  }

  void verifyOTP() {
    if (_otpController.text == '123456') {
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
    if (!_formKey.currentState!.validate()) return;

    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() => _message = 'Kata sandi tidak cocok.');
      return;
    }

    // TODO: panggil API untuk update password di server

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kata sandi berhasil diubah!')),
    );
    // Otomatis kembali ke login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header
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
                    Image.asset('assets/images/logo.png', width: 200, height: 200),
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
                    // Email input
                    TextFormField(
                      controller: _emailController,
                      decoration: _inputDecoration('Masukkan Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email wajib diisi';
                        }
                        final regex = RegExp(
                          r'^[\w\-\.]+@([\w\-]+\.)+[a-zA-Z]{2,4}$',
                        );
                        if (!regex.hasMatch(value)) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Tombol kirim OTP
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            (_secondsRemaining == 0 && !isOTPSent)
                                ? sendOTP
                                : null,
                        style: _buttonStyle(),
                        child: Text(
                          _secondsRemaining == 0
                              ? 'Kirim Kode OTP'
                              : 'Kirim ulang dalam $_secondsRemaining s',
                        ),
                      ),
                    ),

                    // Input OTP setelah dikirim
                    if (isOTPSent) ...[
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _otpController,
                        decoration: _inputDecoration('Masukkan OTP'),
                        keyboardType: TextInputType.number,
                        validator: (_) {
                          if (!isOTPSent) return null;
                          if (_otpController.text.isEmpty)
                            // ignore: curly_braces_in_flow_control_structures
                            return 'OTP wajib diisi';
                          return null;
                        },
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

                    // Form ganti password setelah OTP terverifikasi
                    if (isOTPVerified) ...[
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _newPasswordController,
                        decoration: _inputDecoration('Kata Sandi Baru'),
                        obscureText: true,
                        validator: (_) {
                          if (!isOTPVerified) return null;
                          if (_newPasswordController.text.isEmpty) {
                            return 'Kata sandi wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: _inputDecoration('Konfirmasi Kata Sandi'),
                        obscureText: true,
                        validator: (_) {
                          if (!isOTPVerified) return null;
                          if (_confirmPasswordController.text.isEmpty) {
                            return 'Konfirmasi kata sandi wajib diisi';
                          }
                          return null;
                        },
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

                    // Pesan kesalahan / info
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
                    // Kembali ke login
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        'Sudah ingat kata sandi? Masuk di sini',
                        style: TextStyle(color: Color(0xFF3CAD75)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
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
        borderSide: const BorderSide(color: const Color(0xFF3CAD75), width: 2),
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
