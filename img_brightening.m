% Initialization 
addpath('./functions');

% Image brightening (𝑠 = 𝑟 + 𝑏 dan 𝑠 = 𝑎𝑟 + 𝑏, 𝑎 dan 𝑏 adalah parameter input dari pengguna) 
disp("Put the image inside the `img_in` folder!")
img_name = input("Which image do you want to process? ", 's');
img_path = strcat("img_in/"+img_name);
img = imread(img_path); 

% Display initial image
imshow(img)

disp("Image brightening will generate a new image each pixel is calcualted in formula of s = ar+b.");
a = input("What is the a value? ");
b = input("What is the a value? ");

[rows, cols, num_channels] = size(img);
fprintf("An image size [%d, %d] is inputted!\n", rows, cols);

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
imshow(result_img);