%% Dicomwrite multiframe

resY=permute(resY,[2,3,1]);
X_test=permute(X_test,[2,3,1]);
Y_test=permute(Y_test,[2,3,1]);

endnum=15:15:330;
%%
for ii=1:(length(endnum)-1)
slice_num=[endnum(ii)+1:endnum(ii+1)];

test=resY(:,:,slice_num);
test=uint16(test*100);
[a,b,c] = size(test);
dicomwrite(reshape(test,[a,b,1,c]), strcat(int2str(ii),'_DL.dcm'),'MultiframeSingleFile', true);

test=X_test(:,:,slice_num);
test=uint16(test*100);
[a,b,c] = size(test);
dicomwrite(reshape(test,[a,b,1,c]), strcat(int2str(ii),'_magic.dcm'),'MultiframeSingleFile', true);

test=Y_test(:,:,slice_num);
test=uint16(test*100);
[a,b,c] = size(test);
dicomwrite(reshape(test,[a,b,1,c]), strcat(int2str(ii),'_conv.dcm'),'MultiframeSingleFile', true);
ii
end;

%%
conv_files=dir('*conv*dcm');
 mag_files=dir('*magic*dcm');
 dl_files=dir('*DL*dcm');
 %% add metadata
  
for idx=1:length(conv_files)
X=dicomread(conv_files(idx).name);
XX=dicomread(mag_files(idx).name);
XXX=dicomread(dl_files(idx).name);
XXX=uint16(double(XXX).*(XX~=0));
dicomwrite(X*40,strcat('test',conv_files(idx).name),conv_metadata,'MultiframeSingleFile', true,'CreateMode','copy');
dicomwrite(XX*40,strcat('test',mag_files(idx).name),mag_metadata,'MultiframeSingleFile', true,'CreateMode','copy');
dicomwrite(XXX*40,strcat('test',dl_files(idx).name),dl_metadata,'MultiframeSingleFile', true,'CreateMode','copy');

end;