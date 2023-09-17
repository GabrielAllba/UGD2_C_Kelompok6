import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/models/tipe_kamar.dart';

const tipeKamar = [
  TipeKamar(
      id: '1',
      nama: 'Premium',
      thumbnail: 'images/thumbnail.jpg',
      harga: 550000,
      kapasitas: 20,
      fasilitasUtamaKamar: [
        FasilitasUtamaKamar(
            id: '1', nama: 'Makan Pagi', icon: Icons.breakfast_dining_outlined),
        FasilitasUtamaKamar(
            id: '2', nama: 'Wifi', icon: Icons.wifi_calling_3_outlined),
        FasilitasUtamaKamar(
            id: '3',
            nama: 'Ruangan Bebas Rokok',
            icon: Icons.smoke_free_outlined),
      ],
      fasilitasKamar: [
        FasilitasKamar(
          id: '1',
          nama: 'AC',
        ),
        FasilitasKamar(id: '2', nama: 'Air Mineral'),
        FasilitasKamar(id: '3', nama: 'Pembuat Teh / Kopi'),
        FasilitasKamar(id: '4', nama: 'Televisi'),
        FasilitasKamar(id: '5', nama: 'Balcon'),
        FasilitasKamar(id: '6', nama: 'Meja Belajar'),
      ],
      fiturTambahan: [
        FiturTambahan(id: '1', nama: 'Shower', icon: Icons.shower_outlined),
        FiturTambahan(id: '2', nama: 'Bangku', icon: Icons.chair_alt_outlined),
      ],
      foto: [
        'images/thumbnail.jpg',
        'images/thumbnail-2.jpg',
        'images/thumbnail.jpg',
        'images/thumbnail-2.jpg',
        'images/background.jpg',
        'images/detail.jpg',
      ],
      luasRuangan: 25.5,
      ruangTamu: 2,
      tipeBed: '3 King Bed',
      deskripsi:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
  TipeKamar(
    id: '2',
    nama: 'Deluxe',
    thumbnail: 'images/thumbnail-2.jpg',
    harga: 650000,
    kapasitas: 25,
    fasilitasUtamaKamar: [
      FasilitasUtamaKamar(
          id: '1', nama: 'Makan Pagi', icon: Icons.breakfast_dining_outlined),
      FasilitasUtamaKamar(
          id: '2', nama: 'Wifi', icon: Icons.wifi_calling_3_outlined),
      FasilitasUtamaKamar(
          id: '3',
          nama: 'Ruangan Bebas Rokok',
          icon: Icons.smoke_free_outlined),
    ],
    fasilitasKamar: [
      FasilitasKamar(
        id: '1',
        nama: 'AC',
      ),
      FasilitasKamar(id: '2', nama: 'Air Mineral'),
      FasilitasKamar(id: '3', nama: 'Pembuat Teh / Kopi'),
      FasilitasKamar(id: '4', nama: 'Televisi'),
      FasilitasKamar(id: '5', nama: 'Balcon'),
      FasilitasKamar(id: '6', nama: 'Meja Belajar'),
    ],
    fiturTambahan: [
      FiturTambahan(id: '1', nama: 'Shower', icon: Icons.shower_outlined),
      FiturTambahan(id: '2', nama: 'Bangku', icon: Icons.chair_alt_outlined),
    ],
    foto: [
      'images/thumbnail.jpg',
      'images/thumbnail-2.jpg',
      'images/thumbnail-3.jpg',
      'images/thumbnail-4.jpg',
      'images/thumbnail-5.jpg',
    ],
    luasRuangan: 25.5,
    ruangTamu: 2,
    tipeBed: '3 King Bed',
  ),
  TipeKamar(
      id: '3',
      nama: 'Super Deluxe',
      thumbnail: 'images/thumbnail-3.jpg',
      harga: 650000,
      kapasitas: 30,
      fasilitasUtamaKamar: [
        FasilitasUtamaKamar(
            id: '1', nama: 'Makan Pagi', icon: Icons.breakfast_dining_outlined),
        FasilitasUtamaKamar(
            id: '2', nama: 'Wifi', icon: Icons.wifi_calling_3_outlined),
        FasilitasUtamaKamar(
            id: '3',
            nama: 'Ruangan Bebas Rokok',
            icon: Icons.smoke_free_outlined),
      ],
      fasilitasKamar: [
        FasilitasKamar(
          id: '1',
          nama: 'AC',
        ),
        FasilitasKamar(id: '2', nama: 'Air Mineral'),
        FasilitasKamar(id: '3', nama: 'Pembuat Teh / Kopi'),
        FasilitasKamar(id: '4', nama: 'Televisi'),
        FasilitasKamar(id: '5', nama: 'Balcon'),
        FasilitasKamar(id: '6', nama: 'Meja Belajar'),
      ],
      fiturTambahan: [
        FiturTambahan(id: '1', nama: 'Shower', icon: Icons.shower_outlined),
        FiturTambahan(id: '2', nama: 'Bangku', icon: Icons.chair_alt_outlined),
      ],
      foto: [
        'images/thumbnail.jpg',
        'images/thumbnail-2.jpg',
        'images/thumbnail-3.jpg',
        'images/thumbnail-4.jpg',
        'images/thumbnail-5.jpg',
      ],
      luasRuangan: 25.5,
      ruangTamu: 2,
      tipeBed: '3 King Bed',
      deskripsi:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
  TipeKamar(
      id: '4',
      nama: 'Rich Deluxe',
      thumbnail: 'images/thumbnail-4.jpg',
      harga: 750000,
      kapasitas: 5,
      fasilitasUtamaKamar: [
        FasilitasUtamaKamar(
            id: '1', nama: 'Makan Pagi', icon: Icons.breakfast_dining_outlined),
        FasilitasUtamaKamar(
            id: '2', nama: 'Wifi', icon: Icons.wifi_calling_3_outlined),
        FasilitasUtamaKamar(
            id: '3',
            nama: 'Ruangan Bebas Rokok',
            icon: Icons.smoke_free_outlined),
      ],
      fasilitasKamar: [
        FasilitasKamar(
          id: '1',
          nama: 'AC',
        ),
        FasilitasKamar(id: '2', nama: 'Air Mineral'),
        FasilitasKamar(id: '3', nama: 'Pembuat Teh / Kopi'),
        FasilitasKamar(id: '4', nama: 'Televisi'),
        FasilitasKamar(id: '5', nama: 'Balcon'),
        FasilitasKamar(id: '6', nama: 'Meja Belajar'),
      ],
      fiturTambahan: [
        FiturTambahan(id: '1', nama: 'Shower', icon: Icons.shower_outlined),
        FiturTambahan(id: '2', nama: 'Bangku', icon: Icons.chair_alt_outlined),
      ],
      foto: [
        'images/thumbnail.jpg',
        'images/thumbnail-2.jpg',
        'images/thumbnail-3.jpg',
        'images/thumbnail-4.jpg',
        'images/thumbnail-5.jpg',
      ],
      luasRuangan: 25.5,
      ruangTamu: 2,
      tipeBed: '3 King Bed',
      deskripsi:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
  TipeKamar(
    id: '5',
    nama: 'Super Rich Deluxe',
    thumbnail: 'images/thumbnail-5.jpg',
    harga: 850000,
    kapasitas: 15,
    fasilitasUtamaKamar: [
      FasilitasUtamaKamar(
          id: '1', nama: 'Makan Pagi', icon: Icons.breakfast_dining_outlined),
      FasilitasUtamaKamar(
          id: '2', nama: 'Wifi', icon: Icons.wifi_calling_3_outlined),
      FasilitasUtamaKamar(
          id: '3',
          nama: 'Ruangan Bebas Rokok',
          icon: Icons.smoke_free_outlined),
    ],
    fasilitasKamar: [
      FasilitasKamar(
        id: '1',
        nama: 'AC',
      ),
      FasilitasKamar(id: '2', nama: 'Air Mineral'),
      FasilitasKamar(id: '3', nama: 'Pembuat Teh / Kopi'),
      FasilitasKamar(id: '4', nama: 'Televisi'),
      FasilitasKamar(id: '5', nama: 'Balcon'),
      FasilitasKamar(id: '6', nama: 'Meja Belajar'),
    ],
    fiturTambahan: [
      FiturTambahan(id: '1', nama: 'Shower', icon: Icons.shower_outlined),
      FiturTambahan(id: '2', nama: 'Bangku', icon: Icons.chair_alt_outlined),
    ],
    foto: [
      'images/thumbnail.jpg',
      'images/thumbnail-2.jpg',
      'images/thumbnail-3.jpg',
      'images/thumbnail-4.jpg',
      'images/thumbnail-5.jpg',
    ],
    luasRuangan: 25.5,
    ruangTamu: 2,
    tipeBed: '3 King Bed',
  ),
];
