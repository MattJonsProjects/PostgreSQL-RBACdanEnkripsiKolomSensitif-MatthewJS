-- Contoh Enkripsi
INSERT INTO pelanggan (nama, email, nomor_ktp)
VALUES (
    'Charlie',
    pgp_sym_encrypt('charlie@example.com', 'kunci_rahasia')::bytea,
    pgp_sym_encrypt('1111222233334444', 'kunci_rahasia')::bytea
);

-- Contoh Dekripsi (Khusus Admin) 
SELECT
    id,
    nama,
    pgp_sym_decrypt(email, 'kunci_rahasia') AS email_asli,
    pgp_sym_decrypt(nomor_ktp, 'kunci_rahasia') AS ktp_asli
FROM pelanggan;
