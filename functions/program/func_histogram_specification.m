function [result_img, result_histogram, result_histogram_r, result_histogram_b, result_histogram_g, log] = func_histogram_specification(img_source, img_name_source,img_reference,  img_name_reference,is_grayscaled, is_saved)
    % Initialization 
    addpath('./functions/image');
    addpath('./functions/histogram');
    addpath('./functions/vector');
    
    % Function
    function [final_hist_data, mapped_hist] = match_histogram(hist_data_source, hist_data_ref, img_size, MAX_PIXEL_VAL)
        % Source
        norm_hist_data_source = hist_data_source / img_size;
        cmltv_norm_hist_data_source = make_cumulative(norm_hist_data_source);
        result_hist_data_source = round(cmltv_norm_hist_data_source * MAX_PIXEL_VAL);
        new_hist_data_source = map_new_hist(result_hist_data_source, hist_data_source);
    
        % Ref
        norm_hist_data_ref = hist_data_ref / img_size;
        cmltv_norm_hist_data_ref = make_cumulative(norm_hist_data_ref);
        result_hist_data_ref = round(cmltv_norm_hist_data_ref * MAX_PIXEL_VAL);
    
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
    
    log = "";
    
    % Image details
    [rows_s, cols_s, num_channels_s] = size(img_source);
    [rows_r, cols_r, num_channels_r] = size(img_reference);
    
    MAX_PIXEL_VAL = 255;
    
    if (not (rows_s == rows_r) | not (cols_s == cols_r))
        log = log + sprintf('[FAILED] The two inputted images do not have the same size!\n');
        [result_img, result_histogram, result_histogram_r, result_histogram_b, result_histogram_g] = deal([]);
        return;
    elseif (not (num_channels_s == num_channels_r))
        log = log + sprintf('[FAILED] The two inputted images do not share the same color type!\n');
        [result_img, result_histogram, result_histogram_r, result_histogram_b, result_histogram_g] = deal([]);
        return;
    else
        % Both image rows and cols should be the same
        log = log + sprintf("[INFO] An image size [%d, %d] is inputted!\n", rows_s, cols_s);
        
        % Create placeholder for new image
        if (num_channels_s == 1 | is_grayscaled)
            log = log + sprintf("[PROCESS] Processing grayscale image!\n");
            if (not(num_channels_s == 1))
                % If full colored but want to be grayscaled
                img_source = rgb2gray(img_source);
                img_reference = rgb2gray(img_reference);
            end
            is_gray = true;
            result_img = zeros(rows_s, cols_s, 1, 'uint8');
        else
            log = log + sprintf("[PROCESS] Processing full color image!\n");
            is_gray = false;
            result_img = zeros(rows_s, cols_s, 3, 'uint8');
        end
    
        % Process Image
        [hist_data_source, hist_data_r_source, hist_data_b_source, hist_data_g_source] = histogram_calculate(img_source);
        [hist_data_ref, hist_data_r_ref, hist_data_b_ref, hist_data_g_ref] = histogram_calculate(img_reference);
        img_size = rows_s * cols_s;
    
        [result_histogram, mapped_hist] = match_histogram(hist_data_source, hist_data_ref, img_size, MAX_PIXEL_VAL);
        result_histogram_r = [];
        result_histogram_g = [];
        result_histogram_b = [];
        if (is_gray)        
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
            
                    result_img(r, c, 1) = mapped_hist_r(curr_pixel_r+1);
                    result_img(r, c, 2) = mapped_hist_g(curr_pixel_g+1);
                    result_img(r, c, 3) = mapped_hist_b(curr_pixel_b+1);
                end
            end
        end
    
        % Show result image
        log = log + sprintf("[DISPLAYING] Here is displayed the source, reference, and result image");
   
        
        if is_saved
            % Write image
            if is_grayscaled == 1
                suffix = "grayscaled_";
            else 
                suffix = ""; 
            end
            img_out_name = strcat("histogram_specification_", suffix, img_name_source, img_name_reference);
            write_image(result_img, img_out_name);
            log = log + sprintf("[SAVED] The image is saved in %s\n", img_out_name);
        end
    end
end