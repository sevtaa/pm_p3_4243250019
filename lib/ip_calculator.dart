import 'mata_kuliah.dart';

double konversiNilai(String nilai) {
  final nilaiUpper = nilai.trim().toUpperCase();
  return switch (nilaiUpper) {
    'A' => 4.0,
    'B' => 3.0,
    'C' => 2.0,
    'D' => 1.0,
    'E' => 0.0,
    _ => throw FormatException(
      'Nilai huruf tidak valid (harus A, B, C, D, atau E)',
    ),
  };
}

int validasiSKS(String inputSks) {
  final sks = int.tryParse(inputSks.trim());
  if (sks == null || sks < 1 || sks > 6) {
    throw FormatException('SKS harus angka 1-6');
  }
  return sks;
}

String dapatkanPredikat({
  required double ip,
  String defaultPredikat = 'Cukup',
}) {
  if (ip >= 3.51) return 'Dengan Pujian (Cumlaude)';
  if (ip >= 3.00) return 'Memuaskan';
  if (ip >= 2.75) return 'Sangat Memuaskan';
  return defaultPredikat;
}

List<MataKuliah> cariMKPerluDiperbaiki(List<MataKuliah> daftarMK) {
  return daftarMK.where((mk) => mk.bobot < 2.0).toList();
}

Map<String, dynamic> hitungIP(List<MataKuliah> daftarMK) {
  if (daftarMK.isEmpty) return {'totalSKS': 0, 'ip': 0.0};

  final totalSKS = daftarMK.fold<int>(0, (sum, mk) => sum + mk.sks);
  final totalBobotSKS = daftarMK.fold<double>(
    0.0,
    (sum, mk) => sum + (mk.sks * mk.bobot),
  );

  return {'totalSKS': totalSKS, 'ip': totalBobotSKS / totalSKS};
}

void urutkanMataKuliah(List<MataKuliah> daftarMK) {
  daftarMK.sort((a, b) => a.nama.toLowerCase().compareTo(b.nama.toLowerCase()));
}
