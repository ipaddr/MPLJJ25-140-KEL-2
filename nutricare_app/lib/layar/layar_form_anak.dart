import 'package:flutter/material.dart';
import '../layanan/layanan_firestore.dart';

class LayarFormAnak extends StatefulWidget {
  const LayarFormAnak({super.key});

  @override
  State<LayarFormAnak> createState() => _LayarFormAnakState();
}

class _LayarFormAnakState extends State<LayarFormAnak> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _usiaController = TextEditingController();
  final TextEditingController _asalSekolahController = TextEditingController();
  final TextEditingController _jenisSekolahController = TextEditingController();
  final TextEditingController _kelasController = TextEditingController();

  final LayananFirestore _layananFirestore = LayananFirestore();

  void _simpanData() async {
    if (_formKey.currentState!.validate()) {
      await _layananFirestore.tambahDataAnak({
        'nama': _namaController.text,
        'gender': _genderController.text,
        'usia': _usiaController.text,
        'asalSekolah': _asalSekolahController.text,
        'jenisSekolah': _jenisSekolahController.text,
        'kelas': _kelasController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil disimpan')),
      );
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4B3),
      appBar: AppBar(title: const Text("Formulir Anak Sekolah")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buatField(_namaController, 'Nama'),
              _buatField(_genderController, 'Gender (L/P)'),
              _buatField(_usiaController, 'Usia'),
              _buatField(_asalSekolahController, 'Asal Sekolah'),
              _buatField(_jenisSekolahController, 'Jenis Sekolah (Negeri/Swasta)'),
              _buatField(_kelasController, 'Kelas'),
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
