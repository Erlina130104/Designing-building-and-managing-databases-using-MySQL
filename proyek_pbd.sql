-- Buat database
CREATE DATABASE IF NOT EXISTS Proyek_pbd;
USE Proyek_pbd;

-- Tabel Pengunjung
CREATE TABLE Pengunjung (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nama VARCHAR(50) NOT NULL,
  alamat VARCHAR(100) NOT NULL,
  email VARCHAR(50) NOT NULL,
  no_telepon VARCHAR(20) NOT NULL
);

INSERT INTO Pengunjung (nama, alamat, email, no_telepon) VALUES
('John Doe', 'Jl. Merdeka No. 123', 'johndoe@gmail.com', '08123456789'),
('Jane Smith', 'Jl. Sudirman No. 456', 'janesmith@gmail.com', '08987654321'),
('Mark Johnson', 'Jl. Ahmad Yani No. 789', 'markjohnson@gmail.com', '08567891234'),
('Sarah Williams', 'Jl. Gatot Subroto No. 321', 'sarahwilliams@gmail.com', '08765432109');

-- Tabel Wisata
CREATE TABLE Wisata (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nama VARCHAR(100) NOT NULL,
  kategori VARCHAR(50) NOT NULL,
  alamat VARCHAR(100) NOT NULL,
  deskripsi TEXT,
  harga DECIMAL(10, 2) NOT NULL,
  jam_buka TIME NOT NULL,
  gambar VARCHAR(100)
);

INSERT INTO Wisata (nama, kategori, alamat, deskripsi, harga, jam_buka, gambar) VALUES
('Pantai Indah', 'Pantai', 'Jl. Pantai Indah No. 1', 'Pantai dengan pasir putih dan air jernih.', 50.00, '09:00:00', 'pantai_indah.jpg'),
('Gunung Permai', 'Gunung', 'Jl. Gunung Permai No. 2', 'Gunung dengan pemandangan indah.', 100.00, '07:00:00', 'gunung_permai.jpg'),
('Taman Wisata Alam', 'Taman', 'Jl. Taman Wisata No. 3', 'Taman dengan flora dan fauna.', 20.00, '08:00:00', 'taman_wisata_alam.jpg');

-- Tabel Admin
CREATE TABLE Admin (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nama VARCHAR(50) NOT NULL,
  username VARCHAR(50) NOT NULL,
  password VARCHAR(50) NOT NULL
);

INSERT INTO Admin (nama, username, password) VALUES
('Admin1', 'admin1', 'admin123'),
('Admin2', 'admin2', 'admin456');

-- Tabel Tiket
CREATE TABLE Tiket (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pengunjung_id INT,
  wisata_id INT,
  jumlah_tiket INT NOT NULL,
  tanggal DATE NOT NULL,
  FOREIGN KEY (pengunjung_id) REFERENCES Pengunjung(id),
  FOREIGN KEY (wisata_id) REFERENCES Wisata(id)
);

INSERT INTO Tiket (pengunjung_id, wisata_id, jumlah_tiket, tanggal) VALUES
(1, 1, 2, '2023-05-17'),
(2, 2, 3, '2023-05-18'),
(3, 3, 1, '2023-05-19'),
(4, 1, 4, '2023-05-20');

-- Tabel Ulasan
CREATE TABLE Ulasan (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pengunjung_id INT,
  wisata_id INT,
  rating INT NOT NULL,
  komentar TEXT,
  FOREIGN KEY (pengunjung_id) REFERENCES Pengunjung(id),
  FOREIGN KEY (wisata_id) REFERENCES Wisata(id)
);

INSERT INTO Ulasan (pengunjung_id, wisata_id, rating, komentar) VALUES
(1, 1, 4, 'Pantai Indah sangat menakjubkan!'),
(2, 2, 5, 'Gunung Permai luar biasa dan menantang.'),
(3, 3, 3, 'Taman Wisata menyenangkan untuk keluarga.'),
(4, 1, 2, 'Pantai Indah terlalu ramai dan kotor.');

-- Tabel Kunjungan (Opsional)
CREATE TABLE Kunjungan (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_wisata INT,
  pengunjung_id INT,
  tanggal DATE,
  FOREIGN KEY (id_wisata) REFERENCES Wisata(id),
  FOREIGN KEY (pengunjung_id) REFERENCES Pengunjung(id)
);

INSERT INTO Kunjungan (id_wisata, pengunjung_id, tanggal) VALUES
(1, 1, '2023-01-01'),
(2, 2, '2023-01-02'),
(1, 3, '2023-01-03'),
(3, 4, '2023-01-04'),
(2, 1, '2023-01-05');

-- -------------------------------
-- Query Tunggal (1 Tabel)
-- -------------------------------

-- 1. Semua wisata
SELECT * FROM Wisata;

-- 2. Nama dan harga wisata
SELECT nama, harga FROM Wisata;

-- 3. Total pengunjung yang mengulas
SELECT COUNT(DISTINCT pengunjung_id) AS total_pengunjung FROM Ulasan;

-- 4. Jumlah ulasan per wisata
SELECT wisata_id, COUNT(*) AS jumlah_ulasan FROM Ulasan GROUP BY wisata_id;

-- 5. Wisata dengan total harga tiket > 200
SELECT Wisata.nama, SUM(Tiket.jumlah_tiket * Wisata.harga) AS total_harga
FROM Wisata
JOIN Tiket ON Wisata.id = Tiket.wisata_id
GROUP BY Wisata.id
HAVING total_harga > 200;

