import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LayarRekap extends StatelessWidget {
  const LayarRekap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rekap Bulanan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Hasil Rekap Bulanan Pembagian Bantuan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            BarChart(
              BarChartData(
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [BarChartRodData(toY: 150, color: Colors.blue)],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [BarChartRodData(toY: 75, color: Colors.orange)],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [BarChartRodData(toY: 50, color: Colors.green)],
                    showingTooltipIndicators: [0],
                  ),
                ],
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, _) {
                      switch (value.toInt()) {
                        case 0:
                          return Text('Anak Sekolah');
                        case 1:
                          return Text('Balita');
                        case 2:
                          return Text('Ibu Hamil');
                        default:
                          return Text('');
                      }
                    }),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('Utamakan wilayah Kabupaten Solok yang memiliki permintaan tinggi')
          ],
        ),
      ),
    );
  }
}
