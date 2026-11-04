# Scan

## Tujuan
Memindai seluruh kode di folder `lib` (kecuali file `.g.dart` dan `.freezed.dart`) untuk menemukan kode yang bertentangan dengan aturan di `AGENTS.md`.

## Langkah Kerja
1. Baca file `AGENTS.md` dengan teliti dan patuhi aturannya.
2. Pindai semua kode di folder `lib`, abaikan file `.g.dart` dan `.freezed.dart`.
3. Temukan kode yang bertentangan atau tidak sesuai dengan aturan di `AGENTS.md`.
4. Perbarui isi file `task.md` dengan hasil temuan, disusun berdasarkan:
   - Tipe: Bug Runtime, UX, UI.
   - Kategori: Tinggi, Sedang, Rendah.
5. Ikuti format penulisan seperti contoh di bawah.
6. Baca source SDK untuk mengecek dan memberikan solusi; jangan berasumsi liar.
7. Jika ada saran fitur baru, perbarui file `rencana_fitur_baru.md`.
8. Perbaiki task yang tidak sesuai dengan `AGENTS.md`.
9. Dilarang mengedit file `.dart`.

## Larangan
- Dilarang mengedit file `.dart`.

## Ketentuan
- Wajib baca source SDK sebelum memberikan solusi.

## Contoh Format `task.md`

```md
# Bug Runtime

## Tinggi

- status :
- Masalah : tulis masalah
- Solusi : kasih saran solusinya
- file terkait : [nama file1#21](path file#21), [nama file2#50](path file#50)

# UX

## Sedang

- status :
- Masalah : tulis masalah
- Solusi : kasih saran solusinya
- file terkait : [nama file1#21](path file#21), [nama file2#50](path file#50)
```
