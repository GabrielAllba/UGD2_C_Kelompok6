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
}

class FasilitasUtamaKamar {
  const FasilitasUtamaKamar({
    required this.id,
    required this.nama,
    required this.icon,
  });

  final String id;
  final String nama;
  final IconData icon;
}

class FasilitasKamar {
  const FasilitasKamar({
    required this.id,
    required this.nama,
  });

  final String id;
  final String nama;
}

class FiturTambahan {
  const FiturTambahan({
    required this.id,
    required this.nama,
    required this.icon,
  });
  final String id;
  final String nama;
  final IconData icon;
}
