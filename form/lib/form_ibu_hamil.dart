import 'package:flutter/material.dart';

class FormulirIbuHamil extends StatefulWidget {
  const FormulirIbuHamil({Key? key}) : super(key: key);

  @override
  State<FormulirIbuHamil> createState() => _FormulirIbuHamilState();
}

class _FormulirIbuHamilState extends State<FormulirIbuHamil> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController usiaKehamilanController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController fasilitasController = TextEditingController();
  final TextEditingController teleponController = TextEditingController();

  String jenisBantuan = 'Bantuan Gizi Ibu Hamil';

  @override
  void dispose() {
    namaController.dispose();
    nikController.dispose();
    usiaKehamilanController.dispose();
    alamatController.dispose();
    fasilitasController.dispose();
    teleponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulir Ibu Hamil"),
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
                fontStyle: FontStyle.italic,
                color: Colors.green.shade700,
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
                'Bantuan Gizi Ibu Hamil',
                'Bantuan Gizi Balita',
                'Bantuan Makan Siang dan Susu'
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
                    buildTextField("Nomor Induk Kependudukan", nikController, keyboard: TextInputType.number),
                    buildTextField("Usia Kehamilan (Minggu)", usiaKehamilanController, keyboard: TextInputType.number),
                    buildTextField("Alamat Tempat Tinggal", alamatController),
                    buildTextField("Fasilitas Yang Dikunjungi", fasilitasController),
                    buildTextField("No. Telp", teleponController, keyboard: TextInputType.phone),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
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
