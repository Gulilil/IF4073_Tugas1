% Function untuk melakukan histogram equalization pada satu channel (grayscale)

function imageEqualized = equalizer_operation(channel)
    % Ukuran total pixel dalam channel
    [rows, cols] = size(channel);
    totalPixels = rows * cols;
    
    % Langkah 1: Menghitung histogram secara manual (PDF)
    counts = zeros(1, 256);  % Array untuk menghitung setiap intensitas 0-255
    for i = 1:totalPixels
        pixelValue = channel(i);
        counts(pixelValue + 1) = counts(pixelValue + 1) + 1;
    end
    
    % Langkah 2: Hitung PDF (Probability Density Function)
    pdf = counts / totalPixels;
    
    % Langkah 3: Hitung CDF (Cumulative Distribution Function)
    cdf = cumsum(pdf);
    
    % Langkah 4: Terapkan transformasi equalization ke channel menggunakan fungsi transformasi T(r_k) = (L-1) * CDF(r_k)
    transformFunc = uint8(255 * cdf);  % Normalisasi CDF
    
    % Menerapkan transformasi ke channel asli
    imageEqualized = zeros(size(channel), 'uint8');
    for i = 1:totalPixels
        imageEqualized(i) = transformFunc(channel(i) + 1);  % +1 karena indeks MATLAB dimulai dari 1
    end
end