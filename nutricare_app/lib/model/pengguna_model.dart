class PenggunaModel {
  final String nama;
  final String status;
  final String nomorTelepon;
  final String email;

  PenggunaModel({
    required this.nama,
    required this.status,
    required this.nomorTelepon,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'status': status,
      'nomorTelepon': nomorTelepon,
      'email': email,
    };
  }

  factory PenggunaModel.fromMap(Map<String, dynamic> map) {
    return PenggunaModel(
      nama: map['nama'] ?? '',
      status: map['status'] ?? '',
      nomorTelepon: map['nomorTelepon'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
