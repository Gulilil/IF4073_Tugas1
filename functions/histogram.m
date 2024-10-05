function imhistHistogram = showImhistHistogram(fileInput)
%% SHOWIMHISTHISTOGRAM Tugas Kecil 1 IF4073 Pemrosesan Citra Digital
% 
% 
% Pengerjaan Nomor 1 (dengan Library imHist)
    % Cek apakah file gambar ada
    if exist(fileInput, 'file')
        img = imread(fileInput);
        
        % Cek apakah gambar merupakan Grayscale atau RGB
        if size(img, 3) == 1  % Kondisi Gambar Grayscale
            subplot(2, 2, 1);
            imshow(img);
            title('Grayscale Image');
            
            % Menampilkan histogram grayscale
            subplot(2, 2, 2);
            histogram = imhist(img);  % Assign grayscale histogram pada output
            bar(0:255, histogram, 'FaceColor', 'Magenta', 'EdgeColor', 'Magenta');
            title('Grayscale Histogram (with imhist)');
            set(gca, 'XLim', [0 255], 'YLim', [0 max(histogram)]);  % Set properti sumbu x dan sumbu y
            
        elseif size(img, 3) == 3  % Kondisi Gambar RGB
            % Memisahkan kondisi warna RGB
            II = double(img);  % Konversi ke double untuk proses histogram
            clr = 'rgb';       % Identifikasi RGB
            clrTxt = {'Red', 'Green', 'Blue'};
    
            % Informasi gambar dan combined histogram
            subplot(2, 2, 1);
            imshow(img);
            title('RGB Image');
    
            subplot(2, 2, 2);
            combined_hist = imhist(rgb2gray(img));  % Menampilkan histogram
            imhistHistogram = combined_hist;
            bar(0:255, combined_hist , 'FaceColor', 'Magenta', 'EdgeColor', 'Magenta');
            title('Combined Histogram (with imhist)');
            set(gca, 'XLim', [0 255], 'YLim', [0 max(combined_hist)]); % Set properti sumbu x dan sumbu y
    
            % Informasi histogram untuk RGB
            for i = 1:3
                subplot(2, 3, i + 3); 
                channel_hist = histc(reshape(II(:,:,i), [], 1), 0:255);
                bar(0:255, channel_hist, 'histc')
                
                % Set properti untuk histogram
                set(gca, 'XLim', [0 255], 'YLim', [0 max(channel_hist)]) % Set properti sumbu
                set(findobj(gca, 'Type', 'patch'), 'FaceColor', clr(i), 'EdgeColor', 'none')  % Plot histogram
                title([clrTxt{i}, ' Histogram (with imhist)']); 
            end
        else
            disp('File format is not supported.');
            imhistHistogram = [];  % Empty ketika file format tidak support
        end
    else
        disp('File tidak tersedia atau bukan file .bmp.');
        imhistHistogram = [];  % Empty ketika file tidak tersedia
    end
end
% Cara penggunaan function yang Imhist
fileInput = input('Masukkan nama file (with Imhist): ', 's');  
imhistHistogram = showImhistHistogram(fileInput);
%% 
% Pengerjaan Nomor 1 (tanpa Library imHist)
function scratchHistogram = showScratchHistogram(fileInput)
    % Cek apakah file gambar ada
    if exist(fileInput, 'file')
        img = imread(fileInput);
        
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
            scratchHistogram = grayscale_hist;  % Assign grayscale histogram to output
            
            % Menampilkan histogram grayscale
            subplot(2, 2, 2);
            bar(0:255, grayscale_hist, 'FaceColor', 'Magenta', 'EdgeColor', 'Magenta');
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
            scratchHistogram = combined_hist;  % Assign combined grayscale histogram to output
            
            subplot(2, 2, 2);
            bar(0:255, combined_hist, 'FaceColor', 'Magenta', 'EdgeColor', 'Magenta');  % Plot histogram combined grayscale
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
        disp('File tidak tersedia atau bukan file .bmp.');
        scratchHistogram = [];  % Empty ketika file tidak tersedia
    end
end
% Cara penggunaan function yang scratch
fileInput = input('Masukkan nama file (with Imhist): ', 's');  
scratchHistogram = showScratchHistogram(fileInput);