function min_val = search_min_pixel(img, rows, cols)
    min_val = 255;
    for r = 1:rows
        for c = 1:cols
             if (img(r,c) < min_val)
                 min_val = img(r,c);
             end
        end
    end
end