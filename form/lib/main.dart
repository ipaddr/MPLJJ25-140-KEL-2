import 'package:flutter/material.dart';

// Import halaman-halaman
import 'form_anak.dart';
import 'form_balita.dart';
import 'form_ibu_hamil.dart';
import 'profile_page.dart';

void main() {
  runApp(const NutriCareApp());
}

class NutriCareApp extends StatefulWidget {
  const NutriCareApp({Key? key}) : super(key: key);

  @override
  State<NutriCareApp> createState() => _NutriCareAppState();
}

class _NutriCareAppState extends State<NutriCareApp> {
  int _currentIndex = 0;

  final List<String> _pageTitles = [
    'Formulir Anak Sekolah',
    'Formulir Balita',
    'Formulir Ibu Hamil',
    'Profil Pengguna',
  ];

  final List<Widget> _pages = [
    const FormulirAnakSekolah(),
    const FormulirBalita(),
    const FormulirIbuHamil(),
    const ProfilPengguna(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NutriCare App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('NutriCare - ${_pageTitles[_currentIndex]}'),
          backgroundColor: Colors.green,
          actions: [
            DropdownButton<int>(
              value: _currentIndex,
              dropdownColor: Colors.green[100],
              underline: Container(),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              onChanged: (int? newIndex) {
                if (newIndex != null) {
                  setState(() {
                    _currentIndex = newIndex;
                  });
                }
              },
              items: List.generate(_pageTitles.length, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text(
                    _pageTitles[index],
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }),
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Anak'),
            BottomNavigationBarItem(icon: Icon(Icons.child_care), label: 'Balita'),
            BottomNavigationBarItem(icon: Icon(Icons.pregnant_woman), label: 'Ibu Hamil'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}
