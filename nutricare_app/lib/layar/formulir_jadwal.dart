import 'package:flutter/material.dart';
import '../layanan/layanan_firestore.dart';
import '../model/jadwal_model.dart';

class FormulirJadwalBantuan extends StatefulWidget {
  const FormulirJadwalBantuan({super.key});

  @override
  State<FormulirJadwalBantuan> createState() => _FormulirJadwalBantuanState();
}

class _FormulirJadwalBantuanState extends State<FormulirJadwalBantuan> {
  final _formKey = GlobalKey<FormState>();
  final _jenisController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _waktuController = TextEditingController();
  final _catatanController = TextEditingController();

  final _firestore = LayananFirestore();

  String _selectedJenis = 'Bantuan Gizi Balita';

  @override
  void dispose() {
    _jenisController.dispose();
    _tanggalController.dispose();
    _waktuController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  void _simpanJadwal() {
    if (_formKey.currentState!.validate()) {
      final jadwal = JadwalModel(
        jenis: _selectedJenis,
        tanggal: _tanggalController.text,
        waktu: _waktuController.text,
        catatan: _catatanController.text,
      );

      _firestore.simpanJadwal(jadwal).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jadwal berhasil disimpan')),
        );
        _formKey.currentState!.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Masukkan Jadwal Pembagian Bantuan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedJenis,
                decoration: const InputDecoration(
                  labelText: 'Jenis Bantuan',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Bantuan Gizi Balita',
                    child: Text('Bantuan Gizi Balita'),
                  ),
                  DropdownMenuItem(
                    value: 'Bantuan Gizi Ibu Hamil',
                    child: Text('Bantuan Gizi Ibu Hamil'),
                  ),
                  DropdownMenuItem(
                    value: 'Bantuan Makan Siang dan Susu',
                    child: Text('Bantuan Makan Siang dan Susu'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedJenis = value!;
                  });
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _tanggalController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal (dd/mm/yyyy)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Tanggal tidak boleh kosong' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _waktuController,
                decoration: const InputDecoration(
                  labelText: 'Waktu',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Waktu tidak boleh kosong' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _catatanController,
                decoration: const InputDecoration(
                  labelText: 'Catatan',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _simpanJadwal,
                child: const Text('SIMPAN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
