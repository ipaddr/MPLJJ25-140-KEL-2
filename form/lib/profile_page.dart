import 'package:flutter/material.dart';

class ProfilPengguna extends StatelessWidget {
  const ProfilPengguna({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController namaController = TextEditingController(text: 'Johan');
    final TextEditingController statusController = TextEditingController(text: 'Petugas Sekolah');
    final TextEditingController teleponController = TextEditingController(text: '0812345678');
    final TextEditingController emailController = TextEditingController(text: 'johan1234@gmail.com');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
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
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.green,
                  child: CircleAvatar(
                    radius: 57,
                    backgroundImage: NetworkImage(
                      'https://i.imgur.com/QCNbOAo.png', // Ganti dengan URL gambar profil Anda
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.black),
                    onPressed: () {
                      // Aksi ubah foto profil
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  buildReadOnlyField("Nama", namaController),
                  buildReadOnlyField("Status", statusController),
                  buildReadOnlyField("Nomor Telepon", teleponController),
                  buildReadOnlyField("Email", emailController),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
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

  Widget buildReadOnlyField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}
