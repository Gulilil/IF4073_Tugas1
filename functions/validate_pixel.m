function result = validate_pixel(pixel)
    max_val = 255;
    min_val = 0;
    result = min(pixel, max_val);
    result = max(result, min_val);
end