-- 6. Tiket yang dipesan pada tanggal tertentu
SELECT tanggal, SUM(jumlah_tiket) AS total_tiket
FROM Tiket
WHERE tanggal = '2023-05-17'
GROUP BY tanggal;

-- 7. Wisata dengan jumlah ulasan > 0
SELECT w.nama, COUNT(u.id) AS jumlah_ulasan
FROM Wisata w
LEFT JOIN Ulasan u ON w.id = u.wisata_id
GROUP BY w.id
HAVING jumlah_ulasan > 0;

-- 8. Wisata dengan deskripsi lebih dari 10 karakter
SELECT * FROM Wisata WHERE LENGTH(deskripsi) > 10;

-- 9. Wisata dengan harga tiket maksimum
SELECT * FROM Wisata WHERE harga = (SELECT MAX(harga) FROM Wisata);

-- 10. Wisata yang buka setelah jam 08:00
SELECT * FROM Wisata WHERE jam_buka > '08:00:00';

-- -------------------------------
-- Query JOIN Antar Tabel
-- -------------------------------

-- 1. Pengunjung dan wisata yang diulas
SELECT p.nama, w.nama AS wisata
FROM Pengunjung p
JOIN Ulasan u ON p.id = u.pengunjung_id
JOIN Wisata w ON u.wisata_id = w.id;

-- 2. Pengunjung dan total tiket yang dibeli
SELECT p.nama, SUM(t.jumlah_tiket) AS total_tiket
FROM Pengunjung p
LEFT JOIN Tiket t ON p.id = t.pengunjung_id
GROUP BY p.id;

-- 3. Semua pengunjung & tempat wisata (termasuk yang belum mengulas)
SELECT p.nama, w.nama AS wisata
FROM Pengunjung p
LEFT JOIN Ulasan u ON p.id = u.pengunjung_id
LEFT JOIN Wisata w ON u.wisata_id = w.id;

-- 4. Wisata dan jumlah ulasan
SELECT w.nama, COUNT(u.id) AS jumlah_ulasan
FROM Wisata w
LEFT JOIN Ulasan u ON w.id = u.wisata_id
GROUP BY w.id;

-- 5. Wisata, tiket terjual, dan total pemasukan
SELECT w.nama, SUM(t.jumlah_tiket) AS total_tiket, SUM(t.jumlah_tiket * w.harga) AS total_harga
FROM Wisata w
LEFT JOIN Tiket t ON w.id = t.wisata_id
GROUP BY w.id;

-- 6. Pengunjung, wisata, dan tanggal kunjungan
SELECT p.nama, w.nama AS wisata, t.tanggal
FROM Pengunjung p
JOIN Tiket t ON p.id = t.pengunjung_id
JOIN Wisata w ON t.wisata_id = w.id;

-- 7. Pengunjung yang memberikan ulasan
SELECT p.nama, w.nama AS wisata
FROM Pengunjung p
JOIN Ulasan u ON p.id = u.pengunjung_id
JOIN Wisata w ON u.wisata_id = w.id;

-- 8. Pengunjung dan jumlah tiket (termasuk yang tidak pesan)
SELECT p.nama, w.nama AS wisata, COALESCE(SUM(t.jumlah_tiket), 0) AS total_tiket
FROM Pengunjung p
LEFT JOIN Tiket t ON p.id = t.pengunjung_id
LEFT JOIN Wisata w ON t.wisata_id = w.id
GROUP BY p.id, w.id;

-- 9. Pengunjung yang membeli tiket dan mengulas
SELECT p.nama, w.nama AS wisata, t.tanggal
FROM Pengunjung p
JOIN Ulasan u ON p.id = u.pengunjung_id
JOIN Wisata w ON u.wisata_id = w.id
JOIN Tiket t ON p.id = t.pengunjung_id AND w.id = t.wisata_id;

-- 10. Wisata yang menerima lebih dari 1 ulasan
SELECT w.nama, COUNT(u.id) AS jumlah_ulasan
FROM Wisata w
LEFT JOIN Ulasan u ON w.id = u.wisata_id
GROUP BY w.id
HAVING jumlah_ulasan > 1;

-- -------------------------------
-- Subquery (5 Contoh)
-- -------------------------------

-- 1. Subquery dalam SELECT
SELECT nama, (SELECT COUNT(*) FROM Tiket WHERE pengunjung_id = p.id) AS jumlah_tiket
FROM Pengunjung p;

-- 2. Subquery dalam WHERE
SELECT nama FROM Pengunjung
WHERE id IN (SELECT pengunjung_id FROM Tiket WHERE tanggal = CURDATE());

-- 3. Subquery dalam FROM
SELECT t1.nama, t2.jumlah_ulasan
FROM (
  SELECT p.nama, COUNT(*) AS jumlah_ulasan
  FROM Pengunjung p
  JOIN Ulasan u ON p.id = u.pengunjung_id
  GROUP BY p.id
) t1
JOIN (
  SELECT p.nama, COUNT(*) AS jumlah_ulasan
  FROM Pengunjung p
  JOIN Ulasan u ON p.id = u.pengunjung_id
  WHERE u.rating > 3
  GROUP BY p.id
) t2 ON t1.nama = t2.nama;

-- 4. Subquery dalam HAVING
SELECT id_wisata, COUNT(*) AS jumlah_pengunjung
FROM Kunjungan
GROUP BY id_wisata
HAVING COUNT(*) > 0;

-- 5. Pengunjung yang pernah tercatat di tabel kunjungan
SELECT nama FROM Pengunjung
WHERE id IN (SELECT pengunjung_id FROM Kunjungan);
