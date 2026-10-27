import 'dart:io';

import 'lib/mata_kuliah.dart';
import 'lib/ip_calculator.dart';

void main() {
  final List<MataKuliah> daftarMK = [];

  // Perulangan untuk menerima input dari user sampai nama MK diisi kosong
  while (true) {
    stdout.write('Nama MK : ');
    final nama = stdin.readLineSync() ?? '';
    if (nama.trim().isEmpty) break; // Keluar dari loop jika input kosong

    try {
      stdout.write('SKS     : ');
      final inputSks = stdin.readLineSync() ?? '';
      final sks = validasiSKS(
        inputSks,
      ); // Dipanggil dari lib/ip_calculator.dart

      stdout.write('Nilai   : ');
      final inputNilai = stdin.readLineSync() ?? '';
      final bobot = konversiNilai(
        inputNilai,
      ); // Dipanggil dari lib/ip_calculator.dart

      // Menyimpan data yang sudah valid
      daftarMK.add(
        MataKuliah(
          nama: nama.trim(),
          sks: sks,
          nilai: inputNilai.trim().toUpperCase(),
          bobot: bobot,
        ),
      );
    } on FormatException catch (e) {
      // Menangkap error jika SKS / Nilai salah input
      print('Data diabaikan: ${e.message}\n...');
    }
  }

  if (daftarMK.isEmpty) {
    print('\nTidak ada data mata kuliah yang valid.');
    return;
  }

  // 1. Mengurutkan list mata kuliah secara alfabetis
  urutkanMataKuliah(daftarMK);

  // 2. Menhitung Total SKS dan IP
  final hasil = hitungIP(daftarMK);
  final int totalSKS = hasil['totalSKS'];
  final double ip = hasil['ip'];
  final String predikat = dapatkanPredikat(ip: ip);

  // 3. Menampilkan Ringkasan Hasil
  print('\n----------------------------------------');
  print('Total SKS : $totalSKS');
  print('IP        : ${ip.toStringAsFixed(2)} ($predikat)');

  // 4. Memfilter dan menampilkan MK yang perlu diperbaiki
  final perluDiperbaiki = cariMKPerluDiperbaiki(daftarMK);
  if (perluDiperbaiki.isNotEmpty) {
    final namaMK = perluDiperbaiki.map((e) => e.nama).join(', ');
    print('Perlu diperbaiki: $namaMK');
  }
  print('----------------------------------------');
}
