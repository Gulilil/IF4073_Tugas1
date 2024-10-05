% Initialization 
addpath('./functions');

% Image brightening (𝑠 = 𝑟 + 𝑏 dan 𝑠 = 𝑎𝑟 + 𝑏, 𝑎 dan 𝑏 adalah parameter input dari pengguna) 
[img, img_name] = read_image();

% Display initial image
disp("[DISPLAYING] Here is displayed the initial image");
imshow(img);

disp("[INFO] Image log transformation will generate a new image each pixel is calcualted in formula of s = c log(1+r).");
c_coef = input("What is the c value? ");

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
disp("[DISPLAYING] Here is displayed the result image!");
imshow(result_img);

% Write image
img_out_name = strcat("image_log_transformation_", img_name);
write_image(result_img, img_out_name)