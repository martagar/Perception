function senal = grabacion(t,Fs,Ch,num_bits)
    recObj = audiorecorder(Fs,num_bits,Ch);
    disp('Start Speaking');
    recordblocking(recObj,t);
    disp('End of Recording');
    senal = getaudiodata(recObj);
end