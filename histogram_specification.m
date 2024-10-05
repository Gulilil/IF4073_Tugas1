% Initialization 
addpath('./functions/image');
addpath('./functions/histogram');


disp("Make sure to put the image inside the `img_in` folder!") ;
img_name_source = input("Which image do you want to enhance? ", 's');
img_source = read_image(img_name_source);
% imshow(img_source);

disp("Make sure the reference image is the same size as source image!")
img_name_reference = input("Which image do you want to refer? ", 's');
img_reference = read_image(img_name_reference);
% imshow(img_reference);

% Image details
[rows_s, cols_s, num_channels_s] = size(img_source);
[rows_r, cols_r, num_channels_r] = size(img_reference);

if (not (rows_s == rows_r) | not (cols_s == cols_r))
    disp('[FAILED] The two inputted images do not have the same size!');
elseif (not (num_channels_s == num_channels_r))
    disp('[FAILED] The two inputted images do not share the same color type!');
else
    % Both image rows and cols should be the same
    fprintf("[INFO] The images with size [%d, %d] are inputted!\n", rows_s, cols_s);
    
    is_grayscaled = input("Do you want the image to be grayscaled? (0/1) ");
    % Create placeholder for new image
    if (num_channels_s == 1 | is_grayscaled)
        disp("[PROCESS] Processing grayscale image!");
        if (not(num_channels_s == 1))
            % If full colored but want to be grayscaled
            img_source = rgb2gray(img_source);
            img_reference = rgb2gray(img_reference);
        end
        is_gray = true;
        result_img = zeros(rows, cols, 1, 'uint8');
    else
        disp("[PROCESS] Processing full color image!");
        is_gray = false;
        result_img = zeros(rows, cols, 3, 'uint8');
    end

    % Process Image
    hist = histogram(img_name_source);
end