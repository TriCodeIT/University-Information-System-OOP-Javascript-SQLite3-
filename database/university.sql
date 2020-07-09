CREATE TABLE Matakuliah
(
    id_mk CHAR (5) PRIMARY KEY NOT NULL,
    nama_matakuliah VARCHAR (35) NOT NULL,
    jumlah_sks INTEGER NOT NULL
);
INSERT INTO Matakuliah(id_mk,nama_matakuliah,jumlah_sks) VALUES ('MK001','Fisika Kuantum', 4);
INSERT INTO Matakuliah(id_mk,nama_matakuliah,jumlah_sks) VALUES ('MK002','Fisika Komputasi', 3);
INSERT INTO Matakuliah(id_mk,nama_matakuliah,jumlah_sks) VALUES ('MK003','Instrumentasi Cerdas', 4);
INSERT INTO Matakuliah(id_mk,nama_matakuliah,jumlah_sks) VALUES ('MK004','Data Mining', 4);
INSERT INTO Matakuliah(id_mk,nama_matakuliah,jumlah_sks) VALUES ('MK005','Manajemen Data', 3);

CREATE TABLE Jurusan
(
    id_jr CHAR (5) PRIMARY KEY NOT NULL,
    nama_jurusan VARCHAR (20) NOT NULL
);
INSERT INTO Jurusan(id_jr, nama_jurusan) VALUES ('JR001','FISIKA');
INSERT INTO Jurusan(id_jr, nama_jurusan) VALUES ('JR002','ILMU KOMPUTER');
INSERT INTO Jurusan(id_jr, nama_jurusan) VALUES ('JR003','KIMIA');

CREATE TABLE Dosen
(
    id_dos CHAR (6) PRIMARY KEY NOT NULL,
    nama_dosen VARCHAR (50) NOT NULL
);
INSERT INTO Dosen(id_dos, nama_dosen) VALUES ('DOS001','Ahmad Aminudin');
INSERT INTO Dosen(id_dos, nama_dosen) VALUES ('DOS002','Ana Hadiana');
INSERT INTO Dosen(id_dos, nama_dosen) VALUES ('DOS003','Rubi Henjaya');

CREATE TABLE Mahasiswa
(
    nim CHAR (10) PRIMARY KEY NOT NULL,
    nama_mahasiswa VARCHAR (50) NOT NULL,
    alamat TEXT NOT NULL,
    jenis_kelamin VARCHAR (10) NOT NULL,
    umur INTEGER NOT NULL,
    id_jr CHAR (5) NOT NULL,
    FOREIGN KEY (id_jr) REFERENCES Jurusan (id_jr)
);
INSERT INTO Mahasiswa(nim,nama_mahasiswa,alamat,jenis_kelamin,umur,id_jr) VALUES ('2018210020','TRI SUTRISNA BHAYUKUSUMA','Jalan Depok VI Antapani Kota Bandung','Laki-Laki','22','JR001');
INSERT INTO Mahasiswa(nim,nama_mahasiswa,alamat,jenis_kelamin,umur,id_jr) VALUES ('2018210021','JONATHAN','Jalan Cicendo II Kota Bandung','Laki-Laki','18','JR001');
INSERT INTO Mahasiswa(nim,nama_mahasiswa,alamat,jenis_kelamin,umur,id_jr) VALUES ('2018210022','NIRMALA','Jalan Sangkuriang III Kota Bandung','Perempuan','19','JR002');
INSERT INTO Mahasiswa(nim,nama_mahasiswa,alamat,jenis_kelamin,umur,id_jr) VALUES ('2018210023','RAHMANIA','Jalan Aceh IX Kota Bandung','Perempuan','22','JR003');

