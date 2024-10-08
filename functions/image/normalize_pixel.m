function result = normalize_pixel(pixel, max_val, min_val)
    result = uint8((pixel - min_val) * (255 / double(max_val - min_val)));
end