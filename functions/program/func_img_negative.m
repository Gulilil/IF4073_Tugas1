function [result_img, hist_data, hist_data_r, hist_data_b, hist_data_g, log] = func_img_negative(img, img_name, is_grayscaled, is_saved)
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
    
    PIXEL_MAX_VAL = 255;
    
    for r = 1:rows
        for c = 1:cols
            if (is_gray)
                curr_pixel = img(r,c);
                result_img(r, c) = validate_pixel(PIXEL_MAX_VAL - curr_pixel);
            else
                curr_pixel_r = img(r, c, 1);
                curr_pixel_g = img(r, c, 2);
                curr_pixel_b = img(r, c, 3);
    
                result_img(r, c, 1) = validate_pixel(PIXEL_MAX_VAL - curr_pixel_r);
                result_img(r, c, 2) = validate_pixel(PIXEL_MAX_VAL - curr_pixel_g);
                result_img(r, c, 3) = validate_pixel(PIXEL_MAX_VAL - curr_pixel_b);
            end
        end
    end
    
    % Show result image
    log = log + sprintf("[DISPLAYING] Here is displayed the initial and the result image\n");
    
    % Make histogram
    [hist_data, hist_data_r, hist_data_b, hist_data_g] = histogram_calculate(result_img);
    
    if is_saved
        % Write image
        if is_grayscaled == 1
            suffix = "grayscaled_";
        else 
            suffix = ""; 
        end
        img_out_name = strcat("image_negative_", suffix, img_name);
        write_image(result_img, img_out_name);
        log = log + sprintf("[SAVED] The image is saved in %s\n", img_out_name);
    end

end