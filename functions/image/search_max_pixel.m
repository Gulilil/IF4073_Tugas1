function max_val = search_max_pixel(img, rows, cols)
    max_val = 0;
    for r = 1:rows
        for c = 1:cols
             if (img(r,c) > max_val)
                 max_val = img(r,c);
             end
        end
    end
end