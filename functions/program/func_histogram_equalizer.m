
function [imgEqualized, hist_data, hist_data_r, hist_data_b, hist_data_g, log] = func_histogram_equalizer(img, img_name, is_grayscaled, is_saved)
    % Initialization 
    addpath('./functions/image');
    addpath('./functions/histogram');
    
    log = "";
    
    % Img details
    [rows, cols, num_channels] = size(img);
    log = log + sprintf("[INFO] An image size [%d, %d] is inputted!\n", rows, cols);
    
    if (num_channels == 1 | is_grayscaled)
        % Create placeholder for new image
        log = log + sprintf("[PROCESS] Processing grayscale image!\n");
        if (not(num_channels == 1))
            % If full colored but want to be grayscaled
            img = rgb2gray(img);
        end
        is_gray = true;
    else
        log = log + sprintf("[PROCESS] Processing full color image!\n");
        is_gray = false;
    end
            
    if not(is_gray)  % Jika gambar RGB, proses setiap channel (R, G, B) secara terpisah
        % Pisahkan gambar menjadi 3 channel: R, G, B
        imgR = img(:, :, 1);
        imgG = img(:, :, 2);
        imgB = img(:, :, 3);
    
        % Equalize setiap channel
        imgEqualizedR = equalizer_operation(imgR);
        imgEqualizedG = equalizer_operation(imgG);
        imgEqualizedB = equalizer_operation(imgB);
                
        % Gabungkan kembali ketiga channel menjadi gambar RGB yang sudah di-equalize
        imgEqualized = cat(3, imgEqualizedR, imgEqualizedG, imgEqualizedB);
    else
        % Jika gambar adalah grayscale
        imgEqualized = equalizer_operation(img);
    end
    
    % Show result image
    log = log + sprintf("[DISPLAYING] Here is displayed the initial and the result image\n");
    
    % Menampilkan histogram dari gambar yang telah di-equalize
    [hist_data, hist_data_r, hist_data_b, hist_data_g] = histogram_calculate(imgEqualized);

    if is_saved 
        % Write image
        if is_grayscaled == 1
            suffix = "grayscaled_";
        else 
            suffix = ""; 
        end
        img_out_name = strcat("histogram_equalizer_", suffix, img_name);
        write_image(imgEqualized, img_out_name);
        log = log + sprintf("[SAVED] The image is saved in %s\n", img_out_name);
    end
end