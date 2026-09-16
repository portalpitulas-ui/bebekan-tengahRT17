VERSI ONLINE — KAMPUNG BEBEKAN TENGAH
==========================================

File:
- index.html   = website publik
- admin.html    = dashboard admin
- config.js     = URL + anon key Supabase
- supabase.sql  = database + RLS/security
- README.txt   = panduan

CARA MENJADIKAN ONLINE:
1. Buat akun/project di Supabase.
2. Buka SQL Editor, jalankan seluruh supabase.sql.
3. Di Authentication > Users, buat user email + password untuk admin.
4. Ambil UUID user tersebut.
5. Di SQL Editor jalankan:
   insert into public.admins(user_id,email)
   values ('UUID_USER','EMAIL_ADMIN');
6. Buka Project Settings > API dan salin Project URL serta anon public key.
7. Isi config.js:
   window.SUPABASE_URL = "https://....supabase.co";
   window.SUPABASE_ANON_KEY = "eyJ...";
8. Upload folder ini ke hosting statis (Netlify, Vercel, GitHub Pages, atau hosting biasa).
9. Website publik = index.html
10. Dashboard admin = admin.html

KEAMANAN:
- Password admin ditangani Supabase Auth, bukan disimpan di JavaScript.
- RLS membatasi perubahan database hanya untuk user yang ada di tabel admins.
- Kunci yang dipakai di browser adalah anon/public key; jangan masukkan service_role key ke file.

CATATAN:
Versi ini menggunakan URL foto untuk galeri. Jika Anda ingin, tahap berikutnya bisa dibuatkan upload foto langsung dari dashboard ke Supabase Storage.
