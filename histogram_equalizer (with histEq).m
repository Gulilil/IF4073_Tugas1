% Initialization
addpath('./functions/image');
addpath('./functions/histogram');

% Image histogram equalization
disp("Make sure to put the image inside the `img_in` folder!")    
img_name = input('Masukkan nama file (for histEg): ', 's');  
img = read_image(img_name);

% Menampilkan histogram asli menggunakan import fungsi 
disp('Menampilkan histogram asli...');
[hist_data, hist_data_r, hist_data_b, hist_data_g] = histogram(img);
histogram_show(hist_data, hist_data_r, hist_data_b, hist_data_g, is_gray, "of Initial Image");
        
% Jika gambar RGB, lakukan equalization pada masing-masing channel
if size(img, 3) == 3
    % Pisahkan channel R, G, dan B
    R = img(:, :, 1);
    G = img(:, :, 2);
    B = img(:, :, 3);
            
    % Lakukan histogram equalization pada masing-masing channel
    R_eq = histeq(R);
    G_eq = histeq(G);
    B_eq = histeq(B);
            
    % Gabungkan channel yang telah di-equalize
    imgEqualized = cat(3, R_eq, G_eq, B_eq);
else
    % Jika gambar grayscale, langsung lakukan equalization
    imgEqualized = histeq(img);
end
        
% Simpan gambar yang sudah di-equalize (opsional)
imwrite(imgEqualized, 'equalized_image.png');
        
% Menampilkan histogram dari gambar yang telah di-equalize
disp('Menampilkan histogram dari gambar yang telah di-equalize...');
[hist_data, hist_data_r, hist_data_b, hist_data_g] = histogram('equalized_image.png');
histogram_show(hist_data, hist_data_r, hist_data_b, hist_data_g, is_gray, "of Initial Image");