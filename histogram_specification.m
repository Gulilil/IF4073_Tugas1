% Initialization 
addpath('./functions/image');
addpath('./functions/histogram');
addpath('./functions/vector');

function [final_hist_data, mapped_hist] = match_histogram(hist_data_source, hist_data_ref, img_size, MAX_PIXEL_VAL)
    % Source
    norm_hist_data_source = hist_data_source / img_size;
    cmltv_norm_hist_data_source = make_cumulative(norm_hist_data_source);
    result_hist_data_source = round(cmltv_norm_hist_data_source * MAX_PIXEL_VAL);
    new_hist_data_source = map_new_hist(result_hist_data_source, hist_data_source);
    % disp(new_hist_data_source);

    % Ref
    norm_hist_data_ref = hist_data_ref / img_size;
    cmltv_norm_hist_data_ref = make_cumulative(norm_hist_data_ref);
    result_hist_data_ref = round(cmltv_norm_hist_data_ref * MAX_PIXEL_VAL);
    % disp(result_hist_data_ref);

    len = length(result_hist_data_source);
    mapped_hist = zeros(1, len);
    final_hist_data = zeros(1, len);
    for i = 1: len
        idx_to_map_from_source = result_hist_data_source(i);
        idx_nearest = get_index_nearest_value(result_hist_data_ref, idx_to_map_from_source);
        n = new_hist_data_source(i);
        mapped_hist(i) = idx_nearest;
        final_hist_data(idx_nearest) = final_hist_data(idx_nearest) + n;
        % fprintf("%d %d %d %d\n", i, idx_to_map_from_source, idx_nearest, n);
    end
end

disp("Make sure to put the image inside the `img_in` folder!") ;
img_name_source = input("Which image do you want to enhance? ", 's');
% img_name_source = "savanna.jpg";
img_source = read_image(img_name_source);

disp("Make sure the reference image is the same size as source image!")
img_name_reference = input("Which image do you want to refer? ", 's');
% img_name_source = "wallpaper.jpg";
img_reference = read_image(img_name_reference);

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
        result_img = zeros(rows_s, cols_s, 1, 'uint8');
    else
        disp("[PROCESS] Processing full color image!");
        is_gray = false;
        result_img = zeros(rows_s, cols_s, 3, 'uint8');
    end

    % Process Image
    [hist_data_source, hist_data_r_source, hist_data_b_source, hist_data_g_source] = histogram(img_source);
    histogram_show(hist_data_source, hist_data_r_source, hist_data_b_source, hist_data_g_source, is_gray, "of Source Image");

    [hist_data_ref, hist_data_r_ref, hist_data_b_ref, hist_data_g_ref] = histogram(img_reference);
    histogram_show(hist_data_ref, hist_data_r_ref, hist_data_b_ref, hist_data_g_ref, is_gray, "of Reference Image");
    img_size = rows_s * cols_s;

    [result_histogram, mapped_hist] = match_histogram(hist_data_source, hist_data_ref, img_size, MAX_PIXEL_VAL);
    if (is_gray)
        histogram_show(result_histogram, [], [], [], is_gray, "of Result Match");
        
        for r= 1:rows_s
            for c=1:cols_s
                curr_pixel = img_source(r,c);
                result_img(r, c) = mapped_hist(curr_pixel+1);
            end
        end
    else
        [result_histogram_r, mapped_hist_r] = match_histogram(hist_data_r_source, hist_data_r_ref, img_size, MAX_PIXEL_VAL);
        [result_histogram_g, mapped_hist_g] = match_histogram(hist_data_g_source, hist_data_g_ref, img_size, MAX_PIXEL_VAL);
        [result_histogram_b, mapped_hist_b] = match_histogram(hist_data_b_source, hist_data_b_ref, img_size, MAX_PIXEL_VAL);

        for r= 1:rows_s
            for c=1:cols_s
                curr_pixel_r = img_source(r, c, 1);
                curr_pixel_g = img_source(r, c, 2);
                curr_pixel_b = img_source(r, c, 3);
        
                result_img(r, c, 1) = mapped_hist(curr_pixel_r+1);
                result_img(r, c, 2) = mapped_hist(curr_pixel_g+1);
                result_img(r, c, 3) = mapped_hist(curr_pixel_b+1);
            end
        end
        histogram_show(result_histogram, result_histogram_r, result_histogram_g, result_histogram_b, is_gray, "of Result Match");
    end

    disp(size(result_img));

    % Show result image
    disp("[DISPLAYING] Here is displayed the source, reference, and result image");
    combined_image = cat(2, img_source, img_reference, result_img);
    figure;
    imshow(combined_image);
    title('Display Images (Source | Reference | Result)');

    % Write image
    if is_grayscaled == 1
        suffix = "grayscaled_";
    else 
        suffix = ""; 
    end
    img_out_name = strcat("histogram_specification_", suffix, img_name_source, img_name_reference);
    write_image(combined_image, img_out_name)
end