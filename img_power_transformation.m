% Initialization 
addpath('./functions');

% Transformasi pangkat (𝑠 = 𝑐(r)^n, 𝑐 dan n adalah parameter input dari pengguna)
[img, img_name] = read_image();

% Display initial image
disp("[DISPLAYING] Here is displayed the initial image");
imshow(img);

disp("[INFO] Image log transformation will generate a new image each pixel is calcualted in formula of s = c(r)^n."); 
c_coef = input("What is the c value? ");
n = input("What is the n value? ");

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
            curr_pixel = double(img(r,c));
            result_img(r, c) = validate_pixel(c_coef * (curr_pixel ^ n));
        else
            curr_pixel_r = double(img(r, c, 1))/ PIXEL_MAX_VAL;
            curr_pixel_g = double(img(r, c, 2))/ PIXEL_MAX_VAL;
            curr_pixel_b = double(img(r, c, 3))/ PIXEL_MAX_VAL;

            result_img(r, c, 1) = validate_pixel(uint8(c_coef * (curr_pixel_r ^ n) * PIXEL_MAX_VAL));
            result_img(r, c, 2) = validate_pixel(uint8(c_coef * (curr_pixel_g ^ n) * PIXEL_MAX_VAL));
            result_img(r, c, 3) = validate_pixel(uint8(c_coef * (curr_pixel_b ^ n) * PIXEL_MAX_VAL));
        end
    end
end

% Show result image
disp("[DISPLAYING] Here is displayed the result image!");
imshow(result_img);

% Write image
if is_grayscaled == 1
    suffix = "_grayscaled";
else 
    suffix = ""; 
end
img_out_name = strcat("image_power_transformation_", img_name, suffix);
write_image(result_img, img_out_name)