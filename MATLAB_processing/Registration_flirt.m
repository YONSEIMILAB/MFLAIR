tmp_folder=dir('0*');

for idx=1:86
    tmp_str = tmp_folder(idx).name;
    str1 = '!/usr/local/fsl/bin/flirt -in /home/dl2/Desktop/kanghyun/Total_Severance_registered/';
    str2 = '/Fast_Ax_T2_FLAIR.nii -ref /home/dl2/Desktop/kanghyun/Total_Severance_registered/';
    str3 = '/T2W_FLAIR_Synthetic.nii -out /home/dl2/Desktop/kanghyun/Total_Severance_registered/';
    str4 = '/CFLAIR_reg.nii -omat /home/dl2/Desktop/kanghyun/Total_Severance_registered/';
    str5 = '/CFLAIR_reg.mat -bins 256 -cost corratio -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -2D -dof 12  -interp trilinear';
    str=strcat(str1,tmp_str,str2,tmp_str,str3,tmp_str,str4,tmp_str,str5);
    eval(str)
    idx
end;

/usr/local/fsl/bin/bet /home/dl2/Desktop/kanghyun/Total_Severance_registered/086/MAGiC_T1 /home/dl2/Desktop/kanghyun/Total_Severance_registered/086/MAGiC_T1_brain -Z -f 0.3 -g 0
