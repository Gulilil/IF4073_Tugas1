% Initialization 
addpath('./functions/image');
addpath('./functions/histogram');
addpath('./functions/vector');

disp("Make sure to put the image inside the `img_in` folder!") ;
% img_name_source = input("Which image do you want to enhance? ", 's');
img_name_source = "savanna.jpg";
img_source = read_image(img_name_source);
% imshow(img_source);

disp("Make sure the reference image is the same size as source image!")
% img_name_reference = input("Which image do you want to refer? ", 's');
img_name_source = "mountain.jpg";
img_reference = read_image(img_name_reference);
% imshow(img_reference);

% Image details
[rows_s, cols_s, num_channels_s] = size(img_source);
[rows_r, cols_r, num_channels_r] = size(img_reference);

MAX_PIXEL_VAL = 255;

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
    [hist_data_source, hist_data_r_source, hist_data_b_source, hist_data_g_source] = histogram(img_source);
    [hist_data_ref, hist_data_r_ref, hist_data_b_ref, hist_data_g_ref] = histogram(img_reference);
    img_size = rows_s * cols_s;
    if (is_gray)
        % Source
        norm_hist_data_source = hist_data_source / img_size;
        cmltv_norm_hist_data_source = make_cumulative(norm_hist_data_source);
        result_hist_data_source = uint8(cmltv_norm_hist_data_source * MAX_PIXEL_VAL);
        disp(result_hist_data_source);

        % Ref
        norm_hist_data_ref = hist_data_ref / img_size;
        cmltv_norm_hist_data_ref = make_cumulative(norm_hist_data_ref);
        result_hist_data_ref = uint8(cmltv_norm_hist_data_ref * MAX_PIXEL_VAL);
        disp(result_hist_data_ref);
    else
    end
end