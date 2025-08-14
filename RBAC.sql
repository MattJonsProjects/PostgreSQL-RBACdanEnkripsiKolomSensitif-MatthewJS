-- 1. Buat database
\c postgres;
CREATE DATABASE toko_online;
\c toko_online;

-- 2. Aktifkan ekstensi pgcrypto
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- 3. Buat tabel pelanggan
CREATE TABLE pelanggan (
    id SERIAL PRIMARY KEY,
    nama TEXT,
    email BYTEA,
    nomor_ktp BYTEA
);

-- 4. Tambahkan data terenkripsi
INSERT INTO pelanggan (nama, email, nomor_ktp)
VALUES
('Andi', pgp_sym_encrypt('andi@example.com', 'kunci_rahasia')::bytea, pgp_sym_encrypt('1234567890123456', 'kunci_rahasia')::bytea),
('Budi', pgp_sym_encrypt('budi@example.com', 'kunci_rahasia')::bytea, pgp_sym_encrypt('9876543210987654', 'kunci_rahasia')::bytea);

-- 5. Buat role & user
CREATE ROLE role_admin;
CREATE ROLE role_viewer;

CREATE USER user_admin WITH PASSWORD 'admin123';
CREATE USER user_viewer WITH PASSWORD 'viewer123';

GRANT role_admin TO user_admin;
GRANT role_viewer TO user_viewer;

-- 6. Atur hak akses
GRANT ALL PRIVILEGES ON TABLE pelanggan TO role_admin;   -- admin full akses
REVOKE ALL ON pelanggan FROM PUBLIC;                    -- cabut hak default
GRANT SELECT (id, nama) ON pelanggan TO role_viewer;     -- viewer hanya id & nama
