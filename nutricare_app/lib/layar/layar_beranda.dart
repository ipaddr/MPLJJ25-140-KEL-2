import 'package:flutter/material.dart';
import '../layanan/layanan_auth.dart';

class LayarBeranda extends StatelessWidget {
  final LayananAuth _layananAuth = LayananAuth();

  LayarBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan MediaQuery untuk mendapatkan lebar layar
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4B3),
      appBar: AppBar(
        title: const Text('NutriCare - Beranda'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _layananAuth.keluar();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Halo, Petugas Sekolah",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("Pilih menu untuk mulai mendata bantuan:",
                  style: TextStyle(fontSize: 16)),
              const SizedBox(height: 30),
              // Mengubah childAspectRatio dan crossAxisCount untuk responsivitas
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // menonaktifkan scroll pada gridview
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth > 600 ? 3 : 2, // 3 kolom untuk layar lebih besar dari 600px
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: screenWidth > 600 ? 1.0 : 1.2, // Rasio yang lebih kecil untuk perangkat lebih besar
                ),
                itemCount: 7,
                itemBuilder: (context, index) {
                  return _buildMenuButton(
                    context,
                    _menuLabels[index],
                    _menuIcons[index],
                    _menuRoutes[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String label, IconData icon, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade400, blurRadius: 6, offset: const Offset(0, 3))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.orange),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14))
          ],
        ),
      ),
    );
  }

  // Daftar label, ikon, dan rute untuk menu
  final List<String> _menuLabels = [
    "Form Anak Sekolah",
    "Form Balita",
    "Form Ibu Hamil",
    "Jadwal Bantuan",
    "Histori",
    "Profil",
    "Rekap Bulanan"
  ];

  final List<IconData> _menuIcons = [
    Icons.school,
    Icons.child_care,
    Icons.pregnant_woman,
    Icons.calendar_today,
    Icons.history,
    Icons.person,
    Icons.bar_chart
  ];

  final List<String> _menuRoutes = [
    '/formAnak',
    '/formBalita',
    '/formIbu',
    '/jadwal',
    '/histori',
    '/profil',
    '/rekap'
  ];
}
