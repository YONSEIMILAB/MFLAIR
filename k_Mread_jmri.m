
function [T1, T2, CFLAIR, MFLAIR, PD, bet_mask]=k_Mread_jmri(option, directory_name,view_option,single_option)
% [T1,T2,CFlair,MFlair,PSIR,PD]=k_Mread(sl,option,directory_name)
% option 1 uigetdir directory and do figure;
% v1. w/ hitogram matching 
%     w/o skull stripping
cd('F:\MAGIC_summary\MRM\Dicom_Inputs\Total_Severance_registered_bet');
current=cd;
%
if option==1 
    directory_name = uigetdir;
end
cd(directory_name);
 % T1w
 temp = load_untouch_nii('MAGiC_T1.nii');
 temp = temp.img;
 T1 = temp;

 % MFlair
 temp = load_untouch_nii('T2W_FLAIR_Synthetic.nii');
 MFLAIR = temp.img;
 
 % T2
 temp = load_untouch_nii('MAGiC_T2.nii');
 T2 = temp.img;
 
 % PD
 temp = load_untouch_nii('MAGiC_PD.nii');
 PD = temp.img;
 
 % Conventional FLAIR
 temp = load_untouch_nii('CFLAIR_reg.nii');
 CFLAIR = temp.img;
 
 % Conventional FLAIR
 temp = load_untouch_nii('MAGiC_T1_brain.nii');
 bet_mask = temp.img;
clear temp;
if single_option
    T1 = single(T1);
    T2 = single(T2);
    PD = single(PD);
    MFLAIR = single(MFLAIR);
    CFLAIR = single(CFLAIR);
    bet_mask=single(bet_mask);
    bet_mask=(bet_mask~=0);
end

if view_option
    MFLAIR2 = MFLAIR./max(MFLAIR(:));
    CFLAIR2 = CFLAIR./max(CFLAIR(:));
    T22 = T2./max(T2(:));
    T12 = T1./max(T1(:));
    PD2 = PD./max(PD(:));

    fig=figure(1);
    set(fig, 'position', [200 200 900 750])
    subplot_tight(2,3,1); imagesc(rot90(MFLAIR2(:,:,view_option)),[0 0.2]);axis off image; colormap gray; title('Magic FLAIR','FontSize', 24);
    subplot_tight(2,3,2); imagesc(rot90(CFLAIR2(:,:,view_option)),[0 0.4]); axis off image; colormap gray; title('Conventional FLAIR','FontSize', 24);
    subplot_tight(2,3,3); imagesc(rot90(T22(:,:,view_option)),[0 0.7]); axis off image; colormap gray; title('T2W','FontSize', 24);
    subplot_tight(2,3,5); imagesc(rot90(PD2(:,:,view_option)),[0 0.8]); axis off image; colormap gray; title('PDW','FontSize', 24);
    subplot_tight(2,3,6); imagesc(rot90(T12(:,:,view_option)),[0 0.4]); axis off image; colormap gray; title('T1W','FontSize', 24);
    pause(1)
end;

disp('data preprocess finished');
 cd(current); % Back to the Total_Severance folder