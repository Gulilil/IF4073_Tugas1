function [histogram_data, histogram_data_r, histogram_data_g, histogram_data_b] = histogram(img)
    % Fungsi manual untuk menghitung histogram tanpa fungsi terpisah
    % Menghitung histogram secara manual untuk gambar grayscale atau channel RGB
    [rows, cols, numChannels] = size(img);  % Dapatkan ukuran gambar
    
    % Cek apakah gambar merupakan Grayscale atau RGB
    if numChannels == 1  % Kondisi Gambar Grayscale
        subplot(2, 2, 1);
        imshow(img);
        title('Grayscale Image');
        
        % Inisialisasi histogram grayscale
        grayscale_hist = zeros(1, 256);  % Array untuk menyimpan nilai intensitas 0-255
        
        % Loop melalui setiap pixel untuk menghitung histogram grayscale
        for i = 1:rows
            for j = 1:cols
                intensity = img(i, j);  % Ambil nilai intensitas pixel
                grayscale_hist(intensity + 1) = grayscale_hist(intensity + 1) + 1;  % Tambahkan ke histogram
            end
        end
        
        % Assign histogram grayscale sebagai output
        histogram_data = grayscale_hist;
        histogram_data_r = [];
        histogram_data_g = [];
        histogram_data_b = [];
        
    elseif numChannels == 3  % Kondisi Gambar RGB
        % Memisahkan kondisi warna RGB
        img = double(img);  % Konversi ke double untuk proses histogram
        clr = 'rgb';        % Identifikasi RGB
        clrTxt = {'Red', 'Green', 'Blue'};
        
        % Menghitung histogram combined untuk grayscale dari gambar RGB
        combined_hist = zeros(1, 256);  % Array untuk combined histogram
        grayscale_img = rgb2gray(uint8(img));  % Konversi gambar RGB menjadi grayscale
        
        for i = 1:rows
            for j = 1:cols
                intensity = grayscale_img(i, j);
                combined_hist(intensity + 1) = combined_hist(intensity + 1) + 1;
            end
        end
        
        % Assign combined histogram sebagai output
        histogram_data = combined_hist;
        
        % Informasi histogram untuk RGB
        for i = 1:3
            % Inisialisasi histogram untuk channel RGB
            channel_hist = zeros(1, 256);
            
            % Hitung histogram untuk channel tertentu (R, G, atau B)
            for row = 1:rows
                for col = 1:cols
                    intensity = img(row, col, i);  % Ambil intensitas untuk channel i (R, G, atau B)
                    channel_hist(intensity + 1) = channel_hist(intensity + 1) + 1;
                end
            end

            if (i == 1)
                histogram_data_r = channel_hist;
            elseif(i == 2)
                histogram_data_g = channel_hist;
            else
                histogram_data_b = channel_hist;
            end
        end
    else
        disp('File format is not supported.');
        histogram_data = [];  % Empty ketika file format tidak support
    end
end