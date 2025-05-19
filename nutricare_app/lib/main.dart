// lib/main.dart

import 'package:flutter/material.dart';

// Auth
import 'pages/auth/login.dart';
import 'pages/auth/register.dart';
import 'pages/auth/forgot_password.dart';

// Halaman Utama
import 'pages/home.dart';
import 'pages/histori.dart';
import 'pages/profil.dart';
import 'pages/edit_profil.dart';
import 'pages/tambah_jadwal.dart';
import 'pages/rekap_bulanan.dart';

void main() {
  runApp(const NutriCareApp());
}

class NutriCareApp extends StatelessWidget {
  const NutriCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF3E092),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF3CAD75)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3CAD75),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),

      // Inisialisasi awal: halaman login
      initialRoute: '/login',

      // Definisi semua route
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/forgot': (context) => const ForgotPasswordPage(),
        '/home': (context) => const HomePage(),
        '/histori': (context) =>  HistoriPage(),
        '/profil': (context) => const ProfilPage(),
        '/edit_profil': (context) => const EditProfilPage(),
        '/tambah_jadwal': (context) => const TambahJadwalPage(),
        '/rekap_bulanan': (context) => const RekapBulananPage(),
      },
    );
  }
}
