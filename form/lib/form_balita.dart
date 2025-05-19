import 'package:flutter/material.dart';

class FormulirBalita extends StatefulWidget {
  const FormulirBalita({Key? key}) : super(key: key);

  @override
  State<FormulirBalita> createState() => _FormulirBalitaState();
}

class _FormulirBalitaState extends State<FormulirBalita> {
  final _formKey = GlobalKey<FormState>();

  String jenisBantuan = 'Bantuan Gizi Balita';

  final TextEditingController namaController = TextEditingController();
  final TextEditingController usiaBulanController = TextEditingController();
  final TextEditingController beratBadanController = TextEditingController();
  final TextEditingController tinggiBadanController = TextEditingController();
  final TextEditingController alergiController = TextEditingController();
  final TextEditingController namaOrtuController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    usiaBulanController.dispose();
    beratBadanController.dispose();
    tinggiBadanController.dispose();
    alergiController.dispose();
    namaOrtuController.dispose();
    lokasiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulir Balita"),
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
              value: jenisBantuan,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.yellow.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: [
                'Bantuan Gizi Balita',
                'Bantuan Makan Siang dan Susu',
                'Bantuan Gizi Ibu Hamil'
              ].map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
              onChanged: (value) {
                setState(() {
                  jenisBantuan = value!;
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
                    buildTextField("Usia (Bulan)", usiaBulanController, keyboard: TextInputType.number),
                    buildTextField("Berat Badan (kg)", beratBadanController, keyboard: TextInputType.number),
                    buildTextField("Tinggi Badan (cm)", tinggiBadanController, keyboard: TextInputType.number),
                    buildTextField("Alergi (Jika ada)", alergiController),
                    buildTextField("Nama Orang Tua", namaOrtuController),
                    buildTextField("Lokasi", lokasiController),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Logika penyimpanan data bisa ditambahkan di sini
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
        currentIndex: 1,
        selectedItemColor: Colors.green,
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
