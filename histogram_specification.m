% Initialization 
addpath('./functions/image');
addpath('./functions/histogram');
addpath('./functions/vector');

function final_hist_data = match_histogram(hist_data_source, hist_data_ref, img_size, MAX_PIXEL_VAL)
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
    disp(result_hist_data_ref);

    len = length(result_hist_data_ref);
    final_hist_data = zeros(1, len);
    for i = 1: len
        hist_data_ref_match = result_hist_data_ref(i);
        new_nk = new_hist_data_source(hist_data_ref_match);

        fprintf("%d %d %d\n", i, hist_data_ref_match, new_nk);

        valid = true;
        if (new_nk) == 0 
            valid = false;
        end
        % Search for previous index if new_nk == 0
        % If index is the first index in the list, make it stay zero
        while (not(valid))
            if (hist_data_ref_match == 1 & new_nk == 0)
                valid = true;
            end
            hist_data_ref_match = hist_data_ref_match - 1;
            new_nk = new_hist_data_source(hist_data_ref_match);
            if (not(new_nk == 0))
                valid = true;
            end
        end
        fprintf("%d %d %d\n------\n", i, hist_data_ref_match, new_nk);

        final_hist_data(i) = new_nk;
    end
end

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
    histogram_show(hist_data_source, hist_data_r_source, hist_data_b_source, hist_data_g_source, is_gray, "of Source Image");

    [hist_data_ref, hist_data_r_ref, hist_data_b_ref, hist_data_g_ref] = histogram(img_reference);
    histogram_show(hist_data_ref, hist_data_r_ref, hist_data_b_ref, hist_data_g_ref, is_gray, "of Reference Image");
    img_size = rows_s * cols_s;

    result_histogram = match_histogram(hist_data_source, hist_data_ref, img_size, MAX_PIXEL_VAL);
    % disp(sum_value(result_histogram));
    if (is_gray)
        histogram_show(result_histogram, [], [], [], is_gray, "of Result Match");
    else
        result_histogram_r = match_histogram(hist_data_r_source, hist_data_r_ref, img_size, MAX_PIXEL_VAL);
        result_histogram_g = match_histogram(hist_data_g_source, hist_data_g_ref, img_size, MAX_PIXEL_VAL);
        result_histogram_b = match_histogram(hist_data_b_source, hist_data_b_ref, img_size, MAX_PIXEL_VAL);
        histogram_show(result_histogram, result_histogram_r, result_histogram_g, result_histogram_b, is_gray, "of Result Match");
    end
end