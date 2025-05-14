import 'package:flutter/material.dart';

class LayarProfil extends StatelessWidget {
  final String nama = 'Jihan Salsabila';
  final String status = 'Petugas Sekolah';
  final String telepon = '0812345678';
  final String email = 'jihansalsabila@gmail.com';

  const LayarProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profil Pengguna')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 40, backgroundImage: AssetImage('aset/gambar/user.png')),
            SizedBox(height: 16),
            Text('Nama: $nama'),
            Text('Status: $status'),
            Text('Nomor Telepon: $telepon'),
            Text('Email: $email'),
          ],
        ),
      ),
    );
  }
}