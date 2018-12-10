clc; clear all;

p = randperm(800,800); %bilangan random integer dari 1-800 tanpa berulang
iAkurasi = 1; 
iK2 = 1; 
iArray = 1;
iK = 1;
K = 1; %pengeset-an nilai K pertama kali
iKelasAsli = 1;
jumlahBenar = 0; 
dataTrain = csvread("DataTrain_Tugas3_AI.csv",1);
iKelas = 1;

i = 1;
while (i<801) %perulangan untuk merandom data train dengan menghasilkan array yang baru
    arrayTrain1(i) = dataTrain(p(i),2);
    arrayTrain2(i) = dataTrain(p(i),3);
    arrayTrain3(i) = dataTrain(p(i),4);
    arrayTrain4(i) = dataTrain(p(i),5);
    arrayTrain5(i) = dataTrain(p(i),6);
    arrayKelas(i) = dataTrain(p(i),7);
    i = i+1;
end

while (iK<201) %perulangan untuk K
    for iValid=601:800 %perulangan data train
        for iTrain=1:600 %perulangan data validasi
            x1A = arrayTrain1(iTrain);
            x2A = arrayTrain2(iTrain);
            x3A = arrayTrain3(iTrain);
            x4A = arrayTrain4(iTrain);
            x5A = arrayTrain5(iTrain);
        
            x1B = arrayTrain1(iValid);
            x2B = arrayTrain2(iValid);
            x3B = arrayTrain3(iValid);
            x4B = arrayTrain4(iValid);
            x5B = arrayTrain5(iValid);
        
            posisiIndex(iArray) = euclideanFunction(x1A,x2A,x3A,x4A,x5A,x1B,x2B,x3B,x4B,x5B); %menghitung jarak dengan rumus euclidian
            iArray = iArray + 1;
        end
        kelasAsli(iKelas) = arrayKelas(iValid); 
        sortedPosisi = sort(posisiIndex); %mengurutkan array posisiIndex
        
        while(iK2<=K) %perulangan untuk membuat array baru berisi kelas yang telah disort berdasarkan urutan pada array sortedPosisi
            for j=1:800
                if( sortedPosisi(iK2)==posisiIndex(j) )
                    kelasAsliSorted(iKelasAsli) = arrayKelas(j);
                    iKelasAsli = iKelasAsli + 1;
                    break;
                end
            end
            iK2 = iK2 + 1;
        end
        
        kelasPrediksi(iKelas) = mode(kelasAsliSorted); %voting dengan menggunakan modus (nilai yang paling sering muncul)
        
        iArray = 1;
        iKelasAsli = 1;
        iK2 = 1;
        iKelas = iKelas + 1;
    end
     
    for w=1:(iKelas-1) %perulangan untuk menghitung jumlah benar.
        if(kelasPrediksi(w)==kelasAsli(w))
            jumlahBenar = jumlahBenar + 1; 
        end
    end
     akurasi(iAkurasi) = (jumlahBenar/200) * 100; %rumus akurasi
     akurasiK(iAkurasi) = K; 
     K = K+1;
     jumlahBenar = 0;
     iK = iK + 1;
     iAkurasi = iAkurasi + 1;
     clear kelasPrediksi; %mereset array kelasPrediksi
     clear kelasAsli; %mereset array kelasAsli
     iKelas = 1;
end

%mencari nilai akurasi yang paling tinggi beserta K nya
maxAkurasi = max(akurasi); 

x=find(akurasi==maxAkurasi);

Kterbaik = akurasiK(x);