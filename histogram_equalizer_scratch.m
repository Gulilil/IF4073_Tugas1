% Initialization 
addpath('./functions/image');
addpath('./functions/histogram');

% Citra negatif dan balikan citra negatif
disp("Make sure to put the image inside the `img_in` folder!")    
img_name = input("Which image do you want to process? ", 's');
img = read_image(img_name);

[rows, cols, num_channels] = size(img);
fprintf("[INFO] An image size [%d, %d] is inputted!\n", rows, cols);

if (num_channels ~= 1)
    is_grayscaled = input("Do you want the image to be grayscaled? (0/1) ");
    % Create placeholder for new image
    if (is_grayscaled)
        disp("[PROCESS] Processing grayscale image!");
        if (not(num_channels == 1))
            % If full colored but want to be grayscaled
            img = rgb2gray(img);
        end
        is_gray = true;
        result_img = zeros(rows, cols, 1, 'uint8');
    else
        disp("[PROCESS] Processing full color image!");
        is_gray = false;
        result_img = zeros(rows, cols, 3, 'uint8');
    end
end

% Display Image
imshow(img);

% Display initial histogram
[hist_data, hist_data_r, hist_data_b, hist_data_g] = histogram(img);
histogram_show(hist_data, hist_data_r, hist_data_b, hist_data_g, is_gray, "of Initial Image");
        
if size(img, 3) == 3  % Jika gambar RGB, proses setiap channel (R, G, B) secara terpisah
    % Pisahkan gambar menjadi 3 channel: R, G, B
    imgR = img(:, :, 1);
    imgG = img(:, :, 2);
    imgB = img(:, :, 3);

    % Equalize setiap channel
    imgEqualizedR = equalizer_operation(imgR);
    imgEqualizedG = equalizer_operation(imgG);
    imgEqualizedB = equalizer_operation(imgB);
            
    % Gabungkan kembali ketiga channel menjadi gambar RGB yang sudah di-equalize
    imgEqualized = cat(3, imgEqualizedR, imgEqualizedG, imgEqualizedB);
else
    % Jika gambar adalah grayscale
    imgEqualized = equalizeChannel(img);
end
        
% Simpan gambar yang sudah di-equalize
new_file_directory = './img_in/new_image.png';
new_file = 'new_image.png';
imwrite(imgEqualized, new_file_directory);

% Read new Image
new_img = read_image(new_file);

% Display Image in new figure
figure;
imshow(new_img);

% Menampilkan histogram dari gambar yang telah di-equalize
disp('Menampilkan histogram dari gambar yang telah di-equalize...');
[hist_data, hist_data_r, hist_data_b, hist_data_g] = histogram(new_img);
histogram_show(hist_data, hist_data_r, hist_data_b, hist_data_g, is_gray, "of Equalized Image");