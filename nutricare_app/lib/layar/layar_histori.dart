import 'package:flutter/material.dart';
import '../layanan/layanan_firestore.dart';

class LayarHistori extends StatelessWidget {
  const LayarHistori({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Histori Bantuan')),
      body: FutureBuilder(
        future: LayananFirestore.ambilHistoriBantuan(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          final data = snapshot.data as List;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return ListTile(
                title: Text(item['nama']),
                subtitle: Text("${item['kategori']}\n${item['tanggal']}", maxLines: 2),
                trailing: Text('Disalurkan'),
              );
            },
          );
        },
      ),
    );
  }
}