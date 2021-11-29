# Tugas Besar IF2121 Logika Komputasional Kelompok Surya-Pro-Log

## 13520059 - Suryanto
## 13520070 - Raden Haryosatyo Wisjnunandono
## 13520108 - Muhammad Rakha Athaya
## 13520110 - Farrel Ahmad

<br>

# Table of Contents
- [Introduction](#intro)
- [Program Setup](#PS)

<br>


# Introduction <a name="intro"></a>
Program ini adalah program permainan sederhana dalam bahasa pemrograman Prolog yang pemainnya dapat memilih 3 role yang dapat dipilih. Role ini adalah farmer, rancher, dan fisherman. Masing-masing memiliki kelebihan pada job yang bersesuaian dengan nama role nya. Tujuan dari permainan ini adalah mengumpulkan 20.000 gold atau lebih dalam waktu satu tahun (365 hari).

<br>

# Program Setup <a name="PS"></a>
1. Clone repository ini ke komputer anda.
```sh
$ git clone https://github.com/SurTan02/Surya-Pro-Log.git
```

2. Untuk **Windows**, buka GNU prolog, kemudian click `File`. Setelah itu click `consult`  dan carilah directory `/Surya-Pro-Log` hasil clone repository. Setelah itu click `main.pl`

3. Untuk **Linux**, pindah ke directory `/Surya-Pro-Log` dan jalankan gprolog. Pastikan GNU Prolog sudah terinstall. Command setup adalah sebagai berikut.
```sh
$ cd Surya-Pro-Log
$ gprolog
| ?- consult('main.pl').
```

4. Setelah code berhasil di compile, program sudah dapat dijalankan. Untuk memulai permainan, jalankan command berikut.
```sh
| ?- start.
```

5. Untuk mengetahui command apa saja yang tersedia, dapan menggunakan command `help.`.
```sh
| ?- help.
```

6. Setelah menjalankan command `start` akan muncul tampilan sebagai berikut untuk memilih role pemain. Untuk memilih, tulislah role yang ingin dipilih dengan namanya. Seperti `fisherman.` atau `rancher.` atau `farmer.` sebagai input. Contoh di bawah ini memilih `rancher.`
```sh
| ?- start.
Game Started
Welcome to Harvest Star. Choose your job!
1. fisherman
2. rancher
3. farmer
>>> rancher.
```

7. Setelah memilih role, akan muncul tampilan sebagai berikut, gunakan `help.` untuk mengetahui list of commands.
```sh
>>> rancher.

You choose rancher, let's start working
Day             : 1    
Energy          : 150/150
Gold            : 100
Player Level    : 1
Player Exp      : 0/100
Fishing Level   : 1
Fishing Exp     : 0/100
Ranching Level  : 1
Ranching Exp    : 0/100
Farming Level   : 1
Farming Exp     : 0/100
Luck            : 1
Quest Progress  : You are currently not doing any Quest.

What do you want to do : 
>>> 
```

8. Terdapat beberapa job yang dapat dilakukan, seperti farming, ranching dan fishing. Masing-masing dapat menghasilkan barang tertentu yang dapat dijual. Selain itu, melakukan job-job yang ada dapat menambah EXP.

9. Selamat bermain ^^
