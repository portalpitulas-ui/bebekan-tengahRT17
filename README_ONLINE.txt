KAMPUNG BEBEKAN TENGAH — PAKET SIAP ONLINE
===========================================

Paket ini sudah berisi website publik, dashboard admin, database Supabase, dan GitHub Pages workflow.

YANG SUDAH SIAP
- index.html       : website publik
- admin.html       : dashboard admin
- supabase.sql     : struktur database + RLS
- config.js        : tempat Project URL + Publishable/anon key
- .nojekyll        : agar GitHub Pages menyajikan file statis langsung
- .github/workflows/pages.yml : deploy otomatis GitHub Pages

YANG MASIH WAJIB DILAKUKAN DI AKUN ANDA
1. Buat project Supabase.
2. Jalankan seluruh supabase.sql di SQL Editor.
3. Buat akun admin di Authentication > Users.
4. Masukkan user admin ke tabel public.admins sesuai instruksi di README.txt.
5. Salin Project URL dan Publishable key (atau anon key lama) ke config.js.
6. Buat repository GitHub public, upload semua isi folder ini ke branch main.
7. Settings > Pages > Source: GitHub Actions.
8. Tunggu deployment selesai. Link akan tampil di Settings > Pages.

PENTING KEAMANAN
- Jangan pernah memasukkan service_role/secret key ke config.js.
- Publishable/anon key memang dapat berada di browser, tetapi keamanan database tetap harus berasal dari RLS.

BILA HANYA INGIN WEBSITE TAMPIL DULU
Website ini membutuhkan Supabase untuk memuat data dinamis. Jadi konfigurasi Supabase harus diisi sebelum situs publik berfungsi penuh.
