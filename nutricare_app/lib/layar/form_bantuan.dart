class FormBantuanPage extends StatefulWidget {
  @override
  _FormBantuanPageState createState() => _FormBantuanPageState();
}

class _FormBantuanPageState extends State<FormBantuanPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nikController = TextEditingController();
  final _usiaKehamilanController = TextEditingController();
  final _alamatController = TextEditingController();
  final _fasilitasController = TextEditingController();
  final _noTelpController = TextEditingController();

  final _layananFirestore = LayananFirestore();

  void _simpanDataBantuan() async {
    if (_formKey.currentState!.validate()) {
      await _layananFirestore.tambahDataBantuan({
        'kategori': 'Ibu Hamil',
        'nama': _namaController.text,
        'nik': _nikController.text,
        'usia_kehamilan': _usiaKehamilanController.text,
        'alamat': _alamatController.text,
        'fasilitas': _fasilitasController.text,
        'no_telp': _noTelpController.text,
        'timestamp': DateTime.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data bantuan berhasil disimpan'),
      ));

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Bantuan')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: _namaController, decoration: InputDecoration(labelText: 'Nama'), validator: (v) => v!.isEmpty ? 'Wajib diisi' : null),
              TextFormField(controller: _nikController, decoration: InputDecoration(labelText: 'NIK')),
              TextFormField(controller: _usiaKehamilanController, decoration: InputDecoration(labelText: 'Usia Kehamilan')),
              TextFormField(controller: _alamatController, decoration: InputDecoration(labelText: 'Alamat')),
              TextFormField(controller: _fasilitasController, decoration: InputDecoration(labelText: 'Fasilitas')),
              TextFormField(controller: _noTelpController, decoration: InputDecoration(labelText: 'No Telepon')),
              SizedBox(height: 16),
              ElevatedButton(onPressed: _simpanDataBantuan, child: Text('Simpan'))
            ],
          ),
        ),
      ),
    );
  }
}
