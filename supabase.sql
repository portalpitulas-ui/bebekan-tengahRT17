-- SUPABASE DATABASE SETUP — KAMPUNG BEBEKAN TENGAH
-- Jalankan seluruh file ini di Supabase > SQL Editor.
-- Setelah membuat user admin di Authentication > Users, isi email admin pada bagian terakhir.

create extension if not exists "pgcrypto";

create table if not exists public.admins (
  user_id uuid primary key references auth.users(id) on delete cascade,
  email text unique not null,
  created_at timestamptz default now()
);

create table if not exists public.site_content (
  id int primary key default 1,
  hero_title text default 'KAMPUNG BEBEKAN TENGAH',
  hero_sub text default 'RT 17 / RW 05',
  slogan text default 'Guyub • Rukun • Bersih • Aman • Nyaman',
  welcome text default 'Selamat datang di Website Kampung Bebekan Tengah RT 17 / RW 05.',
  hero_image text default '',
  profile text default 'Kampung Bebekan Tengah merupakan lingkungan masyarakat yang mengedepankan kebersamaan, gotong royong, dan kepedulian antarwarga.',
  history text default '[TULISKAN SEJARAH KAMPUNG DI SINI]',
  kelurahan text default '[ISI DATA]',
  kecamatan text default '[ISI DATA]',
  kota text default '[ISI DATA]',
  provinsi text default 'Jawa Timur',
  updated_at timestamptz default now()
);

insert into public.site_content(id) values (1)
on conflict (id) do nothing;

create table if not exists public.staff (
  id uuid primary key default gen_random_uuid(),
  role text not null,
  name text not null,
  photo_url text default '',
  sort_order int default 0,
  created_at timestamptz default now()
);

create table if not exists public.announcements (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  body text not null,
  date date default current_date,
  created_at timestamptz default now()
);

create table if not exists public.events (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  date date not null,
  time text default '',
  place text default '',
  body text default '',
  created_at timestamptz default now()
);

create table if not exists public.gallery (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  image_url text not null,
  created_at timestamptz default now()
);

create table if not exists public.contact (
  id int primary key default 1,
  leader_name text default '[NAMA KETUA RT]',
  whatsapp text default '[NOMOR WHATSAPP]',
  email text default '[EMAIL]',
  address text default 'Bebekan Tengah RT 17 / RW 05',
  maps_url text default ''
);

insert into public.contact(id) values (1)
on conflict (id) do nothing;

alter table public.admins enable row level security;
alter table public.site_content enable row level security;
alter table public.staff enable row level security;
alter table public.announcements enable row level security;
alter table public.events enable row level security;
alter table public.gallery enable row level security;
alter table public.contact enable row level security;

create or replace function public.is_admin()
returns boolean language sql stable security definer set search_path = public
as $$ select exists(select 1 from public.admins where user_id = auth.uid()); $$;

-- Public can read website data.
create policy "public read site_content" on public.site_content for select using (true);
create policy "public read staff" on public.staff for select using (true);
create policy "public read announcements" on public.announcements for select using (true);
create policy "public read events" on public.events for select using (true);
create policy "public read gallery" on public.gallery for select using (true);
create policy "public read contact" on public.contact for select using (true);

-- Only admin accounts can insert/update/delete.
create policy "admin manage site_content" on public.site_content for all using (public.is_admin()) with check (public.is_admin());
create policy "admin manage staff" on public.staff for all using (public.is_admin()) with check (public.is_admin());
create policy "admin manage announcements" on public.announcements for all using (public.is_admin()) with check (public.is_admin());
create policy "admin manage events" on public.events for all using (public.is_admin()) with check (public.is_admin());
create policy "admin manage gallery" on public.gallery for all using (public.is_admin()) with check (public.is_admin());
create policy "admin manage contact" on public.contact for all using (public.is_admin()) with check (public.is_admin());

-- ADMIN USER:
-- 1) Buat user email/password di Supabase Authentication > Users.
-- 2) Ambil UUID user tersebut.
-- 3) Jalankan:
-- insert into public.admins(user_id,email) values ('UUID_USER','EMAIL_ADMIN');
