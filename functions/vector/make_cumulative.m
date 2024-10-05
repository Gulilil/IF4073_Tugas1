function result_vector = make_cumulative(vector)
    v_length = length(vector); 
    result_vector = zeros(1, v_length);
    for i = 1:v_length
        if (i == 1)
            result_vector(i) = vector(i);
        else
            result_vector(i) = vector(i) + result_vector(i-1)
        end
    end
end

