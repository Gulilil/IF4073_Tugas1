% Initialization 
addpath('./functions/image');
addpath('./functions/histogram');

% Transformasi log (𝑠 = 𝑐 𝑙𝑜𝑔(1 + 𝑟), 𝑐 dan 𝑟 adalah parameter input dari pengguna)
disp("[INFO] Make sure to put the image inside the `img_in` folder!")    
img_name = input("[INPUT] Which image do you want to process? ", 's');
img = read_image(img_name);

disp("[INFO] Image log transformation will generate a new image each pixel is calcualted in formula of s = c log(1+r).");
c_coef = input("[INPUT] What is the c value? ");

[rows, cols, num_channels] = size(img);
fprintf("[INFO] An image size [%d, %d] is inputted!\n", rows, cols);

is_grayscaled = input("[INPUT] Do you want the image to be grayscaled? (0/1) ");
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

for r = 1:rows
    for c = 1:cols
        if (is_gray)
            curr_pixel = double(img(r,c));
            result_img(r, c) = validate_pixel(c_coef * log(1 + curr_pixel));
        else
            curr_pixel_r = double(img(r, c, 1));
            curr_pixel_g = double(img(r, c, 2));
            curr_pixel_b = double(img(r, c, 3));

            result_img(r, c, 1) = validate_pixel(uint8(c_coef * log(1 + curr_pixel_r)));
            result_img(r, c, 2) = validate_pixel(uint8(c_coef * log(1 + curr_pixel_g)));
            result_img(r, c, 3) = validate_pixel(uint8(c_coef * log(1 + curr_pixel_b)));
        end
    end
end

% Show result image
disp("[DISPLAYING] Here is displayed the initial and the result image");
combined_image = cat(2, img, result_img); 
figure;
imshow(combined_image);
title('(Initial) | Images Side by Side Comparison | (Result)');

% Saving option
is_saved = input("[INPUT] Do you want to save the result image? (0/1) ");

if is_saved
    % Write image
    if is_grayscaled == 1
        suffix = "grayscaled_";
    else 
        suffix = ""; 
    end
    img_out_name = strcat("image_log_transformation_", suffix, img_name);
    write_image(combined_image, img_out_name);
end