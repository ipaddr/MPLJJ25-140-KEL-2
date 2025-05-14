import 'package:flutter/material.dart';
import '../layanan/layanan_firestore.dart';

class LayarFormBalita extends StatefulWidget {
  const LayarFormBalita({super.key});

  @override
  State<LayarFormBalita> createState() => _LayarFormBalitaState();
}

class _LayarFormBalitaState extends State<LayarFormBalita> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _umurController = TextEditingController();
  final TextEditingController _beratBadanController = TextEditingController();
  final TextEditingController _tinggiBadanController = TextEditingController();
  final TextEditingController _alergiController = TextEditingController();
  final TextEditingController _namaOrtuController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();

  final LayananFirestore _layananFirestore = LayananFirestore();

  void _simpanData() async {
    if (_formKey.currentState!.validate()) {
      await _layananFirestore.tambahDataBalita({
        'nama': _namaController.text,
        'umur': _umurController.text,
        'beratBadan': _beratBadanController.text,
        'tinggiBadan': _tinggiBadanController.text,
        'alergi': _alergiController.text,
        'namaOrtu': _namaOrtuController.text,
        'lokasi': _lokasiController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data balita berhasil disimpan')),
      );
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4B3),
      appBar: AppBar(title: const Text("Formulir Balita")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buatField(_namaController, 'Nama'),
              _buatField(_umurController, 'Umur'),
              _buatField(_beratBadanController, 'Berat Badan (kg)'),
              _buatField(_tinggiBadanController, 'Tinggi Badan (cm)'),
              _buatField(_alergiController, 'Alergi (jika ada)'),
              _buatField(_namaOrtuController, 'Nama Orang Tua'),
              _buatField(_lokasiController, 'Lokasi/Puskesmas'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _simpanData,
                child: const Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buatField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        validator: (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
      ),
    );
  }
}
