import 'package:flutter/material.dart';

class TipeKamar {
  const TipeKamar({
    required this.id,
    required this.nama,
    required this.thumbnail,
    required this.harga,
    required this.kapasitas,
    this.foto = const [],
    this.luasRuangan = 0,
    this.ruangTamu = 0,
    this.tipeBed = '',
    this.fasilitasUtamaKamar = const [],
    this.fasilitasKamar = const [],
    this.fiturTambahan = const [],
    this.deskripsi = 'Tidak Ada Deskripsi',
  });

  final String id;
  final String nama;
  final String thumbnail;
  final List<String> foto;
  final int harga;
  final int kapasitas;
  final int ruangTamu;
  final double luasRuangan;
  final String tipeBed;
  final List<FasilitasUtamaKamar> fasilitasUtamaKamar;
  final List<FasilitasKamar> fasilitasKamar;
  final List<FiturTambahan> fiturTambahan;
  final String deskripsi;
}

abstract class Fasilitas {
  final String id;
  final String nama;
  final IconData icon;

  const Fasilitas({
    required this.id,
    required this.nama,
    required this.icon,
  });
}

// Extend the base class for specific classes
class FasilitasUtamaKamar extends Fasilitas {
  const FasilitasUtamaKamar({
    required String id,
    required String nama,
    IconData icon = Icons.star_border_outlined,
  }) : super(id: id, nama: nama, icon: icon);
}

class FasilitasKamar extends Fasilitas {
  const FasilitasKamar({
    required String id,
    required String nama,
    IconData icon = Icons.star_border_outlined,
  }) : super(id: id, nama: nama, icon: icon);
}

class FiturTambahan extends Fasilitas {
  const FiturTambahan({
    required String id,
    required String nama,
    IconData icon = Icons.star_border_outlined,
  }) : super(id: id, nama: nama, icon: icon);
}
