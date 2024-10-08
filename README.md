# TUGAS 1 Pemrosesan Citra Digital - IF4073
> Tugas 1: Image Enhancement

## Anggota Kelompok
<table>
    <tr>
        <td>No.</td>
        <td>Nama</td>
        <td>NIM</td>
    </tr>
    <tr>
        <td>1.</td>
        <td>Jason Rivalino</td>
        <td>13521008</td>
    </tr>
    <tr>
        <td>2.</td>
        <td>Juan Christopher Santoso</td>
        <td>13521116</td>
    </tr>
</table>

## Table of Contents
* [Deskripsi Singkat](#deskripsi-singkat)
* [Struktur File](#struktur-file)
* [Requirements](#requirements)
* [Cara Menjalankan Program](#cara-menjalankan-program)
* [Tampilan GUI Program](#tampilan-gui-program)
* [Pembagian Kerja](#pembagian-kerja)
* [Acknowledgements](#acknowledgements)
* [Foto Bersama](#foto-bersama)

## Deskripsi Singkat 
Program yang dibuat dalam tugas ini memiliki kegunaan utama untuk memproses perbaikan kualitas citra dengan berbagai metode. Terdapat beberapa fitur utama yang diimplementasikan dalam pengerjaan Tugas ini antara lain:
1. Menampilkan histogram yang dimiliki oleh citra
2. Perbaikan kualitas citra dengan berbagai metode (Image Brightening, Citra Negatif dan balikannya, transformasi log dan pangkat, dan contrast stretching)
3. Perataan histogram dengan histogram equalizer
4. Penyamaan histogram dengan histogram specification

## Struktur File
```
📦IF4073_Tugas1
 ┣ 📂docs
 ┃ ┗ 📜Tugas1_13521008_13521116.pdf
 ┣ 📂functions
 ┃ ┣ 📂histogram
 ┃ ┃ ┣ 📜equalizer_operation.m
 ┃ ┃ ┣ 📜histogram_calculate.m
 ┃ ┃ ┗ 📜histogram_show.m
 ┃ ┣ 📂image
 ┃ ┃ ┣ 📜normalize_pixel.m
 ┃ ┃ ┣ 📜read_image.m
 ┃ ┃ ┣ 📜search_max_pixel.m
 ┃ ┃ ┣ 📜search_min_pixel.m
 ┃ ┃ ┣ 📜validate_pixel.m
 ┃ ┃ ┗ 📜write_image.m
 ┃ ┣ 📂program
 ┃ ┃ ┣ 📜func_histogram_equalizer.m
 ┃ ┃ ┣ 📜func_histogram_specification.m
 ┃ ┃ ┣ 📜func_img_brightening.m
 ┃ ┃ ┣ 📜func_img_contrast_stretching.m
 ┃ ┃ ┣ 📜func_img_log_transformation.m
 ┃ ┃ ┣ 📜func_img_negative.m
 ┃ ┃ ┗ 📜func_img_power_transformation.m
 ┃ ┗ 📂vector
 ┃ ┃ ┣ 📜get_index_nearest_value.m
 ┃ ┃ ┣ 📜make_cumulative.m
 ┃ ┃ ┣ 📜map_new_hist.m
 ┃ ┃ ┗ 📜sum_value.m
 ┣ 📂img_in
 ┣ 📂img_out
 ┣ 📜image_enhancement.mlapp
 ┣ 📜LICENSE
 ┗ 📜README.md
```

## Requirements
1. Matlab

## Cara Menjalankan Program
Langkah-langkah proses setup program adalah sebagai berikut:
1. Clone repository ini
2. Membuka Matlab lalu masuk ke dalam directory file tempat clone
3. Menjalankan file `image_enhancement.mlapp` yang terdapat pada root directory
4. Menjalankan run setelah file terbuka
5. Program sudah bisa dijalankan

## Tampilan GUI Program
![Screenshot (256)](https://github.com/user-attachments/assets/568047ca-592e-4866-8f3f-c102a96a5226)

## Pembagian Kerja
<table>
    <tr>
        <td>No.</td>
        <td>Nama</td>
        <td>Kontribusi</td>
    </tr>
    <tr>
        <td>1.</td>
        <td>Jason Rivalino</td>
        <td>Pengerjaan visualisasi histogram, Histogram Equalization, laporan</td>
    </tr>
    <tr>
        <td>2.</td>
        <td>Juan Christopher Santoso</td>
        <td>Pengerjaan perbaikan kualitas citra, Histogram Specification, pembuatan GUI, laporan</td>
    </tr>
</table>


## Acknowledgements
- Tuhan Yang Maha Esa
- Pak Rinaldi Munir sebagai Dosen Pemrosesan Citra Digital IF4073

## Foto Bersama
![Screenshot 2024-10-06 224947](https://github.com/user-attachments/assets/b9cb0429-1b90-4d91-8c2d-ad95816b4d7a)
