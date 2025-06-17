import 'package:flutter/material.dart';

class HistoriPage extends StatefulWidget {
  const HistoriPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistoriPageState createState() => _HistoriPageState();
}

class _HistoriPageState extends State<HistoriPage> {
  late String selectedFilter;

  final List<String> filters = [
    'Bantuan Anak Sekolah',
    'Bantuan Balita',
    'Bantuan Ibu Hamil',
  ];

  final List<Map<String, String>> historiData = [
    {
      'jenis': 'Bantuan Anak Sekolah',
      'nama': 'Zikri Ramadhan',
      'gender': 'Laki-laki',
      'sekolah': 'SMKN 1 Kota Solok',
      'kelas': 'Kelas 12',
      'tanggal': '20 April 2025',
    },
    {
      'jenis': 'Bantuan Balita',
      'nama': 'Aqila Zahra',
      'usia': '2 tahun',
      'berat': '12 kg',
      'tinggi': '85 cm',
      'ortu': 'Rina Marlina',
      'tanggal': '12 Mei 2025',
    },
    {
      'jenis': 'Bantuan Ibu Hamil',
      'nama': 'Sari Dewi',
      'nik': '1234567890123456',
      'usiaKehamilan': '28 minggu',
      'alamat': 'Jl. Merpati No. 10',
      'faskes': 'Puskesmas Harapan',
      'telp': '081234567890',
      'tanggal': '30 Mei 2025',
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = historiData
        .where((item) => item['jenis'] == selectedFilter)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF3CAD75),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 50),
                const SizedBox(width: 1),
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

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6E29C),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFF3CAD75), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedFilter,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedFilter = newValue!;
                          });
                        },
                        dropdownColor: const Color(0xFFFFF8DC),
                        borderRadius: BorderRadius.circular(10),
                        items: filters.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        final item = filteredData[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(
                                color: Color(0xFF3CAD75),
                                width: 1.5,
                              ),
                            ),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              child: _buildCardContent(item),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: BottomNavigationBar(
            currentIndex: 2,
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
                  Navigator.pushNamed(context, '/formulir');
                  break;
                case 2:
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

  Widget _buildCardContent(Map<String, String> item) {
    List<Widget> children = [];

    void addField(String label, String? value) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 130,
                child: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 10,
                child: Text(":", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(child: Text(value ?? '-')),
            ],
          ),
        ),
      );
    }

    switch (item['jenis']) {
      case 'Bantuan Anak Sekolah':
        addField('Nama', item['nama']);
        addField('Gender', item['gender']);
        addField('Sekolah', item['sekolah']);
        addField('Kelas', item['kelas']);
        addField('Tanggal', item['tanggal']);
        break;
      case 'Bantuan Balita':
        addField('Nama', item['nama']);
        addField('Usia', item['usia']);
        addField('Berat Badan', item['berat']);
        addField('Tinggi Badan', item['tinggi']);
        addField('Nama Orang Tua', item['ortu']);
        addField('Tanggal', item['tanggal']);
        break;
      case 'Bantuan Ibu Hamil':
        addField('Nama', item['nama']);
        addField('NIK', item['nik']);
        addField('Usia Kehamilan', item['usiaKehamilan']);
        addField('Alamat', item['alamat']);
        addField('Faskes Dikunjungi', item['faskes']);
        addField('No. Telepon', item['telp']);
        addField('Tanggal', item['tanggal']);
        break;
      default:
        children.add(const Text('Data tidak tersedia'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
