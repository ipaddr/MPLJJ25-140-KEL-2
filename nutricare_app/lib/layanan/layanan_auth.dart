import 'package:firebase_auth/firebase_auth.dart';

class LayananAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Masuk
  Future<String?> masukDenganEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // sukses
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Daftar
  Future<String?> daftarDenganEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Lupa Kata Sandi
  Future<String?> lupaKataSandi(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Keluar
  Future<void> keluar() async {
    await _auth.signOut();
  }

  // Cek login
  User? penggunaSekarang() {
    return _auth.currentUser;
  }
}
