import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RekapBulananPage extends StatelessWidget {
  const RekapBulananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Header dari HomePage
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF3CAD75),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 50),
                const SizedBox(width: 1),
                const Text(
                  'NutriCare',
                  style: TextStyle(
                    fontFamily: 'Shrikhand',
                    fontSize: 28,
                    color: Color(0xFFF3E092),
                  ),
                ),
              ],
            ),
          ),

          // Konten halaman
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  14,
                  20,
                  22,
                ), // Margin rapi
                child: Column(
                  children: [
                    const SizedBox(height: 0),
                    const Text(
                      'Hasil Rekap Bulanan\nPembagian Bantuan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Gambar dan Jumlah
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/anak_sekolah.png',
                              height: 60,
                            ),
                            const SizedBox(height: 4),
                            const Text('Anak Sekolah'),
                            const Text(
                              '150',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset('assets/images/balita.png', height: 60),
                            const SizedBox(height: 4),
                            const Text('Balita'),
                            const Text(
                              '75',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/ibu_hamil.png',
                              height: 60,
                            ),
                            const SizedBox(height: 4),
                            const Text('Ibu Hamil'),
                            const Text(
                              '35',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Chart (fl_chart)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF3CAD75), width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 280,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceEvenly,
                          maxY: 160,
                          barTouchData: BarTouchData(enabled: false),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, _) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return const Text('Sekolah');
                                    case 1:
                                      return const Text('Balita');
                                    case 2:
                                      return const Text('Ibu Hamil');
                                    default:
                                      return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 20,
                                reservedSize: 32,
                                getTitlesWidget: (value, _) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(fontSize: 12),
                                  );
                                },
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          gridData: FlGridData(show: true),
                          borderData: FlBorderData(show: false),
                          barGroups: [
                            BarChartGroupData(
                              x: 0,
                              barRods: [
                                BarChartRodData(
                                  toY: 150,
                                  color: Colors.lightBlue,
                                  width: 24,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 1,
                              barRods: [
                                BarChartRodData(
                                  toY: 75,
                                  color: Colors.pinkAccent,
                                  width: 24,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 2,
                              barRods: [
                                BarChartRodData(
                                  toY: 35,
                                  color: Colors.green,
                                  width: 24,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Saran Prioritas
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF3CAD75), width: 2),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.lightbulb,
                            color: Color(0xFF3CAD75),
                            size: 36,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Utamakan wilayah Kabupaten Solok yang memiliki permintaan tinggi',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar dari HomePage
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFF3CAD75), width: 2)),
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: BottomNavigationBar(
            currentIndex: 0,
            selectedItemColor: const Color(0xFF3CAD75),
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            onTap: (idx) {
              switch (idx) {
                case 0:
                  Navigator.pushNamed(context, '/home');
                  break;
                case 1:
                  Navigator.pushNamed(context, '/formulir');
                  break;
                case 2:
                  Navigator.pushNamed(context, '/histori');
                  break;
                case 3:
                  Navigator.pushNamed(context, '/profil');
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                label: 'Formulir',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'Histori',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
