class LayananFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Simpan data bantuan
  Future<void> simpanBantuan(BantuanModel bantuan) async {
    await _firestore.collection('bantuan').add(bantuan.toMap());
  }

  // Ambil daftar bantuan berdasarkan jenis
  Stream<List<BantuanModel>> ambilDaftarBantuan(String jenis) {
    return _firestore
        .collection('bantuan')
        .where('jenis', isEqualTo: jenis)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => BantuanModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  // Simpan jadwal
  Future<void> simpanJadwal(JadwalModel jadwal) async {
    await _firestore.collection('jadwal').add(jadwal.toMap());
  }

  // Ambil semua jadwal
  Stream<List<JadwalModel>> ambilSemuaJadwal() {
    return _firestore.collection('jadwal').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => JadwalModel.fromMap(doc.data() as Map<String, dynamic>)).toList());
  }

  // Simpan data anak
  Future<void> simpanDataAnak(Map<String, String> data) async {
    await _firestore.collection('anak').add(data);
  }
}
