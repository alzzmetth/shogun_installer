# Shogun – User Guide

Dokumen ini menjelaskan tata cara penggunaan Shogun secara sistematis, mulai dari persiapan lingkungan hingga proses instalasi paket.

Shogun adalah sistem installer berbasis repository yang digunakan untuk mendistribusikan dan memasang binary package dengan mekanisme verifikasi integritas menggunakan SHA256.

---

# 1. Persyaratan Sistem

Sebelum menggunakan Shogun, pastikan sistem memenuhi ketentuan berikut:

- Python versi 3.8 atau lebih tinggi
- pip aktif dan dapat diakses melalui terminal
- Koneksi internet stabil
- File executable `shogun` atau `shogun.exe` telah tersedia

Untuk memeriksa versi Python:

```bash
python --version
```

atau

```bash
python3 --version
```

---

# 2. Instalasi Dependency

Shogun memerlukan beberapa dependency Python agar dapat berjalan dengan baik.

Jalankan perintah berikut pada direktori utama project:

```bash
./build.sh
```

Script tersebut akan:

1. Mendeteksi sistem operasi
2. Mendeteksi interpreter Python
3. Memastikan pip tersedia
4. Menginstall dependency:
   - rich
   - requests
5. Memvalidasi module bawaan:
   - json
   - ssl

Jika proses selesai tanpa error, Shogun siap digunakan.

---

# 3. Menjalankan Shogun

## Windows

```bash
shogun.exe
```

## Linux / macOS

```bash
./shogun
```

## Jika menggunakan versi Python langsung

```bash
python main.py
```

Pastikan executable berada di direktori yang benar atau sudah ditambahkan ke PATH.

---

# 4. Penggunaan Perintah

## 4.1 Mencari Package

Gunakan perintah berikut untuk mencari package dalam repository:

```bash
shogun search <keyword>
```

Contoh:

```bash
shogun search qemu
```

Output akan menampilkan:

- Nama package
- Versi
- Arsitektur
- Status verifikasi

---

## 4.2 Melihat Informasi Package

Untuk melihat detail metadata suatu package:

```bash
shogun info <package>
```

Contoh:

```bash
shogun info openjdk
```

Informasi yang ditampilkan:

- Nama package
- Versi
- Arsitektur
- Ukuran file
- SHA256
- Status verifikasi
- URL sumber unduhan

Disarankan untuk meninjau informasi package sebelum instalasi.

---

## 4.3 Menginstall Package

Untuk melakukan instalasi package:

```bash
shogun install <package>
```

Contoh:

```bash
shogun install openjdk
```

---

# 5. Alur Instalasi




---

# 6. Mekanisme Verifikasi

Setiap package memiliki nilai SHA256 dalam repository.

Proses verifikasi memastikan:

- File tidak rusak
- File tidak dimodifikasi
- File sesuai dengan metadata repository

Status verifikasi akan ditampilkan pada hasil pencarian dan informasi package.

---

# 7. Troubleshooting

Jika terjadi kendala:

- Pastikan koneksi internet stabil
- Pastikan dependency telah terinstall
- Jalankan kembali `./build.sh`
- Periksa apakah package tersedia dalam repository
- Pastikan executable memiliki izin eksekusi

Untuk Linux/macOS jika terjadi masalah izin:

```bash
chmod +x shogun
```

---

# 8. Ringkasan Penggunaan

Langkah umum penggunaan Shogun:

1. Install dependency
2. Jalankan Shogun
3. Cari package
4. Periksa informasi
5. Install package

Alur sistem:

Search → Info → Install → Verify → Execute

---

Dokumentasi ini mencakup seluruh prosedur penggunaan Shogun yang tersedia saat ini.
