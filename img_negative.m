% Initialization 
addpath('./functions');

% Image brightening (𝑠 = 𝑟 + 𝑏 dan 𝑠 = 𝑎𝑟 + 𝑏, 𝑎 dan 𝑏 adalah parameter input dari pengguna) 
[img, img_name] = read_image();

% Display initial image
disp("[DISPLAYING] Here is displayed the initial image");
imshow(img);

[rows, cols, num_channels] = size(img);
fprintf("[INFO] An image size [%d, %d] is inputted!\n", rows, cols);

% Create placeholder for new image
if (num_channels == 1)
    disp("[PROCESS] Processing grayscale image!");
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
disp("[DISPLAYING] Here is displayed the result image!");
imshow(result_img);

% Write image
img_out_name = strcat("image_negative_", img_name);
write_image(result_img, img_out_name)