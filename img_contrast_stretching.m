% Initialization 
addpath('./functions/image');
addpath('./functions/histogram');

% Citra negatif dan balikan citra negatif
disp("Make sure to put the image inside the `img_in` folder!")    
img_name = input("Which image do you want to process? ", 's');
img = read_image(img_name);

[rows, cols, num_channels] = size(img);
fprintf("[INFO] An image size [%d, %d] is inputted!\n", rows, cols);

is_grayscaled = input("Do you want the image to be grayscaled? (0/1) ");
% Create placeholder for new image
if (num_channels == 1 | is_grayscaled)
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

% Display initial histogram
[hist_data, hist_data_r, hist_data_b, hist_data_g] = histogram(img);
histogram_show(hist_data, hist_data_r, hist_data_b, hist_data_g, is_gray, "of Initial Image");

if (is_gray)
    max_val = search_max_pixel(img, rows, cols);
    min_val = search_min_pixel(img, rows, cols);
    fprintf('[INFO] Max value: %d, Min value: %d\n', max_val, min_val);

    for r = 1:rows
        for c = 1: cols
            curr_pixel = img(r,c);
            result_img(r, c) = normalize_pixel(curr_pixel, max_val, min_val);
        end
    end
else
    r_aspect = img(:,:,1);  % Red channel
    max_val_r = search_max_pixel(r_aspect, rows, cols);
    min_val_r = search_min_pixel(r_aspect, rows, cols);
    fprintf('[INFO] Red : Max value: %d, Min value: %d\n', max_val_r, min_val_r);

    g_aspect = img(:,:,2);  % Green channel
    max_val_g = search_max_pixel(g_aspect, rows, cols);
    min_val_g = search_min_pixel(g_aspect, rows, cols);
    fprintf('[INFO] Green : Max value: %d, Min value: %d\n', max_val_g, min_val_g);

    b_aspect = img(:,:,3);  % Blue channel
    max_val_b = search_max_pixel(b_aspect, rows, cols);
    min_val_b = search_min_pixel(b_aspect, rows, cols);
    fprintf('[INFO] Blue : Max value: %d, Min value: %d\n', max_val_b, min_val_b);

    for r = 1:rows
        for c = 1: cols
            curr_pixel_r = double(img(r, c, 1));
            curr_pixel_g = double(img(r, c, 2));
            curr_pixel_b = double(img(r, c, 3));

            result_img(r, c, 1) = normalize_pixel(curr_pixel_r, max_val_r, min_val_r);
            result_img(r, c, 2) = normalize_pixel(curr_pixel_g, max_val_g, min_val_g);
            result_img(r, c, 3) = normalize_pixel(curr_pixel_b, max_val_b, min_val_b);
        end
    end
end

% Display result histogram
[hist_data_res, hist_data_r_res, hist_data_b_res, hist_data_g_res] = histogram(result_img);
histogram_show(hist_data_res, hist_data_r_res, hist_data_b_res, hist_data_g_res, is_gray, "of Result Image");

% Show result image
disp("[DISPLAYING] Here is displayed the initial and the result image");
combined_image = cat(2, img, result_img); 
figure;
imshow(combined_image);
title('(Initial) | Images Side by Side Comparison | (Result)');

% Write image
if is_grayscaled == 1
    suffix = "grayscaled_";
else 
    suffix = ""; 
end
img_out_name = strcat("image_constract_stretching_", suffix, img_name);
write_image(combined_image, img_out_name);