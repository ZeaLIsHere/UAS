program Raja_Akademik;
uses crt;

const
    mahasiswa_ilkom24 = 100;

type
    TMahasiswa = record
        nama: string[50];
        nilaiuas: real;
        nilaiuts: real;
        nilaikuis: real;
        nilaiharian: real;
        nilai: real; // Nilai total
    end;

var
    dataMahasiswa: array[1..mahasiswa_ilkom24] of TMahasiswa;
    jumlahMahasiswa: integer;

procedure InputData(var data: array of TMahasiswa; var jumlah: integer);
var
    i: integer;
begin
    write('Masukkan jumlah mahasiswa (maks 100): ');
    readln(jumlah);
    if (jumlah < 1) or (jumlah > mahasiswa_ilkom24) then
    begin
        writeln('Jumlah mahasiswa tidak valid!');
        exit;
    end;

    for i := 1 to jumlah do
    begin
        writeln('Mahasiswa ke-', i);
        write('Nama: ');
        readln(data[i].nama);
        write('Nilai UAS: ');
        readln(data[i].nilaiuas);
        write('Nilai UTS: ');
        readln(data[i].nilaiuts);
        write('Nilai Kuis: ');
        readln(data[i].nilaikuis);
        write('Nilai Harian: ');
        readln(data[i].nilaiharian);

        // Hitung nilai total
        data[i].nilai := (data[i].nilaiuas * 0.15) +
                         (data[i].nilaiuts * 0.15) +
                         (data[i].nilaikuis * 0.10) +
                         (data[i].nilaiharian * 0.60);
    end;
end;

function HitungRataRata(const data: array of TMahasiswa; jumlah: integer): real;
var
    i: integer;
    total: real;
begin
    total := 0;
    for i := 1 to jumlah do
    begin
        total := total + data[i].nilai; // Gunakan nilai total
    end;
    HitungRataRata := total / jumlah;
end;

function CariNilaiMaksimum(const data: array of TMahasiswa; jumlah: integer): real;
var
    i: integer;
    maks: real;
begin
    maks := data[1].nilai; // Gunakan nilai total
    for i := 2 to jumlah do
    begin
        if data[i].nilai > maks then
            maks := data[i].nilai;
    end;
    CariNilaiMaksimum := maks;
end;

function CariNilaiMinimum(const data: array of TMahasiswa; jumlah: integer): real;
var
    i: integer;
    min: real;
begin
    min := data[1].nilai; // Gunakan nilai total
    for i := 2 to jumlah do
    begin
        if data[i].nilai < min then
            min := data[i].nilai;
    end;
    CariNilaiMinimum := min;
end;

procedure UrutkanData(var data: array of TMahasiswa; jumlah: integer);
var
    i, j: integer;
    temp: TMahasiswa;
begin
    for i := 1 to jumlah - 1 do
    begin
        for j := 1 to jumlah - i do
        begin
            if data[j].nilai < data[j + 1].nilai then
            begin
                temp := data[j];
                data[j] := data[j + 1];
                data[j + 1] := temp;
            end;
        end;
    end;
end;

procedure TampilkanStatistik(const data: array of TMahasiswa; jumlah: integer);
var
    rataRata, maks, min: real;
begin
    rataRata := HitungRataRata(data, jumlah);
    maks := CariNilaiMaksimum(data, jumlah);
    min := CariNilaiMinimum(data, jumlah);
    writeln;

    writeln('===== Statistik Nilai =====');
    writeln('Rata-rata nilai: ', rataRata:0:2);
    writeln('Nilai maksimum: ', maks:0:2);
    writeln('Nilai minimum: ', min:0:2);
    writeln;
end;

procedure TampilkanRanking(const data: array of TMahasiswa; jumlah: integer);
var
    i: integer;
begin
    writeln('===== Ranking Mahasiswa =====');
    for i := 1 to jumlah do
    begin
        writeln(i, '. ', data[i].nama, ' - Nilai: ', data[i].nilai:0:2);
    end;
end;

begin
    clrscr;
    jumlahMahasiswa := 0;

    InputData(dataMahasiswa, jumlahMahasiswa);

    if jumlahMahasiswa > 0 then
    begin
        TampilkanStatistik(dataMahasiswa, jumlahMahasiswa);

        UrutkanData(dataMahasiswa, jumlahMahasiswa);

        TampilkanRanking(dataMahasiswa, jumlahMahasiswa);
    end;

    readln;
end.
