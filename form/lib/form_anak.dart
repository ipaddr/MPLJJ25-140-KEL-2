import 'package:flutter/material.dart';

class FormulirAnakSekolah extends StatefulWidget {
  const FormulirAnakSekolah({Key? key}) : super(key: key);

  @override
  State<FormulirAnakSekolah> createState() => _FormulirAnakSekolahState();
}

class _FormulirAnakSekolahState extends State<FormulirAnakSekolah> {
  final _formKey = GlobalKey<FormState>();

  String bantuanDipilih = 'Bantuan Makan Siang dan Susu';
  final TextEditingController namaController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController usiaController = TextEditingController();
  final TextEditingController asalSekolahController = TextEditingController();
  final TextEditingController jenisSekolahController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();

  List<String> jenisBantuan = [
    'Bantuan Makan Siang dan Susu',
    'Bantuan Gizi Ibu Hamil',
    'Bantuan Gizi Balita',
  ];

  @override
  void dispose() {
    namaController.dispose();
    genderController.dispose();
    usiaController.dispose();
    asalSekolahController.dispose();
    jenisSekolahController.dispose();
    kelasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulir Anak Sekolah"),
        backgroundColor: Colors.green.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "NutriCare",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: bantuanDipilih,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.yellow.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: jenisBantuan
                  .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  bantuanDipilih = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    buildTextField("Nama", namaController),
                    buildTextField("Gender ( L / P )", genderController),
                    buildTextField("Usia", usiaController, keyboard: TextInputType.number),
                    buildTextField("Asal Sekolah", asalSekolahController),
                    buildTextField("Jenis Sekolah ( Negeri / Swasta )", jenisSekolahController),
                    buildTextField("Kelas", kelasController, keyboard: TextInputType.number),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Simpan logika data di sini
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Data berhasil disimpan!")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text("SIMPAN"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: "Formulir",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Histori",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, {TextInputType keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            keyboardType: keyboard,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.all(10),
            ),
            validator: (value) => value == null || value.isEmpty ? "Wajib diisi" : null,
          ),
        ],
      ),
    );
  }
}
