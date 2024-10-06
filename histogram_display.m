% Initialization 
addpath('./functions/image');
addpath('./functions/histogram');

% Citra negatif dan balikan citra negatif
disp("[INFO] Make sure to put the image inside the `img_in` folder!")    
img_name = input("[INPUT] Which image do you want to process? ", 's');
img = read_image(img_name);

[rows, cols, num_channels] = size(img);
fprintf("[INFO] An image size [%d, %d] is inputted!\n", rows, cols);

if (num_channels ~= 1)
    is_grayscaled = input("[INPUT] Do you want the image to be grayscaled? (0/1) ");
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