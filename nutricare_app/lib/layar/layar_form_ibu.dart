import 'package:flutter/material.dart';
import '../layanan/layanan_firestore.dart';

class FormulirIbu extends StatefulWidget {
  const FormulirIbu({super.key});

  @override
  _FormulirIbuState createState() => _FormulirIbuState();
}

class _FormulirIbuState extends State<FormulirIbu> {
  final _formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final nikController = TextEditingController();
  final usiaKehamilanController = TextEditingController();
  final alamatController = TextEditingController();
  final fasilitasController = TextEditingController();
  final noTelpController = TextEditingController();

  void simpanData() async {
    if (_formKey.currentState!.validate()) {
      await LayananFirestore.tambahDataBantuan({
        'kategori': 'Ibu Hamil',
        'nama': namaController.text,
        'nik': nikController.text,
        'usia_kehamilan': usiaKehamilanController.text,
        'alamat': alamatController.text,
        'fasilitas': fasilitasController.text,
        'no_telp': noTelpController.text,
        'timestamp': DateTime.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data berhasil disimpan')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bantuan Gizi Ibu Hamil')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: nikController,
                decoration: InputDecoration(labelText: 'Nomor Induk Kependudukan'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: usiaKehamilanController,
                decoration: InputDecoration(labelText: 'Usia Kehamilan (Minggu)'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: alamatController,
                decoration: InputDecoration(labelText: 'Alamat Tempat Tinggal'),
              ),
              TextFormField(
                controller: fasilitasController,
                decoration: InputDecoration(labelText: 'Fasilitas yang Dikunjungi'),
              ),
              TextFormField(
                controller: noTelpController,
                decoration: InputDecoration(labelText: 'No. Telp'),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: simpanData,
                child: Text('SIMPAN'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
