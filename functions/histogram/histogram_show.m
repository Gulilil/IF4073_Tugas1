function histogram_show(histogram_data, histogram_data_r, histogram_data_g, histogram_data_b is_grayscale)
    if (is_grayscale)
        % Menampilkan histogram grayscale
        subplot(1, 1, 1);
        bar(0:255, histogram_data, 'FaceColor', 'Magenta', 'EdgeColor', 'Magenta'); % Plot histogram
        title('Grayscale Histogram');
        set(gca, 'XLim', [0 255], 'YLim', [0 max(histogram_data)]); % Set properti sumbu x dan sumbu y
    else
        subplot(1, 1, 1);
        bar(0:255, combined_hist, 'FaceColor', 'Magenta', 'EdgeColor', 'Magenta');  % Plot histogram
        title('Combined Histogram');
        set(gca, 'XLim', [0 255], 'YLim', [0 max(combined_hist)]); % Set properti sumbu x dan sumbu y
           
        
        for i= 1:3
            if (i == 1):
                channel_hist = histogram_data_r;
            elseif(i == 2):
                channel_hist = histogram_data_g;
            else
                channel_hist = histogram_data_b;
            end
            
            clr = 'rgb';        % Identifikasi RGB
            clrTxt = {'Red', 'Green', 'Blue'};
            subplot(2, 3, i + 3); 
            % Plot histogram RGB
            bar(0:255, channel_hist, 'FaceColor', clr(i), 'EdgeColor', 'none');  % Plot histogram
            set(gca, 'XLim', [0 255], 'YLim', [0 max(channel_hist)]);  % Set properti sumbu
            title([clrTxt{i}, ' Histogram (without imhist)']);
            xlabel('Intensity');
        end
    end
end

