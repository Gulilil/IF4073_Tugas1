function new_hist_data = map_new_hist(rounded_equalized_hist, initial_hist)
    len = length(rounded_equalized_hist); 
    new_hist_data = zeros(1, len);
    for i= 1: len
        n = initial_hist(i);
        equalized_idx = rounded_equalized_hist(i);
        new_hist_data(equalized_idx+1) = new_hist_data(equalized_idx+1) + n;
    end
end

