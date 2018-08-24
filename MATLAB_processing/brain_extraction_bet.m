tmp_folder=dir('0*');

for idx=1:86
    tmp_str = tmp_folder(idx).name;
    str1 = '!/usr/local/fsl/bin/bet /home/dl2/Desktop/kanghyun/Total_Severance_registered/';
    str2 = '/MAGiC_T1 /home/dl2/Desktop/kanghyun/Total_Severance_registered/';
    str3 = '/MAGiC_T1_brain -Z -f 0.3 -g 0';
    str=strcat(str1,tmp_str,str2,tmp_str,str3);
    eval(str)
    idx
end;
