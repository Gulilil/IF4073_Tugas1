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
        
if size(img, 3) == 3  % Jika gambar RGB, proses setiap channel (R, G, B) secara terpisah
    % Pisahkan gambar menjadi 3 channel: R, G, B
    imgR = img(:, :, 1);
    imgG = img(:, :, 2);
    imgB = img(:, :, 3);

    % Equalize setiap channel
    imgEqualizedR = equalizeChannel(imgR);
    imgEqualizedG = equalizeChannel(imgG);
    imgEqualizedB = equalizeChannel(imgB);
            
    % Gabungkan kembali ketiga channel menjadi gambar RGB yang sudah di-equalize
    imgEqualized = cat(3, imgEqualizedR, imgEqualizedG, imgEqualizedB);
else
    % Jika gambar adalah grayscale
    imgEqualized = equalizeChannel(img);
end
        
% Simpan gambar yang sudah di-equalize (opsional)
imwrite(imgEqualized, 'equalized_image.png');
        
% Menampilkan histogram dari gambar yang telah di-equalize
disp('Menampilkan histogram dari gambar yang telah di-equalize...');
[hist_data, hist_data_r, hist_data_b, hist_data_g] = histogram('equalized_image.png');
histogram_show(hist_data, hist_data_r, hist_data_b, hist_data_g, is_gray, "of Initial Image");