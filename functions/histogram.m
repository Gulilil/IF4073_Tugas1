% Pengerjaan Nomor 1 (tanpa Library imHist)
function scratchHistogram = histogram(fileInput)
    % Cek apakah file gambar ada
    if exist(fileInput, 'file')
        img = read_image(fileInput);

        % Periksa apakah gambar merupakan indexed
        if isinteger(img) && size(img, 3) == 1  % Gambar index, punya colormap
            [img, map] = imread(fileInput);  % Baca gambar dan colormap
            img = ind2rgb(img, map);         % Convert indexed ke RGB
            disp('Gambar indexed terdeteksi. Dikover ke RGB.');
        end
        
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
            scratchHistogram = grayscale_hist;
            
            % Menampilkan histogram grayscale
            subplot(2, 2, 2);
            bar(0:255, grayscale_hist, 'FaceColor', 'Magenta', 'EdgeColor', 'Magenta'); % Plot histogram
            title('Grayscale Histogram (without imhist)');
            set(gca, 'XLim', [0 255], 'YLim', [0 max(grayscale_hist)]); % Set properti sumbu x dan sumbu y
            
        elseif numChannels == 3  % Kondisi Gambar RGB
            % Memisahkan kondisi warna RGB
            img = double(img);  % Konversi ke double untuk proses histogram
            clr = 'rgb';        % Identifikasi RGB
            clrTxt = {'Red', 'Green', 'Blue'};
            
            % Informasi gambar dan combined histogram
            subplot(2, 2, 1);
            imshow(uint8(img));  % Tampilkan gambar asli
            title('RGB Image');
            
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
            scratchHistogram = combined_hist;
            
            subplot(2, 2, 2);
            bar(0:255, combined_hist, 'FaceColor', 'Magenta', 'EdgeColor', 'Magenta');  % Plot histogram
            title('Combined Histogram (without imhist)');
            set(gca, 'XLim', [0 255], 'YLim', [0 max(combined_hist)]); % Set properti sumbu x dan sumbu y
            
            % Informasi histogram untuk RGB
            for i = 1:3
                subplot(2, 3, i + 3); 
                
                % Inisialisasi histogram untuk channel RGB
                channel_hist = zeros(1, 256);
                
                % Hitung histogram untuk channel tertentu (R, G, atau B)
                for row = 1:rows
                    for col = 1:cols
                        intensity = img(row, col, i);  % Ambil intensitas untuk channel i (R, G, atau B)
                        channel_hist(intensity + 1) = channel_hist(intensity + 1) + 1;
                    end
                end
                
                % Plot histogram RGB
                bar(0:255, channel_hist, 'FaceColor', clr(i), 'EdgeColor', 'none');  % Plot histogram
                set(gca, 'XLim', [0 255], 'YLim', [0 max(channel_hist)]);  % Set properti sumbu
                title([clrTxt{i}, ' Histogram (without imhist)']);
                xlabel('Intensity');
            end
        else
            disp('File format is not supported.');
            scratchHistogram = [];  % Empty ketika file format tidak support
        end
    else
        disp('File tidak tersedia');
        scratchHistogram = [];  % Empty ketika file tidak tersedia
    end
end