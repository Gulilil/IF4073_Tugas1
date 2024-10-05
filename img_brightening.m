% Initialization 
addpath('./functions');

% Image brightening (𝑠 = 𝑟 + 𝑏 dan 𝑠 = 𝑎𝑟 + 𝑏, 𝑎 dan 𝑏 adalah parameter input dari pengguna) 
[img, img_name] = read_image();

% Display initial image
disp("[DISPLAYING] Here is displayed the initial image");
imshow(img)

disp("[INFO] Image brightening will generate a new image each pixel is calcualted in formula of s = ar+b.");
a = input("What is the a value? ");
b = input("What is the b value? ");

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

for r = 1:rows
    for c = 1:cols
        if (is_gray)
            curr_pixel = img(r,c);
            result_img(r, c) = validate_pixel(a * curr_pixel + b);
        else
            curr_pixel_r = img(r, c, 1);
            curr_pixel_g = img(r, c, 2);
            curr_pixel_b = img(r, c, 3);

            result_img(r, c, 1) = validate_pixel(a * curr_pixel_r + b);
            result_img(r, c, 2) = validate_pixel(a * curr_pixel_g + b);
            result_img(r, c, 3) = validate_pixel(a * curr_pixel_b + b);
        end
    end
end

% Show result image
disp("[DISPLAYING] Here is displayed the result image");
imshow(result_img);

% Write image
if is_grayscaled == 1
    suffix = "_grayscaled";
else 
    suffix = ""; 
end
img_out_name = strcat("image_brightening_", img_name, suffix);
write_image(result_img, img_out_name)