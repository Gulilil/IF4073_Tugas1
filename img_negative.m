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

PIXEL_MAX_VAL = 255;

for r = 1:rows
    for c = 1:cols
        if (is_gray)
            curr_pixel = img(r,c);
            result_img(r, c) = validate_pixel(PIXEL_MAX_VAL - curr_pixel);
        else
            curr_pixel_r = img(r, c, 1);
            curr_pixel_g = img(r, c, 2);
            curr_pixel_b = img(r, c, 3);

            result_img(r, c, 1) = validate_pixel(PIXEL_MAX_VAL - curr_pixel_r);
            result_img(r, c, 2) = validate_pixel(PIXEL_MAX_VAL - curr_pixel_g);
            result_img(r, c, 3) = validate_pixel(PIXEL_MAX_VAL - curr_pixel_b);
        end
    end
end

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
img_out_name = strcat("image_negative_", suffix, img_name);
write_image(result_img, img_out_name)