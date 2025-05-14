class BantuanModel {
  final String nama;
  final String jenis;
  final String keterangan;
  final String tanggal;
  final String waktu;

  BantuanModel({
    required this.nama,
    required this.jenis,
    required this.keterangan,
    required this.tanggal,
    required this.waktu,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'jenis': jenis,
      'keterangan': keterangan,
      'tanggal': tanggal,
      'waktu': waktu,
    };
  }

  factory BantuanModel.fromMap(Map<String, dynamic> map) {
    return BantuanModel(
      nama: map['nama'],
      jenis: map['jenis'],
      keterangan: map['keterangan'],
      tanggal: map['tanggal'],
      waktu: map['waktu'],
    );
  }
}
