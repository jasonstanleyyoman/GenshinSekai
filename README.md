# Genshin Sekai
> Tugas Besar IF2121 Logika Komputasional - Survival Role-Playing Game\
> [Spesifikasi Tubes](https://docs.google.com/document/d/1JDcjBHJrpvziRA3XemN6f3VS_PnY2-MEeJAfmjFqZd0/edit) | [Laporan](https://docs.google.com/document/d/13Jqg5ESk7mf3DLDo3mh9mspo95Vg0vY6iwHdSg7WyY4/edit)

The year is 3092. Humanity has survived through countless trials. Nuclear wars, reactor blasts, exposure to radioactive components have caused all the lifeforms on earth to mutate into something else. Octopi that couldn't adapt itself to the situation had learnt to live with a developed slimy skin. Their anatomy resembles fully of a slime. Because of the look, people named them slimes, just like their physical look. Some humans who were exposed to too much radiation had died of severe health condition. Some who were able to survive developed a longer and sharper ears, their height decreased, and their skin turned green. They were given the name goblins because of their physical look. Wolves didn\'t evolve much, but they became much more aggressive.

### Spesifikasi Lingkungan
**Melalui GNU Prolog Compiler**\
Lakukan install GNU Prolog compiler. Untuk download file installer, bisa melalui [link ini](http://www.gprolog.org/#download) (Windows saja) atau melalui [website resmi GNU Prolog](http://www.gprolog.org/#download). 

**Melalui Terminal Linux**
1. Buka terminal
2. Tambahkan ppa:swi-prolog/stable ke dalam sistem dengan command berikut
```
sudo add-apt-repository ppa:swi-prolog/stable
sudo apt-get update
```
3. Lakukan install SWI-Prolog dengan command berikut
```
sudo apt-get install swi-prolog
```

### Cara Menggunakan
Clone Repository
``` 
https://github.com/jasonstanleyyoman/GenshinSekai.git 
```
Cara membuka file :\
**Melalui GNU Prolog Compiler**
1. Buka GNU Prolog Compile
2. Tekan File > Consult...
3. Buka file berikut
``` 
...\GenshinSekai\src\main.pl 
```
atau 
2. Tekan File > Change Dir...
3. Masuk ke folder repository yang sudah di clone. Kemudian masuk folder src
4. Jalankan command berikut pada GNU Prolog
```
consult('main').
````
**Melalui Terminal Linux**
1. Open directory folder repository yang sudah di clone. Kemudian masuk folder src
2. Masukkan command berikut untuk menjalankan program
```
swipl -s main.pl
```
\
Setelah file berhasil dibuka, lanjutkan dengan tahapan berikut.
1. Masukkan command `start.` (dengan titik) untuk memulai game
2. Gunakan command `help.` apabila memerlukan bantuan di dalam game\
*Catatan : Apabila menemui pertanyaan seperti `true?`(GNU Prolog Compiler) atau `true `(Terminal Linux) langsung tekan enter tanpa mengetik apapun. Game akan berjalan dengan normal.*

### Credits
Created by [@kevinryann](https://github.com/kevinryann), [@Reinaldo16519320](https://github.com/Reinaldo16519320), [@jasonstanleyyoman](https://github.com/jasonstanleyyoman), dan [@salyamevia](https://github.com/salyamevia).

