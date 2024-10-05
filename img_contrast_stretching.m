% Initialization 
addpath('./functions');

% Citra negatif dan balikan citra negatif
disp("Make sure to put the image inside the `img_in` folder!")    
img_name = input("Which image do you want to process? ", 's');
img = read_image(img_name);

% Display initial image
disp("[DISPLAYING] Here is displayed the initial image");
imshow(img);

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

PIXEL_MAX_VAL = 255;

if (is_gray)
    max_val = search_max_pixel(img, rows, cols);
    min_val = search_min_pixel(img, rows, cols);
    fprintf('[INFO] Max value: %d, Min value: %d\n', max_val, min_val);
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
end


% Show result image
%disp("[DISPLAYING] Here is displayed the result image!");
%imshow(result_img);

% Write image
%if is_grayscaled == 1
%    suffix = "grayscaled_";
%else 
%    suffix = ""; 
%end
%img_out_name = strcat("image_constract_stretching_", suffix, img_name);
%write_image(result_img, img_out_name)