CREATE TABLE KontrakKuliah
(
    id_kontrak CHAR (5) PRIMARY KEY NOT NULL,
    nim CHAR (10) NOT NULL,
    id_mk CHAR (5) NOT NULL,
    id_dos CHAR (6) NOT NULL,
    nilai TEXT NOT NULL,
    FOREIGN KEY (nim) REFERENCES Mahasiswa (nim),
    FOREIGN KEY (id_mk) REFERENCES Matakuliah (id_mk),
    FOREIGN KEY (id_dos) REFERENCES Dosen (id_dos)
);
INSERT INTO KontrakKuliah(id_kontrak,nim,id_mk,id_dos,nilai) VALUES ('00001','2018210020','MK003','DOS001','A');
INSERT INTO KontrakKuliah(id_kontrak,nim,id_mk,id_dos,nilai) VALUES ('00002','2018210021','MK004','DOS003','B');
INSERT INTO KontrakKuliah(id_kontrak,nim,id_mk,id_dos,nilai) VALUES ('00003','2018210022','MK005','DOS002','A');
INSERT INTO KontrakKuliah(id_kontrak,nim,id_mk,id_dos,nilai) VALUES ('00004','2018210020','MK002','DOS001','C');
INSERT INTO KontrakKuliah(id_kontrak,nim,id_mk,id_dos,nilai) VALUES ('00005','2018210022','MK001','DOS003','A');
INSERT INTO KontrakKuliah(id_kontrak,nim,id_mk,id_dos,nilai) VALUES ('00006','2018210020','MK005','DOS002','A');
INSERT INTO KontrakKuliah(id_kontrak,nim,id_mk,id_dos,nilai) VALUES ('00007','2018210020','MK004','DOS003','B');
INSERT INTO KontrakKuliah(id_kontrak,nim,id_mk,id_dos,nilai) VALUES ('00008','2018210021','MK003','DOS001','D');
INSERT INTO KontrakKuliah(id_kontrak,nim,id_mk,id_dos,nilai) VALUES ('00009','2018210020','MK005','DOS002','E');
INSERT INTO KontrakKuliah(id_kontrak,nim,id_mk,id_dos,nilai) VALUES ('00010','2018210022','MK004','DOS003','E');

CREATE TABLE Login
(
    user VARCHAR(15) PRIMARY KEY NOT NULL,
    password VARCHAR(15) NOT NULL,
    acces CHAR(5) NOT NULL
); 

INSERT INTO login(user, password, acces) VALUES ('tricodeit','tri165','admin');

--NO.1 Tampilkan Seluruh Data Mahasiswa beserta Nama Jurusannya
SELECT * FROM Mahasiswa NATURAL JOIN Jurusan WHERE Jurusan.id_jr = Mahasiswa.id_jr;

--NO.2 Tampilkan Mahasiswa yang memiliki umur dibawah 20 tahun
SELECT nama_mahasiswa,umur FROM Mahasiswa WHERE umur <20;

--NO.3 Tampilkan Mahasiswa yang memiliki nilai 'B' ke atas
SELECT * FROM KontrakKuliah NATURAL JOIN Mahasiswa WHERE nilai < 'B';

--NO.4 Tampilkan Mahasiswa yang memiliki jumlah SKS lebih dari 10
SELECT nama_mahasiswa,sum(jumlah_sks) FROM KontrakKuliah NATURAL JOIN Matakuliah NATURAL JOIN Mahasiswa group by nim HAVING sum(jumlah_sks) > 10;

--N0.5 Tampilkan mahasiswa yang mengontrak mata kuliah 'data mining'
SELECT nama_mahasiswa,umur,nilai,nama_matakuliah,nama_dosen FROM KontrakKuliah NATURAL JOIN Mahasiswa NATURAL JOIN Matakuliah NATURAL JOIN Dosen WHERE nama_matakuliah = 'Data Mining'; 

--NO.6 Tampilkan jumlah mahasiswa untuk setiap dosen
SELECT nama_dosen,count(DISTINCT nama_mahasiswa)jumlah_mahasiswa FROM KontrakKuliah NATURAL JOIN Dosen NATURAL JOIN Mahasiswa group by id_dos;

--NO.7 Urutkan Mahasiswa Berdasarkan Umurnya
SELECT * FROM Mahasiswa ORDER BY umur asc;

--NO.8 Tampilkan Kontrak Mata Kuliah yang harus Diulang (Nilai D dan E), Serta Tampilkan Data Mahasiswa Jurusan dan Dosen
SELECT * FROM KontrakKuliah NATURAL JOIN Mahasiswa NATURAL JOIN Dosen NATURAL JOIN Matakuliah NATURAL JOIN Jurusan WHERE nilai > 'C';