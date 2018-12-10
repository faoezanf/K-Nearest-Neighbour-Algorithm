clc;clear all;

K = 9; %nilai K dari program pertama (program MencariNilaiK.m)
iK = 1;
iKP = 1;
iArray = 1;
iTest = 1;
total =0;

dataTrain = csvread("DataTrain_Tugas3_AI.csv",1);
dataTest = readtable('DataTest_Tugas3_AI.csv');

while(iTest<201)
    iTrain=1;
    while(iTrain<801)
        x1A = dataTrain(iTrain,2);
        x2A = dataTrain(iTrain,3);
        x3A = dataTrain(iTrain,4);
        x4A = dataTrain(iTrain,5);
        x5A = dataTrain(iTrain,6);
        
        x1B = table2array(dataTest(iTest,2));
        x2B = table2array(dataTest(iTest,3));
        x3B = table2array(dataTest(iTest,4));
        x4B = table2array(dataTest(iTest,5));
        x5B = table2array(dataTest(iTest,6));
        
        jarak(iArray) = euclideanFunction(x1A,x2A,x3A,x4A,x5A,x1B,x2B,x3B,x4B,x5B); %menghitung jarak antar data test dan data train
        
        iArray = iArray + 1;
        
        iTrain = iTrain + 1;
    end
    
    sortedJarak = sort(jarak);
    
    while(iKP<=K) %perulangan untuk membuat array baru berisi kelas yang telah disort berdasarkan urutan pada array sortedJarak
        for j=1:800
            if( sortedJarak(iKP)==jarak(j) )
                kelasSorted(iKP) = dataTrain(j,7);    
                iKP = iKP + 1;
                break;
            end
        end
    end
    
    kelasPrediksi(iK,1) = mode (kelasSorted); %voting
    iK = iK+1;
    
    
    iKP = 1;
    iArray=1;
    iTest = iTest + 1;
end

csvwrite("TebakanTugas3.csv",kelasPrediksi);  %membuat file csv    

