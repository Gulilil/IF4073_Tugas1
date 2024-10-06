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
    imgEqualized = equalizer_operation(img);
end

% Menampilkan histogram dari gambar yang telah di-equalize
disp('Menampilkan histogram dari gambar yang telah di-equalize...');
[hist_data, hist_data_r, hist_data_b, hist_data_g] = histogram(imgEqualized);
histogram_show(hist_data, hist_data_r, hist_data_b, hist_data_g, is_gray, "of Equalized Image");


% Show result image
disp("[DISPLAYING] Here is displayed the initial and the result image");
combined_image = cat(2, img, imgEqualized); 
figure;
imshow(combined_image);
title('(Initial) | Images Side by Side Comparison | (Result)');

% Write image
if is_grayscaled == 1
    suffix = "grayscaled_";
else 
    suffix = ""; 
end
img_out_name = strcat("histogram_equalizer_", suffix, img_name);
write_image(combined_image, img_out_name);