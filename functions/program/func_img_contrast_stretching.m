function [result_img, hist_data, hist_data_r, hist_data_b, hist_data_g, log] = func_img_contrast_stretching(img, img_name, is_grayscaled, is_saved)
    % Initialization 
    addpath('./functions/image');
    addpath('./functions/histogram');
    
    log = "";

    % Img details
    [rows, cols, num_channels] = size(img);
    log = log + sprintf("[INFO] An image size [%d, %d] is inputted!\n", rows, cols);
    
    % Create placeholder for new image
    if (num_channels == 1 | is_grayscaled)
        log = log + sprintf("[PROCESS] Processing grayscale image!\n");
        if (not(num_channels == 1))
            % If full colored but want to be grayscaled
            img = rgb2gray(img);
        end
        is_gray = true;
        result_img = zeros(rows, cols, 1, 'uint8');
    else
        log = log + sprintf("[PROCESS] Processing full color image!\n");
        is_gray = false;
        result_img = zeros(rows, cols, 3, 'uint8');
    end
    
    if (is_gray)
        max_val = search_max_pixel(img, rows, cols);
        min_val = search_min_pixel(img, rows, cols);
        fprintf('[INFO] Max value: %d, Min value: %d\n', max_val, min_val);
    
        for r = 1:rows
            for c = 1: cols
                curr_pixel = img(r,c);
                result_img(r, c) = validate_pixel(normalize_pixel(curr_pixel, max_val, min_val));
            end
        end
    else
        r_aspect = img(:,:,1);  % Red channel
        max_val_r = search_max_pixel(r_aspect, rows, cols);
        min_val_r = search_min_pixel(r_aspect, rows, cols);
        fprintf('[INFO] Red : Max value: %d, Min value: %d\n', max_val_r, min_val_r);
    
        g_aspect = img(:,:,2);  % Green channel
        max_val_g = search_max_pixel(g_aspect, rows, cols);
        min_val_g = search_min_pixel(g_aspect, rows, cols);
        fprintf('[INFO] Green : Max value: %d, Min value: %d\n', max_val_g, min_val_g);
    
        b_aspect = img(:,:,3);  % Blue channel
        max_val_b = search_max_pixel(b_aspect, rows, cols);
        min_val_b = search_min_pixel(b_aspect, rows, cols);
        fprintf('[INFO] Blue : Max value: %d, Min value: %d\n', max_val_b, min_val_b);
    
        for r = 1:rows
            for c = 1: cols
                curr_pixel_r = double(img(r, c, 1));
                curr_pixel_g = double(img(r, c, 2));
                curr_pixel_b = double(img(r, c, 3));
    
                result_img(r, c, 1) = validate_pixel(normalize_pixel(curr_pixel_r, max_val_r, min_val_r));
                result_img(r, c, 2) = validate_pixel(normalize_pixel(curr_pixel_g, max_val_g, min_val_g));
                result_img(r, c, 3) = validate_pixel(normalize_pixel(curr_pixel_b, max_val_b, min_val_b));
            end
        end
    end
    
    % Show result image
    log = log + sprintf("[DISPLAYING] Here is displayed the initial and the result image!\n");
    
    % Make histogram
    [hist_data, hist_data_r, hist_data_b, hist_data_g] = histogram_calculate(result_img);
    
    if is_saved
        % Write image
        if is_grayscaled == 1
            suffix = "grayscaled_";
        else 
            suffix = ""; 
        end
        img_out_name = strcat("image_constract_stretching_", suffix, img_name);
        write_image(result_img, img_out_name);
        log = log + sprintf("[SAVED] The image is saved in %s!\n", img_out_name);
    end
end