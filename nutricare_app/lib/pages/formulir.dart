import 'package:flutter/material.dart';

void main() => runApp(const NutriCareApp());

class NutriCareApp extends StatelessWidget {
  const NutriCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriCare',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const FormulirGabungan(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const DummyPage(title: 'Beranda'),
        '/formulir': (context) => const FormulirGabungan(),
        '/profil': (context) => const DummyPage(title: 'Profil'),
        '/histori': (context) => const DummyPage(title: 'Histori'), // perbaikan typo
      },
    );
  }
}

class FormulirGabungan extends StatefulWidget {
  const FormulirGabungan({super.key});

  @override
  State<FormulirGabungan> createState() => _FormulirGabunganState();
}

class _FormulirGabunganState extends State<FormulirGabungan> {
  String selectedForm = 'Bantuan Makan Siang dan Susu';

  final List<String> bantuanList = [
    'Bantuan Makan Siang dan Susu',
    'Bantuan Gizi Balita',
    'Bantuan Gizi Ibu Hamil',
  ];

  @override
  Widget build(BuildContext context) {
    Widget formWidget;
    switch (selectedForm) {
      case 'Bantuan Gizi Balita':
        formWidget = const FormulirBalita();
        break;
      case 'Bantuan Gizi Ibu Hamil':
        formWidget = const FormulirIbuHamil();
        break;
      default:
        formWidget = const FormulirAnakSekolah();
    }

    return Scaffold(
     body: Column(
      children: [
        // ✅ Header dipindah ke luar scroll agar full-width
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: const BoxDecoration(
            color: Color(0xFF3CAD75),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: SafeArea( // Pastikan tidak ketumpuk status bar
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 50),
                const SizedBox(width: 5),
                const Text(
                  'NutriCare',
                  style: TextStyle(
                    fontFamily: 'Shrikhand',
                    fontSize: 28,
                    color: Color(0xFFF3E092),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ✅ Scroll hanya untuk bagian isi
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedForm,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.yellow[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: bantuanList
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedForm = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                formWidget,
              ],
            ),
          ),
        ),
      ],
    ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFF3CAD75), width: 2)),
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: BottomNavigationBar(
            currentIndex: 1,
            selectedItemColor: const Color(0xFF3CAD75),
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            onTap: (idx) {
              switch (idx) {
                case 0:
                  Navigator.pushNamed(context, '/home');
                  break;
                case 1:
                  // Di halaman ini
                  break;
                case 2:
                  Navigator.pushNamed(context, '/histori'); // ✅ diperbaiki
                  break;
                case 3:
                  Navigator.pushNamed(context, '/profil');
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
              BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Formulir'),
              BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Histori'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
            ],
          ),
        ),
      ),
    );
  }
}


Widget buildField(String label, TextEditingController controller,
    {TextInputType keyboard = TextInputType.text}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: keyboard,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
            contentPadding: EdgeInsets.all(10),
          ),
          validator: (value) =>
              value == null || value.isEmpty ? "Wajib diisi" : null,
        ),
      ],
    ),
  );
}

// Form Anak Sekolah
class FormulirAnakSekolah extends StatefulWidget {
  const FormulirAnakSekolah({super.key});

  @override
  State<FormulirAnakSekolah> createState() => _FormulirAnakSekolahState();
}

class _FormulirAnakSekolahState extends State<FormulirAnakSekolah> {
  final formKey = GlobalKey<FormState>();
  final nama = TextEditingController();
  final gender = TextEditingController();
  final usia = TextEditingController();
  final sekolah = TextEditingController();
  final jenis = TextEditingController();
  final kelas = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          buildField("Nama", nama),
          buildField("Gender (L/P)", gender),
          buildField("Usia", usia, keyboard: TextInputType.number),
          buildField("Asal Sekolah", sekolah),
          buildField("Jenis Sekolah (Negeri/Swasta)", jenis),
          buildField("Kelas", kelas, keyboard: TextInputType.number),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Data Anak Sekolah disimpan")),
                );
              }
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }
}

// Form Balita
class FormulirBalita extends StatefulWidget {
  const FormulirBalita({super.key});

  @override
  State<FormulirBalita> createState() => _FormulirBalitaState();
}

class _FormulirBalitaState extends State<FormulirBalita> {
  final formKey = GlobalKey<FormState>();
  final nama = TextEditingController();
  final usia = TextEditingController();
  final berat = TextEditingController();
  final tinggi = TextEditingController();
  final alergi = TextEditingController();
  final ortu = TextEditingController();
  final lokasi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          buildField("Nama", nama),
          buildField("Usia (bulan)", usia, keyboard: TextInputType.number),
          buildField("Berat Badan (kg)", berat, keyboard: TextInputType.number),
          buildField("Tinggi Badan (cm)", tinggi, keyboard: TextInputType.number),
          buildField("Alergi (Jika ada)", alergi),
          buildField("Nama Orang Tua", ortu),
          buildField("Lokasi", lokasi),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Data Balita disimpan")),
                );
              }
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }
}

// Form Ibu Hamil
class FormulirIbuHamil extends StatefulWidget {
  const FormulirIbuHamil({super.key});

  @override
  State<FormulirIbuHamil> createState() => _FormulirIbuHamilState();
}

class _FormulirIbuHamilState extends State<FormulirIbuHamil> {
  final formKey = GlobalKey<FormState>();
  final nama = TextEditingController();
  final nik = TextEditingController();
  final usiaKehamilan = TextEditingController();
  final alamat = TextEditingController();
  final fasilitas = TextEditingController();
  final telepon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          buildField("Nama", nama),
          buildField("NIK", nik, keyboard: TextInputType.number),
          buildField("Usia Kehamilan (minggu)", usiaKehamilan, keyboard: TextInputType.number),
          buildField("Alamat", alamat),
          buildField("Fasilitas Kesehatan", fasilitas),
          buildField("No. Telepon", telepon, keyboard: TextInputType.phone),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Data Ibu Hamil disimpan")),
                );
              }
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }
}

// Dummy page untuk navigasi lainnya
class DummyPage extends StatelessWidget {
  final String title;
  const DummyPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Halaman $title')),
    );
  }
}
