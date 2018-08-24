clear; clc;
%%

total_folder=dir('0*');

%%
CFLAIR=[];
MFLAIR=[];
T1=[];
T2=[];
PD=[];
bet_mask=[];
sl=10;
cnt=0;
for idx=1:length(total_folder)
    directory_name=total_folder(idx).name;
    [T1t,T2t,CFlairt,MFlairt,PDt,bet_maskt]=k_Mread_jmri(0,directory_name,0,1);

    T1t=T1t(13:492,17:496,5:19);
    T2t=T2t(13:492,17:496,5:19);
    MFlairt=MFlairt(13:492,17:496,5:19);
    PDt=PDt(13:492,17:496,5:19);
    CFlairt=CFlairt(13:492,17:496,5:19);
    bet_maskt=bet_maskt(13:492,17:496,5:19);
%     maskt=(T1t~=0);
%     Ctest=CFlairt(maskt);
%     Mtest=MFlairt(maskt);
%     tmp=ones(length(Ctest),2);
%     tmp(:,1)=Ctest;
%     sol=pinv(tmp)*Mtest;
%     CFlairt=CFlairt*sol(1)+sol(2);
%     CFlairt=CFlairt.*maskt;

    T1=cat(3,T1,T1t);
    T2=cat(3,T2,T2t);
    MFLAIR=cat(3,MFLAIR,MFlairt);
    CFLAIR=cat(3,CFLAIR,CFlairt);
    PD=cat(3,PD,PDt);
    bet_mask=cat(3,bet_mask,bet_maskt);

    cnt=cnt+1;
    disp(idx)        
end
%% Masking  
mask = (T1~=0);
CFLAIR = CFLAIR.*mask;
MFLAIR = MFLAIR.*mask;

%% Normalize : CFLAIR
CFLAIR1 = CFLAIR(:,:,[646:945,991:1050,1081:1095,1171:1185]);
MFLAIR1 = MFLAIR(:,:,[646:945,991:1050,1081:1095,1171:1185]);
mask1 = mask(:,:,[646:945,991:1050,1081:1095,1171:1185]);

CFLAIR2 = CFLAIR(:,:,[1:645,946:990,1051:1080,1096:1170,1186:end]);
MFLAIR2 = MFLAIR(:,:,[1:645,946:990,1051:1080,1096:1170,1186:end]);
mask2 = mask(:,:,[1:645,946:990,1051:1080,1096:1170,1186:end]);
%% Linear scaling parameter
Ctest=CFLAIR1(mask1);
Mtest=MFLAIR1(mask1);
tmp=ones(length(Ctest),2);
tmp(:,1)=Ctest;
sol=pinv(tmp)*Mtest;
CFLAIR1=CFLAIR1*sol(1)+sol(2);
CFLAIR1=CFLAIR1.*mask1;

Ctest=CFLAIR2(mask2);
Mtest=MFLAIR2(mask2);
tmp=ones(length(Ctest),2);
tmp(:,1)=Ctest;
sol=pinv(tmp)*Mtest;
CFLAIR2=CFLAIR2*sol(1)+sol(2);
CFLAIR2=CFLAIR2.*mask2;
%%
CFLAIR(:,:,[646:945,991:1050,1081:1095,1171:1185]) = CFLAIR1;
CFLAIR(:,:,[1:645,946:990,1051:1080,1096:1170,1186:end]) = CFLAIR2;
%% Normalize: Others 
% max_val=max(MFLAIR(:));
CFLAIR(CFLAIR>3000)=3000;
max_val=3000;
MFLAIR=MFLAIR./max_val;
CFLAIR=CFLAIR./max_val;

T1=T1./max(T1(:));
T2=T2./max(T2(:));
PD=PD./max(PD(:));

%%
clearvars -except CFLAIR MFLAIR T1 T2 PD mask_flair; 
% Rotation 
CFLAIR=rot90(CFLAIR);
MFLAIR=rot90(MFLAIR);
PD=rot90(PD);
T1=rot90(T1);
T2=rot90(T2);
mask_flair=rot90(mask_flair);
%%
X_train=cat(4,MFLAIR,T1,T2,PD);
Y_train=CFLAIR;
M_train=mask_flair;
clearvars -except X_train Y_train M_train;
%%
X_train=permute(X_train,[4,2,1,3]);
Y_train=permute(Y_train,[4,2,1,3]);
M_train=permute(M_train,[4,2,1,3]);

