function imhistHistogram = histogram_imhist(fileInput)
%% SHOWIMHISTHISTOGRAM Tugas Kecil 1 IF4073 Pemrosesan Citra Digital
% 
% 
% Pengerjaan Nomor 1 (dengan Library imHist)
    % Cek apakah file gambar ada
    if exist(fileInput, 'file')
        img = read_image(fileInput);
        
        % Periksa apakah gambar merupakan indexed
        if isinteger(img) && size(img, 3) == 1  % Gambar index, punya colormap
            [img, map] = imread(fileInput);  % Baca gambar dan colormap
            img = ind2rgb(img, map);         % Convert indexed ke RGB
            disp('Gambar indexed terdeteksi. Dikover ke RGB.');
        end
        
        % Cek apakah gambar merupakan Grayscale atau RGB
        if size(img, 3) == 1  % Kondisi Gambar Grayscale
            subplot(2, 2, 1);
            imshow(img);
            title('Grayscale Image');
            
            % Menampilkan histogram grayscale
            subplot(2, 2, 2);
            histogram = imhist(img);  % Assign grayscale histogram pada output
            bar(0:255, histogram, 'FaceColor', 'Magenta', 'EdgeColor', 'Magenta'); % Plot histogram
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
            bar(0:255, combined_hist , 'FaceColor', 'Magenta', 'EdgeColor', 'Magenta'); % Plot histogram
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
        disp('File tidak tersedia');
        imhistHistogram = [];  % Empty ketika file tidak tersedia
    end
end