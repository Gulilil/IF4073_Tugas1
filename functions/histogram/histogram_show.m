function histogram_show(histogram_data, is_grayscale)
    if (is_grayscale)
        % Menampilkan histogram grayscale
        subplot(2, 2, 2);
        bar(0:255, histogram_data, 'FaceColor', 'Magenta', 'EdgeColor', 'Magenta'); % Plot histogram
        title('Grayscale Histogram');
        set(gca, 'XLim', [0 255], 'YLim', [0 max(histogram_data)]); % Set properti sumbu x dan sumbu y
    else

    end
end

