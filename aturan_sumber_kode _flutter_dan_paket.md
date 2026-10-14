**Peringatan**
***AI diwajibkan patuhi semua aturan ini***

# Global

1. AI diwajibkan selalu mencari data nya dari `github` atau `dokumen terkait`
   jika masih tidak di temukan bilang kesaya, lalu beritahu saya kode apa saja
   yang di butuhkan biar saya berikan kode sumber dari flutter dan paket paket
   yang terinstall
2. alur kerjanya, semisal kita ingin mengerjakan kode di projek saya ini AI
   wajib mencari dulu dengan rg atau ripgrep sebagai tool pencarian utama, kalau rg atau ripgrep ini tidak bisa jalan, maka gunakan tools yang bisa jalan saja.
3. dilarang berasumsi liar harus selalu merujuk ke file file yang ada di flutter
   dan pub.cache saja.
4. setelah mengerjakan tugas diwajibkan menjalankan flutter analyze.
5. selalu baca dahulu file terkait dan file SDK nya agar selalu mendapatkan kode
   yang sesuai dengan yang terinstall demi atasi bug runtime.
6. perintah cek atau baca : ketika saya ketik prompt cek atau baca maka AI
   diwajibkan baca ulang semu file file saya jadi jangan gunakan dari cache AI.
7. To-dos : selalu gunakan To-dos agar AI tidak lupa langkah langkah nya.
8. file dependency: selalu cari file terkait agar tidak ada asumsi liar. Jika AI
   tidak bisa mengakses proyek saya, AI hanya memberi daftar file yang
   dibutuhkan, tanpa penjelasan, dalam satu code block `txt` dengan aturan:
   - satu path per baris, relatif dari root proyek, diawali `lib/`, `supabase/`,
     atau `PRD/`
   - tanpa bullet, nomor, backtick, `./`, `../`, atau komentar
   - tanpa duplikat
   - gabungkan semua file dari jawaban sebelumnya menjadi satu daftar
9. bahasa indonesia : AI wajib menggunakan bahasa indonesia saat berdiskusi
   dengan saya, serta untuk penamaan variabel, parameter, konstruktor, nama
   fungsi, nama class, nama method, nama geter, nama provider.

# aturan lainnya untuk AI yang tidak bisa menyentuh projek karena ketrbatasan

1. kode perbaikan : kalau AI memberitahu saya kode mana yang di edit itu wajib
   menyertakan potongan kode yang sebelum dan sesudah, jadi saya bisa analisa
   dulu sebelum saya terapkan lalu sertakan komentar dismaping nya itu

# Larangan

1. dilarang menyentuh kode yang diluar topik,
2. dilarang melawan perintah saya, anda cukup berikan sran saja dan tetap
   kerjakan apa yang saya perintahkan.

# kewajiban

1. harus selalu baca ulang semua file yang terkait atau file yang saya kirimkan
   jangan baca dari cache

# PRD

- semua kode harus sesuai dengan isi didalam PRD.
- konflik : jika terjadi konflik misalnya di kode ada `harus a` tapi di PRD
  `harus b` maka AI waib tanyakan ke saya untuk konfirmasi.
- hasil : karena PRD dan kode bisa basi jadi AI harus tanyakan kesaya terlebih
  dahulu apakah PRd nya sudah sesuai.
- kurang jelas : jikalau sebuah PRD membuat AI kurang jelas tolong beritahu saya
  nanti akan saya ubah PRD nya.
- larangan : dilarang merubah file PRD tanpa persetujuan karan itu akan
  berakibat fatal kehasil nya nanti.

# MCP server Dart/Flutter
- aturan ini hanya untuk file file yang berkaitan dengar dart dan flutter saja.
- AI diwajibkan agar selalu menggunakan mcp server dart/flutter untuk menegerjakan tugas.
- yang tidak boleh dilakukan hanya dart_analyze_files, jadi untuk analisis cukup pakai flutter analyze via CLI.
- pencarian file proyek tetap pakai rg/ripgrep/grep/glob; rip_grep_packages hanya untuk kode paket di pub cache.
- sebelum mengerjakan tugas, AI wajib baca ulang source code paket/SDK yang terkait via MCP (read_package_uris), tidak boleh pakai ingatan atau cache.
