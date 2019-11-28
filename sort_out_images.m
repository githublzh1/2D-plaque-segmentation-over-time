
%This code sorts out the images generated by test_predict_plaques_original.py

clc
clear all
close all



%save_result_path = './generate_report_plaque_based/';%plaque_based report shows one plaque progression
save_result_path = './generate_report_chris_1120/';
imgpath = '/home/ran/MyProjs/2DPlaqueSeg/graham_SPARC_fixedS/results_chris_1120_15net/images';
img = dir(imgpath);%get all images
whole_image_path = '/home/ran/2DPlaqueData_SPARC/roi_chris';

if exist(save_result_path,'dir')==0
    mkdir(save_result_path);
end

for i_img = 3:length(img)
    %i_img=3
    img_name = img(i_img).name;
    img_seg1 = strfind(img_name, '-');%find -
    img_seg2 = strfind(img_name,'_');%find _
    img_seg3 = strfind(img_name,'(');%find (
    if isempty(img_seg3)
        folder_plaque_number = '1';
    else
        folder_plaque_number = img_name(img_seg3(1)+1);
    end
    %define folder structure
    folder_patient_name = img_name(1:img_seg1(1)-1);
    folder_position_name = img_name(img_seg2(3)+1:img_seg2(3)+5);
    
    folder_plaque_name = img_name(img_seg2(2)+1:img_seg2(3)-1);
    folder_time_name = img_name(img_seg2(1)+1:img_seg2(2)-1);
    %plaque_based:
    %folder_name = fullfile(save_result_path,'/',folder_patient_name,'/',folder_position_name,'/',folder_plaque_number,'/',folder_time_name);
    %time_based
    folder_name = fullfile(save_result_path,'/',folder_patient_name,'/',folder_time_name,'/',folder_position_name,'/',folder_plaque_name);
    create_folder = exist(folder_name,'dir');   
    if create_folder==0            
        mkdir(folder_name);   
    end
    %put images in this folder
    image = imread(fullfile(imgpath,img_name));
    imwrite(image,fullfile(folder_name,img_name));
    a=size(img_seg2);
    if a(2)==3
      whole_image = imread(fullfile(whole_image_path,img_name));
      imwrite(whole_image,fullfile(folder_name,img_name));
    end
end


