function idx = get_index_nearest_value(vector, val)
    len = length(vector);
    idx = 1;
    while (idx < len & val >= vector(idx))
        idx = idx + 1;
    end
end