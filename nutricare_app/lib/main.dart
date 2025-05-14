import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Dihasilkan oleh `flutterfire configure`

// Import layar utama
import 'layar/layar_login.dart';
import 'layar/layar_beranda.dart';
import 'layar/layar_daftar.dart';
import 'layar/layar_lupa_sandi.dart';

void main() async {
  // Wajib sebelum memanggil method async di main
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase dengan opsi platform dari firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LayarLogin(),
        '/daftar': (context) => const LayarDaftar(),
        '/beranda': (context) => LayarBeranda(),
        '/lupasandi': (context) => const LayarLupaSandi(),
      },
    );
  }
}
