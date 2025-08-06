Designing building and managing databases using MySQL
Proyek Database Wisata – Sistem Tiket & Ulasan
Proyek ini adalah implementasi sistem database pariwisata menggunakan MySQL yang mencakup pengelolaan pengunjung, tempat wisata, transaksi tiket, ulasan, dan data admin. Proyek ini juga mencakup lebih dari 25 query SQL untuk kebutuhan laporan dan analisis data.
 Fitur Utama
- Menyimpan dan mengelola data wisata, pengunjung, tiket, ulasan, dan admin
- Relasi antar tabel dengan foreign key
- Menyisipkan data dummy (contoh)
- Menyediakan berbagai query SQL:
  - SELECT
  - JOIN (INNER, LEFT, RIGHT)
  - Subquery
  - Aggregate + GROUP BY + HAVING
  Struktur Tabel
-	Pengunjung: Menyimpan data pribadi pengunjung seperti nama, alamat, email, dan nomor telepon.
-	Wisata: Berisi informasi tempat wisata, termasuk nama, kategori, alamat, deskripsi, harga tiket, jam buka, dan gambar.
-	Tiket: Mencatat transaksi pemesanan tiket oleh pengunjung, termasuk jumlah tiket dan tanggal kunjungan.
-	Ulasan: Menyimpan rating dan komentar dari pengunjung terhadap tempat wisata.
-	Admin: Data administrator sistem, termasuk username dan password.
-	Kunjungan (opsional): Data kunjungan manual yang mencatat pengunjung yang datang ke tempat wisata tanpa memesan tiket secara sistematis.
 Cara Menjalankan
1. Buka MySQL Workbench atau phpMyAdmin
2. Import / jalankan isi file proyek_pbd.sql
3. Database Proyek_pbd akan otomatis dibuat beserta tabel dan data dummy
4. Jalankan query-query yang tersedia untuk melihat hasil

