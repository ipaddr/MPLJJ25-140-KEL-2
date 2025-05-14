class JadwalModel {
  final String jenis;
  final String tanggal;
  final String waktu;
  final String catatan;

  JadwalModel({
    required this.jenis,
    required this.tanggal,
    required this.waktu,
    required this.catatan,
  });

  Map<String, dynamic> toMap() {
    return {
      'jenis': jenis,
      'tanggal': tanggal,
      'waktu': waktu,
      'catatan': catatan,
    };
  }

  factory JadwalModel.fromMap(Map<String, dynamic> map) {
    return JadwalModel(
      jenis: map['jenis'],
      tanggal: map['tanggal'],
      waktu: map['waktu'],
      catatan: map['catatan'],
    );
  }
}
