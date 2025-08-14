//Login sebagai user_admin
SELECT
    id,
    nama,
    pgp_sym_decrypt(email, 'kunci_rahasia') AS email_asli,
    pgp_sym_decrypt(nomor_ktp, 'kunci_rahasia') AS ktp_asli
FROM pelanggan;

//Login sebagai user_viewer
SELECT * FROM pelanggan;

//Query yang diizinkan untuk viewer
SELECT id, nama FROM pelanggan